//
//  AppDelegate.m
//  BookStore
//
//  Created by Simon yang on 1/16/19.
//  Copyright © 2019 Simon yang. All rights reserved.
//

#import "AppDelegate.h"
#import <SendBirdSDK/SendBirdSDK.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import <AFNetworking/AFURLRequestSerialization.h>
#import <AFNetworking/AFImageDownloader.h>
#import <AFNetworking/UIImage+AFNetworking.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <UserNotifications/UserNotifications.h>

#import "HomePageTabViewController.h"
#import "MsgCenterTabViewController.h"
#import "QuickSellTabViewController.h"
#import "AccountTabViewController.h"
#import "AVCamCameraViewController.h"
#import "LoginPageViewController.h"


//#import "MainTabBarController.h"
//#import "LoginViewController.h"
//#import "MainTabBarController.h"
//#import "UIViewController+Utils.h"
//#import "GroupChannelsViewController.h"
//#import "GroupChannelChatViewController.h"
//#import "NotificationDelegate.h"
//#import "UserProfileViewController.h"
//#import "OpenChannelsViewController.h"
//#import "CreateGroupChannelViewControllerA.h"
//#import "CreateGroupChannelViewControllerB.h"
//#import "OpenChannelChatViewController.h"
//#import "OpenChannelSettingsViewController.h"
//#import "OpenChannelParticipantListViewController.h"
//#import "OpenChannelBannedUserListViewController.h"
//#import "OpenChannelMutedUserListViewController.h"
//#import "SelectOperatorsViewController.h"
//#import "OpenChannelCoverImageNameSettingViewController.h"
//#import "CreateOpenChannelViewControllerA.h"
//#import "CreateOpenChannelViewControllerB.h"
//#import "SettingsViewController.h"
//#import "UpdateUserProfileViewController.h"
//#import "SettingsBlockedUserListViewController.h"
//#import "Utils.h"

@import Photos;

@interface AVCamPhotoCaptureDelegate ()

@property (nonatomic, readwrite) AVCapturePhotoSettings* requestedPhotoSettings;
@property (nonatomic) void (^willCapturePhotoAnimation)(void);
@property (nonatomic) void (^livePhotoCaptureHandler)(BOOL capturing);
@property (nonatomic) void (^completionHandler)(AVCamPhotoCaptureDelegate* photoCaptureDelegate);

@property (nonatomic) NSData* photoData;
@property (nonatomic) NSURL* livePhotoCompanionMovieURL;
@property (nonatomic) NSData* portraitEffectsMatteData;

@end

@implementation AVCamPhotoCaptureDelegate

- (instancetype) initWithRequestedPhotoSettings:(AVCapturePhotoSettings*)requestedPhotoSettings willCapturePhotoAnimation:(void (^)(void))willCapturePhotoAnimation livePhotoCaptureHandler:(void (^)(BOOL))livePhotoCaptureHandler completionHandler:(void (^)(AVCamPhotoCaptureDelegate*))completionHandler
{
    self = [super init];
    if ( self ) {
        self.requestedPhotoSettings = requestedPhotoSettings;
        self.willCapturePhotoAnimation = willCapturePhotoAnimation;
        self.livePhotoCaptureHandler = livePhotoCaptureHandler;
        self.completionHandler = completionHandler;
    }
    return self;
}

- (void) didFinish
{
    if ( [[NSFileManager defaultManager] fileExistsAtPath:self.livePhotoCompanionMovieURL.path] ) {
        NSError* error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:self.livePhotoCompanionMovieURL.path error:&error];
        
        if ( error ) {
            NSLog( @"Could not remove file at url: %@", self.livePhotoCompanionMovieURL.path );
        }
    }
    
    self.completionHandler( self );
}

- (void) captureOutput:(AVCapturePhotoOutput*)captureOutput willBeginCaptureForResolvedSettings:(AVCaptureResolvedPhotoSettings*)resolvedSettings
{
    if ( ( resolvedSettings.livePhotoMovieDimensions.width > 0 ) && ( resolvedSettings.livePhotoMovieDimensions.height > 0 ) ) {
        self.livePhotoCaptureHandler( YES );
    }
}

- (void) captureOutput:(AVCapturePhotoOutput*)captureOutput willCapturePhotoForResolvedSettings:(AVCaptureResolvedPhotoSettings*)resolvedSettings
{
    self.willCapturePhotoAnimation();
}

