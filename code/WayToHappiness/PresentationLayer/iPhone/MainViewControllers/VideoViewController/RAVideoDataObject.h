//
//  RAVideoDataObject.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/26/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoSubCategoryModel.h"
#import "VideoDetailModel.h"

@interface RAVideoDataObject : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *children;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString *imgName;
@property (strong, nonatomic) id model;

+ (id)dataObjectWithVideo:(VideoDetailModel *)video;
+ (id) dataObjectWithSubCategory:(VideoSubCategoryModel *)subCategory;
@end
