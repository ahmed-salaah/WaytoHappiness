//
//  VideoManager.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/21/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "VideoManager.h"
#import "FMDatabase.h"
#import "VideoSubCategoryModel.h"   
#import "VideoDetailModel.h"

@interface VideoManager()
@property (nonatomic, strong) NSArray *subCategories;
@property (nonatomic,strong) FMDatabase * sqliteDB;
@end

@implementation VideoManager

- (id) init{
    if (self = [super init]) {
        [self videoMainCategoryModel];
    }
    return self;
}

- (FMDatabase *)sqliteDB{
    if (!_sqliteDB) {
        _sqliteDB = [[FMDatabase alloc] initWithPath:SqliteFilePathInDocuments];
    }
    return _sqliteDB;
}

- (VideoMainCategoryModel *) videoMainCategoryModel{
    if (!_videoMainCategoryModel) {
        _videoMainCategoryModel = [self getVideoMainCategoryFromDatabase];
        NSMutableArray *subCategories = [self getSubCategories];
        for (VideoSubCategoryModel *subCategory in subCategories) {
            subCategory.videos = [self getVideosForSubCategory:subCategory];
        }
        _videoMainCategoryModel.subCategories = subCategories;
    }
    return _videoMainCategoryModel;
}

- (VideoMainCategoryModel *) getVideoMainCategoryFromDatabase{
    VideoMainCategoryModel * model = [[VideoMainCategoryModel alloc] init];;
    [self.sqliteDB open];
    
    NSString *query =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE Sub1ID = %@",Video_Main_Table,VideoMainCategoryID];
    FMResultSet *allRows = [self.sqliteDB executeQuery:query];
    while ([allRows next]){
        NSNumber * ID = [allRows objectForColumnName:@"Sub1ID"];
        NSString * title = [allRows objectForColumnName:@"Title"];
        model.ID = ID ? [ID stringValue]:nil;
        model.title = title?:nil;
    }
    [self.sqliteDB close];
    return model;
}

- (NSMutableArray *) getSubCategories{
    NSMutableArray *subCategories = [NSMutableArray array];
    [self.sqliteDB open];
    NSString *query =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ == %@",Video_Main_Table,SubCategory_Parent_ColumnName,VideoMainCategoryID];
    FMResultSet *allRows = [self.sqliteDB executeQuery:query];
    while ([allRows next]){
        
        VideoSubCategoryModel * subCategoryModel = [[VideoSubCategoryModel alloc] init];
        NSNumber * ID = [allRows objectForColumnName:@"Sub1ID"];
        NSString * title = [allRows objectForColumnName:@"Title"];
        
        subCategoryModel.ID = ID? ID.stringValue : nil ;
        subCategoryModel.title = title ?:nil;
        subCategoryModel.parentID = VideoMainCategoryID;
        [subCategories addObject:subCategoryModel];
    }
    [self.sqliteDB close];
    return subCategories;
}

- (NSMutableArray *) getVideosForSubCategory:(VideoSubCategoryModel *)subCategory{
    NSMutableArray *videos = [NSMutableArray array];
    [self.sqliteDB open];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = %@",
                       Video_Detail_Table,ID_ColumnName,subCategory.ID];
    FMResultSet *allRows = [self.sqliteDB executeQuery:query];
    while ([allRows next]){
        
        VideoDetailModel * video = [[VideoDetailModel alloc] init];
        NSNumber * ID = [allRows objectForColumnName:@"Sub2Id"];
        NSString * title = [allRows objectForColumnName:@"Title"];
        NSString * imageName = [allRows objectForColumnName:@"img"];
        NSString * embdedYouTube = [allRows objectForColumnName:@"embededYoutube"];
        NSString * fileName = [allRows objectForColumnName:@"fileName"];
        
        video.ID = ID ? ID.stringValue :nil;
        video.subCategoryID =subCategory.ID;
        video.title = title?:nil;
        video.embededYouTube= embdedYouTube?:nil;
        video.fileName = fileName?:nil;
        video.imageName = imageName?:nil;
        [videos addObject:video];
    }
    [self.sqliteDB close];
    return videos;
}

SYNTHESIZE_SINGLETON_FOR_CLASS(VideoManager);
@end
