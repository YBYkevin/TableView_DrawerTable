//
//  ProductCategoryCell.h
//  TableView_DrawerTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKMoveCell.h"

@class ProductCategoryModel;
@interface ProductCategoryCell : KKMoveCell

- (void)setCategoryCellData:(ProductCategoryModel *)productCategory;

@end
