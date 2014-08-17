//
//  ProductCategoryModel.h
//  TableView_DrawerTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductCategoryModel : NSObject

@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSString *categoryImageName;
@property (nonatomic, strong) NSMutableArray *subProductList;

@end
