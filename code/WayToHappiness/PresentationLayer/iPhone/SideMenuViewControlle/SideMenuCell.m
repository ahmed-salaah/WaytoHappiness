//
//  SideMenuCell.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 4/11/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "SideMenuCell.h"

@implementation SideMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) select{
        self.selectedView.alpha = 1;
}
- (void) deselect{
        self.selectedView.alpha = 0;
}

@end
