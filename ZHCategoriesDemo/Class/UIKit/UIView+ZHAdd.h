//
//  UIView+ZHAdd.h
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/12.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZHAddForImage)

/**
 *  捕捉屏幕生成图片
 *
 *  @return 当前view的图片
 */
- (UIImage *)zh_imageCaptured;

/**
 *  捕捉屏幕生成图片
 *
 *  @param afterUpdates 是否需要等待更新
 *
 *  @return 当前view的图片
 */
- (UIImage *)zh_imageCapturedAfterScreenUpdates:(BOOL)afterUpdates;

@end

@interface UIView (ZHADDForRelationship)

/**
 *  获取一个view所在的UIViewController
 */
@property (nonatomic, readonly, strong) UIViewController *zh_viewController;

/**
 *  删除所有的子view
 */
- (void)zh_removeAllSubviews;

@end


@interface UIView (ZHAddForFrame)

@property (nonatomic, assign) CGFloat zh_x;
@property (nonatomic, assign) CGFloat zh_y;
@property (nonatomic, assign) CGFloat zh_width;
@property (nonatomic, assign) CGFloat zh_height;
@property (nonatomic, assign) CGPoint zh_origin;
@property (nonatomic, assign) CGSize  zh_size;

@property (nonatomic, assign) CGFloat zh_centerX;
@property (nonatomic, assign) CGFloat zh_centerY;

@property (nonatomic, assign) CGFloat zh_left;
@property (nonatomic, assign) CGFloat zh_right;
@property (nonatomic, assign) CGFloat zh_top;
@property (nonatomic, assign) CGFloat zh_bottom;

@property (nonatomic, assign) CGPoint zh_topLeft;
@property (nonatomic, assign) CGPoint zh_topRight;
@property (nonatomic, assign) CGPoint zh_bottomLeft;
@property (nonatomic, assign) CGPoint zh_bottomRight;

@end
