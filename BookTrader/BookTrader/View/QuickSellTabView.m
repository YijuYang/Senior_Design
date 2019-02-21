//
//  QuickSellTabView.m
//  BookTrader
//
//  Created by JianShen on 2/21/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QuickSellTabView.h"

@interface QuickSellTabView ()
@property (nonatomic, strong) UIImage* KUIcon;

@end

@implementation QuickSellTabView

/*
 @author Simon, Jian
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self)
    {
        return nil;
    }
    
    self.backgroundColor = [UIColor blueColor];
    
    
    return self;
}


@end
