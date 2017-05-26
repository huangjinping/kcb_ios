//
//  Xianxing.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/14.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "Xianxing.h"

@implementation Xianxing



- (id)initWithStartDate:(NSString*)startDate
                endDate:(NSString*)endDate
            specialDate:(NSString*)specialDate
                 monday:(NSString*)monday
                tuesday:(NSString*)tuesday
              wednesday:(NSString*)wednesday
               thursday:(NSString*)thursday
                 friday:(NSString*)friday
               saturday:(NSString*)saturday
                 sunday:(NSString*)sunday{

    if (self = [super init]) {
        _startDate = [[NSString alloc] initWithString:startDate];
        _endDate = [[NSString alloc] initWithString:endDate];
        _specialDate = [[NSString alloc] initWithString:specialDate];
        _monday = [[NSString alloc] initWithString:monday];
        _tuesday = [[NSString alloc] initWithString:tuesday];
        _wednesday = [[NSString alloc] initWithString:wednesday];
        _thursday = [[NSString alloc] initWithString:thursday];
        _friday = [[NSString alloc] initWithString:friday];
        _saturday = [[NSString alloc] initWithString:saturday];
        _sunday = [[NSString alloc] initWithString:sunday];

    }
    return self;
}


- (void)addToDB{
    [[DataBase sharedDataBase] insertXianxing:self];
}
- (void)updateToDB{
    [[DataBase sharedDataBase] deleteXianxing];
    [[DataBase sharedDataBase] insertXianxing:self];
}
@end
