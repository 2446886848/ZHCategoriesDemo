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
 *  为一个UIControl添加事件
 *
 *  @param target        添加的
 *  @param controlEvents <#controlEvents description#>
 *  @param callBackBlock <#callBackBlock description#>
 */
- (void)zh_addTarget:(id)target forControlEvents:(UIControlEvents)controlEvents withBlock:(ZHControlCallBackBlock)callBackBlock;

@end
