//
//  ShwahedCategory.m
//  WayToHappiness
//
//  Created by Mohamed Abd El-latef on 5/7/14.
//  Copyright (c) 2014 Mohamed Abd El-latef. All rights reserved.
//

#import "ShwahedCategory.h"

@implementation ShwahedCategory
- (void) setImage:(NSString *)image{
    _image = image;
    if ([_image isEqualToString:@"fasl10.jpg"]) {
    _image = [_image stringByReplacingOccurrencesOfString:@"fasl" withString:@"S_"];
    }
    else{
    _image = [_image stringByReplacingOccurrencesOfString:@"fasl" withString:@"S_0"];        
    }
}


@end
