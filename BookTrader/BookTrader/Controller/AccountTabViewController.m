//
//  AccountTabViewController.m
//  BookTrader
//
//  Created by JianShen on 2/21/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AccountTabViewController.h"
#import "AccountTabView.h"
@interface AccountTabViewController ()
@property (nonatomic, strong) AccountTabView* accountView;

@end

@implementation AccountTabViewController

/*
 @author 
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"ACCOUNT";
    
    self.accountView = [[AccountTabView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.accountView];
    
}


@end
