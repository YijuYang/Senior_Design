//
//  AccountController.m
//  TestJson
//
//  Created by qixiang liu on 3/8/19.
//  Copyright © 2019 qixiang liu. All rights reserved.
//

#import "AccountController.h"

@interface AccountController ()

@end

@implementation AccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)createAccountButtonClick:(id)sender {
    if([[_email text] isEqualToString:@""]||[[_password text] isEqualToString:@""]||[[_firstname text] isEqualToString:@""]||[[_lastname text] isEqualToString:@""]){
        NSLog(@"FAILURE: Empty Email or password ..TODO empy other things");
    }else{
        //string-string
        NSDictionary* data = @{
                               @"firstName":[_firstname text],
                               @"lastName" :[_lastname text],
                               @"customerEmail":[_email text],
                               @"customerPwd":[_password text],
                               @"major":[_major text],
                               @"KUID":[_kuid text]
                               };
//
//        _firstName.text = _customer[@"firstName"];
//        _lastName.text = _customer[@"lastName"];
//        _email.text = _customer[@"customerEmail"];
//        _password.text = _customer[@"customerPwd"];
//        _major.text = _customer[@"major"];
//        _kuid.text = _customer[@"KUID"];
        
        UserModel* user = [[UserModel alloc]init];
        //[user sendData3:data];
        
        [user createAccountButtonClick:data completion:^(id response) {
            //after do somthing
            //NSLog(@"%@",response);
            if([response isKindOfClass:[NSString class]]&&[response containsString:@"FAILURE"]){
                //failure
                NSLog(@"FAIL:%@",response);
            
            }else{
                //success
                //data = response;
                NSLog(@"SUCC:%@",response);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //NSLog(@"%@",data);
                    self->_customerInstance = [NSDictionary dictionaryWithDictionary:data];
                    //NSLog(@"%@",self->_customerInstance);
                    [self performSegueWithIdentifier:@"createAccount" sender:self];
                    
                });

            }
        }];
        
    }
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"createAccount"]){
        UITabBarController* destController = [segue destinationViewController];
        AccountDisplayController *display = [destController.viewControllers objectAtIndex:3];
       // NSLog(@"%@",_customerInstance);
        display.customer = _customerInstance;
    }
}
@end
