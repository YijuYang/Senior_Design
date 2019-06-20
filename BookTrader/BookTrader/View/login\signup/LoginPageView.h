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


//protocols == delegates 一种解决objective-c 无法多重继承但可以多协议，进行的接口继承
@protocol LoginPageViewDelegate<NSObject>

- (void) doClickLoginButtonWithEmail: (NSString* )email password:(NSString *) password;

- (void) doClickSignUpButton;

@end


@interface LoginPageView : UIView

@property (nonatomic, weak) id<LoginPageViewDelegate> delegate; //对外开放的变量声明（有get/set），新版本之后也是对内的全局变量 可以用下划线调用，同时synthesize 也帮助我们自动补写
@property (nonatomic, strong) UITextField* passwordTextField;
-(void) stopAnimation;//for UIActivityIndicatorView


@end
