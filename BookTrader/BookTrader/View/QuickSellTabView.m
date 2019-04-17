//
//  QuickSellTabView.m
//  BookTrader
//
//  Created by JianShen on 2/21/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "QuickSellTabView.h"
//#import "BookModel.h"

@interface QuickSellTabView ()

@property (nonatomic, strong) UIImage* KUIcon;
@property (nonatomic, strong) UIImageView * imagePreview;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *isbn;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UITextField *priceField;
@property (nonatomic, strong) UITextField *isbnField;
@property (nonatomic, strong) UITextView *detailField;
@property (nonatomic, strong) NSString * recognition;

@end

//@implementation ALAssetsLibrary (PFLast)
//
//- (void)latestAsset:(void (^)(ALAsset * _Nullable, NSError *_Nullable))block {
//    [self enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//        if (group) {
//            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
//            [group enumerateAssetsWithOptions:NSEnumerationReverse/*遍历方式*/ usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//                if (result) {
//                    if (block) {
//                        block(result,nil);
//                    }
//                    *stop = YES;
//                }
//            }];
//            *stop = YES;
//        }
//    } failureBlock:^(NSError *error) {
//        if (error) {
//            if (block) {
//                block(nil,error);
//            }
//        }
//    }];
//}
//@end

@implementation QuickSellTabView

