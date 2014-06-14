//
//  VideoSubCategorisViewController.m
//  WayToHappiness
//
//  Created by Ahmed Salah on 6/1/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "VideoSubCategorisViewController.h"
#import "VideoCell.h"
#import "UIImageView+AFNetworking.h"
#import "RAVideoDataObject.h"
#import "PreviewVideoViewController.h"
@interface VideoSubCategorisViewController ()

@end

@implementation VideoSubCategorisViewController

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
    [self.collectionView registerNib:[UINib nibWithNibName:@"VideoCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.data count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        VideoCell *cell =(VideoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *imgURL = [[videoThumb_Site_Path stringByAppendingString:((RAVideoDataObject *)[self.data objectAtIndex:indexPath.row]).imgName ]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * imagePath = [VideosImagesFolderInDocuments  stringByAppendingPathComponent:((RAVideoDataObject *)[self.data objectAtIndex:indexPath.row]).imgName ];
 
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        cell.imageView.image  = [UIImage imageWithContentsOfFile:imagePath];
    }
    else{
        [cell.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imgURL]] placeholderImage:[UIImage imageNamed:@"placeholder.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            cell.imageView.image = image;
            [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        }];
    }

    cell.titleLabel.text = ((RAVideoDataObject *)[self.data objectAtIndex:indexPath.row]).name;
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}

#pragma CollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PreviewVideoViewController *videoController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"PreviewVideoViewController"];
    videoController.link = ((RAVideoDataObject *)[self.data objectAtIndex:indexPath.row]).link;
    videoController.videoTitle = ((RAVideoDataObject *)[self.data objectAtIndex:indexPath.row]).name;
    [self.navigationController pushViewController:videoController animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    // We only want to mess here in iPad in the list view
    return CGSizeMake(150, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if ([[HelpManager sharedHelpManager] IS_Landscape] ) {
        return UIEdgeInsetsMake(20, 12, 20, 13);
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

@end
