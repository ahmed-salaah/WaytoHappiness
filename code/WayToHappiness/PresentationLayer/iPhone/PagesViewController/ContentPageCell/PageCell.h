//
//  PageCell.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/12/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "SYPageView.h"
#define WEBVIEW_TAG 2233
@interface PageCell : SYPageView<UIWebViewDelegate>
@property (nonatomic,strong) NSString *HTMLString;
@property (nonatomic) CGRect pageFrame;
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
