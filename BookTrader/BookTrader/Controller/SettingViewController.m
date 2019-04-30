//
//  SettingViewController.m
//  BookTrader
//
//  Created by FengRose on 4/16/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import "SettingViewController.h"
#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "SettingView.h"
#import "UserModel.h"

@interface SettingViewController ()
@property (nonatomic, strong) SettingView* settingView;
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray* settingList;
@property(nonatomic, strong) UITextField* Lastname;
@property(nonatomic, strong) UITextField* Firstname;
@property(nonatomic, strong) UITextField* Password;
@property(nonatomic, strong) UITextField* Emailaddress;
@property (nonatomic, strong) UILabel *fname;
@property (nonatomic, strong) UILabel *lname;
@property (nonatomic, strong) UILabel *email;
@property (nonatomic, strong) UILabel *pword;
@property(nonatomic, strong) UIButton* btn;
@property(nonatomic, strong) UIButton* btn2;
@property(nonatomic,strong)NSDictionary* currUser;
@end

@implementation SettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.settingView = [[SettingView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    [self.view addSubview:self.settingView];
    UserModel* user = [[UserModel alloc]init];
    _currUser = [user getCurrentLocalUserInfo];
    self.fname = [[UILabel alloc] initWithFrame:CGRectMake(5, 75, 95, 40)];
    self.fname.text = @"FirstName: ";
    self.fname.textColor = [UIColor grayColor];
    [self.view addSubview: self.fname];
    
    self.Firstname = [[UITextField alloc] initWithFrame:CGRectMake(100, 75, 200, 40)];
    self.Firstname.adjustsFontSizeToFitWidth = YES;
    self.Firstname.placeholder = @" JoJo";
    self.Firstname.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.Firstname.layer.borderColor = [[UIColor grayColor] CGColor];
    self.Firstname.enabled= NO;
    self.Firstname.keyboardType = UIKeyboardTypeDefault;
    self.Firstname.returnKeyType = UIReturnKeyNext;
    self.Firstname.text = _currUser[@"firstName"];


    [self.view addSubview: self.Firstname];
    
    self.lname = [[UILabel alloc] initWithFrame:CGRectMake(5, 120, 95, 40)];
    self.lname.text = @"LastName: ";
    self.lname.textColor = [UIColor grayColor];
    self.lname.text = _currUser[@"lastName"];

    [self.view addSubview: self.lname];
    
    self.Lastname = [[UITextField alloc] initWithFrame:CGRectMake(100, 120, 200, 40)];
    self.Lastname.adjustsFontSizeToFitWidth = YES;
    self.Lastname.placeholder = @" J";
    self.Lastname.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.Lastname.layer.borderColor = [[UIColor grayColor] CGColor];
    self.Lastname.enabled= NO;
    self.Lastname.keyboardType = UIKeyboardTypeDefault;
    self.Lastname.returnKeyType = UIReturnKeyNext;
    self.Lastname.text = _currUser[@"lastName"];

    [self.view addSubview: self.Lastname];
    
    self.pword = [[UILabel alloc] initWithFrame:CGRectMake(5, 165, 95, 40)];
    self.pword.text = @"Password: ";
    self.pword.textColor = [UIColor grayColor];

    [self.view addSubview: self.pword];
    
    self.Password = [[UITextField alloc] initWithFrame:CGRectMake(100, 165, 200, 40)];
    self.Password.adjustsFontSizeToFitWidth = YES;
    self.Password.placeholder = @" da2819";
    self.Password.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.Password.layer.borderColor = [[UIColor grayColor] CGColor];
    self.Password.enabled= YES;
    self.Password.keyboardType = UIKeyboardTypeDefault;
    self.Password.returnKeyType = UIReturnKeyNext;
    self.Password.text = _currUser[@"customerPwd"];
    self.Password.secureTextEntry = YES;

    [self.view addSubview: self.Password];
    
    self.email = [[UILabel alloc] initWithFrame:CGRectMake(5, 210, 95, 40)];
    self.email.text = @"Email: ";
    self.email.textColor = [UIColor grayColor];

    [self.view addSubview: self.email];
    
    self.Emailaddress = [[UITextField alloc] initWithFrame:CGRectMake(100, 210, 200, 40)];
    self.Emailaddress.adjustsFontSizeToFitWidth = YES;
    self.Emailaddress.placeholder = @" sample@gmail.com";
    self.Emailaddress.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.Emailaddress.layer.borderColor = [[UIColor grayColor] CGColor];
    self.Emailaddress.enabled= NO;
    self.Emailaddress.keyboardType = UIKeyboardTypeDefault;
    self.Emailaddress.returnKeyType = UIReturnKeyNext;
    self.Emailaddress.text = _currUser[@"customerEmail"];

    

    [self.view addSubview: self.Emailaddress];

    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(75, 280, 100, 50)];
    [self.btn setTitle:@"Change" forState:UIControlStateNormal];
    self.btn.enabled=YES;
    self.btn.backgroundColor = [UIColor blueColor];
    self.btn.layer.cornerRadius = 4;
//    self.btn.showsTouchWhenHighlighted = YES;
    [self.btn addTarget:self action:@selector(clickChangeButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    
    self.btn2 = [[UIButton alloc] initWithFrame:CGRectMake(225, 280, 100, 50)];
    [self.btn2 setTitle:@"Confirm" forState:UIControlStateNormal];
    self.btn2.backgroundColor = [UIColor grayColor];
    self.btn2.layer.cornerRadius = 4;
    self.btn2.enabled=YES;
    [self.btn2 addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn2];
    

    
}


- (void) clickChangeButton
{
    self.btn.backgroundColor = [UIColor grayColor];
    self.btn2.backgroundColor = [UIColor blueColor];
    self.Firstname.enabled= YES;
    self.Lastname.enabled= YES;
    self.Password.enabled= YES;
    
}


- (void) clickConfirmButton
{
    self.btn.backgroundColor = [UIColor blueColor];
    self.btn2.backgroundColor = [UIColor grayColor];
    self.Firstname.enabled= NO;
    self.Lastname.enabled= NO;
    self.Password.enabled= NO;

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"INFO"
                                                    message:@"Information changed."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
 
    //check local data is the same as before
    if(_currUser[@"firstName"]!= _Firstname.text||_currUser[@"lastName"]!=_Lastname.text||_currUser[@"customerPwd"]!=_Emailaddress.text){
        
        NSDictionary* data = @{
                               @"firstName":_Firstname.text,
                               @"lastName" :_Lastname.text,
                               @"customerEmail":_currUser[@"customerEmail"],
                               @"customerPwd":_Password.text,
                               @"major":_currUser[@"major"],
                               @"KUID":_currUser[@"KUID"]
                               };
       
        //updata server database
        [UserModel modifyAccount:data completion:^(id response) {
            NSLog(@"%@",response);
            if([response containsString:@"SUCCESS"]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    //remove local
                    [userDefault removeObjectForKey:@"currentUser"];
                    //updata local database
                    [userDefault setObject:data forKey:@"currentUser"];
                    [userDefault synchronize];
                    
                    UserModel* user = [[UserModel alloc]init];
                    NSLog(@"%@", [user getCurrentLocalUserInfo]);
                });
               
            }
        }];
        
       
    }else{
        //do not change anything
    }
}

- (void)doClickSwitch
{
}


@end
