//
//  BooksViewController_iPad.h
//  WayToHappiness
//
//  Created by Ahmed Salah on 5/31/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BooksCell.h"
#import "MBProgressHUD.h"
#import "ReaderViewController.h"
#import "BookMainCategory.h"
#import "BookSubCategoryModel.h"
#import "BookDetailModel.h"
#import "DownloadManager.h"
#import "AFNetworkReachabilityManager.h"
#import "IIViewDeckController.h"
#import "UIImageView+AFNetworking.h"
#import "AboutViewController.h"
#import "WYPopoverController.h"
#import "BookMarkPage.h"
@interface BooksViewController_iPad : UIViewController<BooksCellDelegate,MBProgressHUDDelegate,UIAlertViewDelegate, ReaderViewControllerDelegate,WYPopoverControllerDelegate>
@property (nonatomic,strong) id model;
@property (nonatomic, strong)NSString *titleText;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end
