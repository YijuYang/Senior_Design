//
//  SignupStep2View.m
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//
#import "SignupStep2View.h"

@interface SignupStep2View ()

@property (nonatomic, strong)UIImage *KUIcon;
@property (nonatomic, strong)UIImageView *passwordIconImageView;
@property (nonatomic, strong)UILabel *passwordLabel;
@property (nonatomic, strong)UITextField *passwordTextField;
@property (nonatomic, strong)UIButton *nextBtn;

@end


@implementation SignupStep2View

/*
 @author: Jian
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.backgroundColor = [UIColor whiteColor];;
    
    //KU Icon
    self.KUIcon = [UIImage imageNamed:@"ku.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 140, 220, 200)];
    imageView.backgroundColor = [UIColor grayColor];
    imageView.image = self.KUIcon;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.layer.cornerRadius = 3;
    [self addSubview:imageView];
 
    //passwordLabel
    self.passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 444, 85, 44)];
    self.passwordLabel.text = @"Password: ";
    self.passwordLabel.textColor = [UIColor grayColor];
    [self addSubview:self.passwordLabel];

    //passwordTextField
    self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(90, 444, 300, 44)];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.placeholder = @"set password";
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [self addSubview:self.passwordTextField];
    
    
    //nextBtn
    self.nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(130, 500, 150, 44)];
    [self.nextBtn setTitle:@"Next Step" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundColor:[UIColor lightGrayColor]];
    self.nextBtn.layer.cornerRadius = 4;
    [self addSubview:self.nextBtn];
    
    [self.nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

/*
 @author: Jian
 */
- (void)clickNextBtn
{
    NSString *password = self.passwordTextField.text;
    [self.delegate doClickNextBtnWithPassword:password];
}

@end
