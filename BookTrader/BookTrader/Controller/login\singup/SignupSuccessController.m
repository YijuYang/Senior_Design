//
//  SignupSuccessController.m
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//
#import "SignupSuccessController.h"
#import "SignupSuccessView.h"
#import "SignupStep1Controller.h"
#import "HomePageTabViewController.h"
#import "MsgCenterTabViewController.h"
#import "QuickSellTabViewController.h"
#import "AccountTabViewController.h"
#import "AVCamCameraViewController.h"
#import "LoginPageViewController.h"

@interface SignupSuccessController () <SignupSuccessViewDelegate>

@property (nonatomic, strong)SignupSuccessView *signupSuccessView;
@property (nonatomic, strong)NSString *firstName;
@property (nonatomic, strong)NSString *lastName;
@property (nonatomic, strong)NSString *emailAddress;
@property (nonatomic, strong)NSString *password;

@end

@implementation SignupSuccessController

- (instancetype)initWithFirstName:(NSString *)firstName LastName:(NSString *) lastName EmailAddress:(NSString *)emailAddress Password:(NSString *)password
{
    self = [super init];
    if (!self) return nil;
    self.firstName = firstName;
    self.lastName = lastName;
    self.emailAddress = emailAddress;
    self.password = password;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    
    self.signupSuccessView = [[SignupSuccessView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.signupSuccessView.delegate = self;
    [self.signupSuccessView fillContentWithFirstName:self.firstName LastName:self.lastName EmailAddress:self.emailAddress password:self.password];
    [self.view addSubview:self.signupSuccessView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doClickShoppingBtn
{
    self.view.window.rootViewController = [self rootController];

//    [self.navigationController popToRootViewControllerAnimated:NO];
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
