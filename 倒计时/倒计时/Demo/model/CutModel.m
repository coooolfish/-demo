//
//  CutModel.m
//  倒计时
//
//  Created by fish tony on 2018/5/3.
//  Copyright © 2018年 fish tony. All rights reserved.
//

#import "CutModel.h"

@implementation CutModel

-(void)cutdownMS{
    
    NSInteger secendInterger = [_second integerValue];
    NSInteger minuteInterger = [_minute integerValue];
    NSInteger hourInterger = [_hour integerValue];
    NSInteger dayInterger = [_day integerValue];
    
    if (_ms==0 && secendInterger==0 && minuteInterger==0 && hourInterger==0 && dayInterger==0){
        return;
    }
    
    _ms-=1;
    if (_ms==0 && secendInterger==0 && minuteInterger==0 && hourInterger==0 && dayInterger==0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:cutfinish object:nil];
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
                    if (dayInterger==0) {
                        
                    }
                    else{
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
        //        _day = [NSString stringWithFormat:@"%ld", (long)dayInterger];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:cutting object:nil];
}

-(void)cutdownSecend{
    NSInteger secendInterger = [_second integerValue];
    NSInteger minuteInterger = [_minute integerValue];
    NSInteger hourInterger = [_hour integerValue];
    NSInteger dayInterger = [_day integerValue];
    
    if ( secendInterger==0 && minuteInterger==0 && hourInterger==0 && dayInterger==0){
        return;
    }
    
    secendInterger-=1;
    if (secendInterger==0 && minuteInterger==0 && hourInterger==0 && dayInterger==0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:cutfinish object:nil];
        return;
    }
    if (secendInterger < 0) {
        minuteInterger -= 1;
        secendInterger = 59;
        if (minuteInterger < 0) {
            hourInterger -= 1;
            minuteInterger = 59;
            if (hourInterger<0) {
                dayInterger-=1;
                if (dayInterger==0) {
                    
                }
                else{
                    hourInterger=23;
                }
            }
        }
    }
    _hour = [NSString stringWithFormat:@"%ld", (long)hourInterger];
    _minute = [NSString stringWithFormat:@"%ld", (long)minuteInterger];
    _second = [NSString stringWithFormat:@"%ld", (long)secendInterger];
    if (_day) {
        
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
        //        _day = [NSString stringWithFormat:@"%ld", (long)dayInterger];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:cutting object:nil];
}

@end
