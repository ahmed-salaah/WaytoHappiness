//
//  RAVideoDataObject.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/26/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "RAVideoDataObject.h"

@implementation RAVideoDataObject
- (id) initWithName:(NSString  *)name imgName:(NSString  *)imgName link:(NSString *)link children:(NSArray *)children model:(id)model{
    self = [super init];
    if (self) {
        self.children = children;
        self.name = name;
        self.model = model;
        self.link = link;
        self.imgName = imgName;
        
    }
    return self;
}
+ (id)dataObjectWithVideo:(VideoDetailModel *)video{
    return [[self alloc] initWithName:video.title imgName:video.imageName link:video.fileName children:nil model:video];
}
+ (id) dataObjectWithSubCategory:(VideoSubCategoryModel *)subCategory{
        NSMutableArray *children = [NSMutableArray array];
        for (VideoDetailModel *video in subCategory.videos) {
            [children addObject:[RAVideoDataObject dataObjectWithVideo:video]];
        }
        return [[self alloc] initWithName:subCategory.title imgName:nil link:nil children:children model:subCategory];
}

@end
