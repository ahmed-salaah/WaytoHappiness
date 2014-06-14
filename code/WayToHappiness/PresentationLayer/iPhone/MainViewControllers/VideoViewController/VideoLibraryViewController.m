//
//  VideoLibraryViewController.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/26/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "VideoLibraryViewController.h"
#import "UIImageView+AFNetworking.h"
#import "BookMarkPage.h"
#import "PreviewVideoViewController.h"
#import "AboutViewController.h"

@interface VideoLibraryViewController (){
    SubCell *toBeDownloadcell;
}
@property (weak, nonatomic) IBOutlet RATreeView *treeView;
@property (strong, nonatomic) id expanded;
@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) NSArray *subCategories;
@end

@implementation VideoLibraryViewController

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
    self.subCategories = [[[VideoManager sharedVideoManager] videoMainCategoryModel] subCategories];
    self.data = [NSMutableArray array];
    [self setupNavigationBarButtons];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    [self setupTreeView];
}

- (void) viewDidAppear:(BOOL)animated{
/*    if (![[DownloadManager sharedDownloadManager] reachable]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No internet connection" message:@"Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }*/
}

- (void)didReceiveMemoryWarning
{

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupTreeView{
    self.treeView.delegate =self;
    self.treeView.dataSource = self;
    self.treeView.separatorStyle = RATreeViewCellSeparatorStyleNone;
    [self.treeView setRowsCollapsingAnimation:RATreeViewRowAnimationLeft];
    [self.treeView setRowsExpandingAnimation:RATreeViewRowAnimationLeft];
    [self.treeView registerNib:[UINib nibWithNibName:@"SubCell" bundle:nil] forCellReuseIdentifier:SubCategoryCellIdentifier];
    [self.treeView setEditing:NO animated:NO];
    for (VideoSubCategoryModel *subCategory in self.subCategories) {
        [self.data addObject:[RAVideoDataObject dataObjectWithSubCategory:subCategory]];
    }

}

#pragma mark TreeView Delegate methods
- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    return 60;
}

- (NSInteger)treeView:(RATreeView *)treeView indentationLevelForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    return 3 * treeNodeInfo.treeDepthLevel;
}

- (BOOL)treeView:(RATreeView *)treeView shouldExpandItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    return YES;
}

- (BOOL)treeView:(RATreeView *)treeView shouldItemBeExpandedAfterDataReload:(id)item treeDepthLevel:(NSInteger)treeDepthLevel
{
    if ([item isEqual:self.expanded]) {
        return YES;
    }
    
    return NO;
}

- (void)treeView:(RATreeView *)treeView willDisplayCell:(UITableViewCell *)cell forItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    
}

#pragma mark TreeView Data Source

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    UITableViewCell *cell;
    UIImageView *imageView = nil;
    if (treeNodeInfo.children.count > 0) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        imageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VideoCat_VedioBack"]];
        cell.textLabel.text = ((RAVideoDataObject *)item).name;
        cell.textLabel.textColor = [UIColor orangeColor];        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.imageView.image = [UIImage imageNamed:@"VideoCat_Folder.png"];
        cell.backgroundView = imageView;
    }
    else{
        cell = [treeView dequeueReusableCellWithIdentifier:SubCategoryCellIdentifier];
        if (!cell) {
        cell = [[SubCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SubCategoryCellIdentifier];
        }
        NSString *imgURL = [[videoThumb_Site_Path stringByAppendingString:((RAVideoDataObject *)item).imgName]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString * imagePath = [VideosImagesFolderInDocuments  stringByAppendingPathComponent:((RAVideoDataObject *)item).imgName];
        if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
            ((SubCell*)cell).thumbImg.image  = [UIImage imageWithContentsOfFile:imagePath];
        }
        else{
            [((SubCell*)cell).thumbImg setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imgURL]] placeholderImage:[UIImage imageNamed:@"placeholder.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                ((SubCell*)cell).thumbImg.image = image;
                [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            }];
        }
        ((SubCell*)cell).backgrounImageView.image = [UIImage imageNamed:@"Book2_TitleBack.png"];
        ((SubCell*)cell).titleLabel.text = ((RAVideoDataObject *)item).name;
        ((SubCell*)cell).linkObject = ((RAVideoDataObject *)item).link;
        ((SubCell*)cell).selectionStyle = UITableViewCellSelectionStyleNone;
        ((SubCell*)cell).backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    if (item == nil) {
        return [self.data count];
    }
    
    RAVideoDataObject *data = item;
    return [data.children count];
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    RAVideoDataObject *data = item;
    if (item == nil) {
        return [self.data objectAtIndex:index];
    }
    
    return [data.children objectAtIndex:index];
}

- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    if (treeNodeInfo.children.count == 0) {
        PreviewVideoViewController *videoController = [[[HelpManager sharedHelpManager] storyboard] instantiateViewControllerWithIdentifier:@"PreviewVideoViewController"];
        videoController.link = ((RAVideoDataObject *)item).link;
        videoController.videoTitle = ((RAVideoDataObject *)item).name;
        [self.navigationController pushViewController:videoController animated:YES];
    }
}

- (BOOL)treeView:(RATreeView *)treeView canEditRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    return NO;
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation  duration:(NSTimeInterval)duration {
//    [self setupNavigationbarHeight];
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

- (void) didTappedDownloadButtonAtCell:(SubCell *)cell{
    [self downloadVideo:cell];
}

- (void) didTappedDeleteButtonAtCell:(SubCell *)cell{
    
    [self deleteVideo:cell];
    [[NSFileManager defaultManager] removeItemAtPath:cell.videoModel.filePathInDocuments error:nil];
}

-(void) didTappedplayButtonAtCell:(SubCell *)cell{
    
}

- (void) downloadVideo:(SubCell *)cell{
    VideoDetailModel *video = [cell videoModel];
    
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    HUD.delegate = self;
    HUD.labelText = @"Downloading";
    [HUD show:YES];
    NSString *fromPath = [cell.linkObject stringByAppendingString:video.title];
    [[DownloadManager sharedDownloadManager] downloadFileFrom:fromPath to:video.filePathInDocuments withSuccessBlock:^{
        HUD.labelText = @"";
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        [HUD hide:YES afterDelay:2];
        video.isDownloaded = YES;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [cell updateButtons];
        }];
    } failuerBlock:^{
        [HUD hide:YES];
    }DownloadProgressBlock:^(NSUInteger bytesRead, NSInteger totalBytesRead, NSInteger totalBytesExpectedToRead) {
        HUD.progress = totalBytesRead / (float)totalBytesExpectedToRead;
    }];
    
}

- (void) deleteVideo:(SubCell *)cell{
    toBeDownloadcell = cell;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"تحذير" message:@"هل تريد حذف هذا الفيديو؟" delegate:self cancelButtonTitle:@"إلغاء" otherButtonTitles:@"موافق", nil];
    [alert show];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1:{
            VideoDetailModel *video = [toBeDownloadcell videoModel];
            NSFileManager *manager = [NSFileManager defaultManager];
            [manager removeItemAtPath:video.filePathInDocuments error:nil];
            video.isDownloaded= NO;
            [toBeDownloadcell updateButtons];
            break;
        }
        default:
            break;
    }
}



@end
