//
//  GridTableView.m
//  TableView_DrawerTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "GridTableView.h"
#import "ProductCell.h"
#import "Macro.h"

@implementation GridTableView

static NSString *ProductCellIndentifier = @"ProductCell";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.allowsSelection = NO;
        self.scrollEnabled = YES;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[ProductCell class] forCellReuseIdentifier:ProductCellIndentifier];
        
    }
    return self;
}


#pragma mark -
#pragma mark - TableView DataSource And Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return PRODUCTCELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = [self.productlist count];
    NSLog(@"GridTableView Row %d", number);
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductCellIndentifier];
    
    NSInteger index = indexPath.row;
    NSMutableArray *list = self.productlist[index];
    [cell setProductCellData:list];
    return cell;
}

#pragma mark -
#pragma mark - Set DataSource
- (void)setGridTableDataSource:(NSMutableArray *)dataSource
{
    if ([dataSource count] == 0 || dataSource == nil) return;
    [self.productlist removeAllObjects];
    
    NSInteger number = dataSource.count/PRODUCTCELL_COLCOUNT;
    NSInteger mode = fmodf(dataSource.count, PRODUCTCELL_COLCOUNT);
    number = mode > 0 ? number + 1 : number;
    
    int j = 0;
    for (int i = 0; i < number;  ++i) {
        NSMutableArray *list = [NSMutableArray array];
        for (int col = 0; col < PRODUCTCELL_COLCOUNT && j<[dataSource count]; ++col) {
            [list addObject:dataSource[j]];
            ++j;
        }
        [self.productlist addObject:list];
    }
    
}

- (NSMutableArray *)productlist
{
    if (!_productlist) {
        _productlist = [NSMutableArray array];
    }
    return _productlist;
}

@end
