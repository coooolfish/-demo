//
//  CutdownView.h
//  CutDownView
//
//  Created by fish tony on 2018/4/18.
//  Copyright © 2018年 fish tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerticalLabel.h"

#define timerWith 20
#define timeSpe 2
#define deHeight 40
#define charWitdth 20


@class CutdownView;

@protocol CutDownDegetal

@optional
-(void)resetCutDownViewStartPoint:(CGPoint)startPoint withWidth:(CGFloat)width withHeight:(CGFloat)height withSelf:(CutdownView *)cutDownView;

@end


typedef enum : NSUInteger {
    Sequence_cutdown = 0, //顺序
    Flashback_cutdown //倒序
} SortType;

typedef enum : NSUInteger {
    charStyleNomal = 0, // 显示 "10:10:02"
    charStyleDetail // 显示 “10时10分02秒”
} CharStyle;

@interface CutdownView : UIView

@property (assign, nonatomic) BOOL cutDownSelf; //是否自带到timer(默认自带)

@property (weak, nonatomic) id<CutDownDegetal> delegate;

@property (assign, nonatomic) CharStyle charStyle; //时分秒等 的样式 默认10:10:02
@property (assign, nonatomic) SortType sortType; //顺序还是倒序 默认倒序
@property (nonatomic,assign) VerticalAlignment verticalAlignment; //文本 垂直布局样式

@property (assign, nonatomic) double timeInterver; // 倒计时时间戳
// 或者直接传入具体时间
@property (copy, nonatomic) NSString *day;
@property (copy, nonatomic) NSString *hour;
@property (copy, nonatomic) NSString *minute;
@property (copy, nonatomic) NSString *second;
@property (assign, nonatomic) NSInteger ms;

@property (assign, nonatomic) BOOL showMS;

@property (strong, nonatomic) UIColor *timeColor;
@property (strong, nonatomic) UIColor *charColor;

@property (assign, nonatomic) BOOL showLastChar;

@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat perWidth; //间隔
@property (assign, nonatomic) CGFloat itemWidth; //时间的宽度
@property (assign, nonatomic) CGFloat flagWidth;// “时、分、秒等”的宽度

//color
@property (copy, nonatomic) UIColor *itemBackgroundColor;
@property (copy, nonatomic) UIColor *itemColor;
@property (copy, nonatomic) UIColor *MSBackGroundColor;
@property (copy, nonatomic) UIColor *MSColor;
@property (copy, nonatomic) UIColor *flagBackgroundColor;
@property (copy, nonatomic) UIColor *flagColor;

@property (strong, nonatomic) UIFont *deTimeFont;


-(void)updataView;

@end

