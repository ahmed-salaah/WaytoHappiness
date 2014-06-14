//
//  SetupFilesManager.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/5/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "SetupFilesManager.h"
#import "SSZipArchive.h"
@interface SetupFilesManager()

@end

@implementation SetupFilesManager

- (void) setupFiles{
    [self setupSqliteFileInDocuments];
    [self setupImagesInDocuments];
    [self setupHTMLFileInDocuments];
    [self createDirectoryForBooksImages];
    [self createBooksFolder];
    [self createShawahedImageFolder];
    [self createDirectoryForVideosImages];
}

- (void) setupSqliteFileInDocuments{
    //Copy DataBase To Documents Folder
    NSString *sqliteDatabasePath = [[NSBundle mainBundle] pathForResource:Database_FileName
                                                                   ofType:SQLITE_EXTENISON];
    [[NSFileManager defaultManager] copyItemAtPath:sqliteDatabasePath
                                            toPath:SqliteFilePathInDocuments
                                             error:Nil];
}

- (void) setupImagesInDocuments{
    //Copy ImagesZip to Documents Folder
    NSString *imagesPath = [[NSBundle mainBundle] pathForResource:Shawahed_Folder
                                                                   ofType:ZIP_EXTENISON];
    [[NSFileManager defaultManager] copyItemAtPath:imagesPath
                                            toPath:ImagesZipPathInDocuments
                                             error:Nil];
    //unzip Images
    [SSZipArchive unzipFileAtPath:ImagesZipPathInDocuments toDestination:Documents_Path];
    //delete Zip File
    [[NSFileManager defaultManager] removeItemAtPath:ImagesZipPathInDocuments error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:AddedMACOSXFolderPathInDocuments error:nil];
}

- (void) setupHTMLFileInDocuments{
    //Copy ImagesZip to Documents Folder
    NSString *HTMLPath = [[NSBundle mainBundle] pathForResource:HTML_FileName_1
                                                           ofType:HTML_EXTENISON];
    [[NSFileManager defaultManager] copyItemAtPath:HTMLPath
                                            toPath:WayToHappinessHTMLFilePathPathInDocuments
                                             error:Nil];
    
    NSString *HTMLPath2 = [[NSBundle mainBundle] pathForResource:HTML_FileName_2
                                                         ofType:HTML_EXTENISON];
    [[NSFileManager defaultManager] copyItemAtPath:HTMLPath2
                                            toPath:HappinessHTMLFilePathPathInDocuments
                                             error:Nil];
}

- (NSString *)wayToHappinessHTMLString{
    if (!_wayToHappinessHTMLString) {
        _wayToHappinessHTMLString =  [NSString stringWithContentsOfFile:WayToHappinessHTMLFilePathPathInDocuments encoding:NSUTF8StringEncoding error:nil];
    }
    return _wayToHappinessHTMLString;
}

- (void) createDirectoryForBooksImages{
    [[NSFileManager defaultManager] createDirectoryAtPath:BooksImagesFolderInDocuments withIntermediateDirectories:NO attributes:nil error:nil];
}

- (void) createDirectoryForVideosImages{
    [[NSFileManager defaultManager] createDirectoryAtPath:VideosImagesFolderInDocuments withIntermediateDirectories:NO attributes:nil error:nil];
}
- (void) createBooksFolder{
    [[NSFileManager defaultManager] createDirectoryAtPath:BooksFolderInDocuments withIntermediateDirectories:NO attributes:nil error:nil];
}

- (void) createShawahedImageFolder{
    [[NSFileManager defaultManager] createDirectoryAtPath:shawahedImagesFolderInDocuments withIntermediateDirectories:NO attributes:nil error:nil];
}

SYNTHESIZE_SINGLETON_FOR_CLASS(SetupFilesManager);

@end
