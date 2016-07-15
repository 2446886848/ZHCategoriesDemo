//
//  NSObject+ZHAddForClassSwizzle.m
//  ZHCategoriesDemo
//
//  Created by walen on 16/7/15.
//  Copyright © 2016年 wuzhihe. All rights reserved.
//

#import "NSObject+ZHAddForClassSwizzle.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface NSInvocation (Argument)
- (NSArray *)zh_arguments;
@end

@implementation MessageInfo

- (NSArray *)arguments
{
    return self.originalInvocation.zh_arguments;
}

@end

@implementation TokenInfo
- (instancetype)initWithObj:(id)obj selector:(SEL)aSelector
{
    if (self = [super init]) {
        _instance = obj;
        _selector = aSelector;
    }
    return self;
}
- (void)dispose{
    object_setClass(self.instance, [self.instance class]);
    objc_setAssociatedObject(self.instance, self.selector, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end

static NSString *const kClassSwizzlePrefix = @"ClassSwizzled_";

TokenInfo * swizzle_object(id obj, SEL aSelector, SwizzleBlock block);

@implementation NSObject (ZHAddForClassSwizzle)

- (TokenInfo *)zh_swizzleSelector:(SEL)aSelector usingBlock:(SwizzleBlock)block
{
    return swizzle_object(self, aSelector, block);
}

@end

@implementation NSInvocation (Argument)

// Thanks to the ReactiveCocoa team for providing a generic solution for this.
- (id)zh_argumentAtIndex:(NSUInteger)index {
    const char *argType = [self.methodSignature getArgumentTypeAtIndex:index];
    // Skip const type qualifier.
    if (argType[0] == _C_CONST) argType++;
    
#define WRAP_AND_RETURN(type) do { type val = 0; [self getArgument:&val atIndex:(NSInteger)index]; return @(val); } while (0)
    if (strcmp(argType, @encode(id)) == 0) {
        __autoreleasing id returnObj;
        [self getArgument:&returnObj atIndex:(NSInteger)index];
        return returnObj;
    } else if (strcmp(argType, @encode(SEL)) == 0) {
        SEL selector = 0;
        [self getArgument:&selector atIndex:(NSInteger)index];
        return NSStringFromSelector(selector);
    } else if (strcmp(argType, @encode(Class)) == 0) {
        __autoreleasing Class theClass = Nil;
        [self getArgument:&theClass atIndex:(NSInteger)index];
        return theClass;
        // Using this list will box the number with the appropriate constructor, instead of the generic NSValue.
    } else if (strcmp(argType, @encode(char)) == 0) {
        WRAP_AND_RETURN(char);
    } else if (strcmp(argType, @encode(int)) == 0) {
        WRAP_AND_RETURN(int);
    } else if (strcmp(argType, @encode(short)) == 0) {
        WRAP_AND_RETURN(short);
    } else if (strcmp(argType, @encode(long)) == 0) {
        WRAP_AND_RETURN(long);
    } else if (strcmp(argType, @encode(long long)) == 0) {
        WRAP_AND_RETURN(long long);
    } else if (strcmp(argType, @encode(unsigned char)) == 0) {
        WRAP_AND_RETURN(unsigned char);
    } else if (strcmp(argType, @encode(unsigned int)) == 0) {
        WRAP_AND_RETURN(unsigned int);
    } else if (strcmp(argType, @encode(unsigned short)) == 0) {
        WRAP_AND_RETURN(unsigned short);
    } else if (strcmp(argType, @encode(unsigned long)) == 0) {
        WRAP_AND_RETURN(unsigned long);
    } else if (strcmp(argType, @encode(unsigned long long)) == 0) {
        WRAP_AND_RETURN(unsigned long long);
    } else if (strcmp(argType, @encode(float)) == 0) {
        WRAP_AND_RETURN(float);
    } else if (strcmp(argType, @encode(double)) == 0) {
        WRAP_AND_RETURN(double);
    } else if (strcmp(argType, @encode(BOOL)) == 0) {
        WRAP_AND_RETURN(BOOL);
    } else if (strcmp(argType, @encode(bool)) == 0) {
        WRAP_AND_RETURN(BOOL);
    } else if (strcmp(argType, @encode(char *)) == 0) {
        WRAP_AND_RETURN(const char *);
    } else if (strcmp(argType, @encode(void (^)(void))) == 0) {
        __unsafe_unretained id block = nil;
        [self getArgument:&block atIndex:(NSInteger)index];
        return [block copy];
    } else {
        NSUInteger valueSize = 0;
        NSGetSizeAndAlignment(argType, &valueSize, NULL);
        
        unsigned char valueBytes[valueSize];
        [self getArgument:valueBytes atIndex:(NSInteger)index];
        
        return [NSValue valueWithBytes:valueBytes objCType:argType];
    }
    return nil;
#undef WRAP_AND_RETURN
}

- (NSArray *)zh_arguments {
    NSMutableArray *argumentsArray = [NSMutableArray array];
    for (NSUInteger idx = 2; idx < self.methodSignature.numberOfArguments; idx++) {
        [argumentsArray addObject:[self zh_argumentAtIndex:idx] ?: NSNull.null];
    }
    return [argumentsArray copy];
}

@end

static SEL aliasForSelector(SEL selector) {
    NSCParameterAssert(selector);
    return NSSelectorFromString([kClassSwizzlePrefix stringByAppendingFormat:@"%@", NSStringFromSelector(selector)]);
}

static void __FORWARD_INVOCATION__(__unsafe_unretained NSObject *self, SEL selector, NSInvocation *invocation) {
    
    SwizzleBlock block = objc_getAssociatedObject(self, invocation.selector);

    invocation.selector = aliasForSelector(invocation.selector);
    
    if (block) {
        MessageInfo *info = [[MessageInfo alloc] init];
        info.instance = self;
        info.originalInvocation = invocation;
        block(info);
    }
    else
    {
        [invocation invoke];
    }
}

static NSString *const kSwizzedForwardInvocationSelectorName = @"ClassSwizzled__forwardInvocation:";
static void swizzleForwardInvocation(Class klass) {
    NSCParameterAssert(klass);
    
    char *forwardInvocationSinature = "v@:@";
    IMP originalImplementation = class_replaceMethod(klass, @selector(forwardInvocation:), (IMP)__FORWARD_INVOCATION__, forwardInvocationSinature);
    if (originalImplementation) {
        class_addMethod(klass, NSSelectorFromString(kSwizzedForwardInvocationSelectorName), originalImplementation, forwardInvocationSinature);
    }
}

static void swizzleGetClass(Class subclass, Class originClass) {
    NSCParameterAssert(subclass);
    NSCParameterAssert(originClass);
    Method method = class_getInstanceMethod(subclass, @selector(class));
    IMP newIMP = imp_implementationWithBlock(^(id self) {
        return originClass;
    });
    class_replaceMethod(subclass, @selector(class), newIMP, method_getTypeEncoding(method));
}

Class swizzedClass(id obj) {
    Class originClass = object_getClass(obj);
    NSString *originClassName = NSStringFromClass(originClass);
    if ([originClassName hasPrefix:kClassSwizzlePrefix]) {
        return originClass;
    }
    else if (class_isMetaClass(originClass)) {
        NSCAssert(NO, @"unsupport for class swizzle!");
        return nil;
    }
    
    const char *subclassName = [originClassName stringByAppendingString:kClassSwizzlePrefix].UTF8String;
    Class subclass = objc_getClass(subclassName);
    if (subclass) {
        return subclass;
    }
    
    subclass = objc_allocateClassPair(originClass, subclassName, 0);
    if (subclass == nil) {
        NSString *errrorDesc = [NSString stringWithFormat:@"objc_allocateClassPair failed to allocate class %s.", subclassName];
        NSCAssert(NO, errrorDesc);
        return nil;
    }
    
    swizzleForwardInvocation(subclass);
    swizzleGetClass(subclass, originClass);
    swizzleGetClass(object_getClass(subclass), originClass);
    objc_registerClassPair(subclass);
    
    return subclass;
}

static IMP msgForwardIMP(Class class, SEL selector) {
    IMP msgForwardIMP = _objc_msgForward;
#if !defined(__arm64__)
    Method method = class_getInstanceMethod(class, selector);
    const char *encoding = method_getTypeEncoding(method);
    BOOL methodReturnsStructValue = encoding[0] == _C_STRUCT_B;
    if (methodReturnsStructValue) {
        @try {
            NSUInteger valueSize = 0;
            NSGetSizeAndAlignment(encoding, &valueSize, NULL);
            
            if (valueSize == 1 || valueSize == 2 || valueSize == 4 || valueSize == 8) {
                methodReturnsStructValue = NO;
            }
        } @catch (__unused NSException *e) {}
    }
    if (methodReturnsStructValue) {
        msgForwardIMP = (IMP)_objc_msgForward_stret;
    }
#endif
    return msgForwardIMP;
}

static BOOL isMsgForwardIMP(IMP impl) {
    return impl == _objc_msgForward
#if !defined(__arm64__)
    || impl == (IMP)_objc_msgForward_stret
#endif
    ;
}

void swizzedSelector(Class class, SEL selector) {
    Method targetMethod = class_getInstanceMethod(class, selector);
    IMP targetMethodIMP = method_getImplementation(targetMethod);
    if (!isMsgForwardIMP(targetMethodIMP)) {
        const char *typeEncoding = method_getTypeEncoding(targetMethod);
        SEL aliasSelector = aliasForSelector(selector);
        if (![class instancesRespondToSelector:aliasSelector]) {
            __unused BOOL addedAlias = class_addMethod(class, aliasSelector, method_getImplementation(targetMethod), typeEncoding);
            NSCAssert(addedAlias, @"Original implementation for %@ is already copied to %@ on %@", NSStringFromSelector(selector), NSStringFromSelector(aliasSelector), class);
        }
        
        class_replaceMethod(class, selector, msgForwardIMP(class, selector), typeEncoding);
    }
}

TokenInfo * swizzle_object(id obj, SEL aSelector, SwizzleBlock block) {
    Class newClass = swizzedClass(obj);
    NSCAssert([obj respondsToSelector:aSelector], @"obj:%@ doesn't respondsToSelector:%@", obj, NSStringFromSelector(aSelector));
    
    if (newClass) {
        object_setClass(obj, newClass);
        swizzedSelector(newClass, aSelector);
        objc_setAssociatedObject(obj, aSelector, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
        TokenInfo *token = [[TokenInfo alloc] initWithObj:obj selector:aSelector];
        return token;
    }
    return nil;
}
