//
//  AccountTabView.h
//  BookTrader
//
//  Created by JianShen on 2/21/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AccountTabViewDelegate <NSObject>

- (void)doClickSwitch;

@end

@interface AccountTabView : UIView

@property (nonatomic, weak) id<AccountTabViewDelegate> delegate;

@end
