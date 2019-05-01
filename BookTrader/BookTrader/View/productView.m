//
//  productView.m
//  BookTrader
//
//  Created by JianShen on 3/25/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "productView.h"

@interface productView ()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *isbn;
@property (nonatomic, strong) UILabel *detail;

//@property (nonatomic, strong) UITextField *titleField;
//@property (nonatomic, strong) UITextField *priceField;
//@property (nonatomic, strong) UITextField *isbnField;
//@property (nonatomic, strong) UITextView *detailField;

@property (nonatomic, strong) UIButton *contactButton;
@end

@implementation productView

/*
 @author Yiju, Jian
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self)
    {
        return nil;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.imagePreview = [[UIImageView alloc] initWithFrame:CGRectMake(130, 0, 150, 150)];
    self.imagePreview.backgroundColor = [UIColor orangeColor];
    self.imagePreview.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.imagePreview.layer.borderColor = [[UIColor grayColor] CGColor];
    self.imagePreview.layer.cornerRadius = 8;
    [self addSubview:self.imagePreview];
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(5, 150, 95, 44)];
    self.title.text = @"Title: ";
    self.title.textColor = [UIColor grayColor];
    [self addSubview:self.title];
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(5, 200, 85, 44)];
    self.price.text = @"Price: ";
    self.price.textColor = [UIColor grayColor];
    [self addSubview:self.price];
    
    self.isbn = [[UILabel alloc] initWithFrame:CGRectMake(5, 250, 85, 44)];
    self.isbn.text = @"ISBN: ";
    self.isbn.textColor = [UIColor grayColor];
    [self addSubview:self.isbn];
    
    self.detail = [[UILabel alloc] initWithFrame:CGRectMake(5, 300, 95, 44)];
    self.detail.text = @"Description: ";
    self.detail.textColor = [UIColor grayColor];
    [self addSubview:self.detail];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 175, 405, 44)];
    [self addSubview:self.titleLabel];

    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 225, 50, 44)];
    [self addSubview:self.priceLabel];

    self.isbnLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 275, 300, 44)];
    [self addSubview:self.isbnLabel];

    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 325, 405, 200)];
    self.detailLabel.adjustsFontSizeToFitWidth = NO;
    self.detailLabel.numberOfLines = 0;
    [self addSubview:self.detailLabel];

    self.contactButton = [[UIButton alloc]initWithFrame:CGRectMake(55, 560, 300, 44)];
    self.contactButton.backgroundColor = [UIColor orangeColor];
    [self.contactButton setTitle:@"Contact Seller" forState:UIControlStateNormal];
    [self.contactButton addTarget:self action:@selector(clickContactButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.contactButton];


    
    return self;
}

- (void) clickContactButton
{
    [self.delegate doClickContactButton];
}




@end
