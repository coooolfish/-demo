//
//  CutModel.h
//  倒计时
//
//  Created by fish tony on 2018/5/3.
//  Copyright © 2018年 fish tony. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const cutting = @"cutdowning";
static NSString *const cutfinish = @"cutdownfinish";

@interface CutModel : NSObject

@property (assign, nonatomic) BOOL showMS;

@property (copy, nonatomic) NSString *day;
@property (copy, nonatomic) NSString *hour;
@property (copy, nonatomic) NSString *minute;
@property (copy, nonatomic) NSString *second;
@property (assign, nonatomic) NSInteger ms;

-(void)cutdownMS;
-(void)cutdownSecend;

@end

