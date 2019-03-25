//
//  QuickSellTabView.m
//  BookTrader
//
//  Created by JianShen on 2/21/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QuickSellTabView.h"
#import "BookModel.h"

@interface QuickSellTabView ()

@property (nonatomic, strong) UIImage* KUIcon;
@property (nonatomic, strong) UIImageView * imagePreview;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *isbn;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UITextField *priceField;
@property (nonatomic, strong) UITextField *isbnField;
@property (nonatomic, strong) UITextView *detailField;

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
    
    UIButton *scanISBNbtn = [[UIButton alloc] initWithFrame:CGRectMake(365, 252, 44, 44)];
    scanISBNbtn.backgroundColor = [UIColor whiteColor];
    UIImage *scan = [UIImage imageNamed:@"scan.png"];
    scanISBNbtn.layer.cornerRadius = 5;
    [scanISBNbtn setImage:scan forState:UIControlStateNormal];
    [scanISBNbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scanISBNbtn addTarget:self action:@selector(scanClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:scanISBNbtn];

    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 560, 405, 44)];
    submitBtn.backgroundColor = [UIColor greenColor];
    submitBtn.layer.cornerRadius = 5;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitCliked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:submitBtn];
    
    return self;
}
- (void)submitCliked
{
    if([[self.isbnField text] isEqualToString:@""]||[[self.titleField text] isEqualToString:@""]||[[self.priceField text] isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"INFO"
                                                        message:@"Please complete the necessary information."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }//else{
//        //string-string
//
//       // NSLog(@"%@",_customer);
//
//       // NSArray* author = @[[_author1 text],[_author2 text],[_author3 text]];
//
//        NSLog(@"%@",author);
//
//        NSDictionary* data = @{
//                               @"bookname":[_bookName text],
//                               @"isbn" :[self.isbnField text],
//                               @"author":author,
//                               @"edition":[_edition text],
//                               @"price":[self.priceField text],
//                               @"ID":_customer[@"customerID"],
//
//                               };
//
//        BookModel* book = [[BookModel alloc]init];
//
//        [book sellBooks:data completion:^(id response) {
//            //after do somthing
//            //NSLog(@"%@",response);
//            if([response isKindOfClass:[NSString class]]&&[response containsString:@"FAILURE"]){
//                //failure
//                NSLog(@"FAIL:%@",response);
//
//            }else{
//
//                NSLog(@"SUCC:%@",response);
//
//                dispatch_async(dispatch_get_main_queue(), ^{
//
//
//                });
//
//            }
//        }];
//
//    }
}
- (void)scanClicked
{
    
    NSLog(@"adufhakdhflakjsdhfakjsdhflakjshfdakjlsdfhalks!!!!!");
}
@end
