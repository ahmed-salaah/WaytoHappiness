//
//  BookMarkedPagesViewController.m
//  WayToHappiness
//
//  Created by Ahmed Salah on 4/19/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "BookMarkedPagesViewController.h"
#import "HappinessCell.h"
#import "BookMarkPage.h"
@interface BookMarkedPagesViewController ()

@end

@implementation BookMarkedPagesViewController

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
    self.navigationItem.title = @"Bookmarked Pages";
    if (IOS_7_LESS) {
        [self.tableView setBackgroundView:nil];
    }
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:[UIColor clearColor]];
    if (self.model) {
        [self setupHeaderViewForWayToHappinnes];
    }else
        [self setupHeaderView];
    


}
-(void)viewWillAppear:(BOOL)animated{
//    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void) setupHeaderViewForWayToHappinnes{
    self.categoryImg.image = [UIImage imageNamed:[[HelpManager sharedHelpManager] wayToHappinessHeaderImageName]];
    self.categoryLbl.text = self.model.title;
    [self.categoryLbl setAdjustsFontSizeToFitWidth:YES];
}

- (void) setupHeaderView{
    self.categoryImg.image = [UIImage imageNamed:[self.happinessCategoryModel.title isEqualToString:HappinessDialougesName] ? [[HelpManager sharedHelpManager] happinessDialougesHeaderImageName]:[[HelpManager sharedHelpManager] storyHeaderImageName]];
    self.categoryLbl.text = self.happinessCategoryModel.title;
    [self.categoryLbl setAdjustsFontSizeToFitWidth:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return self.bookMarkedPages.count;
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
    WayToHappinessSubCategoryModel * bookMarkPage = [self.bookMarkedPages objectAtIndex:indexPath.section];
    cell.titleLable.text = bookMarkPage.title;
    cell.categoryImageView.image = [UIImage imageNamed:bookMarkPage.imageName];
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
    BookMarkPage *bookMarkPage = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"BookMarkPage"];
     AbstractPageModel*pageModel =  [self.bookMarkedPages objectAtIndex:indexPath.row];
    [bookMarkPage setHTMLString:pageModel.htmlString];
    [self.navigationController pushViewController:bookMarkPage animated:YES];

}


- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
