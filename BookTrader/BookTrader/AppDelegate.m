//
//  AppDelegate.m
//  BookStore
//
//  Created by Simon yang on 1/16/19.
//  Copyright © 2019 Simon yang. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageTabViewController.h"
#import "MsgCenterTabViewController.h"
#import "QuickSellTabViewController.h"
#import "AccountTabViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [self rootController];
    
    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    return YES;}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

    
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
    
    
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}
    
    
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
    
    
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
    QuickSellTabViewController *quickSellViewController = [[QuickSellTabViewController alloc] init];
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

//TODO:keep it or delete?
- (UITabBarItem *)createTabBarItem:(NSString *)title imageNamed:(NSString *)imageNamed selectedImageNamed:selectedImageNamed {
    UIImage *image = [[UIImage imageNamed:imageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                             image:image
                                                     selectedImage:selectedImage];
    return tabBarItem;
}
@end
