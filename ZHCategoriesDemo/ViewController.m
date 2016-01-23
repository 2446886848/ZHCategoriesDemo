//
//  ViewController.m
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/10.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+ZHAddForKVO.h"
#import "Person.h"
#import "Dog.h"
#import "NSThread+ZHAddForRunloop.h"
#import "UIColor+ZHAdd.h"
#import "UIView+ZHAdd.h"
#import "CALayer+ZHAdd.h"
#import "UIImage+ZHAdd.h"
#import "UIApplication+ZHAdd.h"
#import "NSBundle+ZHAdd.h"
#import "UIControl+ZHAdd.h"
#import "ZHControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor zh_colorWithRGB:0xf0ffff alpha:1.0];
    
    NSLog(@"%f", [self.view.backgroundColor zh_aValue]);
    
//    self.view.backgroundColor = [UIColor zh_colorWithRGB:0xff0000];
    
//    [self testObjectKVO];
//    
//    [self testThreadContainsRunloop];
    
//    [self testViewCategories];
//    [self testLayerCategories];
    
//    [self testRoundedImage];
//    [self testApplicationPath];
    
//    [self testBundle];
    
    [self testControlBlock];
    
}

- (void)testControlBlock
{
    __unsafe_unretained id value = nil;
    {
        ZHControl *control = [[ZHControl alloc] init];
        control.frame = CGRectMake(100, 100, 100, 100);
        control.backgroundColor = [UIColor redColor];
        [self.view addSubview:control];
        
        [control addBlockForControlEvents:UIControlEventTouchUpInside key:@selector(testControlBlock) block:^(id sender) {
            NSLog(@"%@", sender);
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [control removeControlEventsBlockFroKey:@selector(testControlBlock)];
        });
        value = control;
    }
    
    
}

- (void)testBundle
{
    NSLog(@"bundleName = %@, bundleId = %@, bundleAppVersion = %@, bundleBuildVersion = %@", [NSBundle zh_bundleName], [NSBundle zh_bundleID], [NSBundle zh_appVersion], [NSBundle zh_appBuildVersion]);
}

- (void)testApplicationPath
{
    NSLog(@"%@", [UIApplication zh_documentUrl]);
    NSLog(@"%@", [UIApplication zh_documentPath]);
}

- (void)testRoundedImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageView.backgroundColor = [UIColor yellowColor];
    UIImage *image = [UIImage imageNamed:@"add"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        imageView.image = [image zh_imageWithClearRoundWidth:10.0];
    });
    
    [self.view addSubview:imageView];
    
    UIImageView *launchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 200, 200)];
    launchImageView.image = [UIImage zh_launchImage];
    [self.view addSubview:launchImageView];
}

- (void)testViewCategories
{
    UIImage *image = [UIImage imageNamed:@"woniu.jpg"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    view.x = 12323;
    NSAssert(view.x == 12323, @"");
    
    view.y = 422;
    NSAssert(view.y == 422, @"");
    
    view.width = 134;
    NSAssert(view.width == 134, @"");
    
    view.height = 543543;
    NSAssert(view.height == 543543, @"");
    
    view.origin = CGPointMake(43243, 7676);
    NSAssert(CGPointEqualToPoint(view.origin, CGPointMake(43243, 7676)), @"");
    
    view.size = CGSizeMake(3543543, 65465);
    NSAssert(CGSizeEqualToSize(view.size, CGSizeMake(3543543, 65465)), @"");
    
    view.centerX = 5645;
    NSAssert(view.centerX == 5645, @"");
    
    view.centerY = 6546;
    NSAssert(view.centerY == 6546, @"");
    
    view.left = 54353;
    NSAssert(view.left == 54353, @"");
    
    view.right = 54543;
    NSAssert(view.right == 54543, @"");
    
    view.top= 42552;
    NSAssert(view.top == 42552, @"");
    
    view.bottom = 7777;
    NSAssert(view.bottom == 7777, @"");
    
    view.topLeft = CGPointMake(24234, 65465);
    NSAssert(CGPointEqualToPoint(view.topLeft, CGPointMake(24234, 65465)), @"");
    
    view.topRight = CGPointMake(2423422, 654232365);
    NSAssert(CGPointEqualToPoint(view.topRight, CGPointMake(2423422, 654232365)), @"");
    
    view.bottomLeft = CGPointMake(2425534, 6546665);
    NSAssert(CGPointEqualToPoint(view.bottomLeft, CGPointMake(2425534, 6546665)), @"");
    
    view.bottomRight = CGPointMake(2465765234, 6523233465);
    NSAssert(CGPointEqualToPoint(view.bottomRight, CGPointMake(2465765234, 6523233465)), @"");
    
    
    view.layer.contents = (__bridge id)image.CGImage;
    
    NSLog(@"%@", view.zh_viewController);
    [self.view addSubview:view];
    NSLog(@"%@", view.zh_viewController);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImage *capturedImage = [view zh_imageCaptured];
        
        UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
        newView.backgroundColor = [UIColor redColor];
        newView.layer.contents = (__bridge id)capturedImage.CGImage;
        
        [self.view addSubview:newView];
    });
}

