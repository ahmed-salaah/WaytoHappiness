//
//  BookDetailModel.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/21/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookDetailModel : NSObject
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *parentID;
@property (nonatomic,strong) NSString *fileName;
@property (nonatomic,strong) NSString *description;
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *subCategoryID;
@property (nonatomic,strong) NSString *categoryID;
@property (nonatomic,strong) NSString *filePathInDocuments;
@property (nonatomic) BOOL isDownloaded;
@end
