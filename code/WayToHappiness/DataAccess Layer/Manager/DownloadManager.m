//
//  DownloadManager.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/22/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "DownloadManager.h"
//#import "AFDownloadRequestOperation.h"
#import "AFHTTPRequestOperation.h"

@implementation DownloadManager

- (instancetype) init{
    if (self = [super init]) {
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"No Internet Connection");
                    
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"WIFI");
                    
                    
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"3G");
                    break;
                default:
                    break;
                    
                    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
            }
        }];
    }
    return self;
}

- (void) downloadFileFrom:(NSString *)fromPath to:(NSString *)toPath withSuccessBlock:(void(^)())success failuerBlock:(void(^)())failuer DownloadProgressBlock:(void (^)(NSUInteger bytesRead, NSInteger totalBytesRead, NSInteger totalBytesExpectedToRead))downloadProgressBlock {
    NSMutableString *tempStr = [NSMutableString stringWithString:fromPath];
    [tempStr replaceOccurrencesOfString:@" " withString:@"+" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [tempStr length])];
    
    
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@",tempStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest  requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:toPath append:NO]];

    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        downloadProgressBlock(bytesRead,totalBytesRead,totalBytesExpectedToRead);
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success();
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failuer();
    }];
    
    [operation start];
}

- (BOOL) reachable{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (AFNetworkReachabilityStatus) status{
    return [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
}

SYNTHESIZE_SINGLETON_FOR_CLASS(DownloadManager);
@end
