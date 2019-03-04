//
//  HomePageTabViewController.m
//  BookTrader
//
//  Created by JianShen on 2/20/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomePageTabViewController.h"
#import "HomePageTabView.h"
@interface HomePageTabViewController ()

@property (nonatomic, strong) HomePageTabView* homePageView;

@end

@implementation HomePageTabViewController

/*
 @author 
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"HOME";
    
    self.homePageView = [[HomePageTabView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    self.homePageView.delegate = self;
    [self.view addSubview:self.homePageView];
    
}

- (void)doClickSwitch
{
}

@end
