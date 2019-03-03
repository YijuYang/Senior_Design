//
//  SignupStep1Controller.m
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import "SignupStep1Controller.h"
#import "SignupStep2Controller.h"
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

- (void)doClickNextBtnWithEmailAddress:(NSString *)emailAddress
{
//    NSError *error = nil;
//    if ([ValidatorUtil isValidMobile:mobile error:&error]) {
//        __weak typeof (self) weakSelf = self;
//        [weakSelf showLoadingView];
//        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:mobile forKey:@"mobile"];
//        [HttpClient requestJson:kUrlUserRegisterStep1
//                         params:params
//                        success:^(BOOL result, NSNumber *resultCode, NSString *message, NSDictionary *data) {
//                            [weakSelf hideLoadingView];
//                            if (result) {
                                SignupStep2Controller *signupStep2Ctrl = [[SignupStep2Controller alloc] initWithEmailAddress:emailAddress];
                                [self.navigationController pushViewController:signupStep2Ctrl animated:NO];
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