- (void)testLayerCategories
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    view.layer.x = 12323;
    NSAssert(view.layer.x == 12323, @"");
    
    view.layer.y = 422;
    NSAssert(view.layer.y == 422, @"");
    
    view.layer.width = 134;
    NSAssert(view.layer.width == 134, @"");
    
    view.layer.height = 543543;
    NSAssert(view.layer.height == 543543, @"");
    
    view.layer.origin = CGPointMake(43243, 7676);
    NSAssert(CGPointEqualToPoint(view.layer.origin, CGPointMake(43243, 7676)), @"");
    
    view.layer.size = CGSizeMake(3543543, 65465);
    NSAssert(CGSizeEqualToSize(view.layer.size, CGSizeMake(3543543, 65465)), @"");
    
    view.layer.centerX = 5645;
    NSAssert(view.layer.centerX == 5645, @"");
    
    view.layer.centerY = 6546;
    NSAssert(view.layer.centerY == 6546, @"");
    
    view.layer.left = 54353;
    NSAssert(view.layer.left == 54353, @"");
    
    view.layer.right = 54543;
    NSAssert(view.layer.right == 54543, @"");
    
    view.layer.top= 42552;
    NSAssert(view.layer.top == 42552, @"");
    
    view.layer.bottom = 7777;
    NSAssert(view.layer.bottom == 7777, @"");
    
    view.layer.topLeft = CGPointMake(24234, 65465);
    NSAssert(CGPointEqualToPoint(view.layer.topLeft, CGPointMake(24234, 65465)), @"");
    
    view.layer.topRight = CGPointMake(2423422, 654232365);
    NSAssert(CGPointEqualToPoint(view.layer.topRight, CGPointMake(2423422, 654232365)), @"");
    
    view.layer.bottomLeft = CGPointMake(2425534, 6546665);
    NSAssert(CGPointEqualToPoint(view.layer.bottomLeft, CGPointMake(2425534, 6546665)), @"");
    
    view.layer.bottomRight = CGPointMake(2465765234, 6523233465);
    NSAssert(CGPointEqualToPoint(view.layer.bottomRight, CGPointMake(2465765234, 6523233465)), @"");
}

- (void)testThreadContainsRunloop
{
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerSchedule) userInfo:nil repeats:YES];
//    [thread cancel];
}
- (void)timerSchedule
{
    [self performSelector:@selector(timerDo) onThread:[NSThread zh_threadWithRunloopNamed:@"aaa"] withObject:nil waitUntilDone:NO];
}

- (void)timerDo
{
    static int i = 1;
    i++;

    NSLog(@"%@", [NSThread currentThread]);
}

- (void)testObjectKVO
{
    Person *person = [[Person alloc] init];
    Dog *dog = [[Dog alloc] init];
    
    person.dog = dog;
    
    [dog zh_addObserver:person  forKeyPath:@"name" usingBlock:^(id observer, NSString *keyPath, id oldValue, id newValue) {
        NSLog(@"observer = %@ keyPath = %@ oldValue = %@ ,newValue = %@",observer, keyPath, oldValue, newValue);
    } ];
    
    [dog zh_addObserver:self  forKeyPath:@"name" usingBlock:^(id observer, NSString *keyPath, id oldValue, id newValue) {
        NSLog(@"observer = %@ keyPath = %@ oldValue = %@ ,newValue = %@",observer, keyPath, oldValue, newValue);
    } ];
    
    [dog zh_addObserver:person  forKeyPath:@"age" usingBlock:^(id observer, NSString *keyPath, id oldValue, id newValue) {
        NSLog(@"observer = %@ keyPath = %@ oldValue = %@ ,newValue = %@",observer, keyPath, oldValue, newValue);
    } ];
    
    dog.name = @"aaa";
    dog.name = @"bbb";
    dog.age = 10;
    
    //    [dog removeAllBlocks];
    //    [dog removeBlockForKeyPath:@"name"];
    //    [dog removeBlockForKeyPath:@"age"];
    //    [dog removeBlockOfObserver:person];
    //    [dog removeBlockOfObserver:self];
    //    [dog removeBlockOfObserver:person forKeyPath:@"name"];
    //    [dog removeBlockOfObserver:person forKeyPath:@"age"];
    dog.age = 20;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
