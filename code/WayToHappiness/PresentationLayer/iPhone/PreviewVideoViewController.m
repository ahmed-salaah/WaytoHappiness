//
//  PreviewVideoViewController.m
//  WayToHappiness
//
//  Created by Ahmed Salah on 5/3/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "PreviewVideoViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworkReachabilityManager.h"
@interface PreviewVideoViewController ()<UIWebViewDelegate>{
    NSString *html;
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UILabel *headerTitleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PreviewVideoViewController

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
    HUD = [[MBProgressHUD alloc] initWithView:self.webView];
    [self.webView addSubview:HUD];
    [HUD show:YES];
    [self.webView loadHTMLString:html baseURL:[[NSBundle mainBundle] resourceURL]];
    self.webView.delegate = self;
    self.webView.frame = [self.webView superview].frame;
    self.headerTitleLabel.text = self.videoTitle;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];    
}

- (void) viewWillAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setLink:(NSString *)link{
    _link = link;
    NSString *embedHTML = @"<html><head><style type=\"text/css\">\body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><embed webkit-playsinline id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" width=\"320\" height=\"100%%\"></embed></body></html>";
    html = [NSString stringWithFormat:embedHTML,_link];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView{
    [HUD removeFromSuperview];
}


@end
