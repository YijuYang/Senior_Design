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
#import "HomePageTabViewController.h"
#import "MsgCenterTabViewController.h"
#import "QuickSellTabViewController.h"
#import "AccountTabViewController.h"
#import "AVCamCameraViewController.h"
#import "LoginPageViewController.h"
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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    self.loginPage = [[LoginPageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.loginPage.delegate = self;
    [self.view addSubview:self.loginPage];
}
    //move up
-(void)keyboardWillShow:(NSNotification *)note
    {
        NSDictionary *info = [note userInfo];
        CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        
        CGRect frame = self.loginPage.passwordTextField.frame;
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


#pragma mark LoginPageViewDelegate

/*
 @author Qixiang Liu
 */
- (void) doClickLoginButtonWithEmail: (NSString* )email password:(NSString *) password
{
    //check if username and password match
    if([email isEqualToString:@""]||[password isEqualToString:@""]){
        NSString* err = @"invalid email address or password";
        //failure alert
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:err
                                                                preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];

        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
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
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
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
                    NSDictionary * currUser = response[0];
                    [[NSUserDefaults standardUserDefaults] setObject:currUser forKey:@"currentUser"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    self.view.window.rootViewController = [self rootController];

//                    [self.navigationController pushViewController: animated:<#(BOOL)#>:YES];
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
    self.signupStep1Ctrl = [[SignupStep1Controller alloc]init];
    self.view.window.rootViewController = self.signupStep1Ctrl;
    
//    [self pushViewController:self.signupStep1Ctrl animated:NO];

}

#pragma mark
//@author: Jian Shen
- (UITabBarController *)rootController {
    // childController of rootController are navigationControllers/
    //each NavigationController corresponds to specific viewController
    
    UITabBarController *bottomBarController = [[UITabBarController alloc] init];
    
    //home page tab
    HomePageTabViewController *homePageViewController = [[HomePageTabViewController alloc] init];
    homePageViewController.tabBarItem = [self createTabBarItem:@"HOME" imageNamed:@"" selectedImageNamed:@"home_btn@3x.png"];
    homePageViewController.tabBarItem.title = @"HOME";
    UINavigationController *homeNaviCtrl = [[UINavigationController alloc] initWithRootViewController:homePageViewController];
    homeNaviCtrl.tabBarItem.title = @"HOME";
    
    //msg center tab
    MsgCenterTabViewController *msgCenterViewController = [[MsgCenterTabViewController alloc] init];
    msgCenterViewController.tabBarItem = [self createTabBarItem:@"MSG CENTER" imageNamed:@"home_btn@3x.png" selectedImageNamed:@"home_btn@3x.png"];
    msgCenterViewController.tabBarItem.title = @"MSG CENTER";
    msgCenterViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 50, -6, 50);
    UINavigationController *msgNaviCtrl = [[UINavigationController alloc] initWithRootViewController:msgCenterViewController];
    msgNaviCtrl.tabBarItem.title = @"MSG CENTER";
    
    //quick sell tab
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AVCamCameraViewController *quickSellViewController = [storyBoard instantiateViewControllerWithIdentifier:@"camViewController"];
    quickSellViewController.tabBarItem = [self createTabBarItem:@"QUICK SELL" imageNamed:@"" selectedImageNamed:@""];
    quickSellViewController.tabBarItem.title = @"QUICK SELL";
    UINavigationController *qsNaviCtrl = [[UINavigationController alloc] initWithRootViewController:quickSellViewController];
    qsNaviCtrl.tabBarItem.title = @"QUICK SELL";
    //account management tab
    AccountTabViewController *accountViewController = [[AccountTabViewController alloc] init];
    accountViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"ACCONT" image:NULL tag:(NULL)];
    accountViewController.tabBarItem.title = @"ACCOUNT";
    UINavigationController *accountNaviCtrl = [[UINavigationController alloc] initWithRootViewController:accountViewController];
    accountNaviCtrl.tabBarItem.title = @"ACCOUNT";
    
    bottomBarController.viewControllers = @[homeNaviCtrl, msgNaviCtrl, qsNaviCtrl, accountNaviCtrl];
    return bottomBarController;
}

- (UITabBarItem *)createTabBarItem:(NSString *)title imageNamed:(NSString *)imageNamed selectedImageNamed:selectedImageNamed {
    UIImage *image = [[UIImage imageNamed:imageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                             image:image
                                                     selectedImage:selectedImage];
    return tabBarItem;
}


@end
