//
//  BooksCell.m
//  WayToHappiness
//
//  Created by Ahmed Salah on 5/31/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "BooksCell.h"

@implementation BooksCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        // Initialization code
    }
    return self;
}

- (void) setBookModel:(BookDetailModel *)bookModel{
    _bookModel = bookModel;
    [self updateButtons];
    [self bringSubviewToFront:self.downloadButton];
    [self bringSubviewToFront:self.deleteButton];
    
}

- (IBAction)downloadButtonPressed:(id)sender {
    [self.delegate didTappedDownloadButtonAtCell:self];
    
}

- (IBAction)deleteButtonPressed:(id)sender {
    [self.delegate didTappedDeleteButtonAtCell:self];
}


- (void) updateButtons{
    if (_bookModel.isDownloaded) {
        self.downloadButton.hidden = YES;
        self.deleteButton.hidden = NO;
    }else{
        self.downloadButton.hidden = NO;
        self.deleteButton.hidden = YES;
    }
}

- (void) awakeFromNib{
    [super awakeFromNib];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = [UIColor orangeColor].CGColor;
    bottomBorder.borderWidth = 1;
    bottomBorder.frame = CGRectMake(0, self.contentView.frame.size.height - 2, CGRectGetWidth(self.contentView.frame), 2);
    [self.contentView.layer addSublayer:bottomBorder];
}
@end
