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

static NSString* deleteBookAWS = @"http://ec2-54-242-126-17.compute-1.amazonaws.com/deleteBook.php";

static NSString* searchBookAWS = @"http://ec2-54-242-126-17.compute-1.amazonaws.com/searchBook.php";
static NSString* searchBookGoodRead = @"https://www.goodreads.com/search/index.xml";



-(void)sellBooks:(NSDictionary*) data completion:(void (^)(id))completion{
    //POST request
    NSError *error;

//    NSDictionary* storeData =@{
//                               @"bookname":
//                               @"isbn" :
//                               @"author":
//                               @"edition":
//                               @"price":
//                               @"ID":data[@"ID"],
//                               @"description":
//                               @"zimage":
//                               };
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

+(void)findBooks:(NSString*) customerID completion:(void (^)(id ))completion{
    NSURLSession *session = [NSURLSession sharedSession];
    
//    NSURL *url = [NSURL URLWithString:searchBookAWS];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURL* url = [NSURL URLWithString:searchBookAWS];
    
    NSData *postData = [customerID dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", [postData length]];
    
    //URLRequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:url];
    [request setHTTPMethod:@"POST"];//POST
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
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
+(UIImage*)stringToImage:(NSString*) string{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [UIImage imageWithData:data];
    
}
+(NSString*)imageToString:(UIImage*) image{
    NSData* imageData = UIImageJPEGRepresentation(image,0.3);
    NSString* imageString;
    if([imageData respondsToSelector:@selector(base64EncodedStringWithOptions:)])
    {
        //NSLog(@"iOS 7+");
        imageString=[imageData base64EncodedStringWithOptions:kNilOptions];
    }
    else
    {
        imageString=[imageData base64Encoding];
    }
    return imageString;
}

+(void)deleteBook:(NSString*) bookID completion:(void (^)(id))completion{
    NSURLSession *session = [NSURLSession sharedSession];
    
    //    NSURL *url = [NSURL URLWithString:searchBookAWS];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURL* url = [NSURL URLWithString:deleteBookAWS];
    
    NSData *postData = [bookID dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", [postData length]];
    
    //URLRequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:url];
    [request setHTTPMethod:@"POST"];//POST
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask * dataTask =  [session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
        
//        //第三种打印 比较高级 可以报错error，可以得到其他数据类型 NSAraay,NSDictionary,NSString
//        NSError *err;
//        id book = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
//        //NSLog(@"%@", book);
//        if(err){
//            NSLog(@"Failed to serialize into JSON%@",err);
//        }else{
//            //return NSString
//            completion(book);
//        }
        NSString *returnString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
        //NSLog(@"Response:%@",returnString2);
        completion(returnString);
    }];
    
    [dataTask resume];
}

+(void)searchBooksGoodRead:(NSString*) isbn completion:(void (^)(id ))completion{
    NSString *goodReadUrl = [[NSString alloc] initWithFormat: @"https://www.goodreads.com/search/index.xml?q=%@&format=xml&key=Ifvs2BniXIzLnBIA6pxIuQ",isbn];
    NSURL* url = [NSURL URLWithString:goodReadUrl];
    //get data
    // Instantiate a session configuration object.
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Instantiate a session object.
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    // Create a data task object to perform the data downloading.
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error != nil) {
            // If any error occurs then just display its description on the console.
            NSLog(@"%@", [error localizedDescription]);
        }
        else{
            // If no error occurs, check the HTTP status code.
            NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
            
            // If it's other than 200, then show it on the console.
            if (HTTPStatusCode != 200) {
                NSLog(@"HTTP status code = %ld", (long)HTTPStatusCode);
            }
            
            // Call the completion handler with the returned data on the main thread.
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completion(data);
            }];
        }
    }];
    
    // Resume the task.
    [task resume];
    
   
    
    
}

@end
