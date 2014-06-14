//
//  WayToHappinessManager.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/4/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "WayToHappinessManager.h"
#import "SynthesizeSingleton.h"

@interface WayToHappinessManager()
@property (nonatomic, strong) NSArray *subCategories;
@property (nonatomic,strong) FMDatabase * sqliteDB;
@end

@implementation WayToHappinessManager

- (id) init{
    if (self = [super init]) {
        [self wayToHappinessCategory];
    }
    return self;
}

- (FMDatabase *)sqliteDB{
    if (!_sqliteDB) {
        _sqliteDB = [[FMDatabase alloc] initWithPath:SqliteFilePathInDocuments];
    }
    return _sqliteDB;
}

- (WayToHappinessModel *)wayToHappinessCategory{
    if (!_wayToHappinessCategory) {
        _wayToHappinessCategory = [self getWayToHappinessCategoryFromDatabase];
        NSMutableArray *subCategories =  [self getSubCateoriesFromDataBase];
        for (WayToHappinessSubCategoryModel * subCategory in subCategories) {
            NSMutableArray *pages = [self getPagesForSubCategory:subCategory];
            [subCategory setPages:pages];
        }
        [_wayToHappinessCategory setSubCategories:subCategories];
    }
    return _wayToHappinessCategory;
}

- (WayToHappinessModel *) getWayToHappinessCategoryFromDatabase{
    WayToHappinessModel * model = [[WayToHappinessModel alloc] init];;
     [self.sqliteDB open];

    NSString *query =[NSString stringWithFormat:@"SELECT * FROM Main_Category WHERE Sub1ID = %@",WayToHappinessID];
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

- (NSMutableArray *) getSubCateoriesFromDataBase{
    NSMutableArray *subCategories = [NSMutableArray array];
    [self.sqliteDB open];
    NSString *query = @"SELECT * FROM Main_Fessol WHERE Sub1IDParentID == 82";
    FMResultSet *allRows = [self.sqliteDB executeQuery:query];
    while ([allRows next]){
        
        WayToHappinessSubCategoryModel * subCategoryModel = [[WayToHappinessSubCategoryModel alloc] init];
        NSNumber * ID = [allRows objectForColumnName:@"Sub1ID"];
        NSNumber * categoryID = [allRows objectForColumnName:@"Sub1IDParentID"];
        NSString * title = [allRows objectForColumnName:@"Title"];
        NSString * description = [allRows objectForColumnName:@"txt"];
        NSString * imageName = [allRows objectForColumnName:@"img"];
        
        subCategoryModel.ID = ID? ID.stringValue : nil ;
        subCategoryModel.categoryID = categoryID? categoryID.stringValue :nil;
        subCategoryModel.title = title ?:nil;
        subCategoryModel.description = description?:nil;
        subCategoryModel.imageName = imageName?:nil;
        [subCategories addObject:subCategoryModel];
    }
    [self.sqliteDB close];
    return subCategories;
}

- (NSMutableArray *) getPagesForSubCategory:(WayToHappinessSubCategoryModel *)subCategory{

    NSMutableArray *pages = [NSMutableArray array];
    NSString *categoryID = subCategory.categoryID;
    [self.sqliteDB open];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Main_Deteails WHERE Sub1Id = %@",
    subCategory.ID];
    FMResultSet *allRows = [self.sqliteDB executeQuery:query];
    while ([allRows next]){
        
        WayToHappinessPageModel * page = [[WayToHappinessPageModel alloc] init];
        NSNumber * ID = [allRows objectForColumnName:@"Sub2Id"];
        NSNumber * subCategoryID = [allRows objectForColumnName:@"Sub1Id"];
        NSString * title = [allRows objectForColumnName:@"Title"];
        NSString * imageName = [allRows objectForColumnName:@"img"];
        NSString * htmlString = [allRows objectForColumnName:@"html"];
        NSString * jumpString = [allRows objectForColumnName:@"jumb"];
        NSString * description = [allRows objectForColumnName:@"Describtion"];
        NSNumber * isBookmarked = [allRows objectForColumnName:@"IsBookMarked"];
        
        page.ID = ID ? ID.stringValue :nil;
        page.subCategoryID = subCategory ? subCategoryID.stringValue :nil;
        page.title = title?:nil;
        page.htmlString = htmlString?:nil;
        page.jump = jumpString?:nil;
        page.imageName = imageName?:nil;
        page.description = description?:nil;
        page.categoryID = categoryID?:nil;
        page.isbookmarked = isBookmarked;
        [pages addObject:page];
    }
    [self.sqliteDB close];
    return pages;
}

