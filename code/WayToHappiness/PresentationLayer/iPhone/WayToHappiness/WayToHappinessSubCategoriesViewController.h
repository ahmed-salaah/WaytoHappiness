//
//  MainViewController.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/13/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WayToHappinessModel.h"
#import "WayToHappinessSubCategoryModel.h"
#import "WayToHappinessPageModel.h"
#import "WayToHappinessManager.h"
#import "HappinessCell.h"
#import "PagesViewController.h"
#import "WayToHappinessPagesTableViewController.h"
#import "IIViewDeckController.h"
#import "AboutViewController.h"
#import "WYPopoverController.h"
#import "BookMarkedPagesViewController.h"

@interface WayToHappinessSubCategoriesViewController : UIViewController<WYPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) WayToHappinessModel * model;
@property (weak, nonatomic) IBOutlet UIImageView *headerViewBackground;

@end

