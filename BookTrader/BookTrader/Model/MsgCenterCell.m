//
//  MsgCenterCell.m
//  BookTrader
//
//  Created by qixiang liu on 4/2/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import "MsgCenterCell.h"

@implementation MsgCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 重写init方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 创建图片:cellImage，并添加到cell上
        CGFloat imageX = 10;
        CGFloat imageY = 10;
        CGFloat imageWidth = 100;
        CGFloat imageHeight = 100;
        self.cellImage = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageWidth, imageHeight)];
        self.cellImage.backgroundColor = [UIColor redColor];
        [self addSubview:self.cellImage];
        
        // 创建标题:cellTitle，并添加到cell上
        CGFloat titleX = CGRectGetMaxX(self.cellImage.frame) + 10;
        CGFloat titleY = 50;
        CGFloat titleWidth = self.frame.size.width - titleX;
        CGFloat titleHeight = 20;
        self.cellTitle = [[UILabel alloc] initWithFrame: CGRectMake(titleX, titleY, titleWidth, titleHeight)];
        self.cellTitle.text = @"System Notification";
        self.cellTitle.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.cellTitle];
        
        // 创建内容:cellText，并添加到cell上
        CGFloat textX = self.cellTitle.frame.origin.x;
        CGFloat textY = CGRectGetMaxY(self.cellTitle.frame) + 10;
        CGFloat textWidth = titleWidth;
        CGFloat textHeight = 50;
        self.cellText = [[UILabel alloc] initWithFrame:CGRectMake(textX, textY, textWidth, textHeight)];
//        self.cellText.text = @"cell的内容xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
//        self.cellText.font = [UIFont systemFontOfSize:12];
//        self.cellText.numberOfLines = 0;
//        [self addSubview:self.cellText];
        
        // 创建日期:cellDate，并添加到cell上
//        CGFloat dateX = 10;
//        CGFloat dateY = CGRectGetMaxY(self.cellImage.frame) + 10;
//        CGFloat dateWidth = self.frame.size.width - dateX*2;
//        CGFloat dateHeight = 20;
//        self.cellData = [[UILabel alloc] initWithFrame:CGRectMake(dateX, dateY, dateWidth, dateHeight)];
//        self.cellData.text = @"2016-06-30";
//        self.cellData.font = [UIFont systemFontOfSize:12];
//        [self addSubview:self.cellData];
    }
    return self;
}
@end
