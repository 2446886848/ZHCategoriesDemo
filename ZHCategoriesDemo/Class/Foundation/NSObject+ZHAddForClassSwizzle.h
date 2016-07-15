//
//  NSObject+ZHAddForClassSwizzle.h
//  ZHCategoriesDemo
//
//  Created by walen on 16/7/15.
//  Copyright © 2016年 wuzhihe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageInfo : NSObject

@property (nonatomic, strong) id instance;
@property (nonatomic, strong) NSInvocation *originalInvocation;
@property (nonatomic, strong, readonly) NSArray *arguments;

@end

@interface TokenInfo : NSObject
- (instancetype)initWithObj:(id)obj selector:(SEL)aSelector;
- (void)dispose;
@property (nonatomic, strong) id instance;
@property (nonatomic, assign) SEL selector;

@end

typedef void(^SwizzleBlock)(MessageInfo *info);

@interface NSObject (ZHAddForClassSwizzle)

- (TokenInfo *)zh_swizzleSelector:(SEL)aSelector usingBlock:(SwizzleBlock)block;

@end
