//
//  ViewController.m
//  DevTools
//
//  Created by chenfei on 2018/6/26.
//  Copyright © 2018年 c.f. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary* dict = @{@"id":@"123",@"name":@"zhangsan",@"sex":@1,@"age":@20};
    [dict propertyCode];
    [DevTools setSysVolumWith:1.0];
    NSLog(@"%.2f", [DevTools getSystemVolumValue]);
    UITableView* tableView = CreateTableView(self);
    tableView.frame = self.view.bounds;
    [self.view addSubview: tableView];
    NSLog(@"%.2f", KNavBarHeight);
    TableViewZeroFooter(tableView);
    TableViewSepartor(tableView, 1);
    NSLog(@"%@", APP_COPYRIGHT(@"大黑狗"));
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = @"111";
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
