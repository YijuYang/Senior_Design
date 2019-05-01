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
@property (nonatomic, strong)UILabel *firstNameLabel;
@property (nonatomic, strong)UILabel *lastNameLabel;
@end


@implementation SignupSuccessView
/*
 @author: Jian
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    

    self.congrateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 200,[UIScreen mainScreen].bounds.size.width, 44)];
    self.congrateLabel.text = @"Registration Complete";
    [self addSubview:self.congrateLabel];

    
    self.firstNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 312, [UIScreen mainScreen].bounds.size.width, 44)];
    [self addSubview:self.firstNameLabel];
    
    
    self.lastNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 356, [UIScreen mainScreen].bounds.size.width, 44)];
    [self addSubview:self.lastNameLabel];
    

    self.loginNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 400, [UIScreen mainScreen].bounds.size.width, 44)];
    [self addSubview:self.loginNameLabel];

    
    self.passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 444, [UIScreen mainScreen].bounds.size.width, 44)];
    [self addSubview:self.passwordLabel];
    
    
    //shopBtn
    self.shopBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 500, 150, 44) ];
    [self.shopBtn setTitle:@"Continue" forState:UIControlStateNormal];
    [self.shopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.shopBtn setBackgroundColor:[UIColor blueColor]];
    self.shopBtn.layer.cornerRadius = 4;
    [self addSubview:self.shopBtn];
  
    
    [self.shopBtn addTarget:self action:@selector(clickShoppingBtn) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}
/*
 @author: Jian
 */
- (void)fillContentWithFirstName:(NSString *)firstName LastName:(NSString *)lastName EmailAddress:(NSString *)emailAddress password:(NSString *)password
{
    self.firstNameLabel.text = [NSString stringWithFormat:@"First Name: %@", firstName];
    self.lastNameLabel.text = [NSString stringWithFormat:@"Last Name: %@", lastName];
    self.loginNameLabel.text = [NSString stringWithFormat:@"Email Address：%@", emailAddress];
    self.passwordLabel.text = [NSString stringWithFormat:@"Password：%@", password];
}
/*
 @author: Jian
 */
- (void)clickShoppingBtn
{
    [self.delegate doClickShoppingBtn];
}

@end
