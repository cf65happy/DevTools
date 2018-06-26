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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString* str = @"1234";
    str = [str substringToIndex:5];
    NSLog(@"%@", str);
    NSString* str1 = @"234";
    str1 = [str1 substringToIndex:5];
    NSLog(@"%@", str1);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
