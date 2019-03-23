//
//  QuickSellTabView.m
//  BookTrader
//
//  Created by JianShen on 2/21/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QuickSellTabView.h"

@interface QuickSellTabView ()
@property (nonatomic, strong) UIImage* KUIcon;


@end

@implementation QuickSellTabView

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
    
    UIImageView * imagePreview = [[UIImageView alloc] initWithFrame:CGRectMake(80, 0, 150, 150)];
    imagePreview.backgroundColor = [UIColor orangeColor];
    [self addSubview:imagePreview];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(5, 150, 95, 44)];
    title.text = @"Title: ";
    title.textColor = [UIColor grayColor];
    [self addSubview:title];
    
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(10, 194, 85, 44)];
    price.text = @"Price: ";
    price.textColor = [UIColor grayColor];
    [self addSubview:price];
    
    
    UITextField *titleField = [[UITextField alloc] initWithFrame:CGRectMake(105, 150, 300, 44)];
    titleField.backgroundColor = [UIColor whiteColor];
    titleField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:titleField];
    
    UITextField *priceField = [[UITextField alloc] initWithFrame:CGRectMake(105, 194, 300, 44)];
    priceField.backgroundColor = [UIColor whiteColor];
    priceField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:priceField];
    
    UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(5, 240, 95, 44)];
    detail.text = @"Description: ";
    detail.textColor = [UIColor grayColor];
    [self addSubview:detail];
    
    UITextField *detailField = [[UITextField alloc] initWithFrame:CGRectMake(105, 240, 300, 200)];
    detailField.backgroundColor = [UIColor whiteColor];
    detailField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:detailField];

    return self;
}

@end
