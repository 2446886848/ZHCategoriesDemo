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

@property (nonatomic, unsafe_unretained) id target;
@property (nonatomic, assign) UIControlEvents controlEvents;
@property (nonatomic, copy) ZHControlCallBackBlock callBackBlock;

- (instancetype)initWithTarget:(id)target contolEvents:(UIControlEvents)controlEvents callBackBlock:(ZHControlCallBackBlock)callBackBlock;

- (void)invoke:(id)sender;

@end

@implementation ZHControlEventTarget

- (instancetype)initWithTarget:(id)target contolEvents:(UIControlEvents)controlEvents callBackBlock:(ZHControlCallBackBlock)callBackBlock
{
    if (self = [super init]) {
        self.target = target;
        self.controlEvents = controlEvents;
        self.callBackBlock = callBackBlock;
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"ZHControlEventTarget dealloc");
}

- (void)invoke:(id)sender
{
    self.callBackBlock(sender);
}

@end

@implementation UIControl (ZHAdd)

- (void)zh_addTarget:(id)target forControlEvents:(UIControlEvents)controlEvents withBlock:(ZHControlCallBackBlock)callBackBlock
{
    NSAssert(controlEvents, @"controlEvents cann't be nil");
    NSAssert(callBackBlock, @"callBackBlock cann't be nil");
    if (!controlEvents || !callBackBlock) {
        return;
    }
    
    ZHControlEventTarget *eventTarget = [[ZHControlEventTarget alloc] initWithTarget:target contolEvents:controlEvents callBackBlock:callBackBlock];
    [self addTarget:eventTarget action:@selector(invoke:) forControlEvents:controlEvents];
    [[self zh_eventTargetArrM] addObject:eventTarget];
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
