//
//  DownloadManager.h
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/22/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "AFNetworkReachabilityManager.h"
@interface DownloadManager : NSObject

+ (DownloadManager *)sharedDownloadManager;

- (BOOL) reachable;
- (AFNetworkReachabilityStatus) status;
- (void) downloadFileFrom:(NSString *)fromPath to:(NSString *)toPath withSuccessBlock:(void(^)())success failuerBlock:(void(^)())failuer DownloadProgressBlock:(void (^)(NSUInteger bytesRead, NSInteger totalBytesRead, NSInteger totalBytesExpectedToRead))downloadProgressBlock;

@end
