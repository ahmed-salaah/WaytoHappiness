//
//  HappinessViewController_iPad.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/29/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HappinessModel.h"

@interface HappinessViewController_iPad : UIViewController
@property (nonatomic,strong) HappinessModel * happinessModel;
@property (assign, nonatomic) BOOL isHappinesRoad;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tileImageView;
@end
