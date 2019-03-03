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

#import "LoginPageViewController.h"

@interface MsgCenterTabViewController ()
@property (nonatomic, strong) MsgCenterTabView* msgCenterView;
@property (nonatomic, strong) LoginPageViewController* loginCtrl;

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
    
    self.loginCtrl = [LoginPageViewController new];
    self.loginCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:self.loginCtrl animated:YES];}


@end
