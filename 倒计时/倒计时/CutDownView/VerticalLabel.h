//
//  VerticalLabel.h
//  CutDownView
//
//  Created by fish tony on 2018/5/2.
//  Copyright © 2018年 fish tony. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,VerticalAlignment){
    VerticalAlignmentMiddle,
    VerticalAlignmentTop,
    VerticalAlignmentBottom
};

@interface VerticalLabel : UILabel

@property (nonatomic,assign) VerticalAlignment verticalAlignment;

@end

