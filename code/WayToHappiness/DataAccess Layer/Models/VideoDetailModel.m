//
//  VideoDetailModel.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/21/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "VideoDetailModel.h"
@implementation VideoDetailModel
- (instancetype) init{
    if (self = [super init]) {
        self.isDownloaded = NO;
    }
    return self;
}
- (void) setID:(NSString *)ID{
    if (!_ID) {
        _ID = ID;
        self.filePathInDocuments = [[VideosFolderInDocuments stringByAppendingPathComponent:ID] stringByAppendingPathExtension:@"mp4"];

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self checkIfDownloaded];
        }];
    }
}

- (void) checkIfDownloaded{
    NSArray *filesPaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:VideosFolderInDocuments error:nil];
    for (NSString *path in filesPaths) {
        NSString *bookPath = [VideosFolderInDocuments stringByAppendingPathComponent:path] ;
        NSString *path1 = [[VideosFolderInDocuments stringByAppendingPathComponent:_ID] stringByAppendingPathExtension:@"mp4"];
        if ([bookPath isEqualToString:path1]) {
            self.isDownloaded = YES;
            break;
        }
    }
}

@end
