//
//  MainCategoryModel.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 2/22/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WayToHappinessSubCategoryModel.h"
#import "AbstractCategoryModel.h"

@interface WayToHappinessModel : AbstractCategoryModel
@property (nonatomic, strong) NSMutableArray *subCategories;
@end
