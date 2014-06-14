//
//  BookMarkPage.m
//  WayToHappiness
//
//  Created by Ahmed Salah on 4/20/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "BookMarkPage.h"

@interface BookMarkPage ()

@end

@implementation BookMarkPage

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
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.webView addSubview:HUD];
    [HUD show:YES];
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    self.webView.suppressesIncrementalRendering = YES;
    [_webView loadHTMLString:_HTMLString baseURL:baseURL];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

//- (void)setHTMLString:(NSString *)HTMLString{
//    _HTMLString = HTMLString;
//}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [HUD removeFromSuperview];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"error:%@", error.description);
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
