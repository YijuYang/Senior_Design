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

//NSString *customerID =[[NSString alloc] initWithFormat:@"customerID=%@", ?];
+(void)findBooks:(NSString*) customerID completion:(void (^)(id ))completion;



//http:// www.goodreads.com/search?q=8811667739&format=xml&key=YOUR_KEY_VALUE
+(void)searchBooksGoodRead:(NSString*) isbn completion:(void (^)(id ))completion;

+(UIImage*)stringToImage:(NSString*) string;
+(NSString*)imageToString:(UIImage*) image;

//NSString *bookID =[[NSString alloc] initWithFormat:@"bookID=%@", ?];
+(void)deleteBook:(NSString*) bookID completion:(void (^)(id))completion;


@end

NS_ASSUME_NONNULL_END
