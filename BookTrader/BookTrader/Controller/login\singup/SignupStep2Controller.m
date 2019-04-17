//
//  SignupStep2Controller.m
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import "SignupStep2Controller.h"
#import "SignupStep3Controller.h"
#import "SignupSuccessController.h"
#import "SignupStep2View.h"

@interface SignupStep2Controller () <SignupStep2ViewDelegate>

@property (nonatomic, strong)SignupStep2View *signupStep2View;
@property (nonatomic, strong)NSString *emailAddress;
@end

@implementation SignupStep2Controller

- (instancetype)initWithEmailAddress:(NSString *)emailAddress
{
    self = [super init];
    if (!self) return nil;
    
    self.emailAddress = emailAddress;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"register";
    
    self.signupStep2View = [[SignupStep2View alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.signupStep2View.delegate = self;
    [self.view addSubview:self.signupStep2View];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SignupStep2ViewDelegate

- (void)doClickNextBtnWithPassword:(NSString *)password
{
    //TODO: save password to web server
    //hard code for UI Test
    
//    //skip email code authentication
//    SignupSuccessController *successController = [[SignupSuccessController alloc] initWithEmailAddress:self.emailAddress password:password];
//    [self.navigationController pushViewController:successController animated:NO];
}

@end
