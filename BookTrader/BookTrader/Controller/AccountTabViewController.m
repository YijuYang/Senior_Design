//
//  AccountTabViewController.m
//  BookTrader
//
//  Created by JianShen on 2/21/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AccountTabViewController.h"
#import "OnSellViewController.h"
#import "AccountTabView.h"
#import "OrderHistoryViewController.h"
#import "SettingViewController.h"

@interface AccountTabViewController ()
{
    UITableView *_vTable;
}
@property (nonatomic, strong) AccountTabView* accountView;
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray* AccountList;
@property(nonatomic, strong) UIButton* logoutbtn;

@end

@implementation AccountTabViewController

/*
 @author 
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"ACCOUNT";
    //框框
    self.accountView = [[AccountTabView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.accountView];
    //图表
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];

    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.AccountList = @[@" ",@"My selling",@"View History",@"Setting",@"Help and contacts"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.accountView addSubview:self.tableView];
}

- (void)doClickSwitch
{
}

static NSString* cellID = @"cellID";
#pragma mark  table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.AccountList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    NSInteger indexofRow = indexPath.row;
    
    cell.textLabel.text = [_AccountList objectAtIndex:indexofRow];
    return cell;
    
}
-  (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger indexofRow = indexPath.row;
    if(indexofRow==1) {
        NSLog(@"My on sell items",(long)indexPath.row);
        OnSellViewController *onsl= [[OnSellViewController alloc]init];
        [self.navigationController pushViewController:onsl animated:NO];
    }
    else if(indexofRow==2){
        NSLog(@"My Order Historys",(long)indexPath.row);
        OrderHistoryViewController *odsl= [[OrderHistoryViewController alloc]init];
        [self.navigationController pushViewController:odsl animated:NO];
    }
    else if(indexofRow==3){
        NSLog(@"Settings",(long)indexPath.row);
        SettingViewController *stsl= [[SettingViewController alloc]init];
        [self.navigationController pushViewController:stsl animated:NO];
    }
    else if(indexofRow==5){
        self.logoutbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 280, 100, 50)];
        [self.logoutbtn setTitle:@"Log out" forState:UIControlStateNormal];
        self.logoutbtn.enabled=YES;
        self.logoutbtn.backgroundColor = [UIColor greenColor];
        self.logoutbtn.layer.cornerRadius = 4;
        //    self.btn.showsTouchWhenHighlighted = YES;
        [self.logoutbtn addTarget:self action:@selector(clickChangeButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.logoutbtn];
    }
}

@end
