//
//  SignupStep1Controller.m
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//
#import "LoginPageViewController.h"
#import "SignupStep1Controller.h"
#import "SignupSuccessController.h"
#import "SignupStep1View.h"
#import "UserModel.h"
#import "Constants.h"
@interface SignupStep1Controller () <SignupStep1ViewDelegate>

@property (nonatomic, strong) SignupStep1View *signupStep1View;
@property (weak, nonatomic) UINavigationItem *navItem;

@end

@implementation SignupStep1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"register";
    UIBarButtonItem *negativeRightSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeRightSpacer.width = -2;
    UIBarButtonItem *rightDisconnectItem = [[UIBarButtonItem alloc] initWithTitle:@"Profile" style:UIBarButtonItemStylePlain target:self action:@selector(profile)];
    [rightDisconnectItem setTitleTextAttributes:@{NSFontAttributeName: [Constants navigationBarButtonItemFont]} forState:UIControlStateNormal];
    
    UIBarButtonItem *negativeLeftSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeLeftSpacer.width = -2;
    UIBarButtonItem *leftProfileItem = [[UIBarButtonItem alloc] initWithTitle:@"Profile" style:UIBarButtonItemStylePlain target:self action:@selector(profile)];
    [leftProfileItem setTitleTextAttributes:@{NSFontAttributeName: [Constants navigationBarButtonItemFont]} forState:UIControlStateNormal];
    
    
    self.navItem.rightBarButtonItems = @[negativeRightSpacer, rightDisconnectItem];
    self.navItem.leftBarButtonItems = @[negativeLeftSpacer, leftProfileItem];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    self.signupStep1View = [[SignupStep1View alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.signupStep1View.delegate = self;
    [self.view addSubview:self.signupStep1View];



}
    
//move up
-(void)keyboardWillShow:(NSNotification *)note
{
    NSDictionary *info = [note userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGRect frame = self.signupStep1View.passwordTextField.frame;
    int y = frame.origin.y + frame.size.height - (self.view.frame.size.height - keyboardSize.height);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    if(y > 0)
    {
        
        self.view.frame = CGRectMake(0, -y, self.view.frame.size.width, self.view.frame.size.height);
        
    }
    [UIView commitAnimations];
    
}
    
//go back to original layout
-(void)keyboardWillHide:(NSNotification *)note
{
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeView" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SignupStep1ViewDelegate
- (void)doClickNextBtnWithFirstName:(NSString *)firstName LastName:(NSString *)lastName EmailAddress:(NSString *)emailAddress Password:(NSString *)password
{
    //TODO: save email address to web server
    //hard code for UI test
    if([firstName isEqualToString:@""]||[lastName isEqualToString:@""]||[emailAddress isEqualToString:@""]||[password isEqualToString:@""]){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                                                       message:@"Cannot be empty"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if([emailAddress containsString:@"@"]==NO){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                                                       message:@"Email need @"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
  
    NSDictionary* data = @{
                           @"firstName":firstName,
                           @"lastName" :lastName,
                           @"customerEmail":emailAddress,
                           @"customerPwd":password,
                           @"major":@"ALL",
                           @"KUID":@""
                           };
    UserModel* user = [[UserModel alloc]init];
    [user createAccount:data completion:^(id response) {
        if([response isKindOfClass:[NSString class]]&&[response containsString:@"FAILURE"]){
          
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                                                               message:response
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
                
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            });
            
        }else{
            //success return NSDictionary*
            NSLog(@"%@",response);
          

            dispatch_async(dispatch_get_main_queue(), ^{
                //local store
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"currentUser"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                SignupSuccessController *successCtrl = [[SignupSuccessController alloc]initWithFirstName:firstName LastName:lastName EmailAddress:emailAddress Password:password];
                self.view.window.rootViewController = successCtrl;
//                [self.navigationController pushViewController:successCtrl animated:NO];
            });

        }
    }];



}

- (void) doClickBackBtn{
    LoginPageViewController *loginctrl = [[LoginPageViewController alloc] init];
    UINavigationController *objNavigationController=[[UINavigationController alloc]initWithRootViewController:loginctrl];
    self.view.window.rootViewController = objNavigationController;
}
@end
