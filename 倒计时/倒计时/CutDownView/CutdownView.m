//
//  CutdownView.m
//  CutDownView
//
//  Created by fish tony on 2018/4/18.
//  Copyright © 2018年 fish tony. All rights reserved.
//

#import "CutdownView.h"



@interface CutdownView(){
    CGPoint startPoint;
}

@property (weak, nonatomic) NSTimer *timer;

@end

@implementation CutdownView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    startPoint =frame.origin;
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _cutDownSelf = YES;
        //        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        //            NSLog(@"timer");
        //        }];
        //         [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (_height==0) {
        _height = deHeight;
    }
    
    if (!_deTimeFont) {
        _deTimeFont = [UIFont systemFontOfSize:14];
    }
    
    //    @property (assign, nonatomic) CGFloat perWidth; //间隔
    //    @property (assign, nonatomic) CGFloat itemWidth; //时间的宽度
    //    @property (assign, nonatomic) CGFloat flagWidth;// “时、分、秒等”的宽度
    if (_perWidth==0) {
        _perWidth = timeSpe;
    }
    if (_itemWidth==0) {
        _itemWidth = timerWith;
    }
    if (_flagWidth==0) {
        _flagWidth = charWitdth;
    }
    if (_charStyle==charStyleDetail) {
        if (_flagWidth<17) {
            _flagWidth=17;
        }
    }
    
    CGSize newSize;
    
    CGFloat start_x,start_y;
    start_x = 0;
    start_y = startPoint.y;
    
    VerticalLabel *label;
    if (_sortType == Sequence_cutdown) {// 顺序
        if (_day) {
            NSUInteger dayDigit = _day.length;
            for (NSInteger i=0; i<dayDigit; i++) {
                NSRange range = NSMakeRange(i, 1);
                NSString *numStr = [_day substringWithRange:range];
                label = [[VerticalLabel alloc] initWithFrame:CGRectMake(start_x, 0, _itemWidth, _height)];
                label.tag = 10+i;
                if (_itemBackgroundColor) {
                    label.backgroundColor = _itemBackgroundColor;
                }
                if (_itemColor) {
                    label.textColor = _itemColor;
                }
                label.verticalAlignment = _verticalAlignment;
                label.textAlignment = NSTextAlignmentCenter;
                label.text = numStr;
                start_x +=_itemWidth+_perWidth;
                [self addSubview:label];
            }
            
            label = [[VerticalLabel alloc] initWithFrame:CGRectMake(start_x, 0, _flagWidth, _height)];
            label.verticalAlignment = _verticalAlignment;
            label.textAlignment = NSTextAlignmentCenter;
            if (_flagBackgroundColor) {
                label.backgroundColor = _flagBackgroundColor;
            }
            if (_flagColor) {
                label.textColor = _flagColor;
            }
            label.text = @"天";
            [self addSubview:label];
            start_x += _flagWidth+_perWidth;
            
        }
        if (_hour) {
            start_x = [self drawHourMinSen:start_x withString:_hour withFlag:@"时"];
        }
        
        if (_minute) {
            start_x = [self drawHourMinSen:start_x withString:_minute withFlag:@"分"];
        }
        
        if (_second) {
            start_x = [self drawHourMinSen:start_x withString:_second withFlag:@"秒"];
        }
        
        if (_showMS) {
            label = [[VerticalLabel alloc] initWithFrame:CGRectMake(start_x, 0, _flagWidth, _height)];
            if (_MSBackGroundColor) {
                label.backgroundColor = _MSBackGroundColor;
            }
            if (_MSColor) {
                label.textColor = _MSColor;
            }
            label.tag = 1000;
            label.verticalAlignment = _verticalAlignment;
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [NSString stringWithFormat:@"%ld", (long)_ms];
            [self addSubview:label];
            
        }
        
    }
    //    else{// 倒序
    //
    //    }
    
    newSize = CGSizeMake(start_x, _height);
    self.frame = CGRectMake(startPoint.x, startPoint.y, newSize.width, newSize.height);
    
    [_delegate resetCutDownViewStartPoint:startPoint withWidth:newSize.width withHeight:newSize.height withSelf:self];
    
    if(_cutDownSelf){
        if (_showMS) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(cutDown) userInfo:nil repeats:YES];
        }
        else{
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(cutDown) userInfo:nil repeats:YES];
        }
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
}

-(CGFloat)drawHourMinSen:(CGFloat )start_x withString:(NSString *)str withFlag:(NSString *)flagStr{
    VerticalLabel *label;
    NSUInteger strInterger = [str integerValue];
    for (NSInteger i=0; i<2; i++) {
        label = [[VerticalLabel alloc] initWithFrame:CGRectMake(start_x, 0, _itemWidth, _height)];
        if ([flagStr isEqualToString:@"时"]){
            label.tag = 100+i;
        }
        else if ([flagStr isEqualToString:@"分"]){
            label.tag = 200+i;
        }
        else if ([flagStr isEqualToString:@"秒"]){
            label.tag = 300+i;
        }
        
        if (_itemBackgroundColor) {
            label.backgroundColor = _itemBackgroundColor;
        }
        if (_itemColor) {
            label.textColor = _itemColor;
        }
        label.verticalAlignment = _verticalAlignment;
        label.textAlignment = NSTextAlignmentCenter;
        if (i==0) {
            label.text = (strInterger <10 ) ? @"0" : [NSString stringWithFormat:@"%ld", (long)strInterger/10];
        }
        else{
            label.text = (strInterger <10 ) ? [NSString stringWithFormat:@"%ld", strInterger] : [NSString stringWithFormat:@"%ld", (long)strInterger%10];
        }
        [self addSubview:label];
        start_x +=_itemWidth+_perWidth;
    }
    
    label = [[VerticalLabel alloc] initWithFrame:CGRectMake(start_x, 0, _flagWidth, _height)];
    label.verticalAlignment = _verticalAlignment;
    label.textAlignment = NSTextAlignmentCenter;
    if (_flagBackgroundColor) {
        label.backgroundColor = _flagBackgroundColor;
    }
    if (_flagColor) {
        label.textColor = _flagColor;
    }
    [self addSubview:label];
    
    
    if (_charStyle==charStyleNomal) {
        if (_showMS) {
            label.text = @":";
            start_x += _flagWidth+_perWidth;
        }
        else{
            if (![flagStr isEqualToString:@"秒"]) {
                label.text = @":";
                start_x += _flagWidth+_perWidth;
            }
        }
    }
    else{
        label.text = flagStr;
        start_x += _flagWidth+_perWidth;
    }
    
    return  start_x;
    
}


