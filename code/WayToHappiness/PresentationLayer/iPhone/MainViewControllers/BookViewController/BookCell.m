//
//  BookCell.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/22/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "BookCell.h"
#import "DownloadManager.h"

@implementation BookCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        //        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        //        [self setBackgroundColor:[UIColor blackColor]];
        //        self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        //        self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        //        self.readButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        //        self.downloadButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        //        self.deleteButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setBookModel:(BookDetailModel *)bookModel{
    _bookModel = bookModel;
    [self updateButtons];
    [self bringSubviewToFront:self.downloadButton];
    [self bringSubviewToFront:self.readButton];
    [self bringSubviewToFront:self.deleteButton];

}

- (IBAction)downloadButtonPressed:(id)sender {
    [self.delegate didTappedDownloadButtonAtCell:self];

}

- (IBAction)deleteButtonPressed:(id)sender {
    [self.delegate didTappedDeleteButtonAtCell:self];
}


- (void) updateButtons{
    self.readButton.enabled = _bookModel.isDownloaded ?YES:NO;
    if (_bookModel.isDownloaded) {
        self.downloadButton.hidden = YES;
        self.deleteButton.hidden = NO;
    }else{
        self.downloadButton.hidden = NO;
        self.deleteButton.hidden = YES;
    }
}

@end
