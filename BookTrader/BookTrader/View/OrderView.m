//
//  OrderView.m
//  BookTrader
//
//  Created by FengRose on 4/16/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import "OrderView.h"



@interface OrderView ()
@property (nonatomic, strong) UIImageView * imagePreview;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *isbn;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UITextField *priceField;
@property (nonatomic, strong) UITextField *isbnField;
@property (nonatomic, strong) UITextView *detailField;

@property (nonatomic, strong) UIButton *contactButton;
@end
@implementation OrderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self)
    {
        return nil;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.imagePreview = [[UIImageView alloc] initWithFrame:CGRectMake(130, 0, 150, 150)];
    self.imagePreview.image = [UIImage imageNamed:@"bookSample.jpg"];
    self.imagePreview.backgroundColor = [UIColor orangeColor];
    self.imagePreview.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.imagePreview.layer.borderColor = [[UIColor grayColor] CGColor];
    self.imagePreview.layer.cornerRadius = 8;
    [self addSubview:self.imagePreview];
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(5, 150, 95, 44)];
    self.title.text = @"Title: ";
    self.title.textColor = [UIColor grayColor];
    [self addSubview:self.title];
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(5, 220, 85, 44)];
    self.price.text = @"Price: ";
    self.price.textColor = [UIColor grayColor];
    [self addSubview:self.price];
    
    self.isbn = [[UILabel alloc] initWithFrame:CGRectMake(60, 220, 85, 44)];
    self.isbn.text = @"ISBN: ";
    self.isbn.textColor = [UIColor grayColor];
    [self addSubview:self.isbn];
    
    self.detail = [[UILabel alloc] initWithFrame:CGRectMake(5, 315, 95, 44)];
    self.detail.text = @"Description: ";
    self.detail.textColor = [UIColor grayColor];
    [self addSubview:self.detail];
    
    self.titleField = [[UITextField alloc] initWithFrame:CGRectMake(5, 184, 405, 44)];
    self.titleField.backgroundColor = [UIColor whiteColor];
    self.titleField.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.titleField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.titleField.layer.cornerRadius = 8;
    
    
    [self addSubview:self.titleField];
    
    self.priceField = [[UITextField alloc] initWithFrame:CGRectMake(5, 252, 50, 44)];
    self.backgroundColor = [UIColor whiteColor];
    self.priceField.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.priceField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.priceField.layer.cornerRadius = 8;
    [self addSubview:self.priceField];
    
    self.isbnField = [[UITextField alloc] initWithFrame:CGRectMake(60, 252, 300, 44)];
    self.isbnField.backgroundColor = [UIColor whiteColor];
    self.isbnField.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.isbnField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.isbnField.layer.cornerRadius = 8;
    [self addSubview:self.isbnField];
    
    self.detailField = [[UITextView alloc] initWithFrame:CGRectMake(5, 350, 405, 200)];
    self.detailField.backgroundColor = [UIColor whiteColor];
    self.detailField.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.detailField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.detailField.layer.cornerRadius = 8;
    [self addSubview:self.detailField];
    
//    self.contactButton = [[UIButton alloc]initWithFrame:CGRectMake(55, 560, 300, 44)];
//    self.contactButton.backgroundColor = [UIColor orangeColor];
//    [self.contactButton setTitle:@"buy this book? contact buyer now! " forState:UIControlStateNormal];
//    [self.contactButton addTarget:self action:@selector(clickContactButton) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:self.contactButton];
    
    //hard code here
    self.titleField.text = @" ego is the enemy";
    self.isbnField.text = @" 978-1-59184-781-6";
    self.priceField.text = @" 16.83";
    self.detailField.text = @"Ego Is the Enemy is the fourth book by author Ryan Holiday, published on June 14, 2016.It is about the treacherous nature of ego.";
    
    
    return self;
}

- (void) clickContactButton
{
    [self.delegate doClickContactButton];
}


//- (void)scanClicked
//{
//
//    NSLog(@"adufhakdhflakjsdhfakjsdhflakjshfdakjlsdfhalks!!!!!");
//}


@end
