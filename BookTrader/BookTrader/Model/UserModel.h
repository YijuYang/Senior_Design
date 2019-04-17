//
//  UserModel.h
//  TestJson
//
//  Created by qixiang liu on 3/5/19.
//  Copyright © 2019 qixiang liu. All rights reserved.
//Log NSURLSession cannot be returned data

#import <Foundation/Foundation.h>
@interface UserModel : NSObject{

}



//Any HTTP 请求无法有返回值,但是可以操作返回值在这个function里面。@"email=%@&password=%@" 传递的data 格式必须严格要求
-(void)login:(NSString*) emailAndPwd completion:(void (^)(id ))completion;
-(void)login:(NSString*) emailAndPwd;

/* The is part for data style in createAccount
 NSDictionary* data = @{
                     @customerID: <unique>
                     @"firstName":
                     @"lastName" :
                     @"customerEmail":
                     @"customerPwd":
                     @"major":
                     @"KUID":
 };
 */
-(void)createAccount:(NSDictionary*) data;
-(void)createAccount:(NSDictionary*) data completion:(void (^)(id))completion;


+(void)modifyAccount:(NSDictionary*) data completion:(void (^)(id))completion;

-(NSDictionary*)getCurrentLocalUserInfo;













//This is for qixiang to test; u do not use for them
-(void)getDataFromPhp1;
-(void)getDataFromPhp2;
//-(void)postDataToPhpAndGetResponse1;
-(void)postDataToPhpAndGetResponse2:(NSString*) post_data;
-(void)postDataToPhpAndGetResponse3:(NSDictionary*) postData;
-(void)postDataToPhpAndGetResponse4:(NSArray*) postData;

@end

