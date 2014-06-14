//
//  PagesViewController_iPad.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/29/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "PagesViewController_iPad.h"
#import "SYPaginatorView.h"
#import "WayToHappinessSubCategoryModel.h"
#import "HappinessModel.h"
#import "IIViewDeckController.h"
#import "PageCell.h"
#import "WayToHappinessManager.h"
#import "HappinessRoadManager.h"
#import "HappinessDialoguesManager.h"
#define Paginator_Y_Positon 124
#define Paginator_Height_Portrait 900
#define Paginator_Height_LandScape  644
#define Paginator_Width_Portrait 768
#define Paginator_Width_Landscape 1024

@interface PagesViewController_iPad (){
    UIView *displayedCell;
    UIButton *bookmarkButton;
}
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic) NSInteger selectedPageIndex;
@property (strong, nonatomic) SYPaginatorView *paginatorView;
@end

@implementation PagesViewController_iPad

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupNavigationbarHeight];
    [self setupNavigationBarButtons];
    [self  setupHeaderView];
    self.selectedPageIndex = self.selectedPageIndex > 0 ? self.selectedPageIndex : 0;
    if ([[HelpManager sharedHelpManager] IS_Portrait]) {
        [self setupPagintaorViewForPortrait];
    }
    else{
        [self setupPagintaorViewForLandscape];
    }
    [self.view addSubview:self.paginatorView];
}

- (void) setupHeaderView{
    
    NSString *title = [self.model isKindOfClass:[WayToHappinessSubCategoryModel class]] ? ((WayToHappinessSubCategoryModel *)self.model).title : ((AbstractCategoryModel*)self.model).title;
    NSString *imageName = [self.model isKindOfClass:[WayToHappinessSubCategoryModel class]]?[[HelpManager sharedHelpManager] wayToHappinessHeaderImageName]:[((HappinessModel *)self.model).title isEqualToString:HappinessDialougesName]?[[HelpManager sharedHelpManager] happinessDialougesHeaderImageName]:[[HelpManager sharedHelpManager] storyHeaderImageName];
    
    self.headerImageView.image = [UIImage imageNamed:imageName];
    self.headerLabel.text = title;
}

- (void) setupPagintaorViewForPortrait{
    
    self.paginatorView = [[SYPaginatorView alloc] initWithFrame:CGRectMake(0, Paginator_Y_Positon,Paginator_Width_Portrait, Paginator_Height_Portrait)];
//    self.paginatorView.autoresizingMask =UIViewAutoresizingFlexibleWidth;
    self.paginatorView.autoresizesSubviews = YES;
    
    self.paginatorView.delegate =self;
    self.paginatorView.dataSource = self;
	self.paginatorView.pageGapWidth = 20.0f;
    self.paginatorView.currentPageIndex = self.selectedPageIndex;
    self.paginatorView.backgroundColor = [UIColor clearColor];
}

- (void) setupPagintaorViewForLandscape{
    self.paginatorView = [[SYPaginatorView alloc] initWithFrame:CGRectMake(0,Paginator_Y_Positon,Paginator_Width_Landscape,Paginator_Height_LandScape)];
    self.paginatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin;
    self.paginatorView.autoresizesSubviews = YES;
    
    self.paginatorView.delegate =self;
    self.paginatorView.dataSource = self;
    self.paginatorView.pageGapWidth = 20.0f;
    self.paginatorView.currentPageIndex = self.selectedPageIndex;
    self.paginatorView.backgroundColor = [UIColor clearColor];
}

- (void) setCurrentPageIndex:(NSInteger)index{
    self.selectedPageIndex = index;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) setupNavigationbarHeight{
    CGRect frame = self.navigationController.navigationBar.frame;
    frame.size.height = 44;
    self.navigationController.navigationBar.frame = frame;
}

#pragma PaginatorDatasource
- (NSInteger) numberOfPagesForPaginatorView:(SYPaginatorView *)paginatorView{
    
    
    return  [self.model isKindOfClass:[WayToHappinessSubCategoryModel class]] ? ((WayToHappinessSubCategoryModel *)self.model).Pages.count : ((HappinessModel*)self.model).pages.count;
}

- (SYPageView *)paginatorView:(SYPaginatorView *)paginatorView viewForPageAtIndex:(NSInteger)pageIndex{

    static NSString *identifier = @"identifier";
    
    PageCell *page = (PageCell *)[paginatorView dequeueReusablePageWithIdentifier:identifier];
    if (!page) {
        page = [[PageCell alloc] initWithReuseIdentifier:identifier];
    }
    page.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    AbstractPageModel*pageModel =  [self.model isKindOfClass:[WayToHappinessSubCategoryModel class]] ? [((WayToHappinessSubCategoryModel *)self.model).Pages objectAtIndex:pageIndex] : [((HappinessModel*)self.model).pages objectAtIndex:pageIndex];
    page.HTMLString = pageModel.htmlString;
    CGRect frame = self.paginatorView.frame;
    frame.origin.y = 0;
    page.pageFrame = frame;
	return page;
}
#pragma PaginatorDelegate
-(void)paginatorView:(SYPaginatorView *)paginatorView
     willDisplayView:(UIView *)view
             atIndex:(NSInteger)pageIndex{
    displayedCell =view;
    AbstractPageModel*pageModel = [self getCurrentPage];
    if ([pageModel.isbookmarked boolValue])
        bookmarkButton.tintColor = [UIColor blueColor];
    else
        bookmarkButton.tintColor = [UIColor whiteColor];
    
}

