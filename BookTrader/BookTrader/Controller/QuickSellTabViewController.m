//
//  QuickSellTabViewController.m
//  BookTrader
//
//  Created by JianShen on 2/21/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 Implements the view controller for the camera interface.
 */
@import AVFoundation;
@import Photos;

#import <Foundation/Foundation.h>
#import "QuickSellTabViewController.h"
#import "QuickSellTabView.h"
#import "QuickSellTabViewController.h"

@interface QuickSellTabViewController ()

@property (nonatomic,strong) QuickSellTabView* quicksellView;
@property (nonatomic,strong) AVCamCameraViewController* cameraView;

@end

@implementation QuickSellTabViewController

/*
 @author Yiju Yang
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"QUICK SELL";

    self.quicksellView = [[QuickSellTabView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.quicksellView];
}



@end
