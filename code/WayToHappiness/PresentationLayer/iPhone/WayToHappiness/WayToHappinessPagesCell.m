//
//  WayToHappinessPagesCell.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/18/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "WayToHappinessPagesCell.h"
#define IMAGE_WIDTH 84
#define IMAGE_HEIGHT 60
#define IMAGE_X_POSITION 20
#define IMAGE_Y_POSITION 0

#define LABEL_WIDTH 160
#define LABEL_HEIGHT 40
#define LABEL_X_POSITION 110
#define LABEL_Y_POSITION 10

#define VERTICAL_LINE_WIDTH 3
#define VERTICAL_LINE_HEIGHT 60
#define VERTICAL_LINE_X_POSITION 5
#define VERTICAL_LINE_Y_POSITION 0

#define CIRCLE_WIDTH 9
#define CIRCLE_HEIGHT 8
#define CIRCLE_X_POSITION 2
#define CIRCLE_Y_POSITION 25

@implementation WayToHappinessPagesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 70)];
        backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        backgroundImageView.alpha = .5;
        [backgroundImageView setImage:[UIImage imageNamed:[[HelpManager sharedHelpManager] cellBackgrounImage]]];
        self.categoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(IMAGE_X_POSITION, IMAGE_Y_POSITION, IMAGE_WIDTH, IMAGE_HEIGHT)];
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_X_POSITION, LABEL_Y_POSITION, LABEL_WIDTH, LABEL_HEIGHT)];
        [self.titleLable setNumberOfLines:2];
        [self.titleLable setFont:[UIFont systemFontOfSize:15]];
        UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(VERTICAL_LINE_X_POSITION, VERTICAL_LINE_Y_POSITION, VERTICAL_LINE_WIDTH, VERTICAL_LINE_HEIGHT)];
        verticalLine.backgroundColor = [UIColor orangeColor];
        UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(CIRCLE_X_POSITION,CIRCLE_Y_POSITION,CIRCLE_WIDTH, CIRCLE_HEIGHT)];
        circle.backgroundColor = [UIColor blackColor];
        circle.layer.masksToBounds = YES;
        circle.layer.cornerRadius = 4;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:backgroundImageView];
        [self addSubview:verticalLine];
        [self addSubview:circle];
        [self addSubview:self.categoryImageView];
        [self addSubview:self.titleLable];
        
        UIImageView *accessoryImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[HelpManager sharedHelpManager] cellAccessoryViewImage]]];
        self.accessoryView = accessoryImageView;
        CGRect accessoryViewFrame = self.accessoryView.frame;
        accessoryViewFrame.origin.x =accessoryViewFrame.origin.x+10;
        self.accessoryView.frame = accessoryViewFrame;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end