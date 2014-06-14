//
//  DefaultManager.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/12/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

@interface HelpManager : NSObject
@property (nonatomic,strong) UIStoryboard *storyboard;
+ (HelpManager *) sharedHelpManager;
- (BOOL) IS_iPhone;
- (BOOL) IS_iPad;
- (BOOL) IS_iPhone5;
- (BOOL) IS_iPhone4;
- (BOOL) IS_Portrait;
- (BOOL) IS_Landscape;
- (NSString *) wayToHappinessHeaderImageName;
- (NSString *) happinessDialougesHeaderImageName;
- (NSString *) storyHeaderImageName;
- (NSString *) backgroundImageView;
- (NSString *) cellBackgrounImage;
- (NSString *) cellAccessoryViewImage;
- (NSString *) wayToHappinessHeaderSideMenu;
- (NSString *) happinessDialougeHeaderSideMenu;
- (NSString *) storyHeaderSideMenu;
- (NSString *) bookHeaderSideMenu;
- (NSString *) VideoHeaderSideMenu;
- (NSString *) shawahedHeaderSideMenu;

@end
