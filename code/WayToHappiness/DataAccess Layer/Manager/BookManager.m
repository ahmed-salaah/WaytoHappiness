//
//  BookManager.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/21/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "BookManager.h"
#import "FMDatabase.h"
#import "BookSubCategoryModel.h"
#import "BookMainCategory.h"
#import "BookDetailModel.h"

@interface BookManager()
@property (nonatomic,strong) BookMainCategory *AdeanArdyaCategory;
@property (nonatomic,strong) BookMainCategory *AdeanSamawyaCategory;
@property (nonatomic,strong) BookMainCategory *historyCategory;
@property (nonatomic,strong) BookMainCategory *storiesCategory;
@property (nonatomic,strong) BookMainCategory *repliesCategory;
@property (nonatomic,strong) BookMainCategory *waysCategory;
@property (nonatomic,strong) FMDatabase * sqliteDB;
@end
@implementation BookManager

- (id) init{
    if (self = [super init]) {
        [self AdeanArdyaCategory];
        [self AdeanSamawyaCategory];
        [self historyCategory];
//        [self storiesCategory];
        [self repliesCategory];
        [self waysCategory];
         self.categories = @[self.AdeanArdyaCategory,self.AdeanSamawyaCategory,self.repliesCategory,self.historyCategory,self.waysCategory];
    }
    return self;

}
- (FMDatabase *)sqliteDB{
    if (!_sqliteDB) {
        _sqliteDB = [[FMDatabase alloc] initWithPath:SqliteFilePathInDocuments];
    }
    return _sqliteDB;
}

-(BookMainCategory *) AdeanArdyaCategory{
    if (!_AdeanArdyaCategory) {
        _AdeanArdyaCategory = [[BookMainCategory alloc] init];
        _AdeanArdyaCategory = [self getBookWithID:AdeanArdya_ID];
    }
    return _AdeanArdyaCategory;
}
-(BookMainCategory *) AdeanSamawyaCategory{
    if (!_AdeanSamawyaCategory) {
        _AdeanSamawyaCategory = [[BookMainCategory alloc] init];
        _AdeanSamawyaCategory = [self getBookWithID:AdeanSamawya_ID];
    }
    return _AdeanSamawyaCategory;
}
-(BookMainCategory *) historyCategory{
    if (!_historyCategory) {
        _historyCategory = [[BookMainCategory alloc] init];
        _historyCategory = [self getBookWithID:history_ID];
    }
    return _historyCategory;
}
-(BookMainCategory *) storiesCategory{
    if (!_storiesCategory) {
        _storiesCategory = [[BookMainCategory alloc] init];
        _storiesCategory = [self getBookWithID:stories_ID];
    }
    return _storiesCategory;
}
-(BookMainCategory *) repliesCategory{
    if (!_repliesCategory) {
        _repliesCategory = [[BookMainCategory alloc] init];
        _repliesCategory = [self getBookWithID:replies_ID];
    }
    return _repliesCategory;
}
-(BookMainCategory *) waysCategory{
    if (!_waysCategory) {
        _waysCategory = [[BookMainCategory alloc] init];
        _waysCategory = [self getBookWithID:ways_ID];
    }
    return _waysCategory;
}

- (BookMainCategory *)getBookWithID:(NSString *)categroryBookID{
    
    BookMainCategory *model = [self getAbstractCategoryModelWithID:categroryBookID];
    NSMutableArray *subCategories = [self getSubCategoriesOfCategoryID:categroryBookID];
    if ([subCategories count] > 0) {
        for (BookSubCategoryModel *subCategory in subCategories) {
            NSMutableArray *books = [self getBooksDetailsOfID:subCategory.ID];
            subCategory.books = books;
            for (BookDetailModel *book in books) {
                book.subCategoryID = subCategory.ID;
                book.categoryID = categroryBookID;
            }
        }
        model.subCategories = subCategories;
    }
    else{
        NSMutableArray * books = [self getBooksDetailsOfID:categroryBookID];
        for (BookDetailModel *book in books) {
            book.subCategoryID = nil;
            book.categoryID = categroryBookID;
        }
        model.books = books;
    }
    return model;
}
- (NSMutableArray *) getSubCategoriesOfCategoryID:(NSString *)categoryID{
    NSMutableArray *subCategories = [NSMutableArray array];
    [self.sqliteDB open];
    NSString *query =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ == %@",Book_SubCategory_Table,SubCategory_Parent_ColumnName,categoryID];
    FMResultSet *allRows = [self.sqliteDB executeQuery:query];
    while ([allRows next]){
        
        BookSubCategoryModel * subCategoryModel = [[BookSubCategoryModel alloc] init];
        NSNumber * ID = [allRows objectForColumnName:@"Sub1ID"];
        NSString * title = [allRows objectForColumnName:@"Title"];
        
        subCategoryModel.ID = ID? ID.stringValue : nil ;
        subCategoryModel.parentID = categoryID;
        subCategoryModel.title = title ?:nil;
        [subCategories addObject:subCategoryModel];
    }
    [self.sqliteDB close];
    return subCategories;
}
- (NSMutableArray *)getBooksDetailsOfID:(NSString *)ID{
    
    
    NSMutableArray *books = [NSMutableArray array];
    [self.sqliteDB open];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = %@",
                       Book_Detail_Table,ID_ColumnName,ID];
    FMResultSet *allRows = [self.sqliteDB executeQuery:query];
    while ([allRows next]){
        
        BookDetailModel * book = [[BookDetailModel alloc] init];
        NSNumber * ID = [allRows objectForColumnName:@"Sub2Id"];
        NSString * title = [allRows objectForColumnName:@"Title"];
        NSString * fileName = [allRows objectForColumnName:@"FileName"];
        NSString * imageName = [allRows objectForColumnName:@"img"];
        NSString * author = [allRows objectForColumnName:@"Authur"];
        NSString * description = [allRows objectForColumnName:@"Describtion"];
        
        book.ID = ID ? ID.stringValue :nil;
        book.title = title?:nil;
        book.author = author?:nil;
        book.imageName = imageName?:nil;
        book.fileName  = fileName?:nil;
        book.description = description?:nil;
        [books addObject:book];
    }
    [self.sqliteDB close];
    return books;
}
- (BookMainCategory *) getAbstractCategoryModelWithID:(NSString *)ID{
    BookMainCategory* model = [[BookMainCategory alloc] init];;
    [self.sqliteDB open];
    
    NSString *query =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = %@",Book_Main_Table,ID_ColumnName,ID];
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
SYNTHESIZE_SINGLETON_FOR_CLASS(BookManager);
@end