-(void)cutDown{
    
    NSInteger secendInterger = [_second integerValue];
    NSInteger minuteInterger = [_minute integerValue];
    NSInteger hourInterger = [_hour integerValue];
    NSInteger dayInterger = [_day integerValue];
    
    if (_showMS) {
        _ms-=1;
        if (dayInterger==0 && hourInterger==0 && minuteInterger==0 && secendInterger==0 && _ms==0) {
            return;
        }
        if (_ms < 0) {
            secendInterger-=1;
            _ms = 9;
            if (secendInterger < 0) {
                minuteInterger -= 1;
                secendInterger = 59;
                if (minuteInterger < 0) {
                    hourInterger -= 1;
                    minuteInterger = 59;
                    if (hourInterger<0) {
                        dayInterger-=1;
                        hourInterger=23;
                    }
                }
            }
        }
    }
    else{
        secendInterger-=1;
        if (dayInterger==0 && hourInterger==0 && minuteInterger==0 && secendInterger==0 ) {
            return;
        }
        if (secendInterger < 0) {
            minuteInterger -= 1;
            secendInterger = 59;
            if (minuteInterger < 0) {
                hourInterger -= 1;
                minuteInterger = 59;
                if (minuteInterger < 0) {
                    hourInterger -= 1;
                    minuteInterger = 59;
                    if (hourInterger<0) {
                        dayInterger-=1;
                        hourInterger=23;
                    }
                }
            }
        }
    }
    
    _hour = [NSString stringWithFormat:@"%ld", (long)hourInterger];
    _minute = [NSString stringWithFormat:@"%ld", (long)minuteInterger];
    _second = [NSString stringWithFormat:@"%ld", (long)secendInterger];
    if (_day) {
        //        NSInteger dayLength = _day.length;
        //        _day = [NSString stringWithFormat:@"%ld", (long)dayInterger];
        NSMutableString *num = [NSMutableString string];
        for (NSInteger i=0; i<_day.length; i++) {
            if ((int)pow(10, _day.length-(i+1)) > dayInterger) {
                [num appendString:@"0"];
            }
            else
                break;
        }
        [num appendString:[NSString stringWithFormat:@"%ld", (long)dayInterger]];
        _day = num;
    }
    
    
    NSLog(@"%@:%@:%@", _hour, _minute, _second);
    
    //    label.text = _second;
    
    [self updataView];
    
}

-(void)updataView{
    
    NSInteger secendInterger = [_second integerValue];
    NSInteger minuteInterger = [_minute integerValue];
    NSInteger hourInterger = [_hour integerValue];
    
    VerticalLabel *label = [self viewWithTag:100];
    if (label) {
        label.text = (hourInterger <10 ) ? @"0" : [NSString stringWithFormat:@"%ld", (long)hourInterger/10];
    }
    label = [self viewWithTag:101];
    if (label) {
        label.text = (hourInterger <10 ) ? [NSString stringWithFormat:@"%ld", hourInterger] : [NSString stringWithFormat:@"%ld", (long)hourInterger%10];
    }
    
    label = [self viewWithTag:200];
    if (label) {
        label.text = (minuteInterger <10 ) ? @"0" : [NSString stringWithFormat:@"%ld", (long)minuteInterger/10];
    }
    label = [self viewWithTag:201];
    if (label) {
        label.text = (minuteInterger <10 ) ? [NSString stringWithFormat:@"%ld", minuteInterger] : [NSString stringWithFormat:@"%ld", (long)minuteInterger%10];
    }
    
    label = [self viewWithTag:300];
    if (label) {
        label.text = (secendInterger <10 ) ? @"0" : [NSString stringWithFormat:@"%ld", (long)secendInterger/10];
    }
    label = [self viewWithTag:301];
    if (label) {
        label.text = (secendInterger <10 ) ? [NSString stringWithFormat:@"%ld", secendInterger] : [NSString stringWithFormat:@"%ld", (long)secendInterger%10];
    }
    
    label = [self viewWithTag:1000];
    if (label) {
        label.text = [NSString stringWithFormat:@"%ld", (long)_ms];
    }
    
    if (_day) {
        NSUInteger dayDigit = _day.length;
        for (NSInteger i=0; i<dayDigit; i++) {
            label = [self viewWithTag:10+i];
            NSRange range = NSMakeRange(i, 1);
            NSString *numStr = [_day substringWithRange:range];
            label.text = numStr;
        }
    }
}

-(void)removeFromSuperview{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [super removeFromSuperview];
}

@end

