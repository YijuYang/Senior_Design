//
//  OrderHistoryView.h
//  BookTrader
//
//  Created by FengRose on 4/16/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol OrderHistoryViewDelegate<NSObject>

//should pass seller
- (void) doClickContactButton;

@end
@interface OrderHistoryView : UIView
@property (nonatomic, weak) id<OrderHistoryViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