- (void) captureOutput:(AVCapturePhotoOutput*)captureOutput didFinishProcessingPhoto:(AVCapturePhoto*)photo error:(nullable NSError*)error
{
    if ( error != nil ) {
        NSLog( @"Error capturing photo: %@", error );
        return;
    }
    
    self.photoData = [photo fileDataRepresentation];
    
    // Portrait Effects Matte only gets generated if there is a face
    if ( photo.portraitEffectsMatte != nil ) {
        CGImagePropertyOrientation orientation = [[photo.metadata objectForKey:(NSString*)kCGImagePropertyOrientation] intValue];
        AVPortraitEffectsMatte* portraitEffectsMatte = [photo.portraitEffectsMatte portraitEffectsMatteByApplyingExifOrientation:orientation];
        CVPixelBufferRef portraitEffectsMattePixelBuffer = [portraitEffectsMatte mattingImage];
        CIImage* portraitEffectsMatteImage = [CIImage imageWithCVPixelBuffer:portraitEffectsMattePixelBuffer options:@{ kCIImageAuxiliaryPortraitEffectsMatte : @(YES) }];
        CIContext* context = [CIContext context];
        CGColorSpaceRef linearColorSpace = CGColorSpaceCreateWithName( kCGColorSpaceLinearSRGB );
        self.portraitEffectsMatteData = [context HEIFRepresentationOfImage:portraitEffectsMatteImage format:kCIFormatRGBA8 colorSpace:linearColorSpace options:@{ (id)kCIImageRepresentationPortraitEffectsMatteImage : portraitEffectsMatteImage} ];
    }
    else {
        self.portraitEffectsMatteData = nil;
    }
}

- (void) captureOutput:(AVCapturePhotoOutput*)captureOutput didFinishRecordingLivePhotoMovieForEventualFileAtURL:(NSURL*)outputFileURL resolvedSettings:(AVCaptureResolvedPhotoSettings*)resolvedSettings
{
    self.livePhotoCaptureHandler(NO);
}

- (void) captureOutput:(AVCapturePhotoOutput*)captureOutput didFinishProcessingLivePhotoToMovieFileAtURL:(NSURL*)outputFileURL duration:(CMTime)duration photoDisplayTime:(CMTime)photoDisplayTime resolvedSettings:(AVCaptureResolvedPhotoSettings*)resolvedSettings error:(NSError*)error
{
    if ( error != nil ) {
        NSLog( @"Error processing Live Photo companion movie: %@", error );
        return;
    }
    
    self.livePhotoCompanionMovieURL = outputFileURL;
}

- (void) captureOutput:(AVCapturePhotoOutput*)captureOutput didFinishCaptureForResolvedSettings:(AVCaptureResolvedPhotoSettings*)resolvedSettings error:(NSError*)error
{
    if ( error != nil ) {
        NSLog( @"Error capturing photo: %@", error );
        [self didFinish];
        return;
    }
    
    if ( self.photoData == nil ) {
        NSLog( @"No photo data resource" );
        [self didFinish];
        return;
    }
    
    [PHPhotoLibrary requestAuthorization:^( PHAuthorizationStatus status ) {
        if ( status == PHAuthorizationStatusAuthorized ) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHAssetResourceCreationOptions* options = [[PHAssetResourceCreationOptions alloc] init];
                options.uniformTypeIdentifier = self.requestedPhotoSettings.processedFileType;
                PHAssetCreationRequest* creationRequest = [PHAssetCreationRequest creationRequestForAsset];
                [creationRequest addResourceWithType:PHAssetResourceTypePhoto data:self.photoData options:options];
                
                if ( self.livePhotoCompanionMovieURL ) {
                    PHAssetResourceCreationOptions* livePhotoCompanionMovieResourceOptions = [[PHAssetResourceCreationOptions alloc] init];
                    livePhotoCompanionMovieResourceOptions.shouldMoveFile = YES;
                    [creationRequest addResourceWithType:PHAssetResourceTypePairedVideo fileURL:self.livePhotoCompanionMovieURL options:livePhotoCompanionMovieResourceOptions];
                }
                
                // Save Portrait Effects Matte to Photos Library only if it was generated
                if ( self.portraitEffectsMatteData ) {
                    PHAssetCreationRequest* creationRequest = [PHAssetCreationRequest creationRequestForAsset];
                    [creationRequest addResourceWithType:PHAssetResourceTypePhoto data:self.portraitEffectsMatteData options:nil];
                }
                
            } completionHandler:^( BOOL success, NSError* _Nullable error ) {
                if ( ! success ) {
                    NSLog( @"Error occurred while saving photo to photo library: %@", error );
                }
                
                [self didFinish];
            }];
        }
        else {
            NSLog( @"Not authorized to save photo" );
            [self didFinish];
        }
    }];
}

