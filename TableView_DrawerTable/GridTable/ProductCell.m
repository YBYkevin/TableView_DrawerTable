//
//  ProductCell.m
//  TableView_DrawerTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "ProductCell.h"
#import "ProductButton.h"
#import "ProductModel.h"
#import "Macro.h"

@implementation ProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self loadContentView];
    }
    return self;
}

- (void)loadContentView
{
    NSInteger width = SCREEN_HEIGHT/PRODUCTCELL_COLCOUNT/2;
    for (NSInteger i = 0; i < PRODUCTCELL_COLCOUNT; i++)
    {
        ProductButton *btn = [[ProductButton alloc] init];
        btn.frame = CGRectMake(i*width + PRODUCTBUTTON_MARGINX, PRODUCTBUTTON_MARGINY, width - PRODUCTBUTTON_MARGINX, PRODUCTCELL_HEIGHT - 2 * PRODUCTBUTTON_MARGINY);
        btn.tag = PRODUCTBUTTON_TAG + i;
        [self.contentView addSubview:btn];
    }
}

#pragma mark -
#pragma mark - Set DataSource

- (void)setProductCellData:(NSArray *)products
{
    NSInteger number = PRODUCTCELL_COLCOUNT;
    if ([products count]<PRODUCTCELL_COLCOUNT) {
        number = [products count];
    }
    
    for (NSInteger i = 0; i < number; i++)
    {
        ProductButton *btn = (ProductButton *)[self.contentView viewWithTag:PRODUCTBUTTON_TAG + i];
        ProductModel *product = products[i];
        [btn setImage:[UIImage imageNamed:product.imageName] forState:UIControlStateNormal];
        [btn setTitle:product.name forState:UIControlStateNormal];
    }
}

@end
