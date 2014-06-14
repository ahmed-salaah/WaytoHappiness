//
//  BooksCell.h
//  WayToHappiness
//
//  Created by Ahmed Salah on 5/31/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetailModel.h"
#define BOOKS_CELL_ID @"BooksCell"
@class BooksCell;
@protocol BooksCellDelegate
- (void) didTappedDownloadButtonAtCell:(BooksCell *)cell ;
- (void) didTappedDeleteButtonAtCell:(BooksCell *)cell ;
@end
@interface BooksCell : UICollectionViewCell
@property (strong, nonatomic) BookDetailModel *bookModel;
@property (weak, nonatomic) id<BooksCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
- (void) updateButtons;
@end
