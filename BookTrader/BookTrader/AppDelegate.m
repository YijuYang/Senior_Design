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
    [self.window makeKeyAndVisible];
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
- (UITabBarController *)rootController {
   
    UITabBarController *bottomBarController = [[UITabBarController alloc] init];
    
    //home page tab
    HomePageTabViewController *homePageViewController = [[HomePageTabViewController alloc] init];
    homePageViewController.tabBarItem = [self createTabBarItem:@"Home" imageNamed:@"" selectedImageNamed:@""];
    
    UINavigationController *homeNavController = [[UINavigationController alloc] initWithRootViewController:homePageViewController];

    //msg center tab
    MsgCenterTabViewController *msgCenterViewController = [[MsgCenterTabViewController alloc] init];
    msgCenterViewController.tabBarItem = [self createTabBarItem:@"Msg" imageNamed:@"" selectedImageNamed:@""];
    UINavigationController *topicNavController = [[UINavigationController alloc] initWithRootViewController:msgCenterViewController];

    //quick sell tab
    QuickSellTabViewController *quickSellViewController = [[QuickSellTabViewController alloc] init];
    quickSellViewController.tabBarItem = [self createTabBarItem:@"Quick Sell" imageNamed:@"" selectedImageNamed:@""];

    UINavigationController *cartNavController = [[UINavigationController alloc] initWithRootViewController:quickSellViewController];

    //account management tab
    AccountTabViewController *accountViewController = [[AccountTabViewController alloc] init];
    accountViewController.tabBarItem = [self createTabBarItem:@"Account" imageNamed:@"" selectedImageNamed:@""];
    
    UINavigationController *myNavController = [[UINavigationController alloc] initWithRootViewController:accountViewController];

    bottomBarController.viewControllers = @[homeNavController, topicNavController, cartNavController, myNavController];

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
