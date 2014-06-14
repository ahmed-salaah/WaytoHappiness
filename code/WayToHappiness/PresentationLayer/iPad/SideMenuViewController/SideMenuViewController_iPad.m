//
//  SideMenuViewController_iPad.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/29/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "SideMenuViewController_iPad.h"
#import "IIViewDeckController.h"
#import "WayToHappinessMainViewController_iPad.h"
#import "HappinessViewController_iPad.h"
#import "HappinessDialoguesManager.h"
#import "BookMainViewController_iPad.h"
#import "VideoLibraryViewController.h"
#import "HappinessRoadManager.h"
#import "videoViewController.h"
#import "ShawahedMainViewController.h"
#import "SideMenuCell.h"
#define HeightForFirstRowInPortrait 174
@interface SideMenuViewController_iPad (){
    NSInteger selectedIndex;
}

@end

@implementation SideMenuViewController_iPad

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    selectedIndex = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor orangeColor];
    self.tableView.backgroundColor = [UIColor greenColor];
    self.tableView.allowsMultipleSelection = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"SideMenuCell" bundle:Nil] forCellReuseIdentifier:Side_Menu_cell_ID];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MnuSide_Back.png"]];
    self.tableView.bounces = NO;
    [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]] setSelected:YES];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SideMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:Side_Menu_cell_ID];
    if (!cell) {
        
        cell = (SideMenuCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Side_Menu_cell_ID];
    }
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel setFont:[UIFont fontWithName:@"Droid Arabic Kufi" size:18]];
    cell.textLabel.text = [self titleAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[self backgrounImageNameForIndex:indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == selectedIndex) {
        [cell select];
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [((SideMenuCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:selectedIndex inSection:0]]) deselect];
    selectedIndex = indexPath.row;
    [((SideMenuCell *)[tableView cellForRowAtIndexPath:indexPath]) select];
    __block SideMenuViewController_iPad *blocksafeSelf = self;
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        blocksafeSelf.viewDeckController.centerController = [blocksafeSelf controllerAtIndex:indexPath.row];
    }];
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [((SideMenuCell *)[tableView cellForRowAtIndexPath:indexPath]) setSelected:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return [self CellHeight:indexPath];
}

-(void)goToVideo{
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        
        //__strong __typeof(&*weakSelf)strongSelf = weakSelf;
        self.viewDeckController.centerController = [self controllerAtIndex:4];
    }];
}

-(void)goToBooks{
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        
        //__strong __typeof(&*weakSelf)strongSelf = weakSelf;
        self.viewDeckController.centerController = [self controllerAtIndex:5];
    }];
    
}

-(CGFloat)CellHeight:(NSIndexPath *)indexPath{

    if ([[HelpManager sharedHelpManager] IS_Portrait]) {
        return IPAD_HEIGHT/6;
    }
    else{
        return 128;
    }
}

- (NSString *)backgrounImageNameForIndex:(NSInteger)index{
    NSString *imageName;
    switch (index) {
        case WayToHappinessViewControllerType:
            imageName = [[HelpManager sharedHelpManager] wayToHappinessHeaderSideMenu];
            break;
        case HappinessRoadStoryControllerType:
            imageName = [[HelpManager sharedHelpManager] storyHeaderSideMenu];
            break;
        case HappinessDialougesControllerType:
            imageName = [[HelpManager sharedHelpManager] happinessDialougeHeaderSideMenu];
            break;
        case ShwahedControllerType:
            imageName = [[HelpManager sharedHelpManager] shawahedHeaderSideMenu];
            break;
        case VideoLibraryControllerType:
            imageName = [[HelpManager sharedHelpManager] VideoHeaderSideMenu];
            break;
        case BookLibraryControllerType:
            imageName = [[HelpManager sharedHelpManager] bookHeaderSideMenu];
            break;
    }
    return imageName;
}


