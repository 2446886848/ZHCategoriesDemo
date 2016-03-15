//
//  UIView+ZHAdd.m
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/12.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import "UIView+ZHAdd.h"

@implementation UIView (ZHAddForImage)

/**
 *  捕捉屏幕生成图片
 *
 *  @return 当前view的图片
 */
- (UIImage *)zh_imageCaptured
{
    return [self zh_imageCapturedAfterScreenUpdates:NO];
}

/**
 *  捕捉屏幕生成图片
 *
 *  @param afterUpdates 是否需要等待更新
 *
 *  @return 当前view的图片
 */
- (UIImage *)zh_imageCapturedAfterScreenUpdates:(BOOL)afterUpdates
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end

@implementation UIView (ZHAddForFrame)

- (CGFloat)zh_x
{
    return self.frame.origin.x;
}
- (void)setZh_x:(CGFloat)zh_x
{
    CGRect oldFrame = self.frame;
    self.frame = CGRectMake(zh_x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height);
}

- (CGFloat)zh_y
{
    return self.frame.origin.y;
}
- (void)setZh_y:(CGFloat)zh_y
{
    CGRect oldFrame = self.frame;
    self.frame = CGRectMake(oldFrame.origin.x, zh_y, oldFrame.size.width, oldFrame.size.height);
}

- (CGFloat)zh_width
{
    return self.frame.size.width;
}
- (void)setZh_width:(CGFloat)zh_width
{
    CGRect oldFrame = self.frame;
    self.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, zh_width, oldFrame.size.height);
}

- (CGFloat)zh_height
{
    return self.frame.size.height;
}
- (void)setZh_height:(CGFloat)zh_height
{
    CGRect oldFrame = self.frame;
    self.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, zh_height);
}

- (CGPoint)zh_origin
{
    return self.frame.origin;
}

- (void)setZh_origin:(CGPoint)zh_origin
{
    CGRect oldFrame = self.frame;
    self.frame = CGRectMake(zh_origin.x, zh_origin.y, oldFrame.size.width, oldFrame.size.height);
}

- (CGSize)zh_size
{
    return self.bounds.size;
}

- (void)setZh_size:(CGSize)zh_size
{
    self.zh_width = zh_size.width;
    self.zh_height = zh_size.height;
}

- (CGFloat)zh_centerX
{
    return self.center.x;
}

- (void)setZh_centerX:(CGFloat)zh_centerX
{
    CGPoint oldCenter = self.center;
    self.center = CGPointMake(zh_centerX, oldCenter.y);
}

- (CGFloat)zh_centerY
{
    return self.center.y;
}

- (void)setZh_centerY:(CGFloat)zh_centerY
{
    CGPoint oldCenter = self.center;
    self.center = CGPointMake(oldCenter.x, zh_centerY);
}

- (CGFloat)zh_left
{
    return self.zh_x;
}
- (void)setZh_left:(CGFloat)zh_left
{
    self.zh_x = zh_left;
}

- (CGFloat)zh_right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setZh_right:(CGFloat)zh_right
{
    self.zh_x = zh_right - self.zh_width;
}

- (CGFloat)zh_top
{
    return self.zh_y;
}
- (void)setZh_top:(CGFloat)zh_top
{
    self.zh_y = zh_top;
}

- (CGFloat)zh_bottom
{
    return CGRectGetMaxY(self.frame);
}
- (void)setZh_bottom:(CGFloat)zh_bottom
{
    self.zh_y = zh_bottom - self.zh_height;
}

- (CGPoint)zh_topLeft
{
    return CGPointMake(self.zh_left, self.zh_top);
}
- (void)setZh_topLeft:(CGPoint)zh_topLeft
{
    self.zh_top = zh_topLeft.y;
    self.zh_left = zh_topLeft.x;
}

- (CGPoint)zh_topRight
{
    return CGPointMake(self.zh_right, self.zh_top);
}
- (void)setZh_topRight:(CGPoint)zh_topRight
{
    self.zh_top = zh_topRight.y;
    self.zh_right = zh_topRight.x;
}

- (CGPoint)zh_bottomLeft
{
    return CGPointMake(self.zh_left, self.zh_bottom);
}
- (void)setZh_bottomLeft:(CGPoint)zh_bottomLeft
{
    self.zh_left = zh_bottomLeft.x;
    self.zh_bottom = zh_bottomLeft.y;
}

- (CGPoint)zh_bottomRight
{
    return CGPointMake(self.zh_right, self.zh_bottom);
}
- (void)setZh_bottomRight:(CGPoint)zh_bottomRight
{
    self.zh_left = zh_bottomRight.x;
    self.zh_bottom = zh_bottomRight.y;
}

@end

@implementation UIView (ZHADDForRelationship)

/**
 *  获取一个view所在的UIViewController
 */
- (UIViewController *)zh_viewController
{
    id nextResponder = [self nextResponder];
    while (nextResponder) {
        if ( [nextResponder isKindOfClass:[UIViewController class]]) {
            return nextResponder;
        }
        nextResponder = [nextResponder nextResponder];
    }
    return nil;
}

/**
 *  删除所有的子view
 */
- (void)zh_removeAllSubviews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
