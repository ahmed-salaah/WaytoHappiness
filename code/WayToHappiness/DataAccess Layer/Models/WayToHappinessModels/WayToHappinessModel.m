//
//  MainCategoryModel.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 2/22/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "WayToHappinessModel.h"

@implementation WayToHappinessModel

- (instancetype) init{
    if (self = [super init]) {
        self.subCategories = [NSMutableArray array];
    }
    return self;
}

- (void) addSubCategoryObject:(WayToHappinessSubCategoryModel *)object{
    [self.subCategories addObject:object];
}

- (void) setSubCategories:(NSMutableArray *)subCategories{
    _subCategories = subCategories;
    for (AbstractSubCaetgoryModel *subCategory in _subCategories) {
        subCategory.categoryModel = self;
    }
}
@end
