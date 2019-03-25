//
//  SignupStep1Controller.m
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import "SignupStep1Controller.h"
#import "SignupSuccessController.h"
#import "SignupStep1View.h"


@interface SignupStep1Controller () <SignupStep1ViewDelegate>

@property (nonatomic, strong) SignupStep1View *signupStep1View;

@end

@implementation SignupStep1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"register";
    
    self.signupStep1View = [[SignupStep1View alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.signupStep1View.delegate = self;
    [self.view addSubview:self.signupStep1View];



}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SignupStep1ViewDelegate
- (void)doClickNextBtnWithFirstName:(NSString *)firstName LastName:(NSString *)lastName EmailAddress:(NSString *)emailAddress Password:(NSString *)password
{
    //TODO: save email address to web server
    //hard code for UI test
    SignupSuccessController *successCtrl = [[SignupSuccessController alloc]initWithFirstName:firstName LastName:lastName EmailAddress:emailAddress Password:password];
    [self.navigationController pushViewController:successCtrl animated:NO];

}


@end
