//
//  HappinessRoadManager.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/15/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "HappinessRoadManager.h"

#import "FMDatabase.h"
@interface HappinessRoadManager()
@property (nonatomic,strong) FMDatabase * sqliteDB;
@end

@implementation HappinessRoadManager

- (id) init{
    if (self = [super init]) {
        [self happinessRoadModel];
    }
    return self;
}
- (FMDatabase *)sqliteDB{
    if (!_sqliteDB) {
        _sqliteDB = [[FMDatabase alloc] initWithPath:SqliteFilePathInDocuments];
    }
    return _sqliteDB;
}

- (HappinessModel *)happinessRoadModel{
    if (!_happinessRoadModel) {
        _happinessRoadModel = [self getHappinessRoadModelFromDatabase];
        NSMutableArray *pages =  [self getPages];
        _happinessRoadModel.pages = pages;
    }
    return _happinessRoadModel;
}
- (HappinessModel *) getHappinessRoadModelFromDatabase{
    HappinessModel * model = [[HappinessModel alloc] init];;
    [self.sqliteDB open];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Main_Category WHERE Sub1ID = %@", HappinessRoadID];
    FMResultSet *allRows = [self.sqliteDB executeQuery:query];
    while ([allRows next]){
        NSNumber * ID = [allRows objectForColumnName:@"Sub1ID"];
        NSString * title = [allRows objectForColumnName:@"Title"];
        NSString * description = [allRows objectForColumnName:@"txt"];
        NSString * imageName = [allRows objectForColumnName:@"img"];
        model.ID = ID ? [ID stringValue]:nil;
        model.title = title?:nil;
        model.description = description?:nil;
        model.imageName = imageName?:nil;
    }
    [self.sqliteDB close];
    return model;
}

- (NSMutableArray *) getPages{
    NSMutableArray *pages = [NSMutableArray array];
    [self.sqliteDB open];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Main_Deteails WHERE Sub1Id = %@", HappinessRoadID];
    FMResultSet *allRows = [self.sqliteDB executeQuery:query];
    while ([allRows next]){
        
        HappinessPageModel * page = [[HappinessPageModel alloc] init];
        NSNumber * ID = [allRows objectForColumnName:@"Sub2Id"];
        NSString * title = [allRows objectForColumnName:@"Title"];
        NSString * imageName = [allRows objectForColumnName:@"img"];
        NSString * htmlString = [allRows objectForColumnName:@"html"];
        NSString * description = [allRows objectForColumnName:@"Describtion"];
        NSNumber * isBookmarked = [allRows objectForColumnName:@"IsBookMarked"];
      
        page.isbookmarked = isBookmarked;
        page.ID = ID ? ID.stringValue :nil;
        page.title = title?:nil;
        page.htmlString = htmlString?:nil;
        page.imageName = imageName?:nil;
        page.description = description?:nil;
        page.categoryID = HappinessRoadID;
        page.isbookmarked = isBookmarked;
        [pages addObject:page];
    }
    [self.sqliteDB close];
    return pages;
    return nil;
}

-(void)setBookMarkePage:(HappinessPageModel *)page isBookMarked:(BOOL)bookMark{
    [self.sqliteDB open];
    NSString *query = [NSString stringWithFormat:@"UPDATE Main_Deteails Set IsBookMarked = %d WHERE Sub2Id = %@", bookMark, page.ID];
    [self.sqliteDB executeUpdate:query];
    [self.sqliteDB close];
}

-(NSMutableArray *)getBookMarkedPages{
    NSMutableArray *pages = [NSMutableArray array];
    [self.sqliteDB open];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Main_Deteails WHERE Sub1Id = %@ And IsBookMarked = %@", HappinessRoadID, [NSNumber numberWithInt:1]];
    FMResultSet *allRows = [self.sqliteDB executeQuery:query];
    while ([allRows next]){
        
        HappinessPageModel * page = [[HappinessPageModel alloc] init];
        NSNumber * ID = [allRows objectForColumnName:@"Sub2Id"];
        NSString * title = [allRows objectForColumnName:@"Title"];
        NSString * imageName = [allRows objectForColumnName:@"img"];
        NSString * htmlString = [allRows objectForColumnName:@"html"];
        NSString * description = [allRows objectForColumnName:@"Describtion"];
        NSNumber * isBookmarked = [allRows objectForColumnName:@"IsBookMarked"];
        
        page.isbookmarked = isBookmarked;
        page.ID = ID ? ID.stringValue :nil;
        page.title = title?:nil;
        page.htmlString = htmlString?:nil;
        page.imageName = imageName?:nil;
        page.description = description?:nil;
        page.categoryID = HappinessRoadID;
        [pages addObject:page];

    }
    [self.sqliteDB close];
    return pages;
}
SYNTHESIZE_SINGLETON_FOR_CLASS(HappinessRoadManager);
@end
