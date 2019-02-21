//
//  BookItem.h
//  BookStore
//
//  Created by Simon yang on 2/4/19.
//  Copyright © 2019 Simon yang. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface BookItem : UITableViewCell

// 左边的图片, 需要注意: 不要和父类的imageView属性冲突
@property (nonatomic, strong) UIImageView *bookImageView;
// 书名,      需要注意: 不要和父类的textLabel和DetailTextLable属性冲突
@property (nonatomic, strong) UILabel *nameLabel;
// 价格
@property (nonatomic, strong) UILabel *prcieLabel;
// 描述
@property (nonatomic, strong) UILabel *descLabel;

// 显示数据
- (void)config;

@end
