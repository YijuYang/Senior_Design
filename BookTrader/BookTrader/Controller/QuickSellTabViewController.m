//
//  QuickSellTabViewController.m
//  BookTrader
//
//  Created by JianShen on 2/21/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "QuickSellTabViewController.h"
#import "QuickSellTabView.h"
@interface QuickSellTabViewController ()
@property (nonatomic, strong) QuickSellTabView* quicksellView;

@end

@implementation QuickSellTabViewController

/*
 @author 
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"QUICK SELL";
    
    self.quicksellView = [[QuickSellTabView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.quicksellView];
    
}


@end
