//
//  PageCell.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/12/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "PageCell.h"
#import "FlatWebView.h"
#import "MBProgressHUD.h"

@interface PageCell(){
    MBProgressHUD * HUD;
}
@property (nonatomic,strong) FlatWebView *webView;
@end

@implementation PageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
	if ((self = [super initWithReuseIdentifier:reuseIdentifier])) {
        _webView = [[FlatWebView alloc] initWithFrame:self.frame];
        _webView.tag = WEBVIEW_TAG;
        _webView.scrollView.bounces = NO;
        _webView.delegate = self;
        [self addSubview:_webView];
	}
	return self;
}

- (void) setHTMLString:(NSString *)HTMLString{
    _HTMLString = HTMLString;
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [self.webView loadHTMLString:_HTMLString baseURL:baseURL];
    HUD = [[MBProgressHUD alloc] initWithView:self.webView];
    [self.webView addSubview:HUD];
    [HUD show:YES];
}

-(void) setPageFrame:(CGRect)pageFrame{
    if ([[HelpManager sharedHelpManager] IS_Portrait]) {
        pageFrame.size.height -=40;
    }
    else{
        pageFrame.size.height -=30;
    }
    [self.webView setFrame:pageFrame];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [HUD removeFromSuperview];
}
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"error");
}

@end
