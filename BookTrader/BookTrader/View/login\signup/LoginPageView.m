//
//  LoginPageView.m
//  BookTrader
//
//  Created by JianShen on 2/20/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LoginPageView.h"

@interface LoginPageView ()
@property (nonatomic, strong) UIImage* KUIcon;
@property (nonatomic, strong) UILabel* usernameLabel;
@property (nonatomic, strong) UILabel* passwordLabel;
@property (nonatomic, strong) UITextField* usernameTextField;
@property (nonatomic, strong) UITextField* passwordTextField;
@property (nonatomic, strong) UIButton* loginBtn;
@property (nonatomic, strong) UIButton* signupBtn;



@end

@implementation LoginPageView

/*
 @author Simon, Jian
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self)
    {
        return nil;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    
    //KU Icon
    self.KUIcon = [UIImage imageNamed:@"ku.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 140, 220, 200)];
    imageView.backgroundColor = [UIColor grayColor];
    imageView.image = self.KUIcon;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.layer.cornerRadius = 3;
    [self addSubview:imageView];
    
    
    self.usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 400, 95, 44)];
    self.usernameLabel.text = @"User Name: ";
    self.usernameLabel.textColor = [UIColor grayColor];
    [self addSubview:self.usernameLabel];
    
    self.passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 444, 85, 44)];
    self.passwordLabel.text = @"Password: ";
    self.passwordLabel.textColor = [UIColor grayColor];
    [self addSubview:self.passwordLabel];
    
    
    self.usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(105, 400, 300, 44)];
    self.usernameTextField.backgroundColor = [UIColor whiteColor];
    self.usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:self.usernameTextField];
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(105, 444, 300, 44)];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.secureTextEntry = YES;
    [self addSubview:self.passwordTextField];
    
    
    //login button
    self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 500, 150, 44)];
    self.loginBtn.backgroundColor = [UIColor lightGrayColor];
    self.loginBtn.layer.cornerRadius = 5;
    [self.loginBtn setTitle:@"Log in" forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.loginBtn];
    
    //singup button
    self.signupBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 500, 150, 44)];
    self.signupBtn.backgroundColor = [UIColor lightGrayColor];
    self.signupBtn.layer.cornerRadius = 5;
    [self.signupBtn setTitle:@"Sign Up Now!" forState:UIControlStateNormal];
    [self.signupBtn addTarget:self action:@selector(clickSignUpButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.signupBtn];
    
    
//    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(5, 50, 44, 44)];
//    btn2.backgroundColor = [UIColor whiteColor];
//    btn2.layer.cornerRadius = 5;
//    [btn2 setTitle:@"««" forState:UIControlStateNormal];
//    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn2 addTarget:self action:@selector(back_Clicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:btn2];
    return self;
}


#pragma mark user action
- (void) clickLoginButton
{
    NSString* username = self.usernameTextField.text;
    NSString* password = self.passwordTextField.text;
    
    [self.delegate doClickLoginButtonWithUsername:username password:password];
}

- (void) clickSignUpButton
{
    [self.delegate doClickSignUpButton];
}



@end
