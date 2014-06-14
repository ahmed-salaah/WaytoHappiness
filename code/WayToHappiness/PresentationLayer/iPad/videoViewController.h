//
//  videoViewController.h
//  WayToHappiness
//
//  Created by Ahmed Salah on 6/1/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface videoViewController : UIViewController
@property (strong, nonatomic) NSMutableArray *data;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *subCategories;
@end
