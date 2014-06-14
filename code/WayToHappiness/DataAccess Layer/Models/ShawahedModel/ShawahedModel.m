//
//  ShawahedModel.m
//  WayToHappiness
//
//  Created by Ahmed Salah on 4/26/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "ShawahedModel.h"
#import "WayToHappinessManager.h"
@implementation ShawahedModel

- (void) setLessonID:(NSString *)lessonID{
    _lessonID = lessonID;
    self.pageModel = [[WayToHappinessManager sharedWayToHappinessManager] getPageWithID:lessonID];
}
@end
