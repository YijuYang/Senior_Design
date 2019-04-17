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
@interface HomePageTabViewController ()

@property (nonatomic, strong) HomePageTabView* homePageView;
@property (nonatomic, strong) UITableView *tableView;
@property(atomic, strong) NSMutableArray* bookList;
@property(atomic, strong) NSMutableArray* booktitles;
@property(atomic, strong) NSMutableArray* bookprices;
@property(nonatomic, strong) UISearchController *searchController;
@property(nonatomic, strong) NSString *filterString;
@property (atomic,strong) NSArray *allResults;
//searching results
@property (atomic, strong) NSArray *visibleResults;

@property(nonatomic, strong) NSArray* goods;
@property(nonatomic, strong) NSArray* booksonSell;
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
    

    //TABLE VIEW
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 88)];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView
    [self.homePageView addSubview:self.tableView];
    
    
    //get all books from web server
    BookModel* book = [[BookModel alloc] init];
    [book displayAllBooks:^(id response) {
        if([response isKindOfClass:[NSString class]]&&[response containsString:@"FAILURE"]){
            //failure
            NSLog(@"FAIL:%@",response);


        }else{

            NSLog(@"SUCC:%@",response);
            dispatch_async(dispatch_get_main_queue(), ^{

                self.goods = [[NSArray alloc] initWithArray:response copyItems:YES];
                NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
                NSString *fileName = [path stringByAppendingPathComponent:@"goods.plist"];
                [self.goods writeToFile:fileName atomically:YES];
                

            });


        }
    }];
    
    //SEARCH TITLE BAR
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    //    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.delegate = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    
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
    
    cell.textLabel.text = self.visibleResults[indexofRow][@"title"];

    cell.detailTextLabel.text = [self.visibleResults objectAtIndex:indexofRow][@"price"];
    cell.detailTextLabel.text = [cell.detailTextLabel.text stringByAppendingString:@"$"];
    
    cell.imageView.image = [UIImage imageNamed:@"bookSample2.png"];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    productViewController *productCtrl = [[productViewController alloc]init];
    productCtrl.allBooks = self.allResults;
    productCtrl.bookID = self.visibleResults[indexPath.row][@"bookID"];
    productCtrl.booktitle = self.visibleResults[indexPath.row][@"title"];
    productCtrl.ISBN = self.visibleResults[indexPath.row][@"ISBN"];
    productCtrl.price = self.visibleResults[indexPath.row][@"price"];
    productCtrl.bookdescription = self.visibleResults[indexPath.row][@"description"];

    [self.navigationController pushViewController:productCtrl animated:NO];
    
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


@end
