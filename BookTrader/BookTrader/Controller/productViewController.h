//
//  productViewController.h
//  BookTrader
//
//  Created by JianShen on 3/25/19.
//  Copyright © 2019 BookTrader. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface productViewController : UIViewController

@property (nonatomic, assign) NSArray* allBooks;
@property (nonatomic, assign) NSString* bookID;
@property (nonatomic, assign) NSString* bookdescription;
@property (nonatomic, assign) NSString* ISBN;
@property (nonatomic, assign) NSString* booktitle;
@property (nonatomic, assign) NSString* price;
@end
