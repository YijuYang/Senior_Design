//
//  SignupStep1View.h
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignupStep1ViewDelegate <NSObject>

- (void)doClickNextBtnWithFirstName:(NSString *)firstName LastName:(NSString *) lastName EmailAddress:(NSString *)emailAddress Password:(NSString *)password;
- (void)doClickBackBtn;
@end


@interface SignupStep1View : UIView

@property (nonatomic, weak) id<SignupStep1ViewDelegate> delegate;
@property (nonatomic, strong)UITextField *emailAddressTextField;
@property (nonatomic, strong)UITextField *passwordTextField;

@end
