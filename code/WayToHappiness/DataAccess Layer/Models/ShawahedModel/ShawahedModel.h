//
//  ShawahedModel.h
//  WayToHappiness
//
//  Created by Ahmed Salah on 4/26/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WayToHappinessPageModel.h"
@interface ShawahedModel : NSObject
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *lessonID;
@property (nonatomic,strong) WayToHappinessPageModel *pageModel;
@end
