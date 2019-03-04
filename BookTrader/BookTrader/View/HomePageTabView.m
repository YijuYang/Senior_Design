//
//  HomePageTabView.m
//  BookTrader
//
//  Created by JianShen on 2/20/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "HomePageTabView.h"

@interface HomePageTabView()
@property (nonatomic, strong) UIButton* searchConfirmBtn;
@property (nonatomic, strong) UIButton* switchViewModeBtn;
@property (nonatomic, strong) UITextField* searchKeywordTextField;

@property (nonatomic, strong) UIImage* demoImage;
@property (nonatomic, strong) UIImageView* demoExample;

@end

@implementation HomePageTabView

/*
 @author Simon, Jian
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
    self.searchConfirmBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 44, 0, 44, 44)];
    self.searchConfirmBtn.backgroundColor = [UIColor orangeColor];
    self.searchConfirmBtn.layer.cornerRadius = 5;
    [self.searchConfirmBtn setTitle:@"Find" forState:UIControlStateNormal];
    [self.searchConfirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // Click to load result
    //[self.searchConfirmBtn addTarget:self action:@selector(back_Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.searchConfirmBtn];
    
    /*
     *<self.switchViewModeBtn> Switch button :used to swith <list> and <gird> mode
     */
    self.switchViewModeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    self.switchViewModeBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.3 alpha:0.5];
    self.switchViewModeBtn.layer.cornerRadius = 5;
    [self.switchViewModeBtn setTitle:@"∆∆" forState:UIControlStateNormal];
    [self.switchViewModeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.switchViewModeBtn addTarget:self action:@selector(switch_Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.switchViewModeBtn];
    
    /*
     * Searching input bar
     */
    self.searchKeywordTextField = [[UITextField alloc] initWithFrame:CGRectMake(44, 0, [UIScreen mainScreen].bounds.size.width - self.switchViewModeBtn.bounds.size.width - self.searchConfirmBtn.bounds.size.width, 44)];
    self.searchKeywordTextField.backgroundColor = [UIColor whiteColor];
    self.searchKeywordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.searchKeywordTextField.placeholder = @"affordable textbook starts here";
    self.searchKeywordTextField.textColor = [UIColor lightGrayColor];
    [self addSubview:self.searchKeywordTextField];
    
    
    self.demoImage = [UIImage imageNamed:@"demo_listView.png"];
    self.demoExample = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 420, 630)];
    self.demoExample.backgroundColor = [UIColor whiteColor];
    self.demoExample.image = self.demoImage;
    self.demoExample.contentMode = UIViewContentModeScaleAspectFit;
    self.demoExample.layer.cornerRadius = 3;
    [self addSubview:self.demoExample];
    
    return self;

}

- (void) switch_Clicked
{
    UIImage *wdemoImage = [UIImage imageNamed:@"demo_gridView.png"];
    self.demoExample.image = wdemoImage;

//    [self.delegate doClickSwitch];
}

@end
