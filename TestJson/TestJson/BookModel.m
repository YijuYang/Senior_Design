//
//  BookModel.m
//  TestJson
//
//  Created by qixiang liu on 3/11/19.
//  Copyright © 2019 qixiang liu. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel

static NSString* bookUrl = @"http://ec2-54-242-126-17.compute-1.amazonaws.com/bookModel.php";

-(void)sellBooks:(NSDictionary*) data completion:(void (^)(id))completion{
    //POST request
    NSError *error;
    
    NSArray *jsonArray = [NSArray arrayWithObject:data];
    //最后生成jsonData
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSUTF8StringEncoding error:&error];
    //发送请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:bookUrl]];
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
    NSURL* url = [NSURL URLWithString:bookUrl];
    
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
        
        // NSString* responseData =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"Response:%@",responseData);
        
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

-(void)displayAllBooks{
    
}


@end
