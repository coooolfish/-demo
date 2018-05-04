//
//  DemoViewController.m
//  倒计时
//
//  Created by fish tony on 2018/5/3.
//  Copyright © 2018年 fish tony. All rights reserved.
//

#import "DemoViewController.h"
#import "CutdownView.h"

@interface DemoViewController ()<CutDownDegetal>

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CutdownView *cutDownView = [[CutdownView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, self.view.frame.size.height)];
    cutDownView.delegate = self;
    cutDownView.backgroundColor = [UIColor yellowColor];
    cutDownView.day = @"360";
    cutDownView.hour = [NSString stringWithFormat:@"%d", arc4random() % 23];
    cutDownView.minute = [NSString stringWithFormat:@"%d", arc4random() % 59];
    cutDownView.second = [NSString stringWithFormat:@"%d", arc4random() % 59];
    cutDownView.perWidth = 2;
    cutDownView.flagWidth = 5;
    cutDownView.itemWidth = 15;
    cutDownView.height = 20;
    cutDownView.charStyle = charStyleDetail;
    cutDownView.showMS = YES;
    cutDownView.MSBackGroundColor = [UIColor blackColor];
    cutDownView.MSColor = [UIColor redColor];
    [self.view addSubview:cutDownView];
    
}

#pragma mark - CutDownDegetal
-(void)resetCutDownViewStartPoint:(CGPoint)startPoint withWidth:(CGFloat)width withHeight:(CGFloat)height withSelf:(CutdownView *)cutDownView{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CGPoint center = CGPointMake(arc4random() % 100 + 100, arc4random() % 500 + 200);
            cutDownView.center = center;
        });
        
    }];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
}

@end

