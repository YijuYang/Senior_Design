//
//  SettingView.h
//  BookTrader
//
//  Created by FengRose on 4/16/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SettingViewDelegate<NSObject>

//should pass seller
- (void) doClickContactButton;

@end
@interface SettingView : UIView
@property (nonatomic, weak) id<SettingViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
