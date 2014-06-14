//
//  WayToHappinessManager.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/4/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"  
#import "WayToHappinessSubCategoryModel.h"
#import "WayToHappinessModel.h"
#import "WayToHappinessPageModel.h"
@interface WayToHappinessManager : NSObject
@property (nonatomic,strong) WayToHappinessModel *wayToHappinessCategory;
-(void)setBookMarkePage:(WayToHappinessPageModel *)page isBookMarked:(BOOL)bookMark;
-(NSMutableArray *)getBookMarkedPages;
- (WayToHappinessPageModel *) getPageWithID:(NSString *)ID;
+(WayToHappinessManager *)sharedWayToHappinessManager;
@end
