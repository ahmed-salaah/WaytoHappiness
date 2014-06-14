//
//  SetupFilesManager.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/5/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"


@interface SetupFilesManager : NSObject
@property (nonatomic,strong) NSString*wayToHappinessHTMLString;

+ (SetupFilesManager *) sharedSetupFilesManager;
- (void) setupFiles;
@end
