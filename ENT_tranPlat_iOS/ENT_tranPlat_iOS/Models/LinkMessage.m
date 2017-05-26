//
//  LinkMessage.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-11-27.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "LinkMessage.h"

@implementation LinkMessage


- (id)init{
    if (self = [super init]) {
        _urlString = [[NSString alloc] init];
        _range = NSMakeRange(0, 0);
        _title = [[NSString alloc] init];
    }
    
    return self;
}
@end
