//
//  OrderHistory.m
//  BookTrader
//
//  Created by FengRose on 4/16/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import "OrderHistoryViewController.h"
#import "OrderHistoryView.h"
#import "OrderViewController.h"

@interface OrderHistoryViewController ()
@property (nonatomic, strong) OrderHistoryView* orderhistoryView;
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray* bookList;
@end

@implementation OrderHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderhistoryView = [[OrderHistoryView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //    self.homePageView.delegate = self;
    [self.view addSubview:self.orderhistoryView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 88)];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.bookList = @[@"Hamlet", @"Algorithm Design", @"Physics", @"Organic Chemisty",@"Machine Learning",@"Computer Vision",@"Operating System",@"Compiler"];
    _tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.orderhistoryView addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
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
    OrderViewController *orderCtrl = [[OrderViewController alloc]init];
    [self.navigationController pushViewController:orderCtrl animated:NO];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