@end

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [SBDOptions setConnectionTimeout:5];
    [SBDOptions setAuthenticationTimeout:10];
  //[SBDMain initWithApplicationId:@"E9AFEC82-52BB-4423-861B-1C8E287AAC54"]; // New Sample
    [SBDMain initWithApplicationId:@"09582180-8865-402F-93EC-C36657E179CE"]; // Old Sample
    
    [self registerForRemoteNotification];
    
    if (@available(iOS 11.0, *)) {
        [UINavigationBar appearance].tintColor = [UIColor colorNamed:@"color_navigation_tint"];
    } else {
        // Fallback on earlier versions
    }
    
    // Initialize AFNetworking to download an image that has a binary/octet-stream as a mime type.
    AFImageDownloader *sharedImageDownloader = [UIImageView sharedImageDownloader];
    NSMutableSet *types = [[NSMutableSet alloc] initWithSet:[sharedImageDownloader sessionManager].responseSerializer.acceptableContentTypes];
    [types addObject:@"binary/octet-stream"];
    [sharedImageDownloader sessionManager].responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithSet:types];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if (audioSession != nil) {
        NSError *error = nil;
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:&error];
        
        if (error != nil) {
            NSLog(@"Set Audio Session error: %@", error);
        }
    }
    
    

    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    UIStoryboard *launchScreenStoryboard = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil];
//    UIViewController *launchViewController = [launchScreenStoryboard instantiateViewControllerWithIdentifier:@"LaunchScreenViewController"];
//    self.window.rootViewController = launchViewController;
//    [self.window makeKeyAndVisible];
    
    LoginPageViewController *loginctrl = [[LoginPageViewController alloc] init];
    UINavigationController *objNavigationController=[[UINavigationController alloc]initWithRootViewController:loginctrl];

    self.window.rootViewController = objNavigationController;
    
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
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AVCamCameraViewController *quickSellViewController = [storyBoard instantiateViewControllerWithIdentifier:@"camViewController"];
    quickSellViewController.tabBarItem = [self createTabBarItem:@"QUICK SELL" imageNamed:@"" selectedImageNamed:@""];
    quickSellViewController.tabBarItem.title = @"QUICK SELL";
    UINavigationController *qsNaviCtrl = [[UINavigationController alloc] initWithRootViewController:quickSellViewController];
    qsNaviCtrl.tabBarItem.title = @"QUICK SELL";
    //account management tab
    AccountTabViewController *accountViewController = [[AccountTabViewController alloc] init];
    accountViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"ACCONT" image:@"" tag:(@"")];
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

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    // iOS 10 and later for local notification.
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound);
}

- (void)registerForRemoteNotification {
    float osVersion = [UIDevice currentDevice].systemVersion.floatValue;
    if (osVersion >= 10.0) {
#if !(TARGET_OS_SIMULATOR) && (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            NSLog(@"Tries to register push token, granted: %d, error: %@", granted, error);
            if (granted) {
                [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    if (settings.authorizationStatus != UNAuthorizationStatusAuthorized) {
                        return;
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[UIApplication sharedApplication] registerForRemoteNotifications];
                    });
                }];
            }
        }];
        return;
#else
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        UNAuthorizationOptions options = UNAuthorizationOptionAlert;
        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
        }];
#endif
    }
    else {
#if !(TARGET_OS_SIMULATOR)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            });
        }
