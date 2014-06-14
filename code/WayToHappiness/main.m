//
//  main.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 2/22/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "HelpManager.h"
#import "AppDelegate_iPhone.h"
#import "AppDelegate_iPad.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        Class appDelegateClass = [[HelpManager sharedHelpManager] IS_iPhone] ? [AppDelegate_iPhone class] : [AppDelegate_iPad class];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass(appDelegateClass));
    }
}
