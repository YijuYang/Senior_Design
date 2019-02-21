//
//  AccountTabView.m
//  BookTrader
//
//  Created by JianShen on 2/21/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "AccountTabView.h"

@interface AccountTabView ()
@property (nonatomic, strong) UIImage* KUIcon;



@end

@implementation AccountTabView

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
    
    self.backgroundColor = [UIColor greenColor];
    
   
    return self;
}


@end
