//
//  UIImage+ZHAdd.m
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/12.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import "UIImage+ZHAdd.h"
#import "UIView+ZHAdd.h"

@implementation UIImage (ZHAdd)

/**
 *  获取应用的启动图
 *
 *  @return 应用的启动图
 */
+ (instancetype)zh_launchImage
{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = @"Portrait";    //横屏请设置成 @"Landscape"
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    
    if (!launchImageName) {
        return nil;
    }
    NSString *launchImagePath = [self zh_availablePathWithImageName:launchImageName];

    return [UIImage imageWithContentsOfFile:launchImagePath];
}

/**
 *  根据传入的图片名称，查找适合的图片路径
 *
 *  @param imageName 图片名称
 *
 *  @return 图片路径
 */
+ (NSString *)zh_availablePathWithImageName:(NSString *)imageName
{
    //自带后缀名，直接返回文件路径
    if ([imageName componentsSeparatedByString:@"."].count >= 2) {
        return [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    }
    
    NSArray *scaleArr = nil;
    switch ((UInt8)[UIScreen mainScreen].scale) {
        case 3:
            scaleArr = @[@"@3x", @"@2x", @""];
            break;
        case 2:
            scaleArr = @[@"@2x", @"", @"@3x"];
            break;
        case 1:
            scaleArr = @[@"", @"@2x", @"@3x"];
            break;
        default:
            break;
    }
    
    for (NSString *scaleStr in scaleArr) {
        NSString *combinedImageName = [imageName stringByAppendingFormat:@"%@.png", scaleStr];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:combinedImageName ofType:nil];
        if (imagePath) {
            return imagePath;
        }
    }
    return nil;
}

@end

@implementation UIImage (ZHAddForClip)

- (UIImage *)zh_cornerClipedImage
{
    return [self zh_cornerClipedImageWithBackGroundColor:nil];
}

- (UIImage *)zh_cornerClipedImageWithBackGroundColor:(UIColor *)bgColor
{
    if ([bgColor isEqual:[UIColor clearColor]]) {
        bgColor = nil;
    }
    //计算考虑到scale的尺寸
    CGSize selfSize = CGSizeMake(self.size.width, self.size.height);
    
    //保存之前的绘图上下文
    UIGraphicsPushContext(UIGraphicsGetCurrentContext());
    
    //开始一个没有透明背景的上下文
    if (!bgColor) {
        UIGraphicsBeginImageContextWithOptions(selfSize, NO, self.scale);
    }
    else
    {
        UIGraphicsBeginImageContextWithOptions(selfSize, YES, self.scale);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect imageRect = CGRectMake(0, 0, selfSize.width, selfSize.height);
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:imageRect];
    
    if (bgColor) {
        [bgColor setFill];
        CGContextFillRect(context, imageRect);
    }
    
    //剪切上下文
    [ovalPath addClip];
    CGContextAddPath(context, ovalPath.CGPath);
    
    [self drawInRect:CGRectMake(0, 0, selfSize.width, selfSize.height)];
    
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //恢复上下文
    UIGraphicsPopContext();
    return image;
}

- (void)zh_asyncCornerClipComplete:(void(^)(UIImage *newImage))block
{
    [self zh_asyncCornerClipWithPath:^CGPathRef(CGFloat imageWidth, CGFloat imageHeight) {
        return [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, imageWidth, imageHeight)].CGPath;
    } complete:block];
}

- (void)zh_asyncCornerClipWithPath:(CGPathRef(^)(CGFloat imageWidth, CGFloat imageHeight))pathBlock complete:(void(^)(UIImage *newImage))block
{
    NSParameterAssert(block);
    if (!block) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        CGImageRef imageRef = self.CGImage;
        size_t inputWidth = CGImageGetWidth(imageRef);
        size_t inputHeight = CGImageGetHeight(imageRef);
        size_t bytesPerPixel = 4;
        size_t bitsPerComponent = 8;
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        UInt32 *inputPixels = (UInt32 *)calloc(inputHeight * inputWidth, sizeof(UInt32));
        
        CGContextRef context = CGBitmapContextCreate(inputPixels, inputWidth, inputHeight,
                                                     bitsPerComponent, bytesPerPixel * inputWidth, colorSpace,
                                                     kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
        if (pathBlock) {
            CGContextAddPath(context, pathBlock(inputWidth, inputHeight));
            
            CGContextClip(context);
        }
        
        CGContextDrawImage(context, CGRectMake(0, 0, inputWidth, inputHeight), imageRef);
        
        CGImageRef newImageRef = CGBitmapContextCreateImage(context);
        UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:self.scale orientation:self.imageOrientation];
        
        CGContextRelease(context);
        CGColorSpaceRelease(colorSpace);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(newImage);
        });
    });
}

@end
