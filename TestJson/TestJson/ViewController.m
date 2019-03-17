//
//  ViewController.m
//  TestJson
//
//  Created by qixiang liu on 3/5/19.
//  Copyright © 2019 qixiang liu. All rights reserved.
//

#import "ViewController.h"
#import "UserModel.h"
@interface ViewController ()

@end

@implementation ViewController
static NSString* data = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self jsonToOC];
    UserModel *user = [[UserModel alloc]init];
    //[user jsonToOC3];
    
}


-(void)jsonToOC{
    //1.创建NSURLSession对象（可以获取单例对象）
    NSLog(@"Fetching the data");
    NSURLSession *session = [NSURLSession sharedSession];
    //2.根据NSURLSession对象创建一个Task
    
    NSURL *url = [NSURL URLWithString:@"http://localhost/jsonRead.json"];
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
        
                //拿到响应头信息
                NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        
                if(error == nil){
                    NSLog(@"error haha");
                }else{
                    //4.解析拿到的响应数据
                    NSLog(@"%@\n%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding],res.allHeaderFields);
                }
        
        
//        NSString *dummy = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"String: %@",dummy);
    }];
    
    //3.执行Task
    //注意：刚创建出来的task默认是挂起状态的，需要调用该方法来启动任务（执行任务）
    [dataTask resume];
}
- (IBAction)loginbutton:(id)sender {
    if([[_email text] isEqualToString:@""]||[[_password text] isEqualToString:@""]){
        NSLog(@"FAILURE: Empty Email or password");
    }else{
        NSString *post =[[NSString alloc] initWithFormat:@"email=%@&password=%@", [_email text],[_password text]];
        
        NSLog(@"post data: %@",post);
        
        UserModel* user = [[UserModel alloc]init];
        
        //first way
        [user loginButtonClick:post completion:^(id response) {
            //after do somthing
            //NSLog(@"%@",response);
            if([response isKindOfClass:[NSString class]]&&[response containsString:@"FAILURE"]){
                //failure
                NSLog(@"%@",response);
                
            }else{
                //success
                //data = response;
                NSLog(@"%@",response);
                //ASYN
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (NSDictionary* eachData in response){
                        self->_customerInstance = [NSDictionary dictionaryWithDictionary:eachData];
                       // NSString* first = eachData[@"firstName"];
                       //NSLog(@"%@",first);
                    }
                    [self performSegueWithIdentifier:@"login" sender:self];
                });

            }
        }];
        
        
        
    }
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
-(void)alertStatus:(NSString *)msg :(NSString *)title{
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if([segue.identifier isEqualToString:@"login"]){
//        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
//        AccountDisplayController * display = (AccountDisplayController *)navController.topViewController;
//        display.firstName.text = @"Guest";
//    }
    
    if([segue.identifier isEqualToString:@"login"]){
        UITabBarController* destController = [segue destinationViewController];
        //[destController setSelectedIndex:1]; //why this one cannot ?
//        AccountDisplayController *display = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AccountDisplayController"];
        AccountDisplayController *display = [destController.viewControllers objectAtIndex:3];
        SellBookController *sendCustomer = [destController.viewControllers objectAtIndex:2];

        //NSLog(@"%@",_customerInstance);
        display.customer = _customerInstance;
        sendCustomer.customer = _customerInstance;


    }
 
}
@end
