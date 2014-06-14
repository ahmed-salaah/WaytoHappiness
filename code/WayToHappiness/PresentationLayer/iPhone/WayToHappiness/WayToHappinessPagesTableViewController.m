//
//  PagesTableViewController2.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/18/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "WayToHappinessPagesTableViewController.h"
#import "WayToHappinessPagesCell.h"
#import "happinessCell.h"
#import "PagesViewController.h"
#import "IIViewDeckController.h"
#import "AboutViewController.h"

@interface WayToHappinessPagesTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *categoryHeaderViewBackground;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *catgeoryTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *subCategoryImgeView;
@property (weak, nonatomic) IBOutlet UILabel *subCatgeoyrTitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *pagesTableView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation WayToHappinessPagesTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{

    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.navigationItem.hidesBackButton=YES;
    self.backgroundImageView.image = [UIImage imageNamed:[[HelpManager sharedHelpManager] backgroundImageView]];
    if (IOS_7_LESS) {
        [self.tableView setBackgroundView:nil];
    }
    self.tableView.backgroundColor = [UIColor clearColor];
    [self setupNavigationBarButtons];
    [self setupCategoryHeaderView];
    [self setupSubCategoryHeaderView];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupCategoryHeaderView{
    
    self.categoryHeaderViewBackground.image = [UIImage imageNamed:[[HelpManager sharedHelpManager] wayToHappinessHeaderImageName]];
    self.catgeoryTitleLabel.text = self.subCategory.categoryModel.title;
}

- (void) setupSubCategoryHeaderView{
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.subCategoryImgeView.image = [UIImage imageNamed:self.subCategory.imageName];
    self.subCatgeoyrTitleLabel.text = self.subCategory.title;
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma TABLE_VIEW_DELEGATE

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return self.subCategory.Pages.count;

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
    AbstractPageModel * pageModel = [self.subCategory.Pages objectAtIndex:indexPath.section];
    cell.titleLable.text = pageModel.title;
    cell.categoryImageView.image = [UIImage imageNamed:pageModel.imageName];
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
    
    pagesViewController.Model =  self.subCategory;
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
    
    UIView *bookmarkBtnVu = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];

    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoButton addTarget:self
                   action:@selector(infoPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    [infoButton setImage:[UIImage imageNamed:@"Mnu_Icon_About.png"]forState:UIControlStateNormal];
    [infoButton setFrame:CGRectMake(0, 0, 44, 44)];

    [bookmarkBtnVu addSubview:infoButton];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:bookmarkBtnVu]];
}


- (void) infoPressed:(UIButton *) sender{
    AboutViewController *aboutViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"AboutViewController"];
    [self.navigationController pushViewController:aboutViewController animated:YES];
}

- (void) menuPressed{
    [self.viewDeckController openLeftView];
}


@end
