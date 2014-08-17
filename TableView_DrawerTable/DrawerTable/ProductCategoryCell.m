//
//  ProductCategoryCell.m
//  TableView_DrawerTable
//
//  Copyright (c) 2014年 kevin. All rights reserved.
//

#import "ProductCategoryCell.h"
#import "ProductCategoryModel.h"
#import "Macro.h"

@interface ProductCategoryCell()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *categoryImgView;
@property (nonatomic, strong) UILabel *categoryLabel;

@end

@implementation ProductCategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [super.coverView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, CATEGORYCELL_HEIGHT)];
        
        [self loadContentView];
        
    }
    return self;
}

- (void)loadContentView
{
    
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CATEGORYCELL_HEIGHT)];
    _bgImageView.image = [UIImage imageNamed:@"tmall_bg_main"];
    
    _categoryImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80 ,CATEGORYCELL_HEIGHT)];
    
     _categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 200, CATEGORYCELL_HEIGHT/2)];
    
    [self.contentView addSubview:_bgImageView];
    [self.contentView addSubview:_categoryImgView];
    [self.contentView addSubview:_categoryLabel];
}

#pragma mark - Set DataSource
- (void)setCategoryCellData:(ProductCategoryModel *)productCategory
{
    _categoryLabel.text = productCategory.categoryName;
    _categoryImgView.image = [UIImage imageNamed:productCategory.categoryImageName];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
