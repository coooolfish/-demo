//
//  VerticalLabel.m
//  CutDownView
//
//  Created by fish tony on 2018/5/2.
//  Copyright © 2018年 fish tony. All rights reserved.
//

#import "VerticalLabel.h"

@implementation VerticalLabel

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.verticalAlignment = VerticalAlignmentMiddle;
    }
    
    return self;
}

/**
 *  设置属性方法
 *
 *  @param verticalAlignment 垂直调整位置
 */
- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment
{
    _verticalAlignment = verticalAlignment;
    
    [self setNeedsDisplay];
}

/**
 *  计算文字的矩形区域
 *
 *  @param bounds        label矩形区域
 *  @param numberOfLines 行数
 *
 *  @return 返回文字所占的矩形区域
 */
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    //通过设定字体区域的y值来调整垂直位置
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentMiddle:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
    }
    
    return textRect;
}

//重写父类方法
- (void)drawTextInRect:(CGRect)rect
{
    CGRect actualRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}
@end

