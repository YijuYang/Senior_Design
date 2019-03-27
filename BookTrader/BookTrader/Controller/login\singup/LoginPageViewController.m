//
//  LoginPageViewController.m
//  BookTrader
//
//  Created by JianShen on 2/20/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginPageViewController.h"
#import "LoginPageView.h"
#import "SignupStep1Controller.h"
#import "UserModel.h"
@interface LoginPageViewController () <LoginPageViewDelegate>

@property (nonatomic, strong) LoginPageView* loginPage;
@property (nonatomic, strong) SignupStep1Controller* signupStep1Ctrl;

@end

@implementation LoginPageViewController

/*
 @author Jian, Simon
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"welcome";
    
    self.loginPage = [[LoginPageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.loginPage.delegate = self;
    [self.view addSubview:self.loginPage];
}


#pragma mark LoginPageViewDelegate

/*
 @author Qixiang Liu
 */
- (void) doClickLoginButtonWithEmail: (NSString* )email password:(NSString *) password
{
    //TODO:
    //check if username and password match
    if([email isEqualToString:@""]||[password isEqualToString:@""]){
        NSLog(@"FAILURE: Empty Email or password");
    }else{
        //TODO check email style??
        NSString *data =[[NSString alloc] initWithFormat:@"email=%@&password=%@", email,password];
        
      //  NSLog(@"post data: %@",data);
        
        UserModel* user = [[UserModel alloc]init];
        
        //first way
        [user login:data completion:^(id response) {

            if([response isKindOfClass:[NSString class]]&&[response containsString:@"FAILURE"]){
                //failure
                NSLog(@"%@",response);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //failure alert
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                                                                   message:response
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
                    
                    [alert addAction:defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
                });
            }else{
                //success check Case-sensitive
                NSLog(@"%@",response);
                //ASYN
                dispatch_async(dispatch_get_main_queue(), ^{
                    //TODO successful alert?
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }
        }];
        
        
        
    }
    
    
}

/*
 @author
 */
- (void) doClickSignUpButton
{
    self.signupStep1Ctrl = [SignupStep1Controller new];
    [self.navigationController pushViewController:self.signupStep1Ctrl animated:NO];

}
@end
