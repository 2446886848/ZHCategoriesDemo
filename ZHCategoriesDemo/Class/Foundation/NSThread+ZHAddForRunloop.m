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

static NSMutableDictionary *g_RunloopedThreadDictM = nil;

@implementation NSThread (ZHAddForRunloop)

/**
 *  返回一个带有runloop的线程实例
 *
 *  @param threadName 线程的名称
 *
 *  @return 带有runloop的线程实例
 */
+ (instancetype)zh_threadWithRunloopNamed:(NSString *)threadName;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_RunloopedThreadDictM = @{}.mutableCopy;
    });
    
    //如果已经存在线程
    if (g_RunloopedThreadDictM[threadName]) {
        return g_RunloopedThreadDictM[threadName];
    }
    else
    {
        NSThread *thread = [[self alloc] initWithTarget:self selector:@selector(zh_threadEntryPoint:) object:nil];
        thread.name = threadName;
        [thread start];
        if (thread) {
            g_RunloopedThreadDictM[threadName] = thread;
        }
        return thread;
    }
}

+ (void)zh_threadEntryPoint:(id)__unused object {
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

/**
 *  结束当前线程
 */
- (void)zh_exit
{
    if (g_RunloopedThreadDictM[self.name]) {
        [g_RunloopedThreadDictM removeObjectForKey:self.name];
        [NSThread performSelector:@selector(exit) onThread:self withObject:nil waitUntilDone:NO];
    }
}

@end
