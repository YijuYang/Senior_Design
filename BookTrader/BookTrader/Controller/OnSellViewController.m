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

@interface OnSellViewController ()
@property (nonatomic, strong) OnSellView* onsellView;
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray* bookList;
@property(nonatomic, strong) NSArray* goods;
@end

@implementation OnSellViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Do any additional setup after loading the view.
    
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

            NSLog(@"SUCC:%@",response);
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
    
    self.goods = dictArray;
//    NSMutableArray *goodsArray = [[NSMutableArray alloc]init];
//    for (NSDictionary *dict in dictArray) {
//        NSDictionary *good = [[NSDictionary alloc] initWithObjectsAndKeys:dict[@"title"],@"title", dict[@"price"], @"price",dict[@"bookID"], @"bookID",dict[@"ISBN"], @"ISBN",dict[@"description"], @"description",nil];
//        [goodsArray addObject:good];
//    }
//    self.booksonSell = [goodsArray copy];
//
//
//    self.allResults = self.booksonSell;
//    self.visibleResults = self.allResults;
    
    self.onsellView = [[OnSellView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //    self.homePageView.delegate = self;
    [self.view addSubview:self.onsellView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    //    self.bookList = @[@"Hamlet", @"Algorithm Design", @"Physics", @"Organic Chemisty",@"Machine Learning",@"Computer Vision",@"Operating System",@"Compiler"];
    _tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.onsellView addSubview:self.tableView];
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
