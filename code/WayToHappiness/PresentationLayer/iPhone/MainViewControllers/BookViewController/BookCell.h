//
//  BookCell.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/22/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetailModel.h"
#import "MBProgressHUD.h"
@class BookCell;
@protocol BookCellDelegate
- (void) didTappedReadButtonAtCell:(BookCell *)cell ;
- (void) didTappedDownloadButtonAtCell:(BookCell *)cell ;
- (void) didTappedDeleteButtonAtCell:(BookCell *)cell ;
@end

@interface BookCell : UITableViewCell <MBProgressHUDDelegate>
@property (weak, nonatomic) id<BookCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *readButton;
@property (weak, nonatomic) UIViewController *presentingViewController;
@property (strong, nonatomic) BookDetailModel *bookModel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (void) updateButtons;
@end
