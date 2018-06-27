//
//  ViewController.m
//  DevTools
//
//  Created by chenfei on 2018/6/26.
//  Copyright © 2018年 c.f. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+Category.h"
#import "NSDictionary+Category.h"
#import "NSString+Category.h"
#import "NSDateManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary* dict = @{@"id":@"123",@"name":@"zhangsan",@"sex":@1,@"age":@20};
    [dict propertyCode];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
