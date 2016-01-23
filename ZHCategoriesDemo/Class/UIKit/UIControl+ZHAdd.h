//
//  UIControl+ZHAdd.h
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/14.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZHControlCallBackBlock)(id sender);

@interface UIControl (ZHAdd)

/**
 *  为UIControl对象的某一对象添加block回调
 *
 *  @param controlEvents 事件
 *  @param key           标识的key
 *  @param callBackBlock 回调block
 */
- (void)addBlockForControlEvents:(UIControlEvents)controlEvents key:(const void *)key block:(ZHControlCallBackBlock)callBackBlock;

/**
 *  删除key对应的事件响应
 *
 *  @param key 标识的key
 */
- (void)removeControlEventsBlockFroKey:(const void *)key;

@end
