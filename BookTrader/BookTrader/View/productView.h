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
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *isbnLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView * imagePreview;
@property (nonatomic, weak) id<productViewDelegate> delegate;

@end
