//
//  RABookDataObject.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/22/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "RABookDataObject.h"
@implementation RABookDataObject

- (id) initWithName:(NSString  *)name children:(NSArray *)children model:(id)model{
    self = [super init];
    if (self) {
        self.children = children;
        self.name = name;
        self.model = model;
    }
    return self;
}

+ (id) dataObjectWithSubCategory:(BookSubCategoryModel *)subCategory{
    return [[self alloc] initWithName:subCategory.title children:nil model:subCategory];
}

+ (id) dataObjectWithCategory:(BookMainCategory *)category{

    if (category.subCategories.count > 0) {
    NSMutableArray *children = [NSMutableArray array];
        for (BookSubCategoryModel *subCategoryModel in category.subCategories) {
            [children addObject:[RABookDataObject dataObjectWithSubCategory:subCategoryModel]];
        }
        return [[self alloc] initWithName:category.title children:children model:category];
    }
    else{
        return [[self alloc] initWithName:category.title children:nil model:category];
    }
}


@end
