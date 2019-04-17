//
//  MsgCell.h
//  BookTrader
//
//  Created by qixiang liu on 4/15/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MsgCell : UITableViewCell
@property(nonatomic,strong) UIImageView* cellImage;
@property(nonatomic,strong) UILabel* cellTitle;
@property(nonatomic,strong) UILabel* cellText;
@property(nonatomic,strong) UILabel* cellData;

@end

NS_ASSUME_NONNULL_END
