//
//  ShwahedCell.h
//  WayToHappiness
//
//  Created by Ahmed Salah on 4/27/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SHWAHED_CELL_ID @"ShwahedCell"
@class ShwahedCell;
@protocol ShwahedCellDelegate
- (void) didTapButtonAtCell:(ShwahedCell *)cell;
@end
@interface ShwahedCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ShwahedImageView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) id<ShwahedCellDelegate> delegate;

@end
