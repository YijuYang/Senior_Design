//
//  UserModel.m
//  TestJson
//
//  Created by qixiang liu on 3/5/19.
//  Copyright © 2019 qixiang liu. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

static NSString* createAccountLocal= @"http://localhost/createAccount.php";
static NSString* modifyAccountLocal= @"http://localhost/modifyAccount.php";

static NSString* createAccountAWS= @"http://ec2-54-242-126-17.compute-1.amazonaws.com/createAccount.php";

static NSString* loginLocal= @"http://localhost/login.php";
static NSString* loginAWS= @"http://ec2-54-242-126-17.compute-1.amazonaws.com/login.php";

static NSString* postDataForTestLocal= @"http://localhost/postData.php";


-(void)getDataFromPhp1
{
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: @"http://localhost/jsonRead.json"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"json: %@", json);
}

-(void)getDataFromPhp2{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost/login.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLSessionDataTask * dataTask =  [session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
        
        //第一种打印
//        //拿到响应头信息
//        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
//        //4.解析拿到的响应数据
//        NSLog(@"%@\n%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding],res.allHeaderFields);
    
     
        //第二种打印 解析成NSString
        NSString *dummy = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"String: %@",dummy);
        //第三种打印 比较高级 可以报错error，可以得到其他数据类型 NSAraay,NSDictionary,NSString
        NSError *err;
        NSArray* courseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if(err){
            NSLog(@"Failed to serialize into JSON%@",err);
        }
        for(NSDictionary *dic in courseJSON){
//            NSString *customerID = dic[@"customerID"];
              NSString *email = dic[@"customerEmail"];
            NSLog(@"Email : %@",email);
        }
        //ASYN 异步操作 对主线程操作，就是对本class 使用self
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self.tableView reloadData];
        });
        
    }];
    //3.执行Task
    //注意：刚创建出来的task默认是挂起状态的，需要调用该方法来启动任务（执行任务）
    [dataTask resume];
}


//-(void) postDataToPhpAndGetResponse1{
//
//    //POST request
//    NSError *error;
//    //生成NSDictionary Example!!
//    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: @"one", @"two", @"three", nil] forKeys: [NSArray arrayWithObjects: @"a", @"b", @"c", nil]];
//    //生成Array
//    NSArray *jsonArray = [NSArray arrayWithObject:jsonDictionary];
//    //最后生成jsonData
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSUTF8StringEncoding error:&error];
//    //发送请求
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:createAccountLocal]];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:jsonData];
//
//    //OLD 响应请求 给回复
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSString *response = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    NSLog(@"response: %@ in Log",response);
//
//        //NEW print
//        NSURLSession *session = [NSURLSession sharedSession];
//        //NSURL *url = [NSURL URLWithString:@"http://localhost/postData.php"];
//        //NSURLRequest *request2 = [NSURLRequest requestWithURL:url];
//        NSURLSessionDataTask *returnData2 = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            NSString *dummy = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"String: %@",dummy);
//        }];
//    [returnData2 resume];
//
//}
-(void)postDataToPhpAndGetResponse2:(NSString *)post_data{
    
     //POST DATA
     //NSString ==> NSData
     //NSData *postData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
     NSData *postData = [post_data dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
     //length?
     NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
     
     //URLRequest
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
     
     
    [request setURL:[NSURL URLWithString:@"http://localhost/postData.php"]];
    //[request setURL:url];
    [request setHTTPMethod:@"POST"];//POST
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
     //GET DATA
     NSURLSession *session = [NSURLSession sharedSession];
     
     NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,NSURLResponse * _Nullable response,NSError * _Nullable error) {
     
     // 第三种打印
//         NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//         NSLog(@"%@", json);//null?
         //第二种打印
         NSString* responseData =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
         NSLog(@"Response Data %@",responseData);
     }];
     
     [task resume];

}

