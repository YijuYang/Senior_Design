//
//  SignupStep3Controller.m
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import "SignupStep3Controller.h"
#import "SignupSuccessController.h"
#import "SignupStep3View.h"
//#import "User.h"

@interface SignupStep3Controller () <SignupStep3ViewDelegate>

@property (nonatomic, strong)SignupStep3View *signupStep3View;
@property (nonatomic, strong)NSString *emailAddress;
@property (nonatomic, strong)NSString *password;


@end

@implementation SignupStep3Controller

- (instancetype)initWithEmailAddress:(NSString *)emailAddress password:(NSString *)password
{
    self = [super init];
    if (!self) return nil;
    
    self.emailAddress = emailAddress;
    self.password = password;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"register";
    
    self.signupStep3View = [[SignupStep3View alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.signupStep3View.delegate = self;
    [self.view addSubview:self.signupStep3View];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SignupStep3ViewDelegate

//
- (void)doClickNextBtnWithCode:(NSString *)code
{
//    //hard code for UI test
//    SignupSuccessController *ctrl = [[SignupSuccessController alloc] initWithEmailAddress:self.emailAddress password:self.password];
//    [self.navigationController pushViewController:ctrl animated:NO];

}

@end
