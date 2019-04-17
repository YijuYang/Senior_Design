//
//  BookModel.h
//  TestJson
//
//  Created by qixiang liu on 3/11/19.
//  Copyright © 2019 qixiang liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BookModel : NSObject
-(void)displayAllBooks:(void (^)(id))completion;


-(void)sellBooks:(NSDictionary*) data completion:(void (^)(id))completion;


-(void)findBooks:(NSString*) data completion:(void (^)(id ))completion;

+(UIImage*)stringToImage:(NSString*) string;
+(NSString*)imageToString:(UIImage*) image;


@end

NS_ASSUME_NONNULL_END
