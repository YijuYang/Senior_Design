//
//  LoginPageView.h
//  BookTrader
//
//  Created by JianShen on 2/20/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 @author Jian
 */
@protocol LoginPageViewDelegate<NSObject>

- (void) doClickLoginButtonWithEmail: (NSString* )email password:(NSString *) password;

- (void) doClickSignUpButton;

@end


@interface LoginPageView : UIView

@property (nonatomic, weak) id<LoginPageViewDelegate> delegate;

@end
