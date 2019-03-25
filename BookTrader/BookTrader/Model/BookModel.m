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
static NSString* displayBookLocal = @"http://localhost/displayBook.php";
static NSString* displayBookAWS = @"http://ec2-54-242-126-17.compute-1.amazonaws.com/displayBook.php";


-(void)sellBooks:(NSDictionary*) data completion:(void (^)(id))completion{
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
    NSURL* url = [NSURL URLWithString:bookAWS];
    
    NSData *postData = [data dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", [postData length]];
    
    //URLRequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:url];
    [request setHTTPMethod:@"POST"];//POST
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSError *err;
        NSDictionary* json_response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if ( json_response ) {
            completion(json_response);
        }
        else {
            NSLog(@"Error serializing JSON: %@", error);
            NSString *returnString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            completion(returnString);
        }
    }]resume];
}

-(void)displayAllBooks:(void (^)(id))completion{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:displayBookLocal];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask * dataTask =  [session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {

        //第三种打印 比较高级 可以报错error，可以得到其他数据类型 NSAraay,NSDictionary,NSString
        NSError *err;
        NSArray* book = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if(err){
            NSLog(@"Failed to serialize into JSON%@",err);
        }else{
            completion(book);
        }
    }];

    [dataTask resume];
}


@end
