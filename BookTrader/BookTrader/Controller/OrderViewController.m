//
//  OrderViewController.m
//  BookTrader
//
//  Created by FengRose on 4/16/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import "OrderViewController.h"
#import "MsgCenterTabViewController.h"
#import "OrderView.h"
@interface OrderViewController ()<OrderViewDelegate>
@property (nonatomic, strong) OrderView* orderView;

@end

@implementation OrderViewController

/*
 @author
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Book Details";
    self.orderView = [[OrderView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.orderView.delegate = self;
    [self.view addSubview:self.orderView];
    
    
}

#pragma mark productViewDelegate

//- (void) doClickContactButton
//{
//    
//    MsgCenterTabViewController *msgCtr = [MsgCenterTabViewController new];
//    [self.navigationController pushViewController:msgCtr animated:NO];
//}


@end
