//
//  PageModel.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 2/22/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "WayToHappinessPageModel.h"

@implementation WayToHappinessPageModel
@synthesize htmlString = _htmlString;
@synthesize jump = _jump;
@synthesize imageName = _imageName;

- (void) setHtmlString:(NSString *)htmlString{
    if (!_htmlString) {
        _htmlString = htmlString;
        NSString *imagesFolderPath = [ImagesFolderPathInDocuments stringByAppendingString:@"/"];
        NSString * htmlStringInFile = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:WayToHappinessHTMLFilePathPathInDocuments] encoding:NSUTF8StringEncoding error:nil];
        _htmlString = [_htmlString stringByReplacingOccurrencesOfString:ImagesFolderKeyInHTMLPage withString:imagesFolderPath];
        _htmlString = [htmlStringInFile stringByReplacingOccurrencesOfString:@"***HtmlFromDB****" withString:_htmlString];
    }
    else{
        _htmlString = htmlString;
    }

}

- (void) setJump:(NSString *)jump{
    
    _jump = jump;
    NSString *jumpHTML = START_JUMP_DEV;
    NSMutableArray * jumps = [[jump componentsSeparatedByString:@"#"] mutableCopy];
    [jumps removeObject:jumps.firstObject]; //empty string
    int index = 0;
    for (NSString *jumpString in jumps) {
        index++;
        NSArray *components = [jumpString componentsSeparatedByString:@"|"];
        NSString *jumpLine = [JUMP_LINE stringByReplacingOccurrencesOfString:JUMP_Number_KEYWORD withString:[NSString stringWithFormat:@"#%i",index]];
        jumpLine = [jumpLine stringByReplacingOccurrencesOfString:JUMP_TEXT_KEYWORD withString:components[1]];
      jumpHTML =[jumpHTML stringByAppendingString:jumpLine];
    }
    jumpHTML =[jumpHTML stringByAppendingString:END_JUMP_DEV];
    self.htmlString = [self.htmlString  stringByReplacingOccurrencesOfString:JUMP_KEYWORD_HTML withString:jumpHTML];
    NSLog(@"%@",jumpHTML);
}

- (void) setImageName:(NSString *)imageName{
    _imageName = imageName;
    NSString *imagesFolderPath = [ImagesFolderPathInDocuments stringByAppendingString:@"/"];
    self.htmlString = [self.htmlString stringByReplacingOccurrencesOfString:IMAGE_DEV_IMAGE_PATH_NAME withString:[imagesFolderPath stringByAppendingString:imageName]];
}

@end