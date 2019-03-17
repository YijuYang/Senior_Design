//
//  ViewController.h
//  TestJson
//
//  Created by qixiang liu on 3/5/19.
//  Copyright © 2019 qixiang liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "AccountDisplayController.h"
#import "SellBookController.h"
@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (nonatomic, copy) NSDictionary* customerInstance;

@property (strong, nonatomic) IBOutlet UITextField *password;
- (IBAction)loginbutton:(id)sender;
-(void) didReceiveMemoryWarning;
-(void) alertStatus:(NSString*)msg :(NSString*)title;
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end

