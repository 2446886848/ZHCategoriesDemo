//
//  NSThread+ZHAddForRunloop.h
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/10.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSThread (ZHAddForRunloop)

/**
 *  返回一个带runloop的NSThread 单例
 *
 *  @return 带runloop的NSThread 单例
 */
+ (instancetype)zh_sharedThreadWithRunloop;

@end
