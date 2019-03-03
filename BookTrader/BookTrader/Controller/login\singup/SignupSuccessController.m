//
//  SignupSuccessController.m
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//
#import "SignupSuccessController.h"
#import "SignupSuccessView.h"

@interface SignupSuccessController () <SignupSuccessViewDelegate>

@property (nonatomic, strong)SignupSuccessView *signupSuccessView;
@property (nonatomic, strong)NSString *emailAddress;
@property (nonatomic, strong)NSString *password;

@end

@implementation SignupSuccessController

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
    self.title = @"";
    
    self.signupSuccessView = [[SignupSuccessView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.signupSuccessView.delegate = self;
    [self.signupSuccessView fillContentWithLoginName:self.emailAddress password:self.password];
    [self.view addSubview:self.signupSuccessView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doClickShoppingBtn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
