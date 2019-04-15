//
//  QuickSellTabViewController.m
//  BookTrader
//
//  Created by JianShen on 2/21/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 Implements the view controller for the camera interface.
 */
@import AVFoundation;
@import Photos;

#import <Foundation/Foundation.h>
#import "QuickSellTabViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "UserModel.h"
#import "BookModel.h"

@implementation ALAssetsLibrary (PFLast)

- (void)latestAsset:(void (^)(ALAsset * _Nullable, NSError *_Nullable))block {
    [self enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            [group enumerateAssetsWithOptions:NSEnumerationReverse/*遍历方式*/ usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    if (block) {
                        block(result,nil);
                    }
                    *stop = YES;
                }
            }];
            *stop = YES;
        }
    } failureBlock:^(NSError *error) {
        if (error) {
            if (block) {
                block(nil,error);
            }
        }
    }];
}
@end

@interface QuickSellTabViewController ()

@property (nonatomic,strong) UIImageView * templateDisplay;
@property (nonatomic,strong) AVCamCameraViewController* cameraView;
@property (strong,nonatomic) UITextView * templateField;
@property (strong,nonatomic) G8Tesseract* tesseract;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage* KUIcon;
@property (nonatomic, strong) UIImageView * imagePreview;
@property (nonatomic, strong) UILabel *mytitle;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *isbn;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UILabel *author1;
@property (nonatomic, strong) UILabel *author2;
@property (nonatomic, strong) UILabel *author3;
@property (nonatomic, strong) UITextField *authorField1;
@property (nonatomic, strong) UITextField *authorField2;
@property (nonatomic, strong) UITextField *authorField3;
@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UITextField *priceField;
@property (nonatomic, strong) UITextField *isbnField;
@property (nonatomic, strong) UITextView *detailField;
@property (nonatomic, strong) NSString * recognition;

@end

@implementation QuickSellTabViewController

