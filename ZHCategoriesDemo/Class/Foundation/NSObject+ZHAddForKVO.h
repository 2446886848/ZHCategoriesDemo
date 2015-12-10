//
//  NSObject+ZHAddForKVO.h
//  YYKitObjKVODemo
//
//  Created by 吴志和 on 15/12/9.
//  Copyright © 2015年 吴志和. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^KVOCallbackBlock)(id observer, NSString *keyPath, id oldValue, id newValue);

@interface NSObject (ZHAddForKVO)

/**
 *  为当前对象的成员变量添加监听
 *
 *  @param observer 监听者标识，用于移除某一条监听的标识
 *  @param keyPath  要监听的keyPath
 *  @param block    监听到变化后的回调
 */
- (void)addObserver:(id)observer forKeyPath:(NSString *)keyPath usingBlock:(KVOCallbackBlock)block;

/**
 *  移除当前对象所有的监听
 */
- (void)removeAllBlocks;

/**
 *  移除监听者标识对应的所有监听
 *
 *  @param observer 监听者标识
 */
- (void)removeBlockOfObserver:(id)observer;

/**
 *  移除所有keyPath的监听
 *
 *  @param keyPath keyPath标示
 */
- (void)removeBlockForKeyPath:(NSString *)keyPath;

/**
 *  移除指定监听者标示对用的keyPath的监听
 *
 *  @param observer 监听者标识
 *  @param keyPath  keyPath标识
 */
- (void)removeBlockOfObserver:(id)observer forKeyPath:(NSString *)keyPath;

@end
