//
//  HappinessMainViewController.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/18/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "HappinessMainViewController.h"
#import "HappinessCell.h"
#import "HappinessPageModel.h"
#import "PagesViewController.h"
#import "IIViewDeckController.h"
#import "AboutViewController.h"
#import "UIColor+HexColors.h"
@interface HappinessMainViewController (){
    WYPopoverController *popOver;
    BOOL popOverisOpen;
    UIButton *bookmarkButton;
}
@property (weak, nonatomic) IBOutlet UIImageView *categoryBackgrounImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryTitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HappinessMainViewController

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
    [self setupHeaderView];
    [self setupNavigationBarButtons];
    self.tableView.backgroundColor =[UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma TABLE_VIEW_DELEGATE

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return self.categoryModel.pages.count;
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
    HappinessPageModel * pageModel = [self.categoryModel.pages objectAtIndex:indexPath.section];
    cell.titleLable.text = pageModel.title;
    UIImage * image = [UIImage imageNamed:pageModel.imageName];
    cell.categoryImageView.image = image;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PagesViewController *pagesViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"PagesViewController"];
    
    pagesViewController.Model =  self.categoryModel;
    [pagesViewController setCurrentPageIndex:indexPath.section];
    [self.navigationController pushViewController:pagesViewController animated:YES];
    [pagesViewController setCurrentPageIndex:indexPath.section];
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation  duration:(NSTimeInterval)duration {
//    [self setupNavigationbarHeight];
    if (popOverisOpen) {
        [popOver dismissPopoverAnimated:YES];
    }
}

- (void) setupHeaderView{
    self.categoryBackgrounImageView.image = [UIImage imageNamed:[self.categoryModel.title isEqualToString:HappinessDialougesName] ? [[HelpManager sharedHelpManager] happinessDialougesHeaderImageName]:[[HelpManager sharedHelpManager] storyHeaderImageName]];
    self.categoryTitleLabel.text = self.categoryModel.title;
    self.categoryTitleLabel.adjustsFontSizeToFitWidth = YES;
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
                   action:@selector(infoPressed)
         forControlEvents:UIControlEventTouchUpInside];
    [infoButton setImage:[UIImage imageNamed:@"Mnu_Icon_About.png"]forState:UIControlStateNormal];
    [infoButton setFrame:CGRectMake(50, 0, 44, 44)];
    [bookmarkBtnVu addSubview:bookmarkButton];
    [bookmarkBtnVu addSubview:infoButton];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:bookmarkBtnVu]];
}


- (void) setupNavigationbarHeight{
    CGRect frame = self.navigationController.navigationBar.frame;
    frame.size.height = 44;
    self.navigationController.navigationBar.frame = frame;
}

- (void) menuPressed{
    [self.viewDeckController openLeftView];
}

- (void) infoPressed{
    AboutViewController *aboutViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"AboutViewController"];
    [self.navigationController pushViewController:aboutViewController animated:YES];
}

- (void) bookmarkPressed:(UIButton *) sender{
    BookMarkedPagesViewController *pagesTableView = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"BookMarkedPagesViewController"];
    pagesTableView.bookMarkedPages = [[WayToHappinessManager sharedWayToHappinessManager]getBookMarkedPages];
     UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:pagesTableView];
    if ( [self.categoryModel.ID isEqualToString: HappinessDialoguesID]) {
        pagesTableView.bookMarkedPages = [[HappinessDialoguesManager sharedHappinessDialoguesManager]getBookMarkedPages];
    }else{
          pagesTableView.bookMarkedPages =[[HappinessRoadManager sharedHappinessRoadManager]getBookMarkedPages];
    }
    pagesTableView.happinessCategoryModel = self.categoryModel;
    UITapGestureRecognizer * gestureRecognizer = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:gestureRecognizer];
    popOver = [[WYPopoverController alloc] initWithContentViewController:navigation];
    WYPopoverBackgroundView *appeareance = [WYPopoverBackgroundView appearance];
    appeareance.borderWidth = 5;
    appeareance.fillTopColor = [UIColor colorWithHexString:appColor];
    appeareance.fillBottomColor = [UIColor colorWithHexString:appColor];
    int height = [[HelpManager sharedHelpManager] IS_iPhone4] ? 430 : 550;
    if ([[HelpManager sharedHelpManager] IS_Landscape]) {
        popOver.popoverContentSize = CGSizeMake(height, 300);
    }else
    popOver.popoverContentSize = CGSizeMake(300, height);
    popOver.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 0, 10);
    [popOver presentPopoverFromRect:sender.frame inView:sender.superview permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES];
    popOverisOpen = YES;
}

- (void) tap:(UIGestureRecognizer *)gesture{
    [popOver dismissPopoverAnimated:YES];
    popOverisOpen = NO;
    [self.view removeGestureRecognizer:gesture];
}

@end
