//
//  VideoCell.m
//  WayToHappiness
//
//  Created by Ahmed Salah on 6/1/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
