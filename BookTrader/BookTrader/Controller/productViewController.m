//
//  productViewController.m
//  BookTrader
//
//  Created by JianShen on 3/25/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "productViewController.h"
#import "MsgCenterTabViewController.h"
#import "productView.h"
@interface productViewController ()<productViewDelegate>
@property (nonatomic, strong) productView* productView;

@end

@implementation productViewController

/*
 @author
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Book Details";
    self.productView = [[productView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.productView.delegate = self;
    [self.view addSubview:self.productView];
    
    
}

#pragma mark productViewDelegate

- (void) doClickContactButton
{
    
    MsgCenterTabViewController *msgCtr = [MsgCenterTabViewController new];
    [self.navigationController pushViewController:msgCtr animated:NO];
}


@end
