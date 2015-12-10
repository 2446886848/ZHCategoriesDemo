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

@property (nonatomic, unsafe_unretained) id kvoedObj;
@property (nonatomic, unsafe_unretained) id observer;
@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, copy) KVOCallbackBlock block;
- (instancetype)initWithObserver:(id)observer keyPath:(NSString *)keyPath block:(KVOCallbackBlock)block;

@end

@implementation ZHKVOTarget

- (instancetype)initWithObserver:(id)observer keyPath:(NSString *)keyPath block:(KVOCallbackBlock)block;
{
    NSAssert(observer, @"observer cann't be nil");
    NSAssert(keyPath, @"keyPath cann't be nil");
    NSAssert(block, @"block cann't be nil");
    
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
    self.block(self.observer, self.keyPath, oldValue, newValue);
}

- (void)dealloc
{
    //销毁时取消监听
    [self.kvoedObj removeObserver:self forKeyPath:self.keyPath];
}

@end

@implementation NSObject (ZHAddForKVO)

/**
 *  为当前对象的成员变量添加监听
 *
 *  @param observer 监听者标识，用于移除某一条监听的标识
 *  @param keyPath  要监听的keyPath
 *  @param block    监听到变化后的回调
 */
- (void)zh_addObserver:(id)observer forKeyPath:(NSString *)keyPath usingBlock:(KVOCallbackBlock)block;
{
    NSAssert(observer, @"observer cann't be nil");
    NSAssert(keyPath, @"keyPath cann't be nil");
    
    NSMutableDictionary *targetDictM = [self zh_targetDict];
    
    NSMutableArray *targetArrM = targetDictM[keyPath];
    
    if (!targetArrM) {
        targetArrM = @[].mutableCopy;
        targetDictM[keyPath] = targetArrM;
    }
    
    ZHKVOTarget *target = [[ZHKVOTarget alloc] initWithObserver:observer keyPath:keyPath block:block];
    target.kvoedObj = self;
    [self addObserver:target forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    [targetArrM addObject:target];
}

/**
 *  移除当前对象所有的监听
 */
- (void)zh_removeAllBlocks
{
    NSMutableDictionary *targetDictM = [self zh_targetDict];
    
    [[targetDictM allKeys] enumerateObjectsUsingBlock:^(NSString  *keyPath, NSUInteger idx, BOOL * stop) {
        [self zh_removeBlockForKeyPath:keyPath];
    }];
}

/**
 *  移除监听者标识对应的所有监听
 *
 *  @param observer 监听者标识
 */
- (void)zh_removeBlockOfObserver:(id)observer
{
    NSAssert(observer, @"observer cann't be nil");
    
    NSMutableDictionary *targetDictM = [self zh_targetDict];
    
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

/**
 *  移除所有keyPath的监听
 *
 *  @param keyPath keyPath标示
 */
- (void)zh_removeBlockForKeyPath:(NSString *)keyPath
{
    NSAssert(keyPath, @"keyPath cann't be nil");
    
    NSMutableDictionary *targetDictM = [self zh_targetDict];
    NSMutableArray *targetArrM = targetDictM[keyPath];
    
    [targetArrM enumerateObjectsUsingBlock:^(ZHKVOTarget *target, NSUInteger idx, BOOL * stop) {
        [self removeObserver:target forKeyPath:keyPath];
    }];
    [targetArrM removeAllObjects];
}

/**
 *  移除指定监听者标示对用的keyPath的监听
 *
 *  @param observer 监听者标识
 *  @param keyPath  keyPath标识
 */
- (void)zh_removeBlockOfObserver:(id)observer forKeyPath:(NSString *)keyPath
{
    NSAssert(observer, @"observer cann't be nil");
    NSAssert(keyPath, @"keyPath cann't be nil");
    
    NSMutableDictionary *targetDictM = [self zh_targetDict];
    
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

- (NSMutableDictionary *)zh_targetDict
{
    NSMutableDictionary *targetDictM = objc_getAssociatedObject(self, @selector(zh_addObserver:forKeyPath:usingBlock:));
    
    if (!targetDictM || ![targetDictM isKindOfClass:[NSMutableDictionary class]]) {
        targetDictM = @{}.mutableCopy;
        objc_setAssociatedObject(self, @selector(zh_addObserver:forKeyPath:usingBlock:), targetDictM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targetDictM;
}

@end
