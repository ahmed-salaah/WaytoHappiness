//
//  BookDetailModel.m
//  WayToHappiness
//
//  Created by Mohamed Abd ; on 3/21/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "BookDetailModel.h"

@implementation BookDetailModel

- (instancetype) init{
    if (self = [super init]) {
        self.isDownloaded = NO;
    }
    return self;
}


- (void) setID:(NSString *)ID{
    if (!_ID) {
        _ID = ID;
        self.filePathInDocuments = [[BooksFolderInDocuments stringByAppendingPathComponent:ID] stringByAppendingPathExtension:@"pdf"];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self checkIfDownloaded];
        }];
    }
}

- (void) checkIfDownloaded{
    NSArray *filesPaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:BooksFolderInDocuments error:nil];
    for (NSString *path in filesPaths) {
        NSString *bookPath = [BooksFolderInDocuments stringByAppendingPathComponent:path] ;
        NSString *path1 = [[BooksFolderInDocuments stringByAppendingPathComponent:_ID] stringByAppendingPathExtension:@"pdf"];
        if ([bookPath isEqualToString:path1]) {
            self.isDownloaded = YES;
            break;
        }
    }
}

@end
