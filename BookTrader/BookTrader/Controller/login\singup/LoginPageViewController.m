//
//  LoginPageViewController.m
//  BookTrader
//
//  Created by JianShen on 2/20/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginPageViewController.h"
#import "LoginPageView.h"
#import "SignupStep1Controller.h"
@interface LoginPageViewController () <LoginPageViewDelegate>

@property (nonatomic, strong) LoginPageView* loginPage;
@property (nonatomic, strong) SignupStep1Controller* signupStep1Ctrl;

@end

@implementation LoginPageViewController

/*
 @author Jian, Simon
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"welcome";
    
    self.loginPage = [[LoginPageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.loginPage.delegate = self;
    [self.view addSubview:self.loginPage];
}


#pragma mark LoginPageViewDelegate

/*
 @author 
 */
- (void) doClickLoginButtonWithUsername: (NSString* )username password:(NSString *) password
{
    //TODO:
    //errors or go to homepage
}

/*
 @author
 */
- (void) doClickSignUpButton
{
    self.signupStep1Ctrl = [SignupStep1Controller new];
    [self.navigationController pushViewController:self.signupStep1Ctrl animated:YES];
    //TODO:goto Signup Page
}
@end
