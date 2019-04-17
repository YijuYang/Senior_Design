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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self addGestureRecognizer:tap];
    self.backgroundColor = [UIColor whiteColor];
    
    //KU Icon
    self.KUIcon = [UIImage imageNamed:@"ku.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 140, 220, 200)];
    imageView.backgroundColor = [UIColor grayColor];
    imageView.image = self.KUIcon;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.layer.cornerRadius = 3;
    [self addSubview:imageView];
    
    
    self.usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 400, 95, 44)];
    self.usernameLabel.text = @"Email: ";
    self.usernameLabel.textColor = [UIColor grayColor];
    [self addSubview:self.usernameLabel];
    
    self.passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 444, 85, 44)];
    self.passwordLabel.text = @"Password: ";
    self.passwordLabel.textColor = [UIColor grayColor];
    [self addSubview:self.passwordLabel];
    
    
    self.usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(105, 400, 300, 44)];
    self.usernameTextField.backgroundColor = [UIColor whiteColor];
    self.usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [_usernameTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
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
    self.signupBtn.layer.cornerRadius = 4;
    [self.signupBtn setTitle:@"Sign Up Now!" forState:UIControlStateNormal];
    [self.signupBtn addTarget:self action:@selector(clickSignUpButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.signupBtn];
    
    return self;
}


#pragma mark user action
- (void) clickLoginButton
{
    NSString* email = self.usernameTextField.text;
    NSString* password = self.passwordTextField.text;
    
    [self.delegate doClickLoginButtonWithEmail:email password:password];
}

- (void) clickSignUpButton
{
    [self.delegate doClickSignUpButton];
}

//@property (nonatomic, strong) UITextField* usernameTextField;
//@property (nonatomic, strong) UITextField* passwordTextField;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self.usernameTextField isExclusiveTouch]) {
        [self.usernameTextField resignFirstResponder];
    }
    if (![self.passwordTextField isExclusiveTouch]) {
        [self.passwordTextField resignFirstResponder];
    }
}
-(void)dismissKeyboard
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}


@end