/*
 @author Yiju Yang
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getLastImage];

    self.title = @"QUICK SELL";
//    self.quicksellView = [[QuickSellTabView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    [self.view addSubview:self.quicksellView];
 
    // Languages are used for recognition (e.g. eng, ita, etc.). Tesseract will
    // search for the .traineddata language file in the tessdata directory. For
    // example, specifying "eng+ita" will search for "eng.traineddata" and
    // "ita.traineddata".
    
    // Create your Tesseract object using the initWithLanguage method:
    self.tesseract = [[G8Tesseract alloc] initWithLanguage:@"eng"];
    
    // Set up the delegate to receive Tesseract's callbacks.
    // self should respond to TesseractDelegate and implement a
    // "- (BOOL)shouldCancelImageRecognitionForTesseract:(Tesseract*)tesseract"
    // method to receive a callback to decide whether or not to interrupt
    // Tesseract before it finishes a recognition.
    self.tesseract.delegate = self;
    
    // Optional: Limit the character set Tesseract should try to recognize from
    [self.tesseract setVariableValue:@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" forKey:@"tessedit_char_whitelist"];
    [self.tesseract setVariableValue:@".,:;'" forKey:@"tessedit_char_blacklist"];
    
    // See http://www.sk-spell.sk.cx/tesseract-ocr-en-variables for a complete
    // (but not up-to-date) list of Tesseract variables.
    // Specify the image Tesseract should recognize on
//    [self.tesseract setImage:self.image];
    
    // Optional: Limit the area of the image Tesseract should recognize on to a rectangle
    [self.tesseract setRect:CGRectMake(0, 0, 720, 1280)];
    //NSLog(@"what??%@", image.size.width);
    // Start the recognition
//    [self.tesseract recognize];
    
    // Retrieve the recognized text
//    NSLog(@"%@", [self.tesseract recognizedText]);
    
    self.imagePreview = [[UIImageView alloc] initWithFrame:CGRectMake(130, 0, 150, 150)];
    self.imagePreview.backgroundColor = [UIColor orangeColor];
    self.imagePreview.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.imagePreview.layer.borderColor = [[UIColor grayColor] CGColor];
    self.imagePreview.layer.cornerRadius = 8;
    [self getLastImage];
    [self.view addSubview:self.imagePreview];
    
    self.mytitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 150, 95, 44)];
    self.mytitle.text = @"Title: ";
    self.mytitle.textColor = [UIColor grayColor];
    [self.view addSubview:self.mytitle];
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(5, 220, 85, 44)];
    self.price.text = @"Price: ";
    self.price.textColor = [UIColor grayColor];
    [self.view addSubview:self.price];
    
    self.isbn = [[UILabel alloc] initWithFrame:CGRectMake(60, 220, 85, 44)];
    self.isbn.text = @"ISBN: ";
    self.isbn.textColor = [UIColor grayColor];
    [self.view addSubview:self.isbn];
    
    self.detail = [[UILabel alloc] initWithFrame:CGRectMake(5, 395, 95, 44)];
    self.detail.text = @"Description: ";
    self.detail.textColor = [UIColor grayColor];
    [self.view addSubview:self.detail];
    
    self.author1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 285, 85, 44)];
    self.author1.text = @"Author 1: ";
    self.author1.textColor = [UIColor grayColor];
    [self.view addSubview:self.author1];
    
    self.author2 = [[UILabel alloc] initWithFrame:CGRectMake(110, 285, 85, 44)];
    self.author2.text = @"Author 2: ";
    self.author2.textColor = [UIColor grayColor];
    [self.view addSubview:self.author2];
    
    self.author3 = [[UILabel alloc] initWithFrame:CGRectMake(215, 285, 85, 44)];
    self.author3.text = @"Author 3: ";
    self.author3.textColor = [UIColor grayColor];
    [self.view addSubview:self.author3];
    
    self.authorField1 = [[UITextField alloc] initWithFrame:CGRectMake(5, 324, 100, 44)];
    self.authorField1.backgroundColor = [UIColor whiteColor];
    self.authorField1.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.authorField1.layer.borderColor = [[UIColor grayColor] CGColor];
    self.authorField1.layer.cornerRadius = 8;
    [self.view addSubview:self.authorField1];
    
    self.authorField2 = [[UITextField alloc] initWithFrame:CGRectMake(110, 324, 100, 44)];
    self.authorField2.backgroundColor = [UIColor whiteColor];
    self.authorField2.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.authorField2.layer.borderColor = [[UIColor grayColor] CGColor];
    self.authorField2.layer.cornerRadius = 8;
    [self.view addSubview:self.authorField2];
    
    self.authorField3 = [[UITextField alloc] initWithFrame:CGRectMake(215, 324, 100, 44)];
    self.authorField3.backgroundColor = [UIColor whiteColor];
    self.authorField3.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.authorField3.layer.borderColor = [[UIColor grayColor] CGColor];
    self.authorField3.layer.cornerRadius = 8;
    [self.view addSubview:self.authorField3];
    
    self.titleField = [[UITextField alloc] initWithFrame:CGRectMake(5, 184, 405, 44)];
    self.titleField.backgroundColor = [UIColor whiteColor];
    self.titleField.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.titleField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.titleField.layer.cornerRadius = 8;
    [self.view addSubview:self.titleField];
    
    self.priceField = [[UITextField alloc] initWithFrame:CGRectMake(5, 252, 50, 44)];
    self.priceField.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.priceField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.priceField.layer.cornerRadius = 8;
    [self.view addSubview:self.priceField];
    
    self.isbnField = [[UITextField alloc] initWithFrame:CGRectMake(60, 252, 300, 44)];
    self.isbnField.backgroundColor = [UIColor whiteColor];
    self.isbnField.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.isbnField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.isbnField.layer.cornerRadius = 8;
    [self.view addSubview:self.isbnField];
    
    self.detailField = [[UITextView alloc] initWithFrame:CGRectMake(5, 430, 405, 200)];
    self.detailField.backgroundColor = [UIColor whiteColor];
    self.detailField.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.detailField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.detailField.layer.cornerRadius = 8;
    [self.view addSubview:self.detailField];
    
    UIButton *scanISBNbtn = [[UIButton alloc] initWithFrame:CGRectMake(365, 252, 44, 44)];
    scanISBNbtn.backgroundColor = [UIColor whiteColor];
    UIImage *scan = [UIImage imageNamed:@"scan.png"];
    scanISBNbtn.layer.cornerRadius = 5;
    [scanISBNbtn setImage:scan forState:UIControlStateNormal];
    [scanISBNbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scanISBNbtn addTarget:self action:@selector(scanClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanISBNbtn];
    
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 640, 405, 44)];
    submitBtn.backgroundColor = [UIColor greenColor];
    submitBtn.layer.cornerRadius = 5;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
}

- (void)submitInfo
{
    if([[self.isbnField text] isEqualToString:@""]||[[self.titleField text] isEqualToString:@""]||[[self.priceField text] isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"INFO"
                                                        message:@"Please complete the necessary information."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
            //string-string
    
           // NSLog(@"%@",_customer);
            NSArray* author = @[[self.author1 text],[self.author2 text],[self.author3 text]];
    
            NSLog(@"%@",author);
            NSUserDefaults
            NSDictionary* data = @{
                                   @"bookname":[self.titleField text],
                                   @"isbn" :[self.isbnField text],
                                   @"author":author,
                                   @"edition":[self.detailField text],
                                   @"price":[self.priceField text],
                                   @"ID":_customer[@"customerID"],
    
                                   };
    
            BookModel* book = [[BookModel alloc]init];
    //
            [book sellBooks:data completion:^(id response) {
    //            //after do somthing
    //            //NSLog(@"%@",response);
                if([response isKindOfClass:[NSString class]]&&[response containsString:@"FAILURE"]){
    //                //failure
                    NSLog(@"FAIL:%@",response);
    
                }else{
    
                    NSLog(@"SUCC:%@",response);
    
                    dispatch_async(dispatch_get_main_queue(), ^{
    
    
                    });
    //
                }
            }];

        }
}

- (void) scanClicked
{
    
}

- (BOOL)fshouldCancelImageRecognitionForTesseract:(G8Tesseract*)tesseract
{
    NSLog(@"progress: %d", tesseract.progress);
    return NO;  // return YES if you need to interrupt Tesseract before it finishes
}
-(NSMutableArray*)GetALLphotosUsingPohotKit
{
    NSMutableArray *arr = [NSMutableArray array];
    
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (NSInteger i = 0; i < smartAlbums.count; i++) {
        PHFetchOptions *option = [[PHFetchOptions alloc] init];
        option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
        PHCollection *collection = smartAlbums[i];
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            if ([collection.localizedTitle isEqualToString:@"相机胶卷"]) {
                PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
                PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
                NSArray *assets;
                if (fetchResult.count > 0) {
                    assets = [self getAllPhotosAssetInAblumCollection:assetCollection ascending:YES ];
                    [arr addObjectsFromArray:assets];
                }
            }
        }
    }
    return arr;
}

- (NSArray *)getAllPhotosAssetInAblumCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending
{
    NSMutableArray *assets = [NSMutableArray array];
    
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
    [result enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
        [assets addObject:asset];
    }];
    return assets;
}

- (void)accessToImageAccordingToTheAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void(^)(UIImage *image,NSDictionary *info))completion
{
    static PHImageRequestID requestID = -2;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat width = MIN([UIScreen mainScreen].bounds.size.width, 500);
    if (requestID >= 1 && size.width / width == scale) {
        [[PHCachingImageManager defaultManager] cancelImageRequest:requestID];
    }
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    //    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    option.resizeMode = resizeMode;
    
    requestID = [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(result,info);
        });
    }];
    
}

-(void)getLastImage{
    ALAssetsLibrary *al = [[ALAssetsLibrary alloc] init];
    [al latestAsset:^(ALAsset * _Nullable asset, NSError * _Nullable error) {
        NSString *type = [asset valueForProperty:ALAssetPropertyType];
        if ([type isEqual:ALAssetTypePhoto]){
            UIImage *needImage = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            if (needImage) {
                self.imagePreview.image = needImage;
                [self.tesseract setImage:needImage];
                [self.tesseract recognize];
                self.titleField.text = [self.tesseract recognizedText];
            }
        }
    }];
}
@end


