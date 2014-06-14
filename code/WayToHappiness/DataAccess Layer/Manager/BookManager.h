//
//  BookManager.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/21/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
@interface BookManager : NSObject
@property (nonatomic,strong) NSArray * categories;
+ (BookManager *) sharedBookManager;
@end