#pragma clang diagnostic pop
#endif
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [SBDMain registerDevicePushToken:deviceToken unique:YES completionHandler:^(SBDPushTokenRegistrationStatus status, SBDError * _Nullable error) {
        if (error == nil) {
            if (status == SBDPushTokenRegistrationStatusPending) {
                NSLog(@"Push registration is pending.");
            }
            else {
                NSLog(@"APNS Token is registered.");
            }
        }
        else {
            NSLog(@"APNS registration failed with error: %@", error);
        }
    }];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if (userInfo[@"sendbird"] != nil) {
        NSString *channelUrl = userInfo[@"sendbird"][@"channel"][@"channel_url"];
        self.pushReceivedGroupChannel = channelUrl;
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    self.pushReceivedGroupChannel = userInfo[@"sendbird"][@"channel"][@"channel_url"];
    
    [SBDConnectionManager setAuthenticateDelegate:self];
    [SBDConnectionManager authenticate];
    
    completionHandler();
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(nonnull void (^)(void))completionHandler {
    NSLog(@"method for handling events for background url session is waiting to be process. background session id: %@", identifier);
    if (completionHandler != nil) {
        completionHandler();
    }
}

- (void)jumpToGroupChannel:(NSString *)channelUrl {
    /*
    UIViewController *vc = [UIViewController currentViewController];
    
    if ([vc isKindOfClass:[GroupChannelsViewController class]]) {
        GroupChannelsViewController *cvc = (GroupChannelsViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[GroupChannelChatViewController class]]) {
        GroupChannelChatViewController *cvc = (GroupChannelChatViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[GroupChannelSettingsViewController class]]) {
        GroupChannelSettingsViewController *cvc = (GroupChannelSettingsViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[GroupChannelCoverImageNameSettingViewController class]]) {
        GroupChannelCoverImageNameSettingViewController *cvc = (GroupChannelCoverImageNameSettingViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[GroupChannelInviteMemberViewController class]]) {
        GroupChannelInviteMemberViewController *cvc = (GroupChannelInviteMemberViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[CreateGroupChannelViewControllerA class]]) {
        CreateGroupChannelViewControllerA *cvc = (CreateGroupChannelViewControllerA *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[CreateGroupChannelViewControllerB class]]) {
        CreateGroupChannelViewControllerB *cvc = (CreateGroupChannelViewControllerB *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[UserProfileViewController class]]) {
        UserProfileViewController *cvc = (UserProfileViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[OpenChannelsViewController class]]) {
        OpenChannelsViewController *cvc = (OpenChannelsViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[OpenChannelChatViewController class]]) {
        OpenChannelChatViewController *cvc = (OpenChannelChatViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[OpenChannelSettingsViewController class]]) {
        OpenChannelSettingsViewController *cvc = (OpenChannelSettingsViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[OpenChannelParticipantListViewController class]]) {
        OpenChannelParticipantListViewController *cvc = (OpenChannelParticipantListViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[OpenChannelBannedUserListViewController class]]) {
        OpenChannelBannedUserListViewController *cvc = (OpenChannelBannedUserListViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[OpenChannelMutedUserListViewController class]]) {
        OpenChannelMutedUserListViewController *cvc = (OpenChannelMutedUserListViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[SelectOperatorsViewController class]]) {
        SelectOperatorsViewController *cvc = (SelectOperatorsViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[OpenChannelCoverImageNameSettingViewController class]]) {
        OpenChannelCoverImageNameSettingViewController *cvc = (OpenChannelCoverImageNameSettingViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[CreateOpenChannelViewControllerA class]]) {
        CreateOpenChannelViewControllerA *cvc = (CreateOpenChannelViewControllerA *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[CreateOpenChannelViewControllerB class]]) {
        CreateOpenChannelViewControllerB *cvc = (CreateOpenChannelViewControllerB *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[SettingsViewController class]]) {
        SettingsViewController *cvc = (SettingsViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[UpdateUserProfileViewController class]]) {
        UpdateUserProfileViewController *cvc = (UpdateUserProfileViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[SettingsBlockedUserListViewController class]]) {
        SettingsBlockedUserListViewController *cvc = (SettingsBlockedUserListViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
    else if ([vc isKindOfClass:[LoginViewController class]]) {
        LoginViewController *cvc = (LoginViewController *)vc;
        [cvc openChatWithChannelUrl:channelUrl];
    }
     */
}

#pragma mark - SBDAuthenticateDelegate
- (void)shouldHandleAuthInfoWithCompletionHandler:(void (^)(NSString * _Nullable, NSString * _Nullable, NSString * _Nullable, NSString * _Nullable))completionHandler {
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sendbird_user_id"];
    completionHandler(userId, nil, nil, nil);
}

- (void)didFinishAuthenticationWithUser:(SBDUser *)user error:(SBDError *)error {
    if (error == nil) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"sendbird_auto_login"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [SBDMain registerDevicePushToken:[SBDMain getPendingPushToken] unique:YES completionHandler:^(SBDPushTokenRegistrationStatus status, SBDError * _Nullable error) {
            if (error != nil) {
                NSLog(@"APNS registration failed.");
                return;
            }
            
            if (status == SBDPushTokenRegistrationStatusPending) {
                NSLog(@"Push registration is pending.");
            }
            else {
                NSLog(@"APNS Token is registered.");
            }
        }];
        
        if (self.pushReceivedGroupChannel != nil) {
            /*
            UIViewController *vc = [UIViewController currentViewController];
            if ([vc isKindOfClass:[UIAlertController class]]) {
                [vc dismissViewControllerAnimated:NO completion:^{
                    [self jumpToGroupChannel:self.pushReceivedGroupChannel];
                }];
            }
            else {
                [self jumpToGroupChannel:self.pushReceivedGroupChannel];
            }
            
            self.pushReceivedGroupChannel = nil;
             */
        }
        else {
            /*
            MainTabBarController *mainTabBarController = [[MainTabBarController alloc] initWithNibName:@"MainTabBarController" bundle:nil];
            [[UIViewController currentViewController] presentViewController:mainTabBarController animated:NO completion:nil];
             */
        }
    }
}
@end

