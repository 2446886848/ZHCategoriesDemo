//
//  NSThread+ZHAddForRunloop.m
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/10.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import "NSThread+ZHAddForRunloop.h"
#import <objc/runtime.h>
#import <CoreFoundation/CoreFoundation.h>

@implementation NSThread (ZHAddForRunloop)

/**
 *  返回一个带runloop的NSThread 单例
 *
 *  @return 带runloop的NSThread 单例
 */
+ (instancetype)zh_sharedThreadWithRunloop
{
    static NSThread *thread = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        thread = [[self alloc] initWithTarget:self selector:@selector(zh_threadEntryPoint:) object:nil];
        [thread start];
    });
    return thread;
}

+ (void)zh_threadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:[NSString stringWithFormat:@"ZHAddForRunloopThread"]];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

@end
