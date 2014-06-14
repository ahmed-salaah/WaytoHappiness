//
//  WayToHappinessMainViewController_iPad.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/29/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "WayToHappinessMainViewController_iPad.h"
#import "WayToHappinessManager.h"
#import "WayToHappinessModel.h"
#import "WayToHappinessSubCategoryModel.h"
#import "collectionViewCell.h"
#import "PagesViewController_iPad.h"
#import "IIViewDeckController.h"
#import "WYPopoverController.h"
#import "BookMarkedPagesViewController.h"
#import "AboutViewController.h"
#import "UIColor+HexColors.h"
@interface WayToHappinessMainViewController_iPad () <WYPopoverControllerDelegate>
{
    WYPopoverController  *popOver;
    BOOL popOverisOpen;
    UIButton *bookmarkButton;

}
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) WayToHappinessModel *wayToHappinessModel;
@property (strong, nonatomic) NSArray *subCategories;

@end

@implementation WayToHappinessMainViewController_iPad

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.wayToHappinessModel = [[WayToHappinessManager sharedWayToHappinessManager] wayToHappinessCategory];
    self.subCategories = self.wayToHappinessModel.subCategories;
//    [self setupHeaderView];
    [self setupCollectionView];
    [self setupNavigationBarButtons];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void) setupHeaderView{
////    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Mnu_Icon_Mnu.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(menuPressed)];
////    self.headerImageView.image =
//}

-(void) setupCollectionView{
    [self.collectionView registerNib:[UINib nibWithNibName:@"collectionViewCell" bundle:nil] forCellWithReuseIdentifier:CELL_ID];
}

#pragma CollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.subCategories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    collectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    WayToHappinessSubCategoryModel *subCategoryModel = [self.subCategories objectAtIndex:indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:subCategoryModel.imageName];
    cell.titleLabel.text = subCategoryModel.title;
    return cell;
}
#pragma CollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PagesViewController_iPad  *pagesViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"PagesViewController_iPad"];
    pagesViewController.model = [self.subCategories objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:pagesViewController animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    // We only want to mess here in iPad in the list view
    return CGSizeMake(225, 180);
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 1, 20, 1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
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


- (void) bookmarkPressed:(UIButton *) sender{
    BookMarkedPagesViewController *pagesTableView = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"BookMarkedPagesViewController"];
    pagesTableView.bookMarkedPages = [[WayToHappinessManager sharedWayToHappinessManager]getBookMarkedPages];
    pagesTableView.model = self.wayToHappinessModel;
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


- (void) infoPressed:(UIBarButtonItem *) sender{
    AboutViewController *aboutViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"AboutViewController"];
    [self.navigationController pushViewController:aboutViewController animated:YES];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation  duration:(NSTimeInterval)duration {
    if (popOverisOpen) {
        [popOver dismissPopoverAnimated:YES];
        if ([popOver.contentViewController isKindOfClass:[AboutViewController class]]) {
            [self infoPressed:nil];
        }else
            [self bookmarkPressed:bookmarkButton];
        
    }
    //[self setupNavigationbarHeight];
}

- (void) tap:(UIGestureRecognizer *)gesture{
    [popOver dismissPopoverAnimated:YES];
    popOverisOpen = NO;
    [self.view removeGestureRecognizer:gesture];
}

@end
