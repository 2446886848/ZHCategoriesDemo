//
//  UIControl+ZHAdd.m
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/14.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import "UIControl+ZHAdd.h"
#import <objc/runtime.h>

@interface ZHControlEventTarget : NSObject

@property (nonatomic, assign) const void *key;
@property (nonatomic, assign) UIControlEvents controlEvents;
@property (nonatomic, copy) ZHControlCallBackBlock callBackBlock;

- (instancetype)initWithKey:(const void *)key contolEvents:(UIControlEvents)controlEvents callBackBlock:(ZHControlCallBackBlock)callBackBlock;

- (void)invoke:(id)sender;

@end

@implementation ZHControlEventTarget

- (instancetype)initWithKey:(const void *)key contolEvents:(UIControlEvents)controlEvents callBackBlock:(ZHControlCallBackBlock)callBackBlock
{
    if (self = [super init]) {
        self.key = key;
        self.controlEvents = controlEvents;
        self.callBackBlock = callBackBlock;
    }
    return self;
}

- (void)invoke:(id)sender
{
    self.callBackBlock(sender);
}

@end

@implementation UIControl (ZHAdd)

- (void)addBlockForControlEvents:(UIControlEvents)controlEvents key:(const void *)key block:(ZHControlCallBackBlock)callBackBlock
{
    NSAssert(controlEvents, @"controlEvents cann't be nil");
    NSAssert(callBackBlock, @"callBackBlock cann't be nil");
    if (!controlEvents || !callBackBlock) {
        return;
    }
    
    ZHControlEventTarget *eventTarget = [[ZHControlEventTarget alloc] initWithKey:key contolEvents:controlEvents callBackBlock:callBackBlock];
    [self addTarget:eventTarget action:@selector(invoke:) forControlEvents:controlEvents];
    [[self zh_eventTargetArrM] addObject:eventTarget];
}

- (void)removeControlEventsBlockFroKey:(const void *)key
{
    NSMutableArray *deleteTargetArrM = @[].mutableCopy;
    for (ZHControlEventTarget *eventTarget in [self zh_eventTargetArrM]) {
        if (eventTarget.key == key) {
            [deleteTargetArrM addObject:eventTarget];
        }
    }
    [[self zh_eventTargetArrM] removeObjectsInArray:deleteTargetArrM];
}

- (NSMutableArray *)zh_eventTargetArrM
{
    NSMutableArray *arrM = objc_getAssociatedObject(self, @selector(zh_eventTargetArrM));
    if (!arrM) {
        arrM = @[].mutableCopy;
        objc_setAssociatedObject(self, @selector(zh_eventTargetArrM), arrM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return arrM;
}

@end
