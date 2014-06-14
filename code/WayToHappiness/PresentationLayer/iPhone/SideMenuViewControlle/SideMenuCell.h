//
//  SideMenuCell.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 4/11/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>
#define Side_Menu_cell_ID @"SideMenuCell"

@interface SideMenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *selectedView;

@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
- (void) select;
- (void) deselect;

@end
