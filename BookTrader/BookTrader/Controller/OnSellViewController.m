//
//  OnSellViewController.m
//  BookTrader
//
//  Created by FengRose on 4/11/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import "OnSellViewController.h"
#import "OnSellView.h"
#import "OrderViewController.h"
#import "BookModel.h"
#import "UserModel.h"

@interface sellRefreshControl : UIRefreshControl
    
    @end

@implementation sellRefreshControl
    
-(void)beginRefreshing
    {
        [super beginRefreshing];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
-(void)endRefreshing
    {
        [super endRefreshing];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    @end


@interface OnSellViewController ()
@property (nonatomic, strong) OnSellView* onsellView;
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray* bookList;
@property(nonatomic, strong) NSArray* goods;
@end

@implementation OnSellViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
   
    
    self.onsellView = [[OnSellView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.onsellView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 88)];

    self.tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.onsellView addSubview:self.tableView];
    
    //refresh
    sellRefreshControl *refresh = [[sellRefreshControl alloc]init];
    [refresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refresh;
    [self.tableView.refreshControl beginRefreshing];
    
    
}
/*
 @author:Jian
 */
- (void)refresh{
    if (self.tableView.refreshControl.isRefreshing){
        self.tableView.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"loading..."];
        [self loadMySelling];
        self.tableView.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"refresh..."];
        [self.tableView reloadData];
        [self.tableView.refreshControl endRefreshing];
        
    }
}
/*
 @author:Jian
 */
-(void) loadMySelling
{
    UserModel* user = [[UserModel alloc] init];
    NSDictionary* userlocal = [user getCurrentLocalUserInfo];
    NSString *userid = userlocal[@"customerID"];
    //get all books from web server
    BookModel* book = [[BookModel alloc] init];
    [book displayAllBooks:^(id response) {
        if([response isKindOfClass:[NSString class]]&&[response containsString:@"FAILURE"]){
            //failure
            NSLog(@"FAIL:%@",response);
            
            
        }else{
            
            //NSLog(@"SUCC:%@",response);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray* allgoods = [[NSArray alloc] initWithArray:response copyItems:YES];
                NSMutableArray * temp = [[NSMutableArray alloc] init];
                for(int i = 0; i < allgoods.count; ++i)
                {
                    if(allgoods[i][@"customerID"] == userid)
                    {
                        [temp addObject:allgoods[i]];
                    }
                }
                self.goods = [temp copy];
                NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
                NSString *fileName = [path stringByAppendingPathComponent:@"usergoods.plist"];
                [self.goods writeToFile:fileName atomically:YES];
                
                
            });
            
            
        }
    }];
    
    
    
    //plist
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"usergoods.plist"];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:fileName];
    
    self.goods = [dictArray copy];

}

- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        //Jian editted here:
        NSMutableArray * temp = [[NSMutableArray alloc]initWithArray:self.goods];
        //delete DB on server
        NSString *bookID =[[NSString alloc] initWithFormat:@"bookID=%@", temp[indexPath.row][@"bookID"]];
        //ASYN
        dispatch_async(dispatch_get_main_queue(), ^{
            //NSLog(@"%@", bookID);
            [BookModel deleteBook:bookID completion:^(id response) {
                if([response containsString:@"FAILURE"]){
                    NSLog(@"%@",response);
                }else{
                    NSLog(@"%@",response);
                    
                }
            }];
        });
        
        [temp removeObjectAtIndex:indexPath.row];
        self.goods = [temp copy];
        completionHandler (YES);
        [self.tableView reloadData];
        
    }];
    deleteRowAction.image = [UIImage imageNamed:@"Delete"];
    deleteRowAction.backgroundColor = [UIColor redColor];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    
    return config;
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
    return [self.goods count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    NSInteger indexofRow = indexPath.row;
    cell.textLabel.text = self.goods[indexofRow][@"title"];
    cell.detailTextLabel.text = self.goods[indexofRow][@"price"];
    cell.detailTextLabel.text = [cell.detailTextLabel.text stringByAppendingString:@"$"] ;
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self.goods[indexofRow][@"image"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
    cell.imageView.image = [UIImage imageWithData:data];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}

@end
