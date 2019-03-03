//
//  SignupStep3View.m
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import "SignupStep3View.h"

@interface SignupStep3View ()
@property (nonatomic, strong)UIImage *KUIcon;
@property (nonatomic, strong)UIImageView *codeIconImageView;
@property (nonatomic, strong)UITextField *codeTextField;
@property (nonatomic, strong)UILabel *codeLabel;
@property (nonatomic, strong)UIButton *nextBtn;

@end


@implementation SignupStep3View
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
    
    //codeLabel
    self.codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 444, 85, 44)];
    self.codeLabel.text = @"Code: ";
    self.codeLabel.textColor = [UIColor grayColor];
    [self addSubview:self.codeLabel];

    //codeTextField
    self.codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(90, 444, 300, 44)];
    self.codeTextField.backgroundColor = [UIColor whiteColor];
    self.codeTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.codeTextField.placeholder = @"Enter Email Confirmation Code";
    self.codeTextField.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:self.codeTextField];

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
    NSString *code = self.codeTextField.text;
    [self.delegate doClickNextBtnWithCode:code];
}

@end
