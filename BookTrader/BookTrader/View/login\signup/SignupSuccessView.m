//
//  SignupSuccessView.m
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import "SignupSuccessView.h"

@interface SignupSuccessView ()
//@property (nonatomic, strong)UIImage *KUIcon;
@property (nonatomic, strong)UILabel *congrateLabel;
@property (nonatomic, strong)UILabel *loginNameLabel;
@property (nonatomic, strong)UILabel *passwordLabel;
@property (nonatomic, strong)UIButton *shopBtn;

@end


@implementation SignupSuccessView
/*
 @author: Jian
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    //KU Icon
//    self.KUIcon = [UIImage imageNamed:@"ku.png"];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 140, 220, 200)];
//    imageView.backgroundColor = [UIColor grayColor];
//    imageView.image = self.KUIcon;
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    imageView.layer.cornerRadius = 3;
//    [self addSubview:imageView];
//
    
    self.congrateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 200,[UIScreen mainScreen].bounds.size.width, 44)];
    self.congrateLabel.text = @"Congratulations Your Registration Was Successful!";
    [self addSubview:self.congrateLabel];


    self.loginNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 400, [UIScreen mainScreen].bounds.size.width, 44)];
    [self addSubview:self.loginNameLabel];

    
    self.passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 444, [UIScreen mainScreen].bounds.size.width, 44)];
    [self addSubview:self.passwordLabel];
    
    
    //shopBtn
    self.shopBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 500, 150, 44) ];
    [self.shopBtn setTitle:@"start my journey" forState:UIControlStateNormal];
    [self.shopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.shopBtn setBackgroundColor:[UIColor greenColor]];
    self.shopBtn.layer.cornerRadius = 4;
    [self addSubview:self.shopBtn];
  
    
    [self.shopBtn addTarget:self action:@selector(clickShoppingBtn) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}
/*
 @author: Jian
 */
- (void)fillContentWithLoginName:(NSString *)loginName password:(NSString *)password
{
    self.loginNameLabel.text = [NSString stringWithFormat:@"email address：%@", loginName];
    self.passwordLabel.text = [NSString stringWithFormat:@"password：%@", password];
}
/*
 @author: Jian
 */
- (void)clickShoppingBtn
{
    [self.delegate doClickShoppingBtn];
}

@end
