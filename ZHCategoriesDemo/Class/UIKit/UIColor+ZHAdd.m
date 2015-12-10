//
//  UIColor+ZHAdd.m
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/10.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import "UIColor+ZHAdd.h"

#define ZHCOLORMAXVALUE 255.0

@implementation UIColor (ZHAdd)

+ (instancetype)zh_colorWithRGB:(NSInteger)rgbValue
{
    return [self zh_colorWithRGB:rgbValue alpha:1.0];
}

+ (instancetype)zh_colorWithRGB:(NSInteger)rgbValue alpha:(CGFloat)alpha
{
    NSAssert(alpha >= 0.0, @"alpha should be greater than 0");
    NSAssert(alpha <= 1.0, @"alpha should be smaller than 1");
    
    NSInteger rValue = rgbValue & 0xFF0000;
    NSInteger gValue = rgbValue & 0xFF00;
    NSInteger bValue = rgbValue & 0xFF;
    
    CGFloat r = (rValue >> 16) / 255.0;
    CGFloat g = (gValue >> 8) / 255.0;
    CGFloat b = (bValue >> 0) / 255.0;
    return [self colorWithRed:r green:g blue:b alpha:alpha];
}

- (NSInteger)zh_RGBValue
{
    CGFloat rValue = 0;
    CGFloat gValue = 0;
    CGFloat bValue = 0;
    
    [self getRed:&rValue green:&gValue blue:&bValue alpha:NULL];
    
    return ((NSInteger)(rValue * 255.0) << 16) + ((NSInteger)(gValue * 255.0) << 8) + ((NSInteger)(bValue * 255.0) << 0);
}

- (NSInteger)zh_rValue
{
    CGFloat rValue = 0;
    
    [self getRed:&rValue green:NULL blue:NULL alpha:NULL];
    
    return (NSInteger)(rValue * 255.0);
}

- (NSInteger)zh_gValue
{
    CGFloat gValue = 0;
    
    [self getRed:NULL green:&gValue blue:NULL alpha:NULL];
    
    return (NSInteger)(gValue * 255.0);
}

- (NSInteger)zh_bValue
{
    CGFloat bValue = 0;
    
    [self getRed:NULL green:&bValue blue:NULL alpha:NULL];
    
    return (NSInteger)(bValue * 255.0);
}

- (CGFloat)zh_aValue
{
    CGFloat aValue = 0;
    
    [self getRed:NULL green:NULL blue:NULL alpha:&aValue];
    
    return aValue;
}
@end
