//
//  Manager.h
//  WayToHappiness
//
//  Created by Ahmed Salah on 4/26/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "ShawahedModel.h"
#import "SynthesizeSingleton.h"

@interface ShawahedManager : NSObject
@property (nonatomic,strong) NSArray *ShawahedCategories;
@property (nonatomic,strong) FMDatabase * sqliteDB;
+(ShawahedManager *)sharedShawahedManager;
@end
