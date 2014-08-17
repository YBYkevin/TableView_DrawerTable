//
//  GridTableView.h
//  TableView_DrawerTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *productlist;

- (void)setGridTableDataSource:(NSMutableArray *)dataSource;


@end
