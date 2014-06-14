//
//  videoViewController.m
//  WayToHappiness
//
//  Created by Ahmed Salah on 6/1/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "videoViewController.h"
#import "UIImageView+AFNetworking.h"
#import "BookMarkPage.h"
#import "PreviewVideoViewController.h"
#import "AboutViewController.h"
#import "VideoDetailModel.h"
#import "VideoSubCategoryModel.h"
#import "VideoDetailModel.h"
#import "VideoManager.h"
#import "RAVideoDataObject.h"
#import "DownloadManager.h"
#import "IIViewDeckController.h"
#import "MBProgressHUD.h"
#import "VideoSubCategorisViewController.h"
@interface videoViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation videoViewController

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
    [self setupNavigationBarButtons];
     self.subCategories = [[[VideoManager sharedVideoManager] videoMainCategoryModel] subCategories];
     self.data = [NSMutableArray array];
    for (VideoSubCategoryModel *subCategory in self.subCategories) {
        [self.data addObject:[RAVideoDataObject dataObjectWithSubCategory:subCategory]];
    }
    [self.tableView setBackgroundColor:[UIColor clearColor]];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UIImageView *imageView = nil;
    if (!cell) {
        
        cell = (UITableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    imageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VideoCat_VedioBack"]];
    cell.textLabel.text = ((RAVideoDataObject *)[self.data objectAtIndex:indexPath.row]).name;
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [UIImage imageNamed:@"VideoCat_Folder.png"];
    cell.backgroundView = imageView;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoSubCategorisViewController *videoController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"VideoSubCategorisViewController"];
    videoController.data = ((RAVideoDataObject *)[self.data objectAtIndex:indexPath.row]).children;
    videoController.titleLabel.text = ((RAVideoDataObject *)[self.data objectAtIndex:indexPath.row]).name;
    [self.navigationController pushViewController:videoController animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
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
                   action:@selector(infoPressed)
         forControlEvents:UIControlEventTouchUpInside];
    [infoButton setImage:[UIImage imageNamed:@"Mnu_Icon_About.png"]forState:UIControlStateNormal];
    [infoButton setFrame:CGRectMake(0, 0, 44, 44)];

    [bookmarkBtnVu addSubview:infoButton];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:bookmarkBtnVu]];
}

- (void) infoPressed{
    AboutViewController *aboutViewController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"AboutViewController"];
    [self.navigationController pushViewController:aboutViewController animated:YES];
}

- (void) menuPressed{
    [self.viewDeckController openLeftView];
}
@end
