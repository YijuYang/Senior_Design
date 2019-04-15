//
//  CommunicationView.h
//  BookTrader
//
//  Created by qixiang liu on 4/2/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommunicationViewDelegate<NSObject>

NS_ASSUME_NONNULL_BEGIN

@end

@interface CommunicationView : UIView

@property (nonatomic, weak) id<CommunicationViewDelegate> delegate;

@property (nonatomic, strong) UIButton* sendMsgButton;
@property (nonatomic, strong) UITextField* inputTextField;
@end

NS_ASSUME_NONNULL_END
