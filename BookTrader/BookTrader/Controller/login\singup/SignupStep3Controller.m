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

- (void)doClickNextBtnWithCode:(NSString *)code
{
//    if (code.length < 1) {
//        [self toast:@"请输入验证码"];
//        return;
//    }
//
//    __weak typeof (self) weakSelf = self;
//    [weakSelf showLoadingView];
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                   self.emailAddress,     @"mobile",
//                                   _password,   @"password",
//                                   code,        @"code", nil];
//    [HttpClient requestJson:kUrlUserRegisterStep3
//                     params:params
//                    success:^(BOOL status, NSNumber *code, NSString *message, NSDictionary *data) {
//                        [weakSelf hideLoadingView];
//                        if (status) {
//                            //用户注册成功后，保存用户信息
//                            User *user = [User mj_objectWithKeyValues:[data objectForKey:@"user"]];
//                            NSString *app_cart_cookie_id = [data objectForKey:@"app_cart_cookie_id"];
//                            [StorageUtil saveUserId:user.id];
//                            [StorageUtil saveUserMobile:user.mobile];
//                            [StorageUtil saveUserLevel:user.level];
//                            [StorageUtil saveAccessToken:user.access_token];
//                            [StorageUtil saveAppCartCookieId:app_cart_cookie_id];
//
//                            //打开注册成功页面
                            SignupSuccessController *ctrl = [[SignupSuccessController alloc] initWithEmailAddress:self.emailAddress password:self.password];
                            [self.navigationController pushViewController:ctrl animated:NO];
//                        } else {
//                            [weakSelf toast:message];
//                        }
//                    } failure:^(NSError *error) {
//                        [weakSelf hideLoadingView];
//                        [weakSelf toast:[error localizedDescription]];
//                    }];
//
}

@end
