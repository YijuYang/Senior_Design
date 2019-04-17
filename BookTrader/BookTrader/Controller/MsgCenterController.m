//
//  MsgCenterController.m
//  BookTrader
//
//  Created by qixiang liu on 4/4/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import "MsgCenterController.h"
#import "CommunicationView.h"
@interface MsgCenterController ()<CommunicationViewDelegate>
@property (nonatomic, strong) CommunicationView* CommunicationView;

@end

@implementation MsgCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Msg Details";// name 
    self.CommunicationView = [[CommunicationView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.CommunicationView.delegate = self;
    [self.view addSubview:self.CommunicationView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)doSendMsgButton
{
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

@end
