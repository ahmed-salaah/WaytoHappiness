//
//  ViewController.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 2/22/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"
#import "WayToHappinessManager.h"
#import "HappinessDialoguesManager.h"   
#import "HappinessRoadManager.h"
#import "HappinessModel.h"
#import "HappinessPageModel.h"
#import "VideoManager.h"
#import "VideoMainCategoryModel.h"
#import "BookManager.h"
#import "BookMainCategory.h"
#import "VideoDetailModel.h"
#import "VideoSubCategoryModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    WayToHappinessModel * wayToHappinessModel = [[WayToHappinessManager sharedWayToHappinessManager] wayToHappinessCategory];
//    NSLog(@"mainID : %@",wayToHappinessModel.ID);
//    NSLog(@"mainTitle : %@",wayToHappinessModel.title);
//    NSLog(@"Maindescription : %@",wayToHappinessModel.description);
//
//    for (WayToHappinessSubCategoryModel *subCategory in wayToHappinessModel.subCategories) {
//        NSLog(@"ID : %@",subCategory.ID);
//        NSLog(@"CategorID : %@",subCategory.categoryID);
//        NSLog(@"title : %@",subCategory.title);
//        NSLog(@"desctiption : %@",subCategory.description);
//        NSLog(@"image : %@",subCategory.imageName);
//        for (WayToHappinessPageModel *page in subCategory.Pages) {
//            NSLog(@"PageID : %@",page.ID);
//            NSLog(@"subCategorID : %@",page.subCategoryID);
//            NSLog(@"PageCategorID : %@",page.categoryID);
//            NSLog(@"PageTitle : %@",page.title);
//            NSLog(@"Pagehtml : %@",page.htmlString);
//            NSLog(@"PageJump : %@",page.jump);
//            NSLog(@"PageDesctiption : %@",page.description);
//            NSLog(@"PageImage : %@",page.imageName);
//        }
//    }
  VideoMainCategoryModel *videoModel = [[VideoManager sharedVideoManager] videoMainCategoryModel];
    NSArray * booksCategories = [[BookManager  sharedBookManager] categories];
    for (BookMainCategory *book in booksCategories) {
        NSLog(@"Subcategories %@",book.subCategories);
        NSLog(@"books %@",book.books);
    }
    
    VideoDetailModel *video = [[[videoModel.subCategories firstObject] videos] firstObject];
    
//    HappinessModel * dialougesModel = [[HappinessDialoguesManager sharedHappinessDialoguesManager] happinessDialoguesModel];
    
    
  //  HappinessModel * roadModel = [[HappinessRoadManager sharedHappinessRoadManager] happinessRoadModel];
    

    
    UIWebView * youTubeWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0,0,320,320)];
    youTubeWebView.allowsInlineMediaPlayback=YES;
    youTubeWebView.mediaPlaybackRequiresUserAction=NO;
    youTubeWebView.mediaPlaybackAllowsAirPlay=YES;
    youTubeWebView.delegate=self;
    youTubeWebView.scrollView.bounces=NO;
    WayToHappinessSubCategoryModel *subCategory = [wayToHappinessModel.subCategories firstObject];
    
    NSString *linkObj=@"https://www.youtube.com/v/8aA3TWqUGcA?version=3";//@"http://www.youtube.com/v/6MaSTM769Gk";
    NSLog(@"linkObj1_________________%@",linkObj);
    NSString *embedHTML = @"<html><head><style type=\"text/css\">\body {\background-color: transparent;color: white;}\\</style>\\</head><body style=\"margin:0\">\\<embed webkit-playsinline id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \\width=\"320\" height=\"320\"></embed>\\</body></html>";
    
    NSString *html = [NSString stringWithFormat:embedHTML, linkObj];
    [youTubeWebView loadHTMLString:html baseURL:nil];
    [self.view addSubview:youTubeWebView];
//    WayToHappinessPageModel *page = [[[subCategory.Pages firstObject] ];
    //NSString *path = [[NSBundle mainBundle] bundlePath];
  //  NSURL *baseURL = [NSURL fileURLWithPath:path];
//    [youTubeWebView loadHTMLString:video.embededYouTube  baseURL:baseURL];
//    [self.view addSubview:youTubeWebView];
  //  [self.view setBackgroundColor:[UIColor yellowColor]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
