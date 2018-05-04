//
//  DemoTableViewController.m
//  倒计时
//
//  Created by fish tony on 2018/5/3.
//  Copyright © 2018年 fish tony. All rights reserved.
//

#import "DemoTableViewController.h"
#import "CutModel.h"
#import "CutDownCell.h"

@interface DemoTableViewController ()<UITableViewDelegate,UITableViewDataSource,CutDownCellDelegate>{
    UITableView *tableView;
    NSMutableArray *datas;
}
@end

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    tableView.delegate = self;
    //    tableView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:tableView];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        datas = [NSMutableArray array];
        for (NSInteger i=0; i<100; i++) {
            CutModel *model = [[CutModel alloc] init];
            NSInteger dayInt = arc4random() % 365;
            if (dayInt<100) {
                model.day = [NSString stringWithFormat:@"0%lD", (long)dayInt];
            }
            else{
                model.day = [NSString stringWithFormat:@"%lD", (long)dayInt];
            }
            
            model.hour = [NSString stringWithFormat:@"%D", arc4random() % 23];
            model.minute = [NSString stringWithFormat:@"%D", arc4random() % 59];
            model.second = [NSString stringWithFormat:@"%D", arc4random() % 59];
            
            model.showMS = YES;
            model.ms = arc4random()%9;
            
            [datas addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableView reloadData];
        });
        
    });
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        for (CutModel *mode in datas) {
            [mode cutdownMS];
        }
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CutDownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[CutDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.delegate = self;
    [cell setData:datas[indexPath.row] index:indexPath];
    
    return cell;
}

-(void)cutdownFinish:(NSIndexPath *)indexPath{
    NSLog(@"倒计时结束%lD", (long)indexPath.row);
}

@end

