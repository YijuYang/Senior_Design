//
//  BookItemGrid.m
//  BookStore
//
//  Created by Simon yang on 2/5/19.
//  Copyright © 2019 Simon yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookItemGrid.h"

@implementation BookItemGrid

@synthesize leftImageView;
@synthesize rightImageView;
@synthesize leftLable;
@synthesize rightLable;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (id)initDiyWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        //左侧列的视图
        //左侧列底层View
        CGRect leftViewRect = CGRectMake(20, 0, self.frame.size.width/2 - 5, self.frame.size.width/2 - 5);
        UIView * leftView = [[UIView alloc] initWithFrame:leftViewRect];
        [self.contentView addSubview:leftView];
        //左侧列的图片视图
        CGRect leftImageViewRect = CGRectMake(20, 0, leftViewRect.size.width, leftViewRect.size.height-30);
        leftImageView = [[UIImageView alloc] initWithFrame:leftImageViewRect];
        leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        [leftView addSubview:leftImageView];
        //左侧列的文字视图
        CGRect leftLableRect = CGRectMake(50, leftImageViewRect.size.height + 5, leftImageViewRect.size.width - 10, 20);
        leftLable = [[UILabel alloc] initWithFrame:leftLableRect];
        [leftView addSubview:leftLable];
        //左侧列的按钮
        CGRect leftButtonRect = CGRectMake(20, 0, leftViewRect.size.width, leftViewRect.size.height);
        UIButton * leftButton = [[UIButton alloc] initWithFrame:leftButtonRect];
        leftButton.backgroundColor = [UIColor clearColor];
        [leftButton addTarget:self action:@selector(leftButton) forControlEvents:UIControlEventTouchUpInside];
        [leftView addSubview:leftButton];
        
        
        //右侧列的视图
        //右侧列底层View
        CGRect rightViewRect = CGRectMake(leftViewRect.size.width + 90, 0, leftViewRect.size.width, leftViewRect.size.height);
        UIView * rightView = [[UIView alloc] initWithFrame:rightViewRect];
        [self.contentView addSubview:rightView];
        
        //右侧列的图片视图
        CGRect rightImageViewRect = CGRectMake(0, 0, rightViewRect.size.width, rightViewRect.size.height -30);
        rightImageView = [[UIImageView alloc] initWithFrame:rightImageViewRect];
        rightImageView.contentMode = UIViewContentModeScaleAspectFit;
        [rightView addSubview:rightImageView];
        //右侧列的文字视图
        CGRect rightLableRect = CGRectMake(35, rightImageViewRect.size.height + 5, rightImageViewRect.size.width - 10, 20);
        rightLable = [[UILabel alloc] initWithFrame:rightLableRect];
        [rightView addSubview:rightLable];
        //右侧列的按钮
        CGRect rightButtonRect = CGRectMake(0, 0, rightViewRect.size.width, rightViewRect.size.height);
        UIButton * rightButton = [[UIButton alloc] initWithFrame:rightButtonRect];
        rightButton.backgroundColor = [UIColor clearColor];
        [rightButton addTarget:self action:@selector(rightButton) forControlEvents:UIControlEventTouchUpInside];
        [rightView addSubview:rightButton];
    }
    return self;
}

//按钮点击事件
- (void)leftButton
{
    if (self.leftButtonBlock) {
        self.leftButtonBlock();
    }
}

- (void)rightButton
{
    if (self.rightButtonBlock) {
        self.rightButtonBlock();
    }
}

- (void) config
{
    leftImageView.image  = [UIImage imageNamed:@"bookSample.jpg"];
    rightImageView.image = [UIImage imageNamed:@"bookSample2.png"];
}

@end
