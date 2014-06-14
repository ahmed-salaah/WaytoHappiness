//
//  HappinessDialoguesManager.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/15/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HappinessModel.h"
#import "SynthesizeSingleton.h"
#import "HappinessPageModel.h"
@interface HappinessDialoguesManager : NSObject
@property (nonatomic,strong) HappinessModel * happinessDialoguesModel;
+(HappinessDialoguesManager *) sharedHappinessDialoguesManager;
-(void)setBookMarkePage:(HappinessPageModel *)page isBookMarked:(BOOL)bookMark;
-(NSMutableArray *)getBookMarkedPages;
@end
