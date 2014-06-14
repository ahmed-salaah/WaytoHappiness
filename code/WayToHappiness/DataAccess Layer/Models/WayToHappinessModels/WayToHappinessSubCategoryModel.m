//
//  SubMainCategoryModel.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 2/22/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "WayToHappinessSubCategoryModel.h"

@implementation WayToHappinessSubCategoryModel

- (instancetype) init{
    if (self = [super init]) {
        self.Pages = [NSMutableArray array];
    }
    return self;
}

- (void) addPagesObject:(WayToHappinessPageModel *)page{
    [self.Pages addObject:page];
}

- (void) setPages:(NSMutableArray *)Pages{
    _Pages = Pages;
    for (WayToHappinessPageModel *page in _Pages) {
        page.subCatgeoryModel = self;
    }
}

@end
