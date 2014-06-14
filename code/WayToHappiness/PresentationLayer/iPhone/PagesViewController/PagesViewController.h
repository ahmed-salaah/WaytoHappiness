//
//  PagesViewController.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/12/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPageView.h"
#import "WayToHappinessSubCategoryModel.h"
#import "WayToHappinessPageModel.h"
#import "HappinessDialoguesManager.h"
#import "HappinessRoadManager.h"
#import "SYPaginatorView.h"

@interface PagesViewController : UIViewController <SYPaginatorViewDataSource,SYPaginatorViewDelegate >
@property (nonatomic,strong) id model;
@property (nonatomic,strong) WayToHappinessPageModel *currentPage;

- (void) setCurrentPageIndex:(NSInteger)index;
@end
