//
//  CutDownCell.m
//  倒计时
//
//  Created by fish tony on 2018/5/3.
//  Copyright © 2018年 fish tony. All rights reserved.
//

#import "CutDownCell.h"

@interface CutDownCell(){
    
}
@property (copy, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) CutModel *cutModel;
@end

@implementation CutDownCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _cutDownView = [[CutdownView alloc] initWithFrame:CGRectMake(10, 2.5, self.frame.size.width-20, self.frame.size.height)];
        _cutDownView.cutDownSelf = NO;
        [self addSubview:_cutDownView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataTime) name:cutting object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cutOver) name:cutfinish object:nil];
    }
    
    return self;
}

-(void)cutOver{
    [_delegate cutdownFinish:_indexPath];
}

-(void)updataTime{
    [self setData:_cutModel index:_indexPath];
}

-(void)setData:(CutModel *)model index:(NSIndexPath *)indexPath{
    _cutModel = model;
    _indexPath = indexPath;
    
    if (model.day) {
        _cutDownView.day = model.day;
    }
    _cutDownView.hour = model.hour;
    _cutDownView.minute = model.minute;
    _cutDownView.second = model.second;
    _cutDownView.charStyle = charStyleDetail;
    if (model.showMS) {
        _cutDownView.showMS = YES;
        _cutDownView.ms = model.ms;
    }
    
    [_cutDownView updataView];
    
}
@end

