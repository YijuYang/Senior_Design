//
//  UserModel.m
//  TestJson
//
//  Created by qixiang liu on 3/5/19.
//  Copyright © 2019 qixiang liu. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

static NSString* createAccountUrl= @"http://localhost/createAccount.php";
static NSString* createAccountUrl2= @"http://ec2-54-242-126-17.compute-1.amazonaws.com/createAccount.php";

static NSString* loginUrl= @"http://localhost/login.php";
static NSString* loginUrl2= @"http://ec2-54-242-126-17.compute-1.amazonaws.com/login.php";

static NSString* postDataForTestUrl= @"http://localhost/postData.php";

//
//@synthesize user = _user;

//把json数据转换为OC对象
-(void)jsonToOC
{
    
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: @"http://localhost/jsonRead.json"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"json: %@", json);
    
    
}
//-(void)jsonToOC2{
//    //1. 确定URL
//    NSURL *url = [NSURL URLWithString:@"http://ec2-54-242-126-17.compute-1.amazonaws.com/customer.php"];
//
//    
//    //2. 创建请求对象
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    //3. 发送异步请求
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        // data(响应体) ---> 本质就是字符串
//        //4. 解析数据
//        // 反序列化 JSON--->OC对象
//        /*
//         NSJSONReadingMutableContainers = (1UL << 0), 返回可变的字典和数组
//         NSJSONReadingMutableLeaves = (1UL << 1), iOS7以后有问题,一般不用
//         NSJSONReadingAllowFragments = (1UL << 2) 解析的数据 既不是字典也不是数组 必须使用这个枚举值
//         */
//        
//        // kNilOptions == 0
//        //       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//        //        NSLog(@"%@",dict[@"success"]);
//        
//        // 如果解析非字典/数组的数据, 只能使用NSJSONReadingAllowFragments枚举
//        NSString *strM = @"\"GZY\"";
//        id obj = [NSJSONSerialization JSONObjectWithData:[strM dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"%@--%@",[obj class],obj);
//    }];
//    
//    
//    
//}


-(void)jsonToOC3{
    //1.创建NSURLSession对象（可以获取单例对象）
    NSURLSession *session = [NSURLSession sharedSession];
    //2.根据NSURLSession对象创建一个Task
    
    NSURL *url = [NSURL URLWithString:@"http://localhost/login.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //方法参数说明
    /*
     注意：该block是在子线程中调用的，如果拿到数据之后要做一些UI刷新操作，那么需要回到主线程刷新
     第一个参数：需要发送的请求对象
     block:当请求结束拿到服务器响应的数据时调用block
     block-NSData:该请求的响应体
     block-NSURLResponse:存放本次请求的响应信息，响应头，真实类型为NSHTTPURLResponse
     block-NSErroe:请求错误信息
     */
    NSURLSessionDataTask * dataTask =  [session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
        
        //第一种打印
//        //拿到响应头信息
//        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
//
//
//        //4.解析拿到的响应数据
//        NSLog(@"%@\n%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding],res.allHeaderFields);
    
     
        //第二种打印
        
        NSString *dummy = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"String: %@",dummy);
        
        //第三种打印
        NSError *err;
        NSArray* courseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if(err){
            NSLog(@"Failed to serialize into JSON%@",err);
        }
       // NSMutableArray<Course*> *courses = NSMutableArray.new;
        for(NSDictionary *dic in courseJSON){
//            NSString *customerID = dic[@"customerID"];
//            NSString *firstName = dic[@"firstName"];
//            NSString *lastName = dic[@"lastName"];
              NSString *email = dic[@"customerEmail"];
//            NSString *pwd = dic[@"password"];
//            NSString *major = dic[@"major"];

//            Course *course = Course.new;
//            course.customerID = customerID;
//            [courses addObject:course]
            NSLog(@"Email : %@",email);
        }
        
        //ASYN
       // NSLog(@"%@",courses);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//
//        });
        
    }];
    
    //3.执行Task
    //注意：刚创建出来的task默认是挂起状态的，需要调用该方法来启动任务（执行任务）
    [dataTask resume];
}



//NSString *post_data = @"name=rob&color=green";
//[self sendData:post_data];


-(void) sendData{
    
    //POST request
    NSError *error;
    //生成NSDictionary Example!!
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: @"one", @"two", @"three", nil] forKeys: [NSArray arrayWithObjects: @"a", @"b", @"c", nil]];
    //生成Array
    NSArray *jsonArray = [NSArray arrayWithObject:jsonDictionary];
    //最后生成jsonData
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSUTF8StringEncoding error:&error];
    //发送请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:createAccountUrl]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
    //OLD 响应请求 给回复
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *response = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"response: %@ in Log",response);
    
        //NEW print
        NSURLSession *session = [NSURLSession sharedSession];
        //NSURL *url = [NSURL URLWithString:@"http://localhost/postData.php"];
        //NSURLRequest *request2 = [NSURLRequest requestWithURL:url];
        NSURLSessionDataTask *returnData2 = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSString *dummy = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"String: %@",dummy);
        }];
    [returnData2 resume];

}
-(void)sendData2:(NSString *)post_data{
    
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

-(void)sendData3:(NSDictionary *)postData{
    //POST request
    NSError *error;

    NSArray *jsonArray = [NSArray arrayWithObject:postData];
    //最后生成jsonData
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSUTF8StringEncoding error:&error];
    //发送请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:createAccountUrl]];
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

-(void)sendData4:(NSArray *)postData{
    NSError *error;
    //最后生成jsonData
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postData options:NSUTF8StringEncoding error:&error];
    //发送请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/postData.php"]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
 
}

-(void)loginButtonClick:(NSString*) emailAndPwd completion:(void (^)(id))completion{
//This is for Button ACTION
//    if([[_email text] isEqualToString:@""]||[[_password text] isEqualToString:@""]){
//        NSLog(@"FAILURE: Empty Email or password");
//    }else{
//NSString *post =[[NSString alloc] initWithFormat:@"email=%@&password=%@", [_email text],[_password text]];
//NSLog(@"post data: %@",post);
        
        NSURL* url = [NSURL URLWithString:loginUrl2];
        
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
            completion(json_response);
        }
        else {
            NSLog(@"Error serializing JSON: %@", error);
           // NSLog(@"RAW RESPONSE: %@",data);
            NSString *returnString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            //NSLog(@"Response:%@",returnString2);
            completion(returnString);
        }
    }]resume];
    
}
-(void)loginButtonClick:(NSString*) emailAndPwd{
    NSURL* url = [NSURL URLWithString:loginUrl2];
    
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
//
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

-(void)createAccountButtonClick:(NSDictionary*) data{
    //POST request
    NSError *error;
    
    NSArray *jsonArray = [NSArray arrayWithObject:data];
    //最后生成jsonData
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSUTF8StringEncoding error:&error];
    //发送请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:createAccountUrl2]];
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


-(void)createAccountButtonClick:(NSDictionary*) data completion:(void (^)(id))completion{
    //POST request
    NSError *error;
    
    NSArray *jsonArray = [NSArray arrayWithObject:data];
    //最后生成jsonData
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSUTF8StringEncoding error:&error];
    //发送请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:createAccountUrl2]];
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

@end
