//
//  BookItem.m
//  BookStore
//
//  Created by Simon yang on 2/4/19.
//  Copyright © 2019 Simon yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookItem.h"
@interface BookItem ()

@end

@implementation BookItem

/*
 @author:  Simon
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // 初始化视图对象
        // 图片
        _bookImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
        
        // 自定义cell的时候, 所有视图都添加到cell的contentView中
        _bookImageView.backgroundColor = [UIColor whiteColor];
        _bookImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_bookImageView];
        
        // 书名
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 260, 20)];
        [self.contentView addSubview:_nameLabel];
        
        // 价格
        _prcieLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 34, 260, 13)];
        [self.contentView addSubview:_prcieLabel];
        
        // 描述
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 55, 260, 20)];
        [self.contentView addSubview:_descLabel];
    }
    return self;
}

- (void)config
{
//  Name can be here :example
    self.bookImageView.image = [UIImage imageNamed:@"bookSample.jpg"];
    self.nameLabel.text = @"EGO IS THE ENEMY";
    
//    And add some price: example
    self.prcieLabel.text = @"$ 29";
    self.prcieLabel.textColor = [UIColor redColor];
    
//   And some description : example
    self.descLabel.text = @"Some description : example ......";
    self.descLabel.textColor = [UIColor lightGrayColor];
}

@end
