//
//  BooksTableViewController.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/22/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookCell.h"
#import "MBProgressHUD.h"
#import "ReaderViewController.h"
@interface BooksTableViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,BookCellDelegate,MBProgressHUDDelegate,UIAlertViewDelegate, ReaderViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) id model;
@end
