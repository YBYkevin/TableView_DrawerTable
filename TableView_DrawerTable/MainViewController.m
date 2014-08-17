//
//  MainViewController.m
//  TableView_DrawerTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "MainViewController.h"
#import "GridTableView.h"
#import "ProductCategoryCell.h"
#import "ProductCategoryModel.h"
#import "ProductModel.h"
#import "KKMoveCellHelper.h"
#import "Macro.h"

@interface MainViewController ()

@property (nonatomic, strong) GridTableView *gridTableView;
@property (nonatomic, strong) NSMutableArray *categorylist;

@end
static NSString *CategoryCellIndentifier = @"ProductCategoryCell";

@implementation MainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"商品列表";
    [self loadData];
    
    self.tableView.rowHeight = CATEGORYCELL_HEIGHT;
    [self.tableView registerClass:[ProductCategoryCell class] forCellReuseIdentifier:CategoryCellIndentifier];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_furley"]];
    
    [self.tableView addSubview:self.gridTableView];
    [self.tableView sendSubviewToBack:self.gridTableView];
    
}

#pragma mark - Property

-(GridTableView *)gridTableView
{
    if (!_gridTableView) {
        _gridTableView = [[GridTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, GRIDVIEW_HEIGHT)];
    }
    return _gridTableView;
}

-(NSMutableArray *)categorylist
{
    if (!_categorylist) {
        _categorylist = [NSMutableArray array];
    }
    return _categorylist;
}

#pragma mark - DataSource

- (void)loadData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shops" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        ProductCategoryModel *productCategory= [[ProductCategoryModel alloc] init];
        productCategory.categoryName = dict[@"name"];
        productCategory.categoryImageName = dict[@"imageName"];
        NSArray *subArray = dict[@"subClass"];
        [subArray enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL *stop) {
            ProductModel *product = [[ProductModel alloc] init];
            product.name = dic[@"name"];
            product.imageName = dic[@"imageName"];
            [productCategory.subProductList addObject:product];
        }];
        
        [self.categorylist addObject:productCategory];
    }];

}

#pragma mark -
#pragma mark - TableView DataSource And Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categorylist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCategoryModel *model = [self.categorylist objectAtIndex:indexPath.row];
    ProductCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CategoryCellIndentifier forIndexPath:indexPath];
    [cell setCategoryCellData:model];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (![KKMoveCellHelper hasCellMove]) {
        [KKMoveCellHelper openTableView:tableView withSelectIndexPath:indexPath withDrawerHeight: GRIDVIEW_HEIGHT];
        [self refreshCellGridTableView:indexPath];
        [UIView animateWithDuration:0.5 animations:^{
            [self.tableView bringSubviewToFront:self.gridTableView];
        }];
    }
    else{
        [self.tableView sendSubviewToBack:self.gridTableView];
        [KKMoveCellHelper closeTableView:tableView withSelectIndexPath:indexPath];
    }
 
}

-(void)refreshCellGridTableView:(NSIndexPath *)indexPath
{
    
    ProductCategoryCell *cell = (ProductCategoryCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    ProductCategoryModel *categoryModel = [self.categorylist objectAtIndex:indexPath.row];
    
    CGRect cellFrame = cell.frame;
    CGRect newFolderViewFrame = self.gridTableView.frame;
    newFolderViewFrame.origin.y = cellFrame.origin.y + cellFrame.size.height;
    [self.gridTableView setFrame:newFolderViewFrame];
    
    [self.gridTableView setGridTableDataSource:categoryModel.subProductList];
    [self.gridTableView reloadData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
