//
//  VideoManager.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/21/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoMainCategoryModel.h"
#import "SynthesizeSingleton.h"

@interface VideoManager : NSObject
@property (nonatomic,strong) VideoMainCategoryModel *videoMainCategoryModel;

+ (VideoManager *) sharedVideoManager;
@end
