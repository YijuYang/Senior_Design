//
//  UserModel.h
//  TestJson
//
//  Created by qixiang liu on 3/5/19.
//  Copyright © 2019 qixiang liu. All rights reserved.
//Log NSURLSession cannot be returned data

#import <Foundation/Foundation.h>
@interface UserModel : NSObject{
    //NSMutableDictionary* _user;

}
// nonatomic 非原子性访问, 不加同步机制, 多线程并非访问时可提高性能
// strong 相当于一个深拷贝的操作
//@property(nonatomic, strong) NSMutableDictionary* user;

-(void)jsonToOC;
//-(void)jsonToOC2; //old way
-(void)jsonToOC3;
//-(void)getData:(NSString*) email;


//生成NSDictionary Example!!
//NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: @"one", @"two", @"three", nil] forKeys: [NSArray arrayWithObjects: @"a", @"b", @"c", nil]];
//This 4 is test example
-(void)sendData;
-(void)sendData2:(NSString*) post_data;
-(void)sendData3:(NSDictionary*) postData;
-(void)sendData4:(NSArray*) postData;

//
-(void)loginButtonClick:(NSString*) emailAndPwd completion:(void (^)(id ))completion; //emailAndPwd = @"email=%@&password=%@"
-(void)loginButtonClick:(NSString*) emailAndPwd; //emailAndPwd = @"email=%@&password=%@"

/*
 NSDictionary* data = @{
                     @"firstname":[_firstname text],
                     @"lastname" :[_lastname text],
                     @"email":[_email text],
                     @"password":[_password text],
                     @"major":[_major text],
                     @"kuid":[_kuid text]
 };
 */
-(void)createAccountButtonClick:(NSDictionary*) data;
-(void)createAccountButtonClick:(NSDictionary*) data completion:(void (^)(id))completion;



@end

