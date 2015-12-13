//
//  NSBundle+ZHAdd.h
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/13.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (ZHAdd)

/**
 *  获取当前包的名称
 *
 *  @return 当前包的名称
 */
+ (NSString *)zh_bundleName;

/**
 *  获取当前包的bundleId
 *
 *  @return 当前包的bundleId
 */
+ (NSString *)zh_bundleID;

/**
 *  获取当前包的appVersion
 *
 *  @return 当前包的appVersion
 */
+ (NSString *)zh_appVersion;

/**
 *  获取当前包的appBuildVersion
 *
 *  @return 当前包的appBuildVersion
 */
+ (NSString *)zh_appBuildVersion;

@end
