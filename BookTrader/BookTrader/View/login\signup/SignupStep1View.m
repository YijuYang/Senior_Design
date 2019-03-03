//
//  SignupStep1View.m
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//


#import "SignupStep1View.h"


@interface SignupStep1View ()

@property (nonatomic, strong)UIImage *KUIcon;
@property (nonatomic, strong)UIImageView *emailAddressIcon;
@property (nonatomic, strong)UILabel *emailAddressLabel;
@property (nonatomic, strong)UITextField *emailAddressTextField;
@property (nonatomic, strong)UIButton *nextBtn;

@end


@implementation SignupStep1View
/*
 @author: Jian
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    
    //KU Icon
    self.KUIcon = [UIImage imageNamed:@"ku.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 140, 220, 200)];
    imageView.backgroundColor = [UIColor grayColor];
    imageView.image = self.KUIcon;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.layer.cornerRadius = 3;
    [self addSubview:imageView];
    
    
    self.emailAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 444, 85, 44)];
    self.emailAddressLabel.text = @"Email: ";
    self.emailAddressLabel.textColor = [UIColor grayColor];
    [self addSubview:self.emailAddressLabel];

    //emailAddressTextField
    self.emailAddressTextField = [[UITextField alloc]initWithFrame:CGRectMake(90, 444, 300, 44)];
    self.emailAddressTextField.backgroundColor = [UIColor whiteColor];
    self.emailAddressTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.emailAddressTextField.placeholder = @"enter email address for sign up";
    self.emailAddressTextField.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:self.emailAddressTextField];

    
    //nextBtn
    self.nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(130, 500, 150, 44)];
    [self.nextBtn setTitle:@"Next Step" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundColor:[UIColor lightGrayColor]];
    self.nextBtn.layer.cornerRadius = 4;
    [self addSubview:self.nextBtn];
    
    [self.nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

/*
 @author: Jian
 */
- (void)clickNextBtn
{
    NSString *emailAddress = self.emailAddressTextField.text;
    [self.delegate doClickNextBtnWithEmailAddress:emailAddress];
}

@end
