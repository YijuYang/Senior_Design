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
#import "BookModel.h"
@interface productViewController ()<productViewDelegate>
@property (nonatomic, strong) productView* productView;


@end

@implementation productViewController

/*
 @author Jian Shen
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Book Details";
    self.productView = [[productView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.productView.delegate = self;
    [self.view addSubview:self.productView];
    

    self.productView.titleLabel.text = self.booktitle;
    self.productView.isbnLabel.text = self.ISBN;
    self.productView.priceLabel.text = self.price;
    self.productView.detailLabel.text = self.bookdescription;
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self.imagestring options:NSDataBase64DecodingIgnoreUnknownCharacters];
    self.productView.imagePreview.image = [UIImage imageWithData:data];
}


#pragma mark productViewDelegate

- (void) doClickContactButton
{
    
    MsgCenterTabViewController *msgCtr = [MsgCenterTabViewController new];
    [self.navigationController pushViewController:msgCtr animated:NO];
}


@end
