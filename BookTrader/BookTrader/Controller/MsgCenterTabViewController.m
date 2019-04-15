//
//  MsgCenterTabViewController.m
//  BookTrader
//
//  Created by JianShen on 2/20/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "MsgCenterTabViewController.h"
#import "MsgCenterTabView.h"
#import "MsgCenterCell.h"
#import "LoginPageViewController.h"
#import "MsgCenterController.h"
#import "UserModel.h"

@interface MsgCenterTabViewController ()
@property (nonatomic, strong) MsgCenterTabView* msgCenterView;
@property (nonatomic, strong) LoginPageViewController* loginCtrl;

@end

@implementation MsgCenterTabViewController

/*
 @author

 typedef NS_ENUM(NSInteger, UITableViewCellStyle) {
 UITableViewCellStyleDefault,
 // 左侧显示textLabel（不显示detailTextLabel），imageView可选（显示在最左边）
 UITableViewCellStyleValue1,
 // 左侧显示textLabel、右侧显示detailTextLabel（默认蓝色），imageView可选（显示在最左边）
 UITableViewCellStyleValue2,
 // 左侧依次显示textLabel(默认蓝色)和detailTextLabel，imageView可选（显示在最左边）
 UITableViewCellStyleSubtitle
 // 左上方显示textLabel，左下方显示detailTextLabel（默认灰色）,imageView可选（显示在最左边）
 };
 */



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"MSG CENTER";
    self.msgCenterView = [[MsgCenterTabView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.msgCenterView];
    
    // 创建UItableView，style选择Grouped或Plain，这里我们以Grouped为例
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20) style:UITableViewStylePlain];
    // 声明 tableView 的代理和数据源
    tableView.delegate = self;
    tableView.dataSource = self;
    // 添加到 view 上
    [self.view addSubview:tableView];
 
    NSDictionary* isLogin = [UserModel getCurrentLocalUserInfo];
    //NSLog(@"%@",isLogin);
    if(isLogin==nil){
        self.loginCtrl = [LoginPageViewController new];
        self.loginCtrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:self.loginCtrl animated:NO];
    }else{
        //check again local to server
    }
   
    
}
// tableView 中 Section 的个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 每个 Section 中的 Cell 个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
// 设置每个 Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建一个cellID，用于cell的重用
    NSString *cellID = @"cellID";
    // 从tableview的重用池里通过cellID取一个cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        // 如果tableview的重用池中没有取到，就创建一个新的cell，style为Value2，并用cellID对其进行标记。
        //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellID];
   
        cell = [[MsgCenterCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellID];

    }
//    // 设置 cell 的标题
//    cell.textLabel.text = [NSString stringWithFormat:@"System"];
//    // 设置 cell 的副标题
//    cell.detailTextLabel.text = @"Notification";
    return cell;
}


//// 设置 section 的 header 高度
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 10;
//}
//// 设置 section 的 footer 高度
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 10;
//}
// 设置 cell 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}
// cell 的文字缩进
-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 1;
}

// 选中了 cell 时触发
//build message
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中了第%li个cell", (long)indexPath.row);
    MsgCenterController *msg = [[MsgCenterController alloc]init];
    [self.navigationController pushViewController:msg animated:NO];
    
    
    
}
// 设置 cell 是否允许左滑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}
// 设置默认的左滑按钮的title
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Delete";
}
// 点击左滑出现的按钮时触发
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Trigger delete button");
}
// 左滑结束时调用(只对默认的左滑按钮有效，自定义按钮时这个方法无效)
-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"finish left");
}
// 自定义左滑cell时的按钮和触发方法
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建第一个按钮和触发事件
    UITableViewRowAction *cellActionA = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        // 在此写点击按钮时的触发事件
        // ......
        NSLog(@"Press button one");
    }];
    // 定义按钮的颜色
    cellActionA.backgroundColor = [UIColor redColor];
    
//    // 创建第二个按钮和触发事件
//    UITableViewRowAction *cellActionB = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"按钮-2" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
//        // 在此写点击按钮时的触发事件
//    }];
    // 注意这里返回的是一个按钮组，即使只定义了一个按钮也要返回一个组
   // return @[cellActionA, cellActionB];
    return @[cellActionA];

}

@end
