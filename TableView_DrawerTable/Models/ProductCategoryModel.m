//
//  ProductCategoryModel.m
//  TableView_DrawerTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "ProductCategoryModel.h"

@implementation ProductCategoryModel

- (NSMutableArray *)subProductList
{
    if (!_subProductList) {
        _subProductList = [NSMutableArray array];
    }
    return _subProductList;
}

@end
