//
//  AppDelegate_iPad.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/16/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "AppDelegate_iPad.h"
#import "SideMenuViewController_iPad.h"
#import "WayToHappinessMainViewController_iPad.h"
#import "IIViewDeckController.h"
@implementation AppDelegate_iPad
- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    [[UILabel appearance] setFont:[UIFont fontWithName:@"Droid Arabic Kufi" size:18]];

    self.window.rootViewController = [self deckViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (UIViewController *) deckViewController{
    
    UIViewController *sideMenuViewController = [[SideMenuViewController_iPad alloc] init];
    WayToHappinessMainViewController_iPad * wayToHappinessViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"WayToHappinessMainViewController_iPad"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:wayToHappinessViewController];
    UIImage * image = [UIImage imageNamed:@"Mnu_Back.png"];
    [navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    IIViewDeckController* deckViewController = [[IIViewDeckController alloc] initWithCenterViewController:navigationController  leftViewController:sideMenuViewController];
    
    deckViewController.automaticallyUpdateTabBarItems = YES;
    deckViewController.navigationControllerBehavior = IIViewDeckNavigationControllerIntegrated;
    deckViewController.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToCloseBouncing;
    deckViewController.maxSize = 200;
    return deckViewController;
}
@end
