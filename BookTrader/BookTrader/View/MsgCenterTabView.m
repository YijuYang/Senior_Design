//
//  MsgCenterTabView.m
//  BookTrader
//
//  Created by JianShen on 2/20/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "MsgCenterTabView.h"

@interface MsgCenterTabView ()
@property (nonatomic, strong) UIImage* KUIcon;



@end

@implementation MsgCenterTabView

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
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    
    
    return self;
}


@end
