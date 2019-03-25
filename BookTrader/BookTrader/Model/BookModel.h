//
//  BookModel.h
//  TestJson
//
//  Created by qixiang liu on 3/11/19.
//  Copyright © 2019 qixiang liu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookModel : NSObject
-(void)displayAllBooks:(void (^)(id))completion;


-(void)sellBooks:(NSDictionary*) data completion:(void (^)(id))completion;


-(void)findBooks:(NSString*) data completion:(void (^)(id ))completion;
@end

NS_ASSUME_NONNULL_END
