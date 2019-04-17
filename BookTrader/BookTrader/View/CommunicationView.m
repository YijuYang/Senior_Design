//
//  CommunicationView.m
//  BookTrader
//
//  Created by qixiang liu on 4/2/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommunicationView.h"

@implementation CommunicationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self)
    {
        return nil;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    /*
     *<searchConfirmBtn> Search button
     */
    self.sendMsgButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 44, 0, 44, 44)];
    self.sendMsgButton.backgroundColor = [UIColor whiteColor];
    self.sendMsgButton.layer.cornerRadius = 5;
    [self.sendMsgButton setTitle:@"Send" forState:UIControlStateNormal];
    [self.sendMsgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // Click to load result
    //[self.searchConfirmBtn addTarget:self action:@selector(back_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sendMsgButton];
    
//    /*
//     *<self.switchViewModeBtn> Switch button :used to swith <list> and <gird> mode
//     */
//    self.switchViewModeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    self.switchViewModeBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.3 alpha:0.5];
//    self.switchViewModeBtn.layer.cornerRadius = 5;
//    [self.switchViewModeBtn setTitle:@"∆∆" forState:UIControlStateNormal];
//    [self.switchViewModeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.switchViewModeBtn addTarget:self action:@selector(switch_Clicked) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:self.switchViewModeBtn];
    
    /*
     * Searching input bar
     */
    self.inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - self.sendMsgButton.bounds.size.width, 44)];
    self.inputTextField.backgroundColor = [UIColor whiteColor];
    self.inputTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.inputTextField.placeholder = @"Enter ...";
    self.inputTextField.textColor = [UIColor lightGrayColor];
    [self addSubview:self.inputTextField];
    

    return self;
}



@end
