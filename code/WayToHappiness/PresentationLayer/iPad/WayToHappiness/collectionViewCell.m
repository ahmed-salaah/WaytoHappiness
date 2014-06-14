//
//  collectionViewCell.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/29/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "collectionViewCell.h"
#import "QuartzCore/CALayer.h"
#import "UIView+Shadow.h"
#import "UIColor+HexColors.h"

@implementation collectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}

- (void) awakeFromNib{
    [self.iconImageView makeInsetShadowWithRadius:50 Color:[UIColor colorWithHexString:appColor] Directions:@[Bottom_Direction]];
    self.backgroundColor = [UIColor colorWithHexString:appColor];
}
@end
