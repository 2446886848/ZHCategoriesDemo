//
//  UIApplication+ZHAdd.m
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/13.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import "UIApplication+ZHAdd.h"

@implementation UIApplication (ZHAdd)

/**
 *  获取当前应用的Documents目录的URL
 *
 *  @return Documents目录的URL
 */
+ (NSURL *)zh_documentUrl
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSAllDomainsMask] lastObject];
}

/**
 *  获取当前应用的Documents目录的路径
 *
 *  @return Documents目录的路径
 */
+ (NSString *)zh_documentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

/**
 *  获取当前应用的Library目录的URL
 *
 *  @return @return Library目录的URL
 */
+ (NSURL *)zh_libraryUrl
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
}

/**
 *  获取当前应用的Library目录的路径
 *
 *  @return Library目录的路径
 */
+ (NSString *)zh_libraryPath
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

/**
 *  获取当前应用的Caches目录的URL
 *
 *  @return @return Caches目录的URL
 */
+ (NSURL *)zh_cacheUrl
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

/**
 *  获取当前应用的Caches目录的路径
 *
 *  @return Caches目录的路径
 */
+ (NSString *)zh_cachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

@end
