//
//  Location.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/16.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "Location.h"

@class Location;
static Location *_loc = nil;
@implementation Location


- (id)shareLocation{
    if (_loc == nil) {
        _loc = [[Location alloc] init];
    }
    return _loc;
}

- (void)autoSetCity{
    
}

@end
