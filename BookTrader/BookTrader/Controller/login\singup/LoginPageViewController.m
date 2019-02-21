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

@interface LoginPageViewController () <LoginPageViewDelegate>

@property (nonatomic, strong) LoginPageView* loginPage;

@end

@implementation LoginPageViewController

/*
 @author Jian, Simon
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"WELCOME BACK";
    
    self.loginPage = [[LoginPageView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
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
    //TODO:goto Signup Page
}


@end
