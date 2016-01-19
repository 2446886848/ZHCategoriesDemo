//
//  CALayer+ZHAdd.m
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/14.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import "CALayer+ZHAdd.h"

@implementation CALayer (ZHAddForFrame)

- (CGFloat)x
{
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x
{
    CGRect oldFrame = self.frame;
    self.frame = CGRectMake(x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height);
}

- (CGFloat)y
{
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y
{
    CGRect oldFrame = self.frame;
    self.frame = CGRectMake(oldFrame.origin.x, y, oldFrame.size.width, oldFrame.size.height);
}

- (CGFloat)width
{
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width
{
    CGRect oldFrame = self.frame;
    self.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, width, oldFrame.size.height);
}

- (CGFloat)height
{
    return self.frame.size.height;
}
-(void)setHeight:(CGFloat)height
{
    CGRect oldFrame = self.frame;
    self.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, height);
}

- (CGPoint)origin
{
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin
{
    CGRect oldFrame = self.frame;
    self.frame = CGRectMake(origin.x, origin.y, oldFrame.size.width, oldFrame.size.height);
}

- (CGSize)size
{
    return self.bounds.size;
}
- (void)setSize:(CGSize)size
{
    self.width = size.width;
    self.height = size.height;
}

- (CGFloat)centerX
{
    return self.position.x;
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint oldCenter = self.position;
    self.position = CGPointMake(centerX, oldCenter.y);
}

- (CGFloat)centerY
{
    return self.position.y;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint oldCenter = self.position;
    self.position = CGPointMake(oldCenter.x, centerY);
}

- (CGFloat)left
{
    return self.x;
}
- (void)setLeft:(CGFloat)left
{
    self.x = left;
}

- (CGFloat)right
{
    return self.x + self.width;
}
- (void)setRight:(CGFloat)right
{
    self.x = right - self.width;
}

- (CGFloat)top
{
    return self.y;
}
- (void)setTop:(CGFloat)top
{
    self.y = top;
}

- (CGFloat)bottom
{
    return self.y + self.height;
}
- (void)setBottom:(CGFloat)bottom
{
    self.y = bottom - self.height;
}

- (CGPoint)topLeft
{
    return CGPointMake(self.left, self.top);
}
- (void)setTopLeft:(CGPoint)topLeft
{
    self.top = topLeft.y;
    self.left = topLeft.x;
}

- (CGPoint)topRight
{
    return CGPointMake(self.right, self.top);
}
- (void)setTopRight:(CGPoint)topRight
{
    self.top = topRight.y;
    self.right = topRight.x;
}

- (CGPoint)bottomLeft
{
    return CGPointMake(self.x, self.bottom);
}
- (void)setBottomLeft:(CGPoint)bottomLeft
{
    self.left = bottomLeft.x;
    self.bottom = bottomLeft.y;
}

- (CGPoint)bottomRight
{
    return CGPointMake(self.right, self.bottom);
}
- (void)setBottomRight:(CGPoint)bottomRight
{
    self.right = bottomRight.x;
    self.bottom = bottomRight.y;
}

@end

@implementation CALayer (ZHAdd)

@end
