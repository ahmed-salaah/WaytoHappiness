//
//  RABookDataObject.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/22/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookMainCategory.h"
#import "BookSubCategoryModel.h"
@interface RABookDataObject : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *children;
@property (strong, nonatomic) id model;

+ (id)dataObjectWithCategory:(BookMainCategory *)category;
+ (id) dataObjectWithSubCategory:(BookSubCategoryModel *)subCategory;

@end
