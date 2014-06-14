//
//  ShwahedCell.m
//  WayToHappiness
//
//  Created by Ahmed Salah on 4/27/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "ShwahedCell.h"

@implementation ShwahedCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)buttonHandler:(id)sender {
    [self.delegate didTapButtonAtCell:self];
}

- (void) awakeFromNib{
    [super awakeFromNib];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = [UIColor orangeColor].CGColor;
    bottomBorder.borderWidth = 1;
   bottomBorder.frame = CGRectMake(0, self.contentView.frame.size.height - 2, CGRectGetWidth(self.contentView.frame), 2);
    [self.contentView.layer addSublayer:bottomBorder];
}

@end
