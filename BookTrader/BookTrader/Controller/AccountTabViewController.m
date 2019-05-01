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
#import "BrowsingHistoryViewController.h"
#import "SettingViewController.h"
#import "HelpContactViewController.h"
#import "login\singup/LoginPageViewController.h"

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
    
    UIImage* icon = [UIImage imageNamed:@"Booktrader.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 100, 100)];
    imageView.backgroundColor = [UIColor blueColor];
    imageView.image = icon;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.layer.cornerRadius = 3;
    [self.view addSubview:imageView];
    //图表
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];

    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.AccountList = @[@"My Sales",@"My Browsing History",@"Settings",@"Contact Developers"];
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    [self.accountView addSubview:self.tableView];
    //Logout button
    self.logoutbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 380, 100, 50)];
    [self.logoutbtn setTitle:@"Log Out" forState:UIControlStateNormal];
    self.logoutbtn.enabled=YES;
    self.logoutbtn.backgroundColor = [UIColor blueColor];
    self.logoutbtn.layer.cornerRadius = 4;
    //    self.btn.showsTouchWhenHighlighted = YES;
    [self.logoutbtn addTarget:self action:@selector(clickLogoutButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logoutbtn];
}

- (void) clickLogoutButton
{
    LoginPageViewController *lgsl= [[LoginPageViewController alloc]init];
//    [self.navigationController pushViewController:lgsl animated:NO];
    self.view.window.rootViewController = lgsl;

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
//        if(indexPath.row != 0)
//        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];

            NSInteger indexofRow = indexPath.row;
            
            cell.textLabel.text = [_AccountList objectAtIndex:indexofRow];
//        }
//        else
//        {
//            UIImage *icon = [UIImage imageNamed:@"Booktrader.png"];
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
//            cell.imageView.image = icon;
//        }
    }
   
    return cell;
    
}
    
-  (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger indexofRow = indexPath.row;
    if(indexofRow==0) {
        NSLog(@"My on sell items",(long)indexPath.row);
        OnSellViewController *onsl= [[OnSellViewController alloc]init];
        [self.navigationController pushViewController:onsl animated:NO];
    }
    else if(indexofRow==1){
        NSLog(@"My Order Historys",(long)indexPath.row);
        BrowsingHistoryViewController *odsl= [[BrowsingHistoryViewController alloc]init];
        [self.navigationController pushViewController:odsl animated:NO];
    }
    else if(indexofRow==2){
        NSLog(@"Settings",(long)indexPath.row);
        SettingViewController *stsl= [[SettingViewController alloc]init];
        [self.navigationController pushViewController:stsl animated:NO];
    }
    else if(indexofRow==3){
        NSLog(@"Help&Contact",(long)indexPath.row);
        HelpContactViewController *hcsl= [[HelpContactViewController alloc]init];
        [self.navigationController pushViewController:hcsl animated:NO];
    }
}

    
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 45;
    }
@end
