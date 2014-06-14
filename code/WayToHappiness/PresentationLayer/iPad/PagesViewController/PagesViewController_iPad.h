//
//  PagesViewController_iPad.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/29/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPaginatorView.h"

@interface PagesViewController_iPad : UIViewController<SYPaginatorViewDelegate,SYPaginatorViewDataSource>
@property (nonatomic,strong) id model;

- (void) setCurrentPageIndex:(NSInteger)index;
@end
