//
//  HappinessDialoguesPageModel.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 3/15/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "HappinessPageModel.h"

@implementation HappinessPageModel
@synthesize htmlString = _htmlString;
@synthesize imageName = _imageName;
-(void) setHtmlString:(NSString *)htmlString{
    if (!_htmlString) {
        _htmlString = htmlString;
        NSString *imagesFolderPath = [ImagesFolderPathInDocuments stringByAppendingString:@"/"];
        NSString * htmlStringInFile = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:HappinessHTMLFilePathPathInDocuments] encoding:NSUTF8StringEncoding error:nil];
        _htmlString = [_htmlString stringByReplacingOccurrencesOfString:ImagesFolderKeyInHTMLPage withString:imagesFolderPath];
        _htmlString = [htmlStringInFile stringByReplacingOccurrencesOfString:@"***HtmlFromDB****" withString:_htmlString];
    }
    else{
        _htmlString = htmlString;
    }
}


- (void) setImageName:(NSString *)imageName{
    _imageName = imageName;
    NSString *imagesFolderPath = [ImagesFolderPathInDocuments stringByAppendingString:@"/"];
    self.htmlString = [self.htmlString stringByReplacingOccurrencesOfString:IMAGE_DEV_IMAGE_PATH_NAME withString:[imagesFolderPath stringByAppendingString:imageName]];
}

- (id) init{
    if (self = [super init]) {
        
    }
    return self;
}


@end