-(void)setBookMarkePage:(WayToHappinessPageModel *)page isBookMarked:(BOOL)bookMark{
    [self.sqliteDB open];
    NSString *query = [NSString stringWithFormat:@"UPDATE Main_Deteails Set IsBookMarked = %d WHERE Sub2Id = %@",bookMark, page.ID];
    [self.sqliteDB executeUpdate:query];
    [self.sqliteDB close];
}

-(NSMutableArray *)getBookMarkedPages{
    NSMutableArray *pages = [NSMutableArray array];
    [self.sqliteDB open];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Main_Deteails WHERE ID = %@ And IsBookMarked = %@", [NSNumber numberWithInt:1], [NSNumber numberWithInt:1]];
    FMResultSet *allRows = [self.sqliteDB executeQuery:query];
    while ([allRows next]){
        
        WayToHappinessPageModel * page = [[WayToHappinessPageModel alloc] init];
        NSNumber * ID = [allRows objectForColumnName:@"Sub2Id"];
        NSNumber * subCategoryID = [allRows objectForColumnName:@"Sub1Id"];
        NSString * title = [allRows objectForColumnName:@"Title"];
        NSString * imageName = [allRows objectForColumnName:@"img"];
        NSString * htmlString = [allRows objectForColumnName:@"html"];
        NSString * jumpString = [allRows objectForColumnName:@"jumb"];
        NSString * description = [allRows objectForColumnName:@"Describtion"];
        NSNumber * isBookmarked = [allRows objectForColumnName:@"IsBookMarked"];
        
        page.ID = ID ? ID.stringValue :nil;
        page.subCategoryID = subCategoryID.stringValue;
        page.title = title?:nil;
        page.htmlString = htmlString?:nil;
        page.jump = jumpString?:nil;
        page.imageName = imageName?:nil;
        page.description = description?:nil;
        page.isbookmarked = isBookmarked;
        [pages addObject:page];
    }
    [self.sqliteDB close];
    return pages;
    
}

- (WayToHappinessPageModel *) getPageWithID:(NSString *)ID{
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Main_Deteails WHERE Sub2Id = %@",
                       ID];
    WayToHappinessPageModel * page;
    [self.sqliteDB open];
    FMResultSet *allRows = [self.sqliteDB executeQuery:query];
    while ([allRows next]){
        
        page = [[WayToHappinessPageModel alloc] init];
        NSNumber * ID = [allRows objectForColumnName:@"Sub2Id"];
        NSNumber * subCategoryID = [allRows objectForColumnName:@"Sub1Id"];
        NSString * title = [allRows objectForColumnName:@"Title"];
        NSString * imageName = [allRows objectForColumnName:@"img"];
        NSString * htmlString = [allRows objectForColumnName:@"html"];
        NSString * jumpString = [allRows objectForColumnName:@"jumb"];
        NSString * description = [allRows objectForColumnName:@"Describtion"];
        NSNumber * isBookmarked = [allRows objectForColumnName:@"IsBookMarked"];
        
        page.ID = ID ? ID.stringValue :nil;
        page.subCategoryID = subCategoryID.stringValue;
        page.title = title?:nil;
        page.htmlString = htmlString?:nil;
        page.jump = jumpString?:nil;
        page.imageName = imageName?:nil;
        page.description = description?:nil;
        page.isbookmarked = isBookmarked;
    }
    [self.sqliteDB close];
    return page;
}
SYNTHESIZE_SINGLETON_FOR_CLASS(WayToHappinessManager);
@end
