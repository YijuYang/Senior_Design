//
//  AccountController.h
//  TestJson
//
//  Created by qixiang liu on 3/8/19.
//  Copyright © 2019 qixiang liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "AccountDisplayController.h"
NS_ASSUME_NONNULL_BEGIN

@interface AccountController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *firstname;
@property (strong, nonatomic) IBOutlet UITextField *lastname;
@property (strong, nonatomic) IBOutlet UITextField *email;

@property (strong, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) IBOutlet UITextField *major;


@property (strong, nonatomic) IBOutlet UITextField *kuid;
@property (nonatomic, copy) NSDictionary* customerInstance;

- (IBAction)createAccountButtonClick:(id)sender;
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end

NS_ASSUME_NONNULL_END
