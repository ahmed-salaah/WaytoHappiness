//
//  BookSubCell.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/28/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "BookSubCell.h"

@implementation BookSubCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:@"BookSubCell" owner:nil options:nil]
                lastObject];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
