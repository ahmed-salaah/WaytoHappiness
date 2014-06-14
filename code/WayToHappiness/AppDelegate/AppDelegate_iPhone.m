//
//  AppDelegate_iPhone.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/16/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "AppDelegate_iPhone.h"
#import "PagesViewController.h"
#import "IIViewDeckController.h"
#import "SideMenuViewController.h"
#import "IIWrapController.h"
#import "ViewController.h"
#import "WayToHappinessManager.h"
#import "WayToHappinessSubCategoriesViewController.h"

@implementation AppDelegate_iPhone

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    self.window.rootViewController = [self deckViewController];
    [self.window makeKeyAndVisible];    
    return YES;
}

- (UIViewController *) deckViewController{
    
    UIViewController *sideMenuViewController = [[SideMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    WayToHappinessSubCategoriesViewController *waytoHappinessViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"WayToHappinessSubCategoriesViewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:waytoHappinessViewController];
    
    UIImage * image = [UIImage imageNamed:@"Mnu_Back.png"];
    [navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    [navigationController.navigationBar.layer setContents: (id)[UIImage imageNamed:@"Mnu_Back.png"].CGImage];
    IIViewDeckController* deckViewController = [[IIViewDeckController alloc] initWithCenterViewController:navigationController  leftViewController:sideMenuViewController];
    deckViewController.automaticallyUpdateTabBarItems = YES;
    deckViewController.navigationControllerBehavior = IIViewDeckNavigationControllerIntegrated;
    deckViewController.maxSize = 20;
    deckViewController.centerhiddenInteractivity =IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
    return deckViewController;
}

@end