/*
 @author Simon, Jian
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self)
    {
        return nil;
    }
    //self.KUIcon = [UIImage alloc];
    
//    NSDictionary * infp = [NSDictionary alloc];
//    NSMutableArray *arr = [self GetALLphotosUsingPohotKit];
////    [self accessToImageAccordingToTheAsset:arr[0][0] size:CGSizeMake(150, 150)
    
    self.imagePreview = [[UIImageView alloc] initWithFrame:CGRectMake(130, 0, 150, 150)];
    self.imagePreview.backgroundColor = [UIColor orangeColor];
    self.imagePreview.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.imagePreview.layer.borderColor = [[UIColor grayColor] CGColor];
    self.imagePreview.layer.cornerRadius = 8;
//    [self getLastImage];
    [self addSubview:self.imagePreview];
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(5, 150, 95, 44)];
    self.title.text = @"Title: ";
    self.title.textColor = [UIColor grayColor];
    [self addSubview:self.title];
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(5, 220, 85, 44)];
    self.price.text = @"Price: ";
    self.price.textColor = [UIColor grayColor];
    [self addSubview:self.price];
    
    self.isbn = [[UILabel alloc] initWithFrame:CGRectMake(60, 220, 85, 44)];
    self.isbn.text = @"ISBN: ";
    self.isbn.textColor = [UIColor grayColor];
    [self addSubview:self.isbn];
    
    self.detail = [[UILabel alloc] initWithFrame:CGRectMake(5, 315, 95, 44)];
    self.detail.text = @"Description: ";
    self.detail.textColor = [UIColor grayColor];
    [self addSubview:self.detail];
    
    self.titleField = [[UITextField alloc] initWithFrame:CGRectMake(5, 184, 405, 44)];
    self.titleField.backgroundColor = [UIColor whiteColor];
    self.titleField.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.titleField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.titleField.layer.cornerRadius = 8;
    [self addSubview:self.titleField];
    
    self.priceField = [[UITextField alloc] initWithFrame:CGRectMake(5, 252, 50, 44)];
    self.backgroundColor = [UIColor whiteColor];
    self.priceField.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.priceField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.priceField.layer.cornerRadius = 8;
    [self addSubview:self.priceField];
    
    self.isbnField = [[UITextField alloc] initWithFrame:CGRectMake(60, 252, 300, 44)];
    self.isbnField.backgroundColor = [UIColor whiteColor];
    self.isbnField.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.isbnField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.isbnField.layer.cornerRadius = 8;
    [self addSubview:self.isbnField];
    
    self.detailField = [[UITextView alloc] initWithFrame:CGRectMake(5, 350, 405, 200)];
    self.detailField.backgroundColor = [UIColor whiteColor];
    self.detailField.layer.borderWidth = UITextBorderStyleRoundedRect;
    self.detailField.layer.borderColor = [[UIColor grayColor] CGColor];
    self.detailField.layer.cornerRadius = 8;
    [self addSubview:self.detailField];
    
    UIButton *scanISBNbtn = [[UIButton alloc] initWithFrame:CGRectMake(365, 252, 44, 44)];
    scanISBNbtn.backgroundColor = [UIColor whiteColor];
    UIImage *scan = [UIImage imageNamed:@"scan.png"];
    scanISBNbtn.layer.cornerRadius = 5;
    [scanISBNbtn setImage:scan forState:UIControlStateNormal];
    [scanISBNbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scanISBNbtn addTarget:self action:@selector(scanClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:scanISBNbtn];

    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 560, 405, 44)];
    submitBtn.backgroundColor = [UIColor greenColor];
    submitBtn.layer.cornerRadius = 5;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitCliked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:submitBtn];
    
    return self;
}
            
- (void)submitCliked
{
    if([[self.isbnField text] isEqualToString:@""]||[[self.titleField text] isEqualToString:@""]||[[self.priceField text] isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"INFO"
                                                        message:@"Please complete the necessary information."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }//else{
//        //string-string
//
//       // NSLog(@"%@",_customer);
//
//       // NSArray* author = @[[_author1 text],[_author2 text],[_author3 text]];
//
//        NSLog(@"%@",author);
//
//        NSDictionary* data = @{
//                               @"bookname":[_bookName text],
//                               @"isbn" :[self.isbnField text],
//                               @"author":author,
//                               @"edition":[_edition text],
//                               @"price":[self.priceField text],
//                               @"ID":_customer[@"customerID"],
//
//                               };
//
//        BookModel* book = [[BookModel alloc]init];
//
//        [book sellBooks:data completion:^(id response) {
//            //after do somthing
//            //NSLog(@"%@",response);
//            if([response isKindOfClass:[NSString class]]&&[response containsString:@"FAILURE"]){
//                //failure
//                NSLog(@"FAIL:%@",response);
//
//            }else{
//
//                NSLog(@"SUCC:%@",response);
//
//                dispatch_async(dispatch_get_main_queue(), ^{
//
//
//                });
//
//            }
//        }];
//
//    }
}
- (void)scanClicked
{
    
    NSLog(@"adufhakdhflakjsdhfakjsdhflakjshfdakjlsdfhalks!!!!!");
}
//
//-(NSMutableArray*)GetALLphotosUsingPohotKit
//{
//    NSMutableArray *arr = [NSMutableArray array];
//
//    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//
//    for (NSInteger i = 0; i < smartAlbums.count; i++) {
//        PHFetchOptions *option = [[PHFetchOptions alloc] init];
//        option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
//        option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
//        PHCollection *collection = smartAlbums[i];
//        if ([collection isKindOfClass:[PHAssetCollection class]]) {
//            if ([collection.localizedTitle isEqualToString:@"相机胶卷"]) {
//                PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
//                PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
//                NSArray *assets;
//                if (fetchResult.count > 0) {
//                    assets = [self getAllPhotosAssetInAblumCollection:assetCollection ascending:YES ];
//                    [arr addObjectsFromArray:assets];
//                }
//            }
//        }
//    }
//    return arr;
//}
//
//- (NSArray *)getAllPhotosAssetInAblumCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending
//{
//    NSMutableArray *assets = [NSMutableArray array];
//
//    PHFetchOptions *option = [[PHFetchOptions alloc] init];
//    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
//    option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
//
//    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
//    [result enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
//        [assets addObject:asset];
//    }];
//    return assets;
//}
//
//- (void)accessToImageAccordingToTheAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void(^)(UIImage *image,NSDictionary *info))completion
//{
//    static PHImageRequestID requestID = -2;
//
//    CGFloat scale = [UIScreen mainScreen].scale;
//    CGFloat width = MIN([UIScreen mainScreen].bounds.size.width, 500);
//    if (requestID >= 1 && size.width / width == scale) {
//        [[PHCachingImageManager defaultManager] cancelImageRequest:requestID];
//    }
//    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
//    option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
//    //    option.resizeMode = PHImageRequestOptionsResizeModeFast;
//    option.resizeMode = resizeMode;
//
//    requestID = [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            completion(result,info);
//        });
//    }];
//
//}
//
//
//-(void)getLastImage{
//    ALAssetsLibrary *al = [[ALAssetsLibrary alloc] init];
//    [al latestAsset:^(ALAsset * _Nullable asset, NSError * _Nullable error) {
//        NSString *type = [asset valueForProperty:ALAssetPropertyType];
//        if ([type isEqual:ALAssetTypePhoto]){
//            UIImage *needImage = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
//            if (needImage) {
//                self.imagePreview.image = needImage;
//            }
//        }
//    }];
//}

@end