- (void)paginatorViewDidBeginPaging:(SYPaginatorView *)paginatorView{
    NSLog(@"will Begin Paging");
}

- (void)paginatorView:(SYPaginatorView *)paginatorView didScrollToPageAtIndex:(NSInteger)pageIndex{
 AbstractPageModel*pageModel =  [self.model isKindOfClass:[WayToHappinessSubCategoryModel class]] ? [((WayToHappinessSubCategoryModel *)self.model).Pages objectAtIndex:pageIndex] : [((HappinessModel*)self.model).pages objectAtIndex:pageIndex];
    self.headerLabel.text = pageModel.title;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
//    [self setupNavigationbarHeight];
    self.paginatorView.alpha = 0;
    [self.paginatorView removeFromSuperview];
    if (fromInterfaceOrientation == UIInterfaceOrientationPortrait || [[HelpManager sharedHelpManager] IS_Landscape]) {
        [self setupPagintaorViewForLandscape];
    }
    else {
        [self setupPagintaorViewForPortrait];
    }
    self.paginatorView.alpha = 0;
    [self.view addSubview:self.paginatorView];
    [UIView animateWithDuration:.3 animations:^{
        self.paginatorView.alpha = 1;
    }];
}

- (void) menuPressed{
    [self.viewDeckController openLeftView];
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
                       action:@selector(bookmarkPressed)
             forControlEvents:UIControlEventTouchUpInside];
    [bookmarkButton setImage:[UIImage imageNamed:@"Mnu_Icon_BookMark.png"]forState:UIControlStateNormal];
    [bookmarkButton setFrame:CGRectMake(0, 0, 44, 44)];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoButton addTarget:self
                   action:@selector(share)
         forControlEvents:UIControlEventTouchUpInside];
    [infoButton setImage:[UIImage imageNamed:@"Mnu_Icon_About.png"]forState:UIControlStateNormal];
    [infoButton setFrame:CGRectMake(50, 0, 44, 44)];
    [bookmarkBtnVu addSubview:bookmarkButton];
    [bookmarkBtnVu addSubview:infoButton];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:bookmarkBtnVu]];
}

-(void)share{
    AbstractPageModel*pageModel = [self getCurrentPage];
    
    
    NSArray *activityItems = [[NSArray alloc] initWithObjects:pageModel.title, [NSString stringWithFormat:Sharing_Link, pageModel.ID], nil];
    UIActivityViewController *activityController =
    [[UIActivityViewController alloc]
     initWithActivityItems:activityItems
     applicationActivities:nil];
    //    activityController.excludedActivityTypes = [[NSArray alloc] initWithObjects:
    //                                                UIActivityTypeCopyToPasteboard,
    //                                                UIActivityTypePostToWeibo,
    //                                                UIActivityTypeSaveToCameraRoll,
    //                                                UIActivityTypeCopyToPasteboard,
    //                                                UIActivityTypeMessage,
    //                                                UIActivityTypeAssignToContact,
    //                                                UIActivityTypePrint,
    //                                                UIActivityTypeMail,
    //                                                nil];
    
    NSAttributedString *as = [[NSAttributedString alloc] initWithString:@"إلغاء" attributes:@{NSForegroundColorAttributeName:[UIColor blueColor]}];
    [[UIButton appearanceWhenContainedIn:[UIActivityViewController class], nil] setAttributedTitle:as forState:UIControlStateNormal];
    
    
    [self presentViewController:activityController
                       animated:YES completion:nil];
}

- (void)bookmarkPressed{
    AbstractPageModel*pageModel = [self getCurrentPage];
    if (![pageModel.isbookmarked boolValue])
        bookmarkButton.tintColor = [UIColor blueColor];
    else
        bookmarkButton.tintColor = [UIColor whiteColor];
    
    if ([self.model isKindOfClass:[WayToHappinessSubCategoryModel class]]) {
        [[WayToHappinessManager sharedWayToHappinessManager] setBookMarkePage:(WayToHappinessPageModel *)pageModel isBookMarked:![pageModel.isbookmarked boolValue]];
    }else{
        if ([((AbstractCategoryModel *)self.model).ID isEqualToString:HappinessDialoguesID]) {
            [[HappinessDialoguesManager sharedHappinessDialoguesManager]setBookMarkePage:(HappinessPageModel *)pageModel isBookMarked:![pageModel.isbookmarked boolValue]];
        }
        else{
            [[HappinessRoadManager sharedHappinessRoadManager]setBookMarkePage:(HappinessPageModel *)pageModel isBookMarked:![pageModel.isbookmarked boolValue]];
        }
    }
    pageModel.isbookmarked = [NSNumber numberWithBool:![pageModel.isbookmarked boolValue]];
}
-(AbstractPageModel *)getCurrentPage{
    AbstractPageModel*pageModel =  [self.model isKindOfClass:[WayToHappinessSubCategoryModel class]] ? [((WayToHappinessSubCategoryModel *)self.model).Pages objectAtIndex:self.paginatorView.currentPageIndex] : [((HappinessModel*)self.model).pages objectAtIndex:self.paginatorView.currentPageIndex];
    return pageModel;
}


@end
