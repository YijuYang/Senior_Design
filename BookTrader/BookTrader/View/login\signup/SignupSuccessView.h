//
//  SignupSuccessView.h
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignupSuccessViewDelegate <NSObject>

- (void)doClickShoppingBtn;

@end


@interface SignupSuccessView : UIView
@property (nonatomic, weak) id<SignupSuccessViewDelegate> delegate;

- (void)fillContentWithLoginName:(NSString *)loginName password:(NSString *)password;

@end
