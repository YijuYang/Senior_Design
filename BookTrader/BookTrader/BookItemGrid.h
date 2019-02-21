//
//  BookItemGrid.h
//  BookStore
//
//  Created by Simon yang on 2/5/19.
//  Copyright © 2019 Simon yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LeftButtonBlock)(void);
typedef void(^RightButtonBlock)(void);

@interface BookItemGrid : UITableViewCell

@property (nonatomic, strong) UIImageView      * leftImageView;
@property (nonatomic, strong) UIImageView      * rightImageView;
@property (nonatomic, strong) UILabel          * leftLable;
@property (nonatomic, strong) UILabel          * rightLable;

@property (nonatomic, copy  ) LeftButtonBlock  leftButtonBlock;
@property (nonatomic, copy  ) RightButtonBlock rightButtonBlock;

- (id)initDiyWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier;

- (void) config;

@end
