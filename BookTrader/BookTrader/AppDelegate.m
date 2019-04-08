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
#import "AVCamCameraViewController.h"
#import "LoginPageViewController.h"

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
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
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

