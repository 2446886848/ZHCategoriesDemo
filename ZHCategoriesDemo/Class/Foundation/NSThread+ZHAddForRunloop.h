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
 *  返回一个带有runloop的线程实例
 *
 *  @param threadName 线程的名称
 *
 *  @return 带有runloop的线程实例
 */
+ (instancetype)zh_threadWithRunloopNamed:(NSString *)threadName;

/**
 *  结束当前线程
 */
- (void)zh_exit;

@end
