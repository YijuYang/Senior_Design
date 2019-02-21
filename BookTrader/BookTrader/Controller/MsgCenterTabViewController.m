//
//  MsgCenterTabViewController.m
//  BookTrader
//
//  Created by JianShen on 2/20/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "MsgCenterTabViewController.h"
#import "MsgCenterTabView.h"
@interface MsgCenterTabViewController ()
@property (nonatomic, strong) MsgCenterTabView* msgCenterView;

@end

@implementation MsgCenterTabViewController

/*
 @author 
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"MSG CENTER";
    self.msgCenterView = [[MsgCenterTabView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.msgCenterView];
    
    
}


@end
