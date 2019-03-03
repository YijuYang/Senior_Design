//
//  SignupStep1View.h
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignupStep1ViewDelegate <NSObject>

- (void)doClickNextBtnWithEmailAddress:(NSString *)emailAddress;

@end


@interface SignupStep1View : UIView

@property (nonatomic, weak) id<SignupStep1ViewDelegate> delegate;

@end
