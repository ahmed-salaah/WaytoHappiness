//
//  ShawahedViewController.h
//  WayToHappiness
//
//  Created by Ahmed Salah on 4/26/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShawahedModel.h"
#import "EXPhotoViewer.h"
@interface ShawahedViewController : UIViewController
@property (nonatomic, strong)NSArray *shawahedModelArr;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end
