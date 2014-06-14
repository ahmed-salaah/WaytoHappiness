//
//  ShawahedViewController.m
//  WayToHappiness
//
//  Created by Ahmed Salah on 4/26/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "ShawahedViewController.h"
#import "ShawahedManager.h"
#import "UIImageView+AFNetworking.h"
#import "HelpManager.h"
#import "IIViewDeckController.h"
#import "AboutViewController.h"
#import "WYPopoverController.h"
#import "UIColor+HexColors.h"
#import "ShwahedCell.h"
#import "BookMarkPage.h"
#define IMAGE_VIEW_TAG 2233
#define Bookmark_Color @"99CCFF"

@interface ShawahedViewController ()<WYPopoverControllerDelegate,ShwahedCellDelegate>{
    WYPopoverController *popOver;
    BOOL popOverisOpen;
}

@end

@implementation ShawahedViewController

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
    [self.collectionView registerNib:[UINib nibWithNibName:@"ShwahedCell" bundle:nil] forCellWithReuseIdentifier:SHWAHED_CELL_ID];
    [self setupNavigationBarButtons];
}
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma CollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shawahedModelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShwahedCell * cell = (ShwahedCell *)[collectionView dequeueReusableCellWithReuseIdentifier:SHWAHED_CELL_ID forIndexPath:indexPath];
    ShawahedModel *shawahedPageModel = [self.shawahedModelArr objectAtIndex:indexPath.row];
    NSString *imgURL = [[shawahedThumb_Image_Path stringByAppendingString:shawahedPageModel.image]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * imagePath = [shawahedImagesFolderInDocuments  stringByAppendingPathComponent:shawahedPageModel.image];
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        cell.ShwahedImageView.image= [UIImage imageWithContentsOfFile:imagePath];
    }
    else{
        [cell.ShwahedImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imgURL]] placeholderImage:[UIImage imageNamed:@"placeholder.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            cell.ShwahedImageView.image = image;
            [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            NSLog(@"%@",error.description);
        }];
    }

    cell.delegate = self;
    return cell;
}

#pragma CollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ShwahedCell * cell = (ShwahedCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [EXPhotoViewer showImageFrom:cell.ShwahedImageView];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    // We only want to mess here in iPad in the list view
    if ([[HelpManager sharedHelpManager] IS_Landscape] && [[HelpManager sharedHelpManager] IS_iPhone5])
        return CGSizeMake(135, 200);
    else
        return CGSizeMake(150, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if ([[HelpManager sharedHelpManager] IS_Landscape] ) {
        if ([[HelpManager sharedHelpManager] IS_iPhone5]) {
            return UIEdgeInsetsMake(20, 12, 20, 13);

        }else{
            return UIEdgeInsetsMake(20, 14, 20, 14);
        }
    }else{
        return UIEdgeInsetsMake(20, 9, 20, 9);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self.collectionView.collectionViewLayout invalidateLayout];
    if (popOverisOpen) {
        [popOver dismissPopoverAnimated:YES];
        [self infoPressed:self.navigationItem.rightBarButtonItem];
    }
}
- (void) tap:(UIGestureRecognizer *)gesture{
    [popOver dismissPopoverAnimated:YES];
    popOverisOpen = NO;
    [self.view removeGestureRecognizer:gesture];
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


- (void) menuPressed{
    [self.viewDeckController openLeftView];
}

- (void) infoPressed:(UIButton *) sender{
    AboutViewController *aboutViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"AboutViewController"];
    [self.navigationController pushViewController:aboutViewController animated:YES];
}

- (void) didTapButtonAtCell:(ShwahedCell *)cell{
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:cell];
    ShawahedModel *shawahedPageModel = [self.shawahedModelArr objectAtIndex:indexPath.row];
    BookMarkPage *bookMarkPage = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"BookMarkPage"];
    [bookMarkPage setHTMLString:shawahedPageModel.pageModel.htmlString];
    [self.navigationController pushViewController:bookMarkPage animated:YES];
}


@end