//
//  BookModel.m
//  TestJson
//
//  Created by qixiang liu on 3/11/19.
//  Copyright © 2019 qixiang liu. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel

static NSString* bookAWS = @"http://ec2-54-242-126-17.compute-1.amazonaws.com/bookModel.php";
static NSString* bookLocal = @"http://localhost/bookModel.php";
static NSString* displayBookLocal = @"http://localhost/displayAllBooksInfo.php";
static NSString* displayBookAWS = @"http://ec2-54-242-126-17.compute-1.amazonaws.com/displayAllBooksInfo.php";

static NSString* searchBookAWS = @"http://ec2-54-242-126-17.compute-1.amazonaws.com/searchBook.php";



-(void)sellBooks:(NSDictionary*) data image:(UIImage*)img completion:(void (^)(id))completion{
    //POST request
    NSError *error;
    
    NSArray *jsonArray = [NSArray arrayWithObject:data];
    //最后生成jsonData
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSUTF8StringEncoding error:&error];
    //发送请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:bookAWS]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
    //GET DATA
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,NSURLResponse * _Nullable response,NSError * _Nullable error) {
        
        NSString *returnString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
        //NSLog(@"Response:%@",returnString2);
        completion(returnString);
        
    }];
    
    [task resume];
}

-(void)findBooks:(NSString*) data completion:(void (^)(id ))completion{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:searchBookAWS];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask * dataTask =  [session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
        
        //第三种打印 比较高级 可以报错error，可以得到其他数据类型 NSAraay,NSDictionary,NSString
        NSError *err;
        NSArray* book = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if(err){
            //failure
            NSLog(@"Failed to serialize into JSON%@",err);
        }else{
            //return NSarray
            completion(book);
        }
    }];
    
    [dataTask resume];
}

-(void)displayAllBooks:(void (^)(id))completion{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:displayBookAWS];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask * dataTask =  [session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {

        //第三种打印 比较高级 可以报错error，可以得到其他数据类型 NSAraay,NSDictionary,NSString
        NSError *err;
        NSArray* book = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if(err){
            NSLog(@"Failed to serialize into JSON%@",err);
        }else{
            //return NSarray
            completion(book);
        }
    }];

    [dataTask resume];
}


@end
