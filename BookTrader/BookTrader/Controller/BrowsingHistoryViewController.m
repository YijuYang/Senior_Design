//
//  OrderHistory.m
//  BookTrader
//
//  Created by FengRose on 4/16/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import "BrowsingHistoryViewController.h"
#import "OrderHistoryView.h"
#import "OrderViewController.h"
#import "productViewController.h"

@interface BrowsingHistoryViewController ()
@property (nonatomic, strong) OrderHistoryView* orderhistoryView;
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray* bookList;
@end

@implementation BrowsingHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderhistoryView = [[OrderHistoryView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //    self.homePageView.delegate = self;
    [self.view addSubview:self.orderhistoryView];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 88)];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    self.tableView.dataSource = self;

      [self loadBrowsingHistory];
    [self.orderhistoryView addSubview:self.tableView];
}
    
-(void)loadBrowsingHistory
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"browsingHistory.plist"];
    NSMutableArray *dictArray = [NSMutableArray arrayWithContentsOfFile:fileName];
    self.bookList  = [[NSMutableArray alloc] initWithArray:dictArray];
        
}

    /*
     @author: Jian Shen
     */
- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *fileName = [path stringByAppendingPathComponent:@"browsingHistory.plist"];
        NSMutableArray *dictArray = [NSMutableArray arrayWithContentsOfFile:fileName];
        self.bookList  = [[NSMutableArray alloc] initWithArray:dictArray];
        [self.bookList removeObjectAtIndex:indexPath.row];

        [self.bookList writeToFile:fileName atomically:YES];
        
        completionHandler (YES);
        [self.tableView reloadData];
    }];
    deleteRowAction.image = [UIImage imageNamed:@"Delete"];
    deleteRowAction.backgroundColor = [UIColor redColor];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
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
    cell.textLabel.text = self.bookList[indexPath.row][@"title"];
    cell.detailTextLabel.text = self.bookList[indexPath.row][@"price"];
    cell.detailTextLabel.text = [cell.detailTextLabel.text stringByAppendingString:@"$"];
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self.bookList[indexofRow][@"image"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
    cell.imageView.image = [UIImage imageWithData:data];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
    
/*
 @author: Jian Shen
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        productViewController *productCtrl = [[productViewController alloc]init];
        productCtrl.bookID = self.bookList[indexPath.row][@"bookID"];
        productCtrl.booktitle = self.bookList[indexPath.row][@"title"];
        productCtrl.ISBN = self.bookList[indexPath.row][@"ISBN"];
        productCtrl.price = self.bookList[indexPath.row][@"price"];
        productCtrl.bookdescription = self.bookList[indexPath.row][@"description"];
        productCtrl.imagestring = self.bookList[indexPath.row][@"image"];
        
        [self.navigationController pushViewController:productCtrl animated:NO];
        
    }


@end
