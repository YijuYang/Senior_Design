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
//这里的interface 仅对内（当前class）开放
@property (nonatomic, strong) UIImage* KUIcon;
@property (nonatomic, strong) UILabel* usernameLabel;
@property (nonatomic, strong) UILabel* passwordLabel;
@property (nonatomic, strong) UITextField* usernameTextField;
@property (nonatomic, strong) UIButton* loginBtn;
@property (nonatomic, strong) UIButton* signupBtn;
@property (nonatomic, strong) UIButton* guestLoginBtn;
@property (nonatomic, strong) UIActivityIndicatorView *loginLoad;


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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 140, 220, 220)];
    //imageView.backgroundColor = [UIColor blueColor];
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
    self.usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;
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
    [self.signupBtn setTitle:@"Sign Up" forState:UIControlStateNormal];
    [self.signupBtn addTarget:self action:@selector(clickSignUpButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.signupBtn];
    
    //guest Login button
    self.guestLoginBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 570, 170, 44)];
    self.guestLoginBtn.backgroundColor = [UIColor lightGrayColor];
    self.guestLoginBtn.layer.cornerRadius = 4;
    [self.guestLoginBtn setTitle:@"Guest Login" forState:UIControlStateNormal];
    [self.guestLoginBtn addTarget:self action:@selector(clickGuestLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.guestLoginBtn];
    
    return self;
}

    //close keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
#pragma mark user action
- (void) clickLoginButton
{
    [_loginBtn setTitle:nil forState:UIControlStateNormal];
    _loginLoad = [[UIActivityIndicatorView alloc] initWithFrame:self.loginBtn.bounds];
    [_loginLoad setUserInteractionEnabled:YES];
    [_loginLoad setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    //改变小菊花颜色
    [_loginLoad setColor:[UIColor greenColor]];
    //下文去解释下面这两行行代码的作用
    //CGAffineTransform transform = CGAffineTransformMakeScale(.7f, .7f);
    //addFriendActivityIndicator.transform = transform;
    [self.loginBtn addSubview:_loginLoad];
    //小菊花开始转圈圈
    [_loginLoad startAnimating];
    NSString* email = self.usernameTextField.text;
    NSString* password = self.passwordTextField.text;
    
    [self.delegate doClickLoginButtonWithEmail:email password:password];



}

-(void) clickGuestLoginButton
{
    [_guestLoginBtn setTitle:nil forState:UIControlStateNormal];
    UIActivityIndicatorView *guestLoginLoad = [[UIActivityIndicatorView alloc] initWithFrame:_guestLoginBtn.bounds];
    [guestLoginLoad setUserInteractionEnabled:YES];
    [guestLoginLoad setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    //改变小菊花颜色
    [guestLoginLoad setColor:[UIColor greenColor]];
    //下文去解释下面这两行行代码的作用
    //CGAffineTransform transform = CGAffineTransformMakeScale(.7f, .7f);
    //addFriendActivityIndicator.transform = transform;
    [_guestLoginBtn addSubview:guestLoginLoad];
    //小菊花开始转圈圈
    [guestLoginLoad startAnimating];
    
    //two way; server hide email and password
    
    //directly login in client (not secure)
    
    NSString* email = @"q709l816@ku.edu";
    NSString* password = @"123123";
    [self.delegate doClickLoginButtonWithEmail:email password:password];
//    [guestLoginLoad stopAnimating];
//    [_guestLoginBtn setTitle:@"Guest Login" forState:UIControlStateNormal];

    

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

-(void) stopAnimation
{
    [_loginLoad stopAnimating];
    [_loginBtn setTitle:@"Log in" forState:UIControlStateNormal];
}

@end
