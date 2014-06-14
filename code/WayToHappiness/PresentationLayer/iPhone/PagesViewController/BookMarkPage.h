//
//  BookMarkPage.h
//  WayToHappiness
//
//  Created by Ahmed Salah on 4/20/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlatWebView.h"
#import "MBProgressHUD.h"

@interface BookMarkPage : UIViewController<UIWebViewDelegate>{
    MBProgressHUD * HUD;
}
@property (nonatomic,strong)IBOutlet FlatWebView *webView;
@property (nonatomic,strong) NSString *HTMLString;
@property (nonatomic,strong) NSString *pageTitle;
@end
