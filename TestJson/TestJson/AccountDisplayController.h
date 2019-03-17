//
//  AccountDisplayController.h
//  TestJson
//
//  Created by qixiang liu on 3/14/19.
//  Copyright © 2019 qixiang liu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountDisplayController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *firstName;

@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *email;

@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *major;
@property (strong, nonatomic) IBOutlet UITextField *kuid;

@property (nonatomic, retain) NSDictionary* customer;

@end

NS_ASSUME_NONNULL_END
