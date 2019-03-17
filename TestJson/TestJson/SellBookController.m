//
//  SellBookController.m
//  TestJson
//
//  Created by qixiang liu on 3/15/19.
//  Copyright © 2019 qixiang liu. All rights reserved.
//

#import "SellBookController.h"

@interface SellBookController ()

@end

@implementation SellBookController

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

- (IBAction)SellBookButtonClick:(UIButton *)sender {
    if([[_ISBN text] isEqualToString:@""]||[[_bookName text] isEqualToString:@""]||[[_price text] isEqualToString:@""]){
        NSLog(@"FAILURE: Empty price or name ..TODO empy other things");
    }else{
        //string-string
        
        NSLog(@"%@",_customer);

        NSArray* author = @[[_author1 text],[_author2 text],[_author3 text]];
        
        NSLog(@"%@",author);

        NSDictionary* data = @{
                               @"bookname":[_bookName text],
                               @"isbn" :[_ISBN text],
                               @"author":author,
                               @"edition":[_edition text],
                               @"price":[_price text],
                               @"ID":_customer[@"customerID"],

                               };
        
        BookModel* book = [[BookModel alloc]init];
        
        [book sellBooks:data completion:^(id response) {
            //after do somthing
            //NSLog(@"%@",response);
            if([response isKindOfClass:[NSString class]]&&[response containsString:@"FAILURE"]){
                //failure
                NSLog(@"FAIL:%@",response);

            }else{

                NSLog(@"SUCC:%@",response);

                dispatch_async(dispatch_get_main_queue(), ^{


                });

            }
        }];
        
    }
    
}
@end
