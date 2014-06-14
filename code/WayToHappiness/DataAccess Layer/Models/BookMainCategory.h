//
//  BookMainCategory.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/21/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookMainCategory : NSObject
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSMutableArray *books;
@property (nonatomic,strong) NSMutableArray *subCategories;
@end
