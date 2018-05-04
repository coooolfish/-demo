//
//  ViewController.m
//  倒计时
//
//  Created by fish tony on 2018/5/3.
//  Copyright © 2018年 fish tony. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"
#import "DemoTableViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableView;
    NSArray *datas;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    datas = @[@{@"id":@"1001", @"text":@"normal"},
              @{@"id":@"1002", @"text":@"tableView"}];
    
    
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = datas[indexPath.row][@"text"];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger num = [datas[indexPath.row][@"id"] integerValue];
    if ( num==1001 ) {
        [self.navigationController pushViewController:[DemoViewController new] animated:YES];
    }
    else{
        [self.navigationController pushViewController:[DemoTableViewController new] animated:YES];
    }
    
}

@end

