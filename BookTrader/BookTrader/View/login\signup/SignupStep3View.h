//
//  SignupStep3View.h
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignupStep3ViewDelegate <NSObject>

- (void)doClickNextBtnWithCode:(NSString *)code;

@end


@interface SignupStep3View : UIView

@property (nonatomic, weak) id<SignupStep3ViewDelegate> delegate;

@end