-(void)postDataToPhpAndGetResponse3:(NSDictionary *)postData{
    //POST request
    NSError *error;

    NSArray *jsonArray = [NSArray arrayWithObject:postData];
    //最后生成jsonData
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSUTF8StringEncoding error:&error];
    //发送请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:createAccountLocal]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
    //GET DATA
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,NSURLResponse * _Nullable response,NSError * _Nullable error) {
        
        // 第三种打印
        //         NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        //         NSLog(@"%@", json);//null?
        //第二种打印
        NSString* responseData =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Response Data %@",responseData);
    }];
    
    [task resume];
}

-(void)postDataToPhpAndGetResponse4:(NSArray *)postData{
    NSError *error;
    //最后生成jsonData
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postData options:NSUTF8StringEncoding error:&error];
    //发送请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/postData.php"]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
 
}

-(void)login:(NSString*) emailAndPwd completion:(void (^)(id))completion{
    
        NSURL* url = [NSURL URLWithString:loginAWS];
        
        NSData *postData = [emailAndPwd dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
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
        NSArray* json_response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if ( json_response ) {
            completion(json_response);//NSArray
        }
        else {

            //NSLog(@"Error serializing JSON: %@", error); //NSString

            //NSLog(@"Error serializing JSON: %@", error); //NSString
           // NSLog(@"RAW RESPONSE: %@",data);
            NSString *returnString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            //NSLog(@"Response:%@",returnString2);
            completion(returnString);
        }
    }]resume];
    
}
-(void)login:(NSString*) emailAndPwd{
    NSURL* url = [NSURL URLWithString:loginAWS];
    
    NSData *postData = [emailAndPwd dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
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

        //print1
        NSString* responseData =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Response Data: %@",responseData);
        
        //print 2
//        NSError *err;
//        NSArray* customer = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
//
//        if(err){
//            NSLog(@"Failed to serialize into JSON%@",err);
//        }else{
//            for(NSDictionary *dic in customer){
//                for(NSString* key in dic){
//                    [self->_user setValue:dic[key] forKey:key];
//                    NSLog(@": %@",dic[key]);
//
//                }
//            }
//        }
    }]resume];
}

-(void)createAccount:(NSDictionary*) data{
    //POST request
    NSError *error;
    
    NSArray *jsonArray = [NSArray arrayWithObject:data];
    //最后生成jsonData
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSUTF8StringEncoding error:&error];
    //发送请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:createAccountAWS]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
    //GET DATA
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,NSURLResponse * _Nullable response,NSError * _Nullable error) {
        
        //NSString* responseData =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSError *err;
        NSArray* responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if(err){
            NSLog(@"Failed to serialize into JSON%@",err);
        }
        NSLog(@"Response Data %@",responseData);
    }];
    
    [task resume];
}


-(void)createAccount:(NSDictionary*) data completion:(void (^)(id))completion{
    //POST request
    NSError *error;
    
    NSArray *jsonArray = [NSArray arrayWithObject:data];
    //最后生成jsonData
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSUTF8StringEncoding error:&error];
    //发送请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:createAccountAWS]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
    //GET DATA
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,NSURLResponse * _Nullable response,NSError * _Nullable error) {
        
        NSString *returnString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
        //NSLog(@"Response:%@",returnString2);
        completion(returnString); //only have string

//        NSError *err;
//        NSDictionary* json_response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
//        if ( json_response ) {
//            completion(json_response);
//        }
//        else {
//            NSLog(@"Error serializing JSON: %@", error);
//            // NSLog(@"RAW RESPONSE: %@",data);
//            NSString *returnString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
//            //NSLog(@"Response:%@",returnString2);
//            completion(returnString);
//        }
    }];
    
    [task resume];
}


-(void)modifyAccount:(NSDictionary*) data completion:(void (^)(id))completion{
    NSError *error;
    
    NSArray *jsonArray = [NSArray arrayWithObject:data];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSUTF8StringEncoding error:&error];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:modifyAccountLocal]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,NSURLResponse * _Nullable response,NSError * _Nullable error) {
        
        NSString *returnString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
        //NSLog(@"Response:%@",returnString2);
        completion(returnString);
    }];
    
    [task resume];
}

@end
