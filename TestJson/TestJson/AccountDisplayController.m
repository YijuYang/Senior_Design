//
//  AccountDisplayController.m
//  TestJson
//
//  Created by qixiang liu on 3/14/19.
//  Copyright © 2019 qixiang liu. All rights reserved.
//

#import "AccountDisplayController.h"

@interface AccountDisplayController ()

@end

@implementation AccountDisplayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self reloadData];
    
    //NSLog(@"%@",_customer);

    _firstName.text = _customer[@"firstName"];
    _lastName.text = _customer[@"lastName"];
    _email.text = _customer[@"customerEmail"];
    _password.text = _customer[@"customerPwd"];
    _major.text = _customer[@"major"];
    _kuid.text = _customer[@"KUID"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
