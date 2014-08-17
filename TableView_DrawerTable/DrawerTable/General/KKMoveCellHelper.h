//
//  KKMoveCellHelper.h
//  TableView_DrawerTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKMoveCellHelper : NSObject

+ (void)openTableView:(UITableView *)tableView withSelectIndexPath:(NSIndexPath *)indexPath withDrawerHeight:(CGFloat)drawerHeight;
+ (void)closeTableView:(UITableView *)tableView withSelectIndexPath:(NSIndexPath *)indexPath;

+ (BOOL)hasCellMove;

@end
