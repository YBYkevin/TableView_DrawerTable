//
//  KKMoveCellHelper.m
//  TableView_DrawerTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define NAVIGATION_BAR_HEGHT 44

#import "KKMoveCellHelper.h"
#import "KKMoveCell.h"

@interface KKMoveCellHelper()

@end

static NSMutableArray *_animationCellContainer;

static BOOL _cellMove;

@implementation KKMoveCellHelper

+ (BOOL)hasCellMove
{
    return _cellMove;//用于判断是否有cell展开了，一次只能展开一个cell
}

//获取偏移的高度
+ (CGFloat)offsetBottomYInTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    CGFloat screenHight = SCREEN_HEIGHT - NAVIGATION_BAR_HEGHT;
    CGFloat cellHeight = cell.frame.size.height;
    
    CGFloat frameY = cell.frame.origin.y;
    CGFloat offY = tableView.contentOffset.y;
    CGFloat curVisualY = frameY - offY;
    CGFloat bottomY = screenHight - curVisualY - cellHeight;
    
    return bottomY;
}

//用于判断Cell移动的方向
+ (void)animateCell:(KKMoveCell *)cell withDirection:(CellMoveDirection)direction withStatus:(BOOL)status
{
    CGRect newFrame = cell.frame;
    cell.moveDirection = direction;
    switch (direction)
    {
        case CellMoveDirectionUp:
            newFrame.origin.y -= cell.moveDistance;
            break;
        case CellMoveDirectionDown:
            newFrame.origin.y += cell.moveDistance;
            break;
        default:NSAssert(NO, @"can not detect direction");
            break;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
                         cell.frame = newFrame;
                     } completion:^(BOOL finished) {
                         _cellMove = status;

                     }];
}

+ (void)openTableView:(UITableView *)tableView withSelectIndexPath:(NSIndexPath *)indexPath withDrawerHeight:(CGFloat)drawerHeight
{
    if (!_animationCellContainer) {
        _animationCellContainer = [[NSMutableArray alloc] init];
    }
    
    NSArray *paths = [tableView indexPathsForVisibleRows];
    
    CGFloat bottomY = [self offsetBottomYInTableView:tableView withIndexPath:indexPath];
    
    CGFloat moveUpDistance = 0;
    CGFloat moveDownDistance = 0;
    
    if (bottomY >= drawerHeight) {
        moveDownDistance = drawerHeight;
        moveUpDistance = 0;
    }else{
        moveDownDistance = bottomY;
        moveUpDistance = drawerHeight - bottomY;
    }
    
    [paths enumerateObjectsUsingBlock:^(NSIndexPath *path, NSUInteger idx, BOOL *stop) {
        KKMoveCell *moveCell = (KKMoveCell *)[tableView cellForRowAtIndexPath:path];
        if (path.row != indexPath.row)
        {
            moveCell.coverView.alpha = 0.5;
        }
        
        CellMoveDirection moveCellDirection;
        if (path.row <= indexPath.row)
        {
            moveCell.moveDistance = moveUpDistance;
            moveCellDirection = CellMoveDirectionUp;
        }
        else
        {
            moveCell.moveDistance = moveDownDistance;
            moveCellDirection = CellMoveDirectionDown;
        }
        
        [self animateCell:moveCell withDirection:moveCellDirection withStatus:YES];
        [_animationCellContainer addObject:moveCell];
    }];

    tableView.scrollEnabled = NO;
}


+ (void)closeTableView:(UITableView *)tableView withSelectIndexPath:(NSIndexPath *)indexPath
{
    
    [_animationCellContainer enumerateObjectsUsingBlock:^(KKMoveCell *moveCell, NSUInteger idx, BOOL *stop) {
       
        CellMoveDirection moveCellDirection = moveCell.moveDirection == CellMoveDirectionUp ? CellMoveDirectionDown : CellMoveDirectionUp;
        
        [self animateCell:moveCell withDirection:moveCellDirection withStatus:NO];
        
    }];
    
    NSArray *paths = [tableView indexPathsForVisibleRows];
    for (NSIndexPath *path in paths)
    {
        KKMoveCell *moveCell = (KKMoveCell *)[tableView cellForRowAtIndexPath:path];
        moveCell.coverView.alpha = 0;
    }
    
    tableView.scrollEnabled = YES;
    [_animationCellContainer removeAllObjects];
}


@end
