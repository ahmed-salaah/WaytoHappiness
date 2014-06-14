//
//  AbstractCategoryModel.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/15/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbstractCategoryModel : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *imageName;
@end
