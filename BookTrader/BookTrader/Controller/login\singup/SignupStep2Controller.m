//
//  SignupStep2Controller.m
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import "SignupStep2Controller.h"
#import "SignupStep3Controller.h"
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
//    NSError *error = nil;
//    if ([ValidatorUtil isValidPassword:password error:&error]) {
//        __weak typeof (self) weakSelf = self;
//        [weakSelf showLoadingView];
//        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                       _mobile,    @"mobile",
//                                       password,   @"password", nil];
//        [HttpClient requestJson:kUrlUserRegisterStep2
//                         params:params
//                        success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
//                            [weakSelf hideLoadingView];
//                            if (result) {
                                SignupStep3Controller *signupStep3Ctrl = [[SignupStep3Controller alloc] initWithEmailAddress:self.emailAddress password:password];
                                [self.navigationController pushViewController:signupStep3Ctrl animated:NO];
//                            } else {
//                                [weakSelf toast:message];
//                            }
//                        } failure:^(NSError *error) {
//                            [weakSelf hideLoadingView];
//                            [weakSelf toast:[error localizedDescription]];
//                        }];
//    } else {
//        [self toast:[error localizedDescription]];
//    }
}

@end
