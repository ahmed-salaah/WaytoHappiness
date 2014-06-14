//
//  BookSubCategoryCell.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/23/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoDetailModel.h"
#define SubCategoryCellIdentifier @"SubCategory"
@class SubCell;
@protocol videoCellDelegate
- (void) didTappedplayButtonAtCell:(SubCell *)cell ;
- (void) didTappedDownloadButtonAtCell:(SubCell *)cell ;
- (void) didTappedDeleteButtonAtCell:(SubCell *)cell ;
@end

@interface SubCell : UITableViewCell<UIWebViewDelegate>
@property (weak, nonatomic) id<videoCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *backgrounImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImg;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) NSString *linkObject;
@property (strong, nonatomic) VideoDetailModel *videoModel;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

- (void) updateButtons;
@end
