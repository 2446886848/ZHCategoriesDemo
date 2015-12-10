//
//  NSObject+ZHAddForKVO.m
//  YYKitObjKVODemo
//
//  Created by 吴志和 on 15/12/9.
//  Copyright © 2015年 吴志和. All rights reserved.
//

#import "NSObject+ZHAddForKVO.h"
#import <objc/runtime.h>

@interface ZHKVOTarget : NSObject

@property (nonatomic, strong) id observer;
@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, copy) KVOCallbackBlock block;
- (instancetype)initWithObserver:(id _Nonnull)observer keyPath:(NSString * _Nonnull)keyPath block:(KVOCallbackBlock)block;

@end

@implementation ZHKVOTarget

- (instancetype)initWithObserver:(id _Nonnull)observer keyPath:(NSString * _Nonnull)keyPath block:(KVOCallbackBlock)block;
{
    if (self = [super init]) {
        self.observer = observer;
        self.keyPath = keyPath;
        self.block = block;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (!self.block) {
        return;
    }
    if (![keyPath isEqualToString:self.keyPath]) {
        return;
    }
    
    if ([change[NSKeyValueChangeKindKey] integerValue] != NSKeyValueChangeSetting) {
        return;
    }
    
    id oldValue = change[NSKeyValueChangeOldKey];
    id newValue = change[NSKeyValueChangeNewKey];
    
    if (oldValue == [NSNull null]) {
        oldValue = nil;
    }
    if (newValue == [NSNull null]) {
        newValue = nil;
    }
    self.block(oldValue, newValue);
}

@end

@implementation NSObject (ZHAddForKVO)

- (void)addObserver:(id)observer forKeyPath:(NSString *)keyPath usingBlock:(KVOCallbackBlock)block;
{
    NSAssert(observer, @"observer cann't be nil");
    NSAssert(keyPath, @"keyPath cann't be nil");
    
    NSMutableDictionary *targetDictM = [self targetDict];
    
    NSMutableArray *targetArrM = targetDictM[keyPath];
    
    if (!targetArrM) {
        targetArrM = @[].mutableCopy;
        targetDictM[keyPath] = targetArrM;
    }
    
    ZHKVOTarget *target = [[ZHKVOTarget alloc] initWithObserver:observer keyPath:keyPath block:block];
    [self addObserver:target forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    [targetArrM addObject:target];
}

- (void)removeBlockOfObserver:(id)observer
{
    NSAssert(observer, @"observer cann't be nil");
    
    NSMutableDictionary *targetDictM = [self targetDict];
    
    for (NSMutableArray *targetArrM in [targetDictM allValues]) {
        NSMutableArray *removeTargetArrM = @[].mutableCopy;
        
        for (ZHKVOTarget *target in targetArrM) {
            if (target.observer == observer) {
                [self removeObserver:target forKeyPath:target.keyPath];
                [removeTargetArrM addObject:target];
            }
        }
        [targetArrM removeObjectsInArray:removeTargetArrM];
    }
}
- (void)removeBlockOfObserver:(id)observer forKeyPath:(NSString *)keyPath
{
    NSAssert(observer, @"observer cann't be nil");
    NSAssert(keyPath, @"keyPath cann't be nil");
    
    NSMutableDictionary *targetDictM = [self targetDict];
    
    NSMutableArray *targetArrM = targetDictM[keyPath];
    if (!targetArrM) {
        return;
    }
    
    NSMutableArray *removeTargetArrM = @[].mutableCopy;
    for (ZHKVOTarget *target in targetArrM) {
        if (target.observer == observer && [target.keyPath isEqualToString:keyPath]) {
            [self removeObserver:target forKeyPath:keyPath];
            [removeTargetArrM removeObject:target];
            continue;
        }
    }
    [targetArrM removeObjectsInArray:removeTargetArrM];
}

- (NSMutableDictionary *)targetDict
{
    NSMutableDictionary *targetDictM = objc_getAssociatedObject(self, @selector(addObserver:forKeyPath:usingBlock:));
    
    if (!targetDictM || ![targetDictM isKindOfClass:[NSMutableDictionary class]]) {
        targetDictM = @{}.mutableCopy;
        objc_setAssociatedObject(self, @selector(addObserver:forKeyPath:usingBlock:), targetDictM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targetDictM;
}

@end
