//
//  HomePageTabViewController.m
//  BookTrader
//
//  Created by JianShen on 2/20/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomePageTabViewController.h"
#import "HomePageTabView.h"
#import "productViewController.h"
@interface HomePageTabViewController ()

@property (nonatomic, strong) HomePageTabView* homePageView;
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray* bookList;

@end

@implementation HomePageTabViewController

/*
 @author 
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"HOME";
    
    self.homePageView = [[HomePageTabView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    self.homePageView.delegate = self;
    [self.view addSubview:self.homePageView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 88)];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.bookList = @[@"Hamlet", @"Algorithm Design", @"Physics", @"Organic Chemisty",@"Machine Learning",@"Computer Vision",@"Operating System",@"Compiler"];
    _tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.homePageView addSubview:self.tableView];
    
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
    return [self.bookList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    NSInteger indexofRow = indexPath.row;
    cell.textLabel.text = [_bookList objectAtIndex:indexofRow];
    cell.detailTextLabel.text = @"10$";
    cell.imageView.image = [UIImage imageNamed:@"bookSample2.png"];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    productViewController *productCtrl = [[productViewController alloc]init];
    [self.navigationController pushViewController:productCtrl animated:NO];
    
}


@end