- (UIViewController *)controllerAtIndex:(NSInteger) index{
    UIViewController *viewController;
    switch (index) {
        case WayToHappinessViewControllerType:
            return  [self WaytoHappindessViewController];
            break;
        case HappinessRoadStoryControllerType:
            return  [self HappindessRoadViewController];
            break;
        case HappinessDialougesControllerType:
            return  [self HappindessDialougesViewController];
            break;
        case ShwahedControllerType:
            return  [self shawahedViewController];
            break;
        case BookLibraryControllerType:
            return  [self bookLibraryViewController];
            break;
        case VideoLibraryControllerType:
            return  [self videoLibraryViewController];
            break;
            
        default:
            break;
    }
    return viewController;
}

- (UIViewController *) WaytoHappindessViewController{
    WayToHappinessMainViewController_iPad * wayToHappinessViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"WayToHappinessMainViewController_iPad"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:wayToHappinessViewController];
    UIImage * image = [UIImage imageNamed:@"Mnu_Back.png"];
    [navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    return navigationController;
}

- (UIViewController *) HappindessDialougesViewController{
    HappinessViewController_iPad * dialougesViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"HappinessViewController_iPad"];
    UINavigationController *navigaitonController = [[UINavigationController alloc] initWithRootViewController:dialougesViewController];
    dialougesViewController.happinessModel = [[HappinessDialoguesManager sharedHappinessDialoguesManager] happinessDialoguesModel];
    dialougesViewController.isHappinesRoad = NO;
    
    UIImage * image = [UIImage imageNamed:@"Mnu_Back.png"];
    [navigaitonController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    return navigaitonController;
}

- (UIViewController *) HappindessRoadViewController{
    HappinessViewController_iPad * dialougesViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"HappinessViewController_iPad"];
    UINavigationController *navigaitonController = [[UINavigationController alloc] initWithRootViewController:dialougesViewController];
    dialougesViewController.happinessModel = [[HappinessRoadManager sharedHappinessRoadManager] happinessRoadModel];
    dialougesViewController.isHappinesRoad = YES;
    UIImage * image = [UIImage imageNamed:@"Mnu_Back.png"];
    [navigaitonController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    return navigaitonController;
}

- (UIViewController *)bookLibraryViewController{
    BookMainViewController_iPad *bookMainViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"BookMainViewController_iPad"];
    UINavigationController *navigaitonController = [[UINavigationController alloc] initWithRootViewController:bookMainViewController];
    UIImage * image = [UIImage imageNamed:@"Mnu_Back.png"];
    [navigaitonController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    return navigaitonController;

}

- (UIViewController *) videoLibraryViewController{
    videoViewController *videoMainViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"videoViewController"];
    UINavigationController *navigaitonController = [[UINavigationController alloc] initWithRootViewController:videoMainViewController];
    UIImage * image = [UIImage imageNamed:@"Mnu_Back.png"];
    [navigaitonController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    return navigaitonController;
}

- (UIViewController *)shawahedViewController{
    ShawahedMainViewController *shawahedMainViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"ShawahedMainViewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:shawahedMainViewController];
    UIImage * image = [UIImage imageNamed:@"Mnu_Back.png"];
    [navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    return navigationController;
}

- (NSString *)titleAtIndex:(NSInteger)index{
    NSString *title;
    switch (index) {
        case WayToHappinessViewControllerType:
            title = @"الطريق إلى السعادة";
            break;
        case HappinessRoadStoryControllerType:
            title = @"رواية طريق السعادة";
            break;
        case HappinessDialougesControllerType:
            title = @"حوارات السعادة";
            break;
        case ShwahedControllerType:
            title = @"الشواهد";
            break;
        case VideoLibraryControllerType:
            title = @"مكتبه الفيديو";
            break;
        case BookLibraryControllerType:
            title = @"مكتبه الكتب";
            break;
        default:
            title = @"";
            break;
    }
    return title;
}


@end
