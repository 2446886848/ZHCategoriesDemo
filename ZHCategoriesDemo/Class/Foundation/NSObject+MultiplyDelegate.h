//
//  NSObject+MultiplyDelegate.h
//  MultiplyDelegate
//
//  Created by walen on 16/6/27.
//  Copyright © 2016年 walen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MultiplyDelegate)

/**
 *  为一个对象增加delegate
 *
 *  @param delegate 要增加的Delegate
 */
- (void)zh_addDelegate:(id)delegate;

/**
 *  为一个对象增加delegate
 *
 *  @param delegate 要增加的Delegate
 *  @param key      delegate对应的对象
 */
- (void)zh_addDelegate:(id)delegate forKey:(NSString *)key;

/**
 *  为一个对象移除delegate
 *
 *  @param delegate 要移除的delegate
 */
- (void)zh_removeDelegate:(id)delegate;

/**
 *  为一个对象移除delegate
 *
 *  @param delegate 要移除的delegate
 *  @param key      delegate对应的key
 */
- (void)zh_removeDelegate:(id)delegate forKey:(NSString *)key;

@end
