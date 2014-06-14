//
//  MainViewController.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/13/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "WayToHappinessSubCategoriesViewController.h"
#import "UIColor+HexColors.h"


@interface WayToHappinessSubCategoriesViewController(){
    WYPopoverController *popOver;
    BOOL popOverisOpen;
    UIButton *bookmarkButton;
}

@end

@implementation WayToHappinessSubCategoriesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    [self setupNavigationbarHeight];
    if (IOS_7_LESS) {
        [self.tableView setBackgroundView:nil];
    }

    self.model = [[WayToHappinessManager sharedWayToHappinessManager] wayToHappinessCategory];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.backgroundImageView.image = [UIImage imageNamed:[[HelpManager sharedHelpManager] backgroundImageView]];
    [self setupHeaderView];
    [self setupNavigationBarButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return self.model.subCategories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    HappinessCell *cell = (HappinessCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[HappinessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    WayToHappinessSubCategoryModel * subCategoryModel = [self.model.subCategories objectAtIndex:indexPath.section];
    cell.titleLable.text = subCategoryModel.title;
    cell.categoryImageView.image = [UIImage imageNamed:subCategoryModel.imageName];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WayToHappinessPagesTableViewController *pagesTableView = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"WayToHappinessPagesTableViewController"];
    pagesTableView.subCategory = [self.model.subCategories objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:pagesTableView animated:YES];
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}


#pragma SetupHeader
- (void) setupHeaderView{
    self.headerViewBackground.image = [UIImage imageNamed:[[HelpManager sharedHelpManager] wayToHappinessHeaderImageName]];
    self.titleLabel.text = self.model.title;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation  duration:(NSTimeInterval)duration {
    if (popOverisOpen) {
        [popOver dismissPopoverAnimated:YES];
        if ([popOver.contentViewController isKindOfClass:[AboutViewController class]]) {
            [self infoPressed:self.navigationItem.rightBarButtonItems[0]];
        }else
            [self bookmarkPressed:self.navigationItem.rightBarButtonItems[1] ];

    }
    //[self setupNavigationbarHeight];
}

- (void) setupNavigationbarHeight{
    CGRect frame = self.navigationController.navigationBar.frame;
    frame.size.height = 44;
    self.navigationController.navigationBar.frame = frame;
}

- (void) setupNavigationBarButtons{
    
    UIView *btnVu = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(menuPressed) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"Mnu_Icon_Mnu.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(10, 0, 44, 44)];
    [btnVu addSubview:button];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:btnVu]];
    
    UIView *bookmarkBtnVu = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    bookmarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bookmarkButton addTarget:self
                       action:@selector(bookmarkPressed:)
             forControlEvents:UIControlEventTouchUpInside];
    [bookmarkButton setImage:[UIImage imageNamed:@"Mnu_Icon_BookMark.png"]forState:UIControlStateNormal];
    [bookmarkButton setFrame:CGRectMake(0, 0, 44, 44)];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoButton addTarget:self
                   action:@selector(infoPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    [infoButton setImage:[UIImage imageNamed:@"Mnu_Icon_About.png"]forState:UIControlStateNormal];
    [infoButton setFrame:CGRectMake(50, 0, 44, 44)];
    [bookmarkBtnVu addSubview:bookmarkButton];
    [bookmarkBtnVu addSubview:infoButton];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:bookmarkBtnVu]];
}

- (void) menuPressed{
    [self.viewDeckController openLeftView];
}

- (void) bookmarkPressed:(UIButton *) sender{
      BookMarkedPagesViewController *pagesTableView = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"BookMarkedPagesViewController"];
    pagesTableView.bookMarkedPages = [[WayToHappinessManager sharedWayToHappinessManager]getBookMarkedPages];
    pagesTableView.model = self.model;
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:pagesTableView];
    UITapGestureRecognizer * gestureRecognizer = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:gestureRecognizer];
    popOver = [[WYPopoverController alloc] initWithContentViewController:navigationController];
    WYPopoverBackgroundView *appeareance = [WYPopoverBackgroundView appearance];
    popOver.delegate = self;
    appeareance.borderWidth = 5;
    appeareance.fillTopColor = [UIColor colorWithHexString:Bookmark_Color];
    appeareance.fillBottomColor = [UIColor colorWithHexString:Bookmark_Color];
    int height = [[HelpManager sharedHelpManager] IS_iPhone4] ? 430 : 550;
    if ([[HelpManager sharedHelpManager] IS_Landscape]) {
        popOver.popoverContentSize = CGSizeMake(height, 290);
    }else
        popOver.popoverContentSize = CGSizeMake(290, height-10);
    popOver.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 0, 10);
    [popOver presentPopoverFromRect:sender.frame inView:sender.superview permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES];
        popOverisOpen = YES;
}


- (void) infoPressed:(UIButton *) sender{
    AboutViewController *aboutViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"AboutViewController"];
    [self.navigationController pushViewController:aboutViewController animated:YES];
}

- (void) tap:(UIGestureRecognizer *)gesture{
    [popOver dismissPopoverAnimated:YES];
        popOverisOpen = NO;
    [self.view removeGestureRecognizer:gesture];
}





@end
