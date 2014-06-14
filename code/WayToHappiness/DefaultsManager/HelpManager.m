//
//  DefaultManager.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/12/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "HelpManager.h"

@implementation HelpManager

- (BOOL) IS_iPhone{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return YES;
    }
    return NO;
}

- (BOOL) IS_iPad{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return NO;
}

- (BOOL) IS_iPhone5{
    if ([self IS_iPhone]&&[[UIScreen mainScreen] bounds].size.height == 568) {
        return YES;
    }
    return NO;
}

- (BOOL) IS_iPhone4{
    if ([self IS_iPhone]&&[[UIScreen mainScreen] bounds].size.height == 480) {
        return YES;
    }
    return NO;
}

- (BOOL) IS_Portrait{
    return [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationPortrait;
}
- (BOOL) IS_Landscape{
    return [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft|| [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight;
}

- (UIStoryboard *) storyboard{
    if (!_storyboard) {
        if ([self IS_iPhone]) {
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:Nil];
        }
        else{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:Nil];
        }
    }
    return _storyboard;
}

- (NSString *) wayToHappinessHeaderImageName{
    return @"Book_Title3.png";
}
- (NSString *) happinessDialougesHeaderImageName{
    return @"Book_Title2.png";
}
- (NSString *) storyHeaderImageName{
    return @"Book_Title1.png";
}
- (NSString *) backgroundImageView{
    return @"Book_Back.png";
}
- (NSString *) cellBackgrounImage{
    return @"Book_ClassTitleBack.png";
}
- (NSString *) cellAccessoryViewImage{
    return @"CLass_More.png";
}
- (NSString *) wayToHappinessHeaderSideMenu{
        return @"MnuSide_H1.png";
}
- (NSString *) happinessDialougeHeaderSideMenu{
        return @"MnuSide_H3.png";
}
- (NSString *) storyHeaderSideMenu{
        return @"MnuSide_H2.png";
}
- (NSString *) bookHeaderSideMenu{
    return @"MnuSide_H16.png";
}
- (NSString *) VideoHeaderSideMenu{
    return @"MnuSide_H5.png";
}
- (NSString *) shawahedHeaderSideMenu{
        return @"MnuSide_H4.png";
}


SYNTHESIZE_SINGLETON_FOR_CLASS(HelpManager);
@end
