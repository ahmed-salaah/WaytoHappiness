//
//  HappinessDialoguesManager.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/15/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "HappinessDialoguesManager.h"
#import "FMDatabase.h"

@interface HappinessDialoguesManager()
@property (nonatomic,strong) FMDatabase * sqliteDB;
@property (nonatomic,strong ) NSMutableArray *pages;
@property (nonatomic,strong ) HappinessPageModel *page;
@end

@implementation HappinessDialoguesManager

- (id) init{
    if (self = [super init]) {
        [self happinessDialoguesModel];
    }
    return self;
}
- (FMDatabase *)sqliteDB{
    if (!_sqliteDB) {
        _sqliteDB = [[FMDatabase alloc] initWithPath:SqliteFilePathInDocuments];
    }
    return _sqliteDB;
}

- (HappinessModel *)happinessDialoguesModel{
    if (!_happinessDialoguesModel) {
        _happinessDialoguesModel = [self getHappinessDialougeModelFromDatabase];
        NSMutableArray *pages =  [self getPages];
        _happinessDialoguesModel.pages = pages;
    }
    return _happinessDialoguesModel;
}
- (HappinessModel *) getHappinessDialougeModelFromDatabase{
    HappinessModel * model = [[HappinessModel alloc] init];;
    [self.sqliteDB open];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Main_Category WHERE Sub1ID = %@",HappinessDialoguesID];
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
    self.pages = [[NSMutableArray alloc] init ];
    [self.sqliteDB open];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Main_Deteails WHERE Sub1Id = %@", HappinessDialoguesID];
    FMResultSet *allRows = [self.sqliteDB executeQuery:query];

    while ([allRows next]){
        
        self.page = [[HappinessPageModel alloc] init];
        NSNumber * ID = [allRows objectForColumnName:@"Sub2Id"];
        NSString * title = [allRows objectForColumnName:@"Title"];
        NSString * imageName = [allRows objectForColumnName:@"img"];
        NSString * htmlString = [allRows objectForColumnName:@"html"];
        NSString * description = [allRows objectForColumnName:@"Describtion"];
        NSNumber * isBookmarked = [allRows objectForColumnName:@"IsBookMarked"];
        
        self.page.ID = ID.stringValue;
        self.page.title = title;
        self.page.htmlString = htmlString;
        self.page.imageName = imageName;
        self.page.description = description;
        self.page.categoryID = HappinessDialoguesID;
        self.page.isbookmarked = isBookmarked;
        [self.pages addObject:self.page];
    }
    [self.sqliteDB close];
    return self.pages;
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
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Main_Deteails WHERE Sub1Id = %@ And IsBookMarked = %@", HappinessDialoguesID, [NSNumber numberWithInt:1]];
    FMResultSet *allRows = [self.sqliteDB executeQuery:query];
    while ([allRows next]){
        
        HappinessPageModel * page = [[HappinessPageModel alloc] init];
        NSNumber * ID = [allRows objectForColumnName:@"Sub2Id"];
        NSString * title = [allRows objectForColumnName:@"Title"];
        NSString * imageName = [allRows objectForColumnName:@"img"];
        NSString * description = [allRows objectForColumnName:@"Describtion"];
        NSString * htmlString = [allRows objectForColumnName:@"html"];
        NSNumber * isBookmarked = [allRows objectForColumnName:@"IsBookMarked"];
        
        page.ID = ID.stringValue ;
        page.title = title;
        page.description = description;
        page.categoryID = HappinessDialoguesID;
        page.htmlString = htmlString;
        page.imageName = imageName;        
        page.isbookmarked = isBookmarked;
        [pages addObject:page];
    }
    [self.sqliteDB close];
    return pages;
}
SYNTHESIZE_SINGLETON_FOR_CLASS(HappinessDialoguesManager);
@end
