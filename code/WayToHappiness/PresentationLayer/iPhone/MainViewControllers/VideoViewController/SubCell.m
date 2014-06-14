//
//  BookSubCategoryCell.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/23/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "SubCell.h"
#import "DownloadManager.h"

@implementation SubCell{
    UIActivityIndicatorView *indicatorView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:@"SubCell" owner:nil options:nil]
                lastObject];
        
        self.webView.allowsInlineMediaPlayback=YES;
        self.webView.mediaPlaybackRequiresUserAction=NO;
        self.webView.mediaPlaybackAllowsAirPlay=YES;
        self.webView.delegate=self;
        self.webView.scrollView.bounces=NO;
        
//        NSString *linkObj=@"https://www.youtube.com/v/8aA3TWqUGcA?version=3";//@"http://www.youtube.com/v/6MaSTM769Gk";
        NSLog(@"linkObj1_________________%@",self.linkObject);
        NSString *embedHTML = @"<html><head><style type=\"text/css\">\body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><embed webkit-playsinline id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" width=\"85\" height=\"60\"></embed></body></html>";
        
        NSString *html = [NSString stringWithFormat:embedHTML,self.linkObject];
        [self.webView loadHTMLString:html baseURL:[[NSBundle mainBundle] resourceURL]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) awakeFromNib{

//    self.webView.allowsInlineMediaPlayback=YES;
//    self.webView.mediaPlaybackRequiresUserAction=NO;
//    self.webView.mediaPlaybackAllowsAirPlay=YES;
//    self.webView.delegate=self;
//    self.webView.scrollView.bounces=NO;
//    int xPositionForIndicator = (self.webView.frame.size.width/2) - 10;
//    indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPositionForIndicator, 15, 20, 20)];
//    indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//    int xPositionForLabel = self.webView.frame.origin.x + self.webView.frame.size.width + 15;
//    CGRect labelFrame = self.titleLabel.frame;
//    labelFrame.origin.x = xPositionForLabel;
//    self.titleLabel.frame = labelFrame;
//    self.webView.scrollView.scrollEnabled = YES;
//    self.webView.layer.borderColor = [UIColor darkGrayColor].CGColor;
//    self.webView.layer.borderWidth = .5;
//    
//    [self bringSubviewToFront:self.webView];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self.webView addSubview:indicatorView];
    [indicatorView startAnimating];
    return YES;
}
- (IBAction)downloadButtonPressed:(id)sender {
    [self.delegate didTappedDownloadButtonAtCell:self];
    
}

- (IBAction)deleteButtonPressed:(id)sender {
    [self.delegate didTappedDeleteButtonAtCell:self];
}

- (IBAction)playButtonPressed:(id)sender {
    [self.delegate didTappedplayButtonAtCell:self];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"Failed");
}

- (void) webViewDidFinishLoad:(UIWebView *)webView{
    [indicatorView stopAnimating];
    [indicatorView removeFromSuperview];
}


- (void) setLinkObject:(NSString *)linkObject{
//    if (!_linkObject) {
        _linkObject = linkObject;
        NSString *embedHTML = @"<html><head><style type=\"text/css\">\body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><embed webkit-playsinline id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" width=\"70\" height=\"50\"></embed></body></html>";
        NSString *html = [NSString stringWithFormat:embedHTML, self.linkObject];
        [self.webView loadHTMLString:html baseURL:nil];
//    }
}

-(void)setVideoModel:(VideoDetailModel *)videoModel{
    _videoModel = videoModel;
    [self updateButtons];
    [self bringSubviewToFront:self.downloadButton];
    [self bringSubviewToFront:self.playButton];
    [self bringSubviewToFront:self.deleteButton];

}

- (void) updateButtons{
    self.playButton.enabled = self.videoModel.isDownloaded ?YES:NO;
    if (self.videoModel.isDownloaded) {
        self.downloadButton.hidden = YES;
        self.deleteButton.hidden = NO;
    }else{
        self.downloadButton.hidden = NO;
        self.deleteButton.hidden = YES;
    }
    
}

@end
