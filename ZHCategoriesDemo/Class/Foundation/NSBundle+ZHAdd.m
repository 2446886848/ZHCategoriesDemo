//
//  NSBundle+ZHAdd.m
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/13.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import "NSBundle+ZHAdd.h"

@implementation NSBundle (ZHAdd)

/**
 *  获取当前包的名称
 *
 *  @return 当前包的名称
 */
+ (NSString *)zh_bundleName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

/**
 *  获取当前包的bundleId
 *
 *  @return 当前包的bundleId
 */
+ (NSString *)zh_bundleID
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

/**
 *  获取当前包的appVersion
 *
 *  @return 当前包的appVersion
 */
+ (NSString *)zh_appVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

/**
 *  获取当前包的appBuildVersion
 *
 *  @return 当前包的appBuildVersion
 */
+ (NSString *)zh_appBuildVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

@end
