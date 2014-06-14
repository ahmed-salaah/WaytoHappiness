//
//  HappinessDialoguesPageModel.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/15/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "AbstractPageModel.h"

@interface HappinessPageModel : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *categoryID;
@property (nonatomic, strong) NSString *subCategoryID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *htmlString;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *jump;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSNumber *isbookmarked;
@end
