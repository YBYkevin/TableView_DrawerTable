//
//  KKMoveCell.m
//  TableView_DrawerTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "KKMoveCell.h"

@implementation KKMoveCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self addSubview:self.coverView];
       
    }
    return self;
}

#pragma mark - Property

- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor whiteColor];
        _coverView.alpha = 0.0;
    }
    return _coverView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
