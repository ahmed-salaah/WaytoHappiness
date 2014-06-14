//
//  MainViewControllerCell.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/15/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "HappinessCell.h"
#define IMAGE_WIDTH 110
#define IMAGE_HEIGHT 70
#define LABEL_X_POSITION 115
#define LABEL_Y_POSITION 15
#define LABEL_WIDTH 160
#define LABEL_HEIGHT 40

@implementation HappinessCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 70)];
        [self.backgroundImageView setImage:[UIImage imageNamed:[[HelpManager sharedHelpManager] cellBackgrounImage]]];
        self.backgroundImageView.alpha = .5;
        self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.categoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IMAGE_WIDTH, IMAGE_HEIGHT)];
        if ([[HelpManager sharedHelpManager] IS_iPhone]) {
            self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_X_POSITION, LABEL_Y_POSITION, LABEL_WIDTH, LABEL_HEIGHT)];
        }
        else{
            self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_X_POSITION, LABEL_Y_POSITION, 500 , LABEL_HEIGHT)];
        }

        self.titleLable.textAlignment = NSTextAlignmentCenter;
        [self.titleLable setNumberOfLines:2];
        [self.titleLable setBackgroundColor:[UIColor clearColor]];
        self.titleLable.textColor = [UIColor whiteColor];
        [self.titleLable setFont:CUSTOM_FONT_(13)];
        [self.titleLable setAdjustsFontSizeToFitWidth:YES];
        UIImageView *accessoryImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[HelpManager sharedHelpManager] cellAccessoryViewImage]]];
        accessoryImageView.frame = CGRectMake(self.bounds.size.width - 20, 30, 15, 15);
        accessoryImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.categoryImageView];
        [self addSubview:self.titleLable];
//        [self  addSubview:accessoryImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
