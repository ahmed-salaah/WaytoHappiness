//
//  VideoDetailModel.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/21/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoDetailModel : NSObject
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *embededYouTube;
@property (nonatomic,strong) NSString *firstName;
@property (nonatomic,strong) NSString *fileName;
@property (nonatomic,strong) NSString *subCategoryID;
@property (nonatomic,strong) NSString *filePathInDocuments;

@property (nonatomic) BOOL isDownloaded;
@end
