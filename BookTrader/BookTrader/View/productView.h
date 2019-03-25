//
//  productView.h
//  BookTrader
//
//  Created by JianShen on 3/25/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol productViewDelegate<NSObject>

//should pass seller
- (void) doClickContactButton;

@end

@interface productView : UIView

@property (nonatomic, weak) id<productViewDelegate> delegate;

@end
