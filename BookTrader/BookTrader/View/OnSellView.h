//
//  OnSellView.h
//  BookTrader
//
//  Created by FengRose on 4/11/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol OnSellViewDelegate<NSObject>

//should pass seller
- (void) doClickContactButton;

@end
@interface OnSellView : UIView
@property (nonatomic, weak) id<OnSellViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
