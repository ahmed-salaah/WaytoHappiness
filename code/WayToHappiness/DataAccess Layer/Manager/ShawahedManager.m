//
//  Manager.m
//  WayToHappiness
//
//  Created by Ahmed Salah on 4/26/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "ShawahedManager.h"
#import "ShwahedCategory.h"
@implementation ShawahedManager

- (id) init{
    if (self = [super init]) {

    }
    return self;
}

- (FMDatabase *)sqliteDB{
    if (!_sqliteDB) {
        _sqliteDB = [[FMDatabase alloc] initWithPath:SqliteFilePathInDocuments];
    }
    return _sqliteDB;
}

- (NSArray *) ShawahedCategories{
    if (!_ShawahedCategories) {
        _ShawahedCategories = [self getShwahedCategoriesFromDatabase];
        for (ShwahedCategory *category in _ShawahedCategories) {
            category.shwahedArray = [self getShawahedFromDatabaseWithCategoryID:category.ID];
        }
    }
    return _ShawahedCategories;
}

- (NSArray *) getShwahedCategoriesFromDatabase{
    [self.sqliteDB open];
    NSMutableArray *categories = [NSMutableArray array];
    NSString *query =[NSString stringWithFormat:@"SELECT * FROM Shawed_Cat"];
    FMResultSet *allRows = [self.sqliteDB executeQuery:query];
    [allRows next]; //to skip first row 
    while ([allRows next]){
        ShwahedCategory * model = [[ShwahedCategory alloc] init];
        NSNumber * ID = [allRows objectForColumnName:@"Sub1ID"];
        NSString * title = [allRows objectForColumnName:@"Title"];
        NSString * image = [allRows objectForColumnName:@"img"];
        model.ID = ID ?[ID stringValue]:nil;
        model.title = title?:nil;
        model.image = image?:nil;
        [categories addObject:model];
    }
    [self.sqliteDB close];
    return categories;
}

- (NSArray *) getShawahedFromDatabaseWithCategoryID:(NSString *)categoryID{
    [self.sqliteDB open];
    NSMutableArray *data = [NSMutableArray array];
    NSString *query =[NSString stringWithFormat:@"SELECT * FROM Shawed WHERE Sub1ID = %@",categoryID];
    FMResultSet *allRows = [self.sqliteDB executeQuery:query];
    while ([allRows next]){
        ShawahedModel * model = [[ShawahedModel alloc] init];
        NSNumber * ID = [allRows objectForColumnName:@"Sub2ID"];
        NSString * title = [allRows objectForColumnName:@"Title"];
        NSString * image = [allRows objectForColumnName:@"imgTall"];
        NSString * lessonID = [allRows objectForColumnName:@"Sub2IdLesson"];        
        model.ID = ID ?[ID stringValue]:nil;
        model.title = title?:nil;
        model.image = image?:nil;
        model.lessonID = lessonID;
        [data addObject:model];
    }
    [self.sqliteDB close];
    return data;
}

SYNTHESIZE_SINGLETON_FOR_CLASS(ShawahedManager);

@end
