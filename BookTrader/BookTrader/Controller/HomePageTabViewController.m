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
#import "BookModel.h"

@interface RefreshControl : UIRefreshControl
    
    @end

@implementation RefreshControl
    
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

@interface HomePageTabViewController ()

@property (nonatomic, strong) HomePageTabView* homePageView;
@property (nonatomic, strong) UITableView *tableView;
@property(atomic, strong) NSMutableArray* bookList;
@property(atomic, strong) NSMutableArray* booktitles;
@property(atomic, strong) NSMutableArray* bookprices;
@property(nonatomic, strong) UISearchController *searchController;
@property(nonatomic, strong) NSString *filterString;
@property (atomic,strong) NSArray *allResults;
@property (atomic, strong) NSArray *visibleResults;

@property(nonatomic, strong) NSArray* goods;
@property(nonatomic, strong) NSArray* booksonSell;

@property(nonatomic, strong) NSMutableArray* myBrowsingHistory;

@end

@implementation HomePageTabViewController

/*
 @author Jian
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"HOME";

    //TABLE VIEW
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 88)];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    
    //SEARCH TITLE BAR
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
    self.searchController.searchBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);

    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    
    //refresh
    RefreshControl *refresh = [[RefreshControl alloc]init];
    [refresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refresh;
    [self.tableView.refreshControl beginRefreshing];
    

}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 40;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}
    
- (void)refresh{
    if (self.tableView.refreshControl.isRefreshing){
        self.tableView.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"loading..."];
        [self loadBooksfromAWS];
        self.tableView.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"refresh..."];
        [self.tableView reloadData];
        [self.tableView.refreshControl endRefreshing];
        
    }
}
- (void) loadBooksfromAWS
{
    //get all books from web server
    BookModel* book = [[BookModel alloc] init];
    [book displayAllBooks:^(id response) {
        if([response isKindOfClass:[NSString class]]&&[response containsString:@"FAILURE"]){
            //failure
            NSLog(@"FAIL:%@",response);
            
            
        }else{

            //NSLog(@"SUCC:%@",response);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.goods = [[NSArray alloc] initWithArray:response copyItems:YES];
                NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
                NSString *fileName = [path stringByAppendingPathComponent:@"goods.plist"];
                [self.goods writeToFile:fileName atomically:YES];
                
                
            });
            
            
        }
    }];
    
    
    //plist
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"goods.plist"];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:fileName];
    
    NSMutableArray *goodsArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in dictArray) {
        NSDictionary *good = [[NSDictionary alloc] initWithObjectsAndKeys:dict[@"title"],@"title", dict[@"price"], @"price",dict[@"bookID"], @"bookID",dict[@"ISBN"], @"ISBN",dict[@"description"], @"description",dict[@"image"],@"image",nil];
        [goodsArray addObject:good];
    }
    self.booksonSell = [goodsArray copy];
    self.allResults = self.booksonSell;
    self.visibleResults = self.allResults;
    
}
    
//
//-(void)viewDidDisappear:(BOOL)animated
//{
//    [self loadBooksfromAWS];
//    [self.tableView reloadData];
//}

#pragma mark -- setFilterString
- (void) setFilterString:(NSString*) filterString
{
    NSLog(@"%@", filterString);
    if(!filterString || filterString.length <= 0)//make sure all bookd are displayed after search cancel
    {
        self.visibleResults = self.allResults;
    }
    else
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@",@"title",filterString];
        self.visibleResults = [NSArray arrayWithArray:[self.allResults filteredArrayUsingPredicate:predicate]];

    }
    [self.tableView reloadData];
}


- (void)willDissmissSearchController:(UISearchController*) searchController
{
    self.visibleResults = self.allResults;
    [self.tableView reloadData];
}



#pragma mark ---- UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if (!searchController.active) {
        return;
    }
    self.filterString = searchController.searchBar.text;
}







static NSString* cellID = @"cellID";
#pragma mark  table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
    

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.visibleResults count];
}

    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    NSInteger indexofRow = indexPath.row;
    int len = [self.visibleResults[indexofRow][@"title"] length];
    if(len > 24)
    {
         NSString *subStr = [self.visibleResults[indexofRow][@"title"] substringWithRange:NSMakeRange(0,24)];
        subStr = [subStr stringByAppendingString:@"..."];
        cell.textLabel.text = subStr;

    }
    else
    {
        cell.textLabel.text = self.visibleResults[indexofRow][@"title"];

    }

    
    cell.detailTextLabel.text = [self.visibleResults objectAtIndex:indexofRow][@"price"];
    cell.detailTextLabel.text = [cell.detailTextLabel.text stringByAppendingString:@"$"];
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self.visibleResults[indexofRow][@"image"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        cell.imageView.image = [UIImage imageWithData:data];
    return cell;
    
}

    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}
    
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    productViewController *productCtrl = [[productViewController alloc]init];
    productCtrl.bookID = self.visibleResults[indexPath.row][@"bookID"];
    productCtrl.booktitle = self.visibleResults[indexPath.row][@"title"];
    productCtrl.ISBN = self.visibleResults[indexPath.row][@"ISBN"];
    productCtrl.price = self.visibleResults[indexPath.row][@"price"];
    productCtrl.bookdescription = self.visibleResults[indexPath.row][@"description"];
    productCtrl.imagestring = self.visibleResults[indexPath.row][@"image"];
    
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"browsingHistory.plist"];
    NSMutableArray *dictArray = [NSMutableArray arrayWithContentsOfFile:fileName];
    self.myBrowsingHistory  = [[NSMutableArray alloc] initWithArray:dictArray];
   
    [self.myBrowsingHistory addObject:self.visibleResults[indexPath.row]];
    [self.myBrowsingHistory writeToFile:fileName atomically:YES];
    [self.navigationController pushViewController:productCtrl animated:NO];
    
}

@end
