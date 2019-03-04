//
//  HomePageTabView.h
//  BookTrader
//
//  Created by JianShen on 2/20/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomePageTabViewDelegate <NSObject>

- (void)doClickSwitch;

@end

@interface HomePageTabView : UIView
@property (nonatomic, weak) id<HomePageTabViewDelegate> delegate;

@end
