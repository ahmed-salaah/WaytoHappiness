//
//  VideoWebViewController.m
//  WayToHappiness
//
//  Created by Ahmed Salah on 5/3/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "VideoWebViewController.h"

@implementation VideoWebViewController

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setLink:(NSString *)link{
    _link = link;
    NSString *embedHTML = @"<html><head><style type=\"text/css\">\body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><embed webkit-playsinline id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" width=\"auto\" height=\"auto\"></embed></body></html>";
    
    NSString *html = [NSString stringWithFormat:embedHTML,_link];
    [self loadHTMLString:html baseURL:[[NSBundle mainBundle] resourceURL]];
}

@end
