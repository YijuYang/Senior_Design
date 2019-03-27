//
//  SignupStep2View.h
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignupStep2ViewDelegate <NSObject>

- (void)doClickNextBtnWithPassword:(NSString *)password;

@end


@interface SignupStep2View : UIView

@property (nonatomic, weak) id<SignupStep2ViewDelegate> delegate;

@end
