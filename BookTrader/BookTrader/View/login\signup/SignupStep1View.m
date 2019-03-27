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
@property (nonatomic, strong)UILabel *FirstNameLabel;
@property (nonatomic, strong)UITextField *FirstNameTextField;
@property (nonatomic, strong)UILabel *LastNameLabel;
@property (nonatomic, strong)UITextField *LastNameTextField;
@property (nonatomic, strong)UILabel *passwordLabel;
@property (nonatomic, strong)UITextField *passwordTextField;

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
    
    
    //firstName label
    self.FirstNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 444, 95, 44)];
    self.FirstNameLabel.text = @"First Name: ";
    self.FirstNameLabel.textColor = [UIColor grayColor];
    [self addSubview:self.FirstNameLabel];
    
    //firstName textfield
    self.FirstNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 444, 300, 44)];
    self.FirstNameTextField.backgroundColor = [UIColor whiteColor];
    self.FirstNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.FirstNameTextField.placeholder = @"enter your first name here";
    self.FirstNameTextField.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:self.FirstNameTextField];
    
    //lastname label
    self.LastNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 488, 95, 44)];
    self.LastNameLabel.text = @"Last Name: ";
    self.LastNameLabel.textColor = [UIColor grayColor];
    [self addSubview:self.LastNameLabel];
    
    //lastname textfield
    self.LastNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 488, 300, 44)];
    self.LastNameTextField.backgroundColor = [UIColor whiteColor];
    self.LastNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.LastNameTextField.placeholder = @"enter your last name here";
    self.LastNameTextField.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:self.LastNameTextField];
    
    //emailAddress
    self.emailAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 532, 95, 44)];
    self.emailAddressLabel.text = @"Email: ";
    self.emailAddressLabel.textColor = [UIColor grayColor];
    [self addSubview:self.emailAddressLabel];

    //emailAddressTextField
    self.emailAddressTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 532, 300, 44)];
    self.emailAddressTextField.backgroundColor = [UIColor whiteColor];
    self.emailAddressTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.emailAddressTextField.placeholder = @"enter your email address here";
    self.emailAddressTextField.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:self.emailAddressTextField];

    //passwordLabel
    self.passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 576, 85, 44)];
    self.passwordLabel.text = @"Password: ";
    self.passwordLabel.textColor = [UIColor grayColor];
    [self addSubview:self.passwordLabel];
    
    //passwordTextField
    self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 576, 300, 44)];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.placeholder = @"set password here";
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [self addSubview:self.passwordTextField];
    
    //nextBtn
    self.nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(130, 640, 150, 44)];
    [self.nextBtn setTitle:@"Next Step" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundColor:[UIColor blueColor]];
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
    NSString *firstName = self.FirstNameTextField.text;
    NSString *lastName = self.LastNameTextField.text;
    NSString *emailAddress = self.emailAddressTextField.text;
    NSString *password = self.passwordTextField.text;
    [self.delegate doClickNextBtnWithFirstName:firstName LastName:lastName EmailAddress:emailAddress Password:password];
}

@end
