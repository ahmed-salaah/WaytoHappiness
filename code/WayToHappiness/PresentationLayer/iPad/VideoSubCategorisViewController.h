//
//  VideoSubCategorisViewController.h
//  WayToHappiness
//
//  Created by Ahmed Salah on 6/1/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoSubCategorisViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong)NSArray *data;
@end
