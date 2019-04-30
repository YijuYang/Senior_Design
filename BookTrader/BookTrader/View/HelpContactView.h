//
//  HelpContactView.h
//  BookTrader
//
//  Created by FengRose on 4/29/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HelpContactViewDelegate<NSObject>

//should pass seller
- (void) doClickContactButton;

@end
@interface HelpContactView : UIView
@property (nonatomic, weak) id<HelpContactViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
