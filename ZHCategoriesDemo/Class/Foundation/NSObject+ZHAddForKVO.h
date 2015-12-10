//
//  NSObject+ZHAddForKVO.h
//  YYKitObjKVODemo
//
//  Created by 吴志和 on 15/12/9.
//  Copyright © 2015年 吴志和. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^KVOCallbackBlock)(id oldValue, id newValue);

@interface NSObject (ZHAddForKVO)

- (void)addObserver:(id)observer forKeyPath:(NSString *)keyPath usingBlock:(KVOCallbackBlock)block;

- (void)removeBlockOfObserver:(id)observer;
- (void)removeBlockOfObserver:(id)observer forKeyPath:(NSString *)keyPath;

@end
