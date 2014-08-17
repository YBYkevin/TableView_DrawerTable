//
//  KKMoveCell.h
//  TableView_DrawerTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CellMoveDirection) {
    CellMoveDirectionUp = 1,
    CellMoveDirectionDown
};

@interface KKMoveCell : UITableViewCell

@property (nonatomic, assign) CellMoveDirection moveDirection;

@property (nonatomic, assign) CGFloat moveDistance;

@property (nonatomic, strong) UIView *coverView;//用于遮盖单元格,子类要重写coverView的frame

@end
