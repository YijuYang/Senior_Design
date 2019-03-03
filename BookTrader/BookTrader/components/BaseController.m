//
//  BaseController.m
//  BookTrader
//
//  Created by JianShen on 3/3/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import "BaseController.h"


@implementation BaseController
/*
 @author: Jian
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavLeftBarButtonItem];
    self.view.backgroundColor = [UIColor lightGrayColor];
}
/*
 @author: Jian
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - self.navigationController
/*
 @author: Jian
 */
- (void)setNavLeftBarButtonItem
{
    //TODO:
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStyleDone target:self action:@selector(popSelfController)];
}
/*
 @author: Jian
 */
- (void)popSelfController
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
