//
//  CutDownCell.h
//  倒计时
//
//  Created by fish tony on 2018/5/3.
//  Copyright © 2018年 fish tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CutdownView.h"
#import "CutModel.h"

@protocol CutDownCellDelegate

@optional
-(void)cutdownFinish:(NSIndexPath *)indexPath;

@end

@interface CutDownCell : UITableViewCell

@property (weak, nonatomic) id <CutDownCellDelegate> delegate;

@property (strong, nonatomic) CutdownView *cutDownView;

-(void)setData:(CutModel *)model index:(NSIndexPath *)indexPath;

@end

