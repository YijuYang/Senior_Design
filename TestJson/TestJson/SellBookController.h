//
//  SellBookController.h
//  TestJson
//
//  Created by qixiang liu on 3/15/19.
//  Copyright © 2019 qixiang liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"
#import "AccountDisplayController.h"
NS_ASSUME_NONNULL_BEGIN

@interface SellBookController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *bookName;

@property (strong, nonatomic) IBOutlet UITextField *ISBN;
@property (strong, nonatomic) IBOutlet UITextField *author1;
@property (strong, nonatomic) IBOutlet UITextField *author2;
@property (strong, nonatomic) IBOutlet UITextField *author3;

@property (strong, nonatomic) IBOutlet UITextField *edition;
@property (strong, nonatomic) IBOutlet UITextField *price;
@property (nonatomic, retain) NSDictionary* customer;

- (IBAction)SellBookButtonClick:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END
