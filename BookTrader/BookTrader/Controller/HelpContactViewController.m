//
//  HelpContactController.m
//  BookTrader
//
//  Created by FengRose on 4/29/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelpContactViewController.h"
#import "HelpContactView.h"
@interface HelpContactViewController ()<HelpContactViewDelegate>
@property (nonatomic, strong) HelpContactView* helpcontactView;
@property (nonatomic, strong) UILabel *contact1;
@property (nonatomic, strong) UILabel *contact2;
@property (nonatomic, strong) UILabel *contact3;
@property (nonatomic, strong) UILabel *contact4;
@property (nonatomic, strong) UILabel *contact5;

@end

@implementation HelpContactViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Developer Contact Info";
    self.helpcontactView = [[HelpContactView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.helpcontactView.delegate = self;
    [self.view addSubview:self.helpcontactView];
 
    self.contact1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 85, 500, 40)];
    self.contact1.text = @"Yiju Yang: y150y133@gmail.com ";
    self.contact1.textColor = [UIColor grayColor];
    [self.view addSubview: self.contact1];
    
    self.contact2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 130, 500, 40)];
    self.contact2.text = @"Jian Shen: jianshen205@gmail.com";
    self.contact2.textColor = [UIColor grayColor];
    [self.view addSubview: self.contact2];
    
    self.contact3 = [[UILabel alloc] initWithFrame:CGRectMake(5, 175, 500, 40)];
    self.contact3.text = @"Qixiang Liu: qixiangxing@gmail.com";
    self.contact3.textColor = [UIColor grayColor];
    [self.view addSubview: self.contact3];
    
    self.contact4 = [[UILabel alloc] initWithFrame:CGRectMake(5, 220, 500, 40)];
    self.contact4.text = @"Siluo Feng: s682f720@ku.edu";
    self.contact4.textColor = [UIColor grayColor];
    [self.view addSubview: self.contact4];
    
    self.contact5 = [[UILabel alloc] initWithFrame:CGRectMake(5, 255, 500, 40)];
    self.contact5.text = @"Robert Goss: rgoss091@gmail.com";
    self.contact5.textColor = [UIColor grayColor];
    [self.view addSubview: self.contact5];
}


@end
