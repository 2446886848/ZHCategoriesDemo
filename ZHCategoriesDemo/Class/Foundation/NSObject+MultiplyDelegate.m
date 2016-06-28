//
//  NSObject+MultiplyDelegate.m
//  MultiplyDelegate
//
//  Created by walen on 16/6/27.
//  Copyright © 2016年 walen. All rights reserved.
//

#import "NSObject+MultiplyDelegate.h"
#import <objc/runtime.h>

@interface ZHDelegate : NSObject

@property (nonatomic, strong) NSHashTable *hashTable;

- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;

@end

@implementation ZHDelegate

- (instancetype)init
{
    if (self = [super init]) {
        _hashTable = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (double)timeStampOfObject:(NSObject *)object
{
    return [objc_getAssociatedObject(object, @selector(timeStampOfObject:)) doubleValue];
}

- (void)addTimeStampForObject:(NSObject *)object
{
    double timeStamp = [NSDate timeIntervalSinceReferenceDate];
    objc_setAssociatedObject(object, @selector(timeStampOfObject:), @(timeStamp), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addDelegate:(id)delegate
{
    [self addTimeStampForObject:delegate];
    [self.hashTable addObject:delegate];
}
- (void)removeDelegate:(id)delegate
{
    [self.hashTable removeObject:delegate];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    NSHashTable *table = [self delegatesResponseToSelector:aSelector];
    return table.count > 0;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSHashTable *table = [self delegatesResponseToSelector:aSelector];
    return [[table anyObject] methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL selector = anInvocation.selector;
    
    NSHashTable *table = [self delegatesResponseToSelector:selector];
    
    NSMethodSignature *signature = [table.anyObject methodSignatureForSelector:selector];
    
    id lastDelegate = nil;
    if (![@(signature.methodReturnType) isEqualToString:@"v"]) {
        lastDelegate = [self lastDelegateInHashTable:table];
    }
    for (id delegate in table) {
        if (delegate != lastDelegate) {
            [anInvocation invokeWithTarget:delegate];
        }
    }
    [anInvocation invokeWithTarget:lastDelegate];
}

- (id)lastDelegateInHashTable:(NSHashTable *)hashTable
{
    if (hashTable.count == 0) {
        return nil;
    }
    id lastDelegate = hashTable.anyObject;
    double lastTimeStamp = [self timeStampOfObject:lastDelegate];
    
    for (id delegate in hashTable.allObjects) {
        if ([self timeStampOfObject:delegate] > lastTimeStamp) {
            lastTimeStamp = [self timeStampOfObject:delegate];
            lastDelegate = delegate;
        }
    }
    return lastDelegate;
}

- (NSHashTable *)delegatesResponseToSelector:(SEL)aSelector
{
    NSHashTable *responsedDelegates = [NSHashTable weakObjectsHashTable];
    for (id delegte in self.hashTable.allObjects) {
        if ([delegte respondsToSelector:aSelector]) {
            [responsedDelegates addObject:delegte];
        }
    }
    return responsedDelegates;
}

@end

@implementation NSObject (MultiplyDelegate)

- (const char *)zh_customKeyForKey:(NSString *)key
{
    return [@"ZHDelegate" stringByAppendingString:key].UTF8String;
}

- (ZHDelegate *)zh_delegateForKey:(NSString *)key
{
    return [self valueForKey:key];
}

- (void)zh_setDelegate:(ZHDelegate *)delegate forKey:(NSString *)key
{
    objc_setAssociatedObject(self, [self zh_customKeyForKey:key], delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setValue:delegate forKey:key];
}

- (void)zh_addDelegate:(id)delegate
{
    [self zh_addDelegate:delegate forKey:NSStringFromSelector(@selector(delegate))];
}

- (void)zh_addDelegate:(id)delegate forKey:(NSString *)key
{
    [self zh_checkDelegate:delegate forKey:key];
    
    ZHDelegate *currentDelegate = [self zh_delegateForKey:key];
    //说明已经被直接赋值
    if (currentDelegate && ![currentDelegate isKindOfClass:[ZHDelegate class]]) {
        return;
    }
    if (!currentDelegate) {
        currentDelegate = [[ZHDelegate alloc] init];
        [self zh_setDelegate:currentDelegate forKey:key];
    }
    [currentDelegate addDelegate:delegate];
}

- (void)zh_removeDelegate:(id)delegate
{
    [self zh_removeDelegate:delegate forKey:NSStringFromSelector(@selector(delegate))];
}

- (void)zh_removeDelegate:(id)delegate forKey:(NSString *)key
{
    ZHDelegate *currentDelegate = [self zh_delegateForKey:key];
    //说明已经被直接赋值
    if (![currentDelegate isKindOfClass:[ZHDelegate class]]) {
        return;
    }
    [currentDelegate removeDelegate:delegate];
}

- (BOOL)zh_checkDelegate:(id)delegate forKey:(NSString *)key
{
    NSArray *protocolNames = [self zh_protocolsForClass:self.class forKey:key];
    for (NSString *protocolName in protocolNames) {
        if (![delegate conformsToProtocol:NSProtocolFromString(protocolName)]) {
            NSAssert(YES, @"%@ doesn't conformsToProtocol %@", delegate, NSProtocolFromString(protocolName));
            return NO;
        }
    }
    return YES;
}

- (NSArray *)zh_protocolsForClass:(Class)class forKey:(NSString *)key
{
    objc_property_t property = class_getProperty(class, key.UTF8String);
    if (property == NULL) {
        return nil;
    }
    const char *propertyAttribute = property_getAttributes(property);
    
    NSString *attributeStr = [[NSString alloc] initWithCString:propertyAttribute encoding:NSUTF8StringEncoding];
    
    NSMutableArray *protocolNames = @[].mutableCopy;
    while (attributeStr.length != 0) {
        NSRange leftRange = [attributeStr rangeOfString:@"<"];
        if (leftRange.location != NSNotFound) {
            NSRange rightRange = [attributeStr rangeOfString:@">"];
            if (rightRange.location != NSNotFound) {
                NSString *protocolName = [attributeStr substringWithRange:NSMakeRange(leftRange.location + 1, rightRange.location - leftRange.location - 1)];
                if (protocolName) {
                    [protocolNames addObject:protocolName];
                    attributeStr = [attributeStr substringFromIndex:rightRange.location + 1];
                }
                else
                {
                    attributeStr = nil;
                }
            }
            else
            {
                attributeStr = nil;
            }
        }
        else
        {
            attributeStr = nil;
        }
    }
    return protocolNames;
}

@end
