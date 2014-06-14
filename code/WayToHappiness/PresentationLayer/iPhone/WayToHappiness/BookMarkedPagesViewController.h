//
//  BookMarkedPagesViewController.h
//  WayToHappiness
//
//  Created by Ahmed Salah on 4/19/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WayToHappinessManager.h"
#import "HappinessRoadManager.h"
#import "HappinessDialoguesManager.h"
@interface BookMarkedPagesViewController : UIViewController

@property (strong, nonatomic) AbstractCategoryModel * model;
@property (nonatomic,strong) HappinessModel *happinessCategoryModel;

@property (retain, nonatomic)NSMutableArray *bookMarkedPages;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImg;
@property (weak, nonatomic) IBOutlet UILabel *categoryLbl;
@end
