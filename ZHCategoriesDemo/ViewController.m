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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testObjectKVO];
    
    [self testThreadContainsRunloop];
}

- (void)testThreadContainsRunloop
{
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerSchedule) userInfo:nil repeats:YES];
//    [thread cancel];
}
- (void)timerSchedule
{
    [self performSelector:@selector(timerDo) onThread:[NSThread zh_sharedThreadWithRunloop] withObject:nil waitUntilDone:NO];
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
