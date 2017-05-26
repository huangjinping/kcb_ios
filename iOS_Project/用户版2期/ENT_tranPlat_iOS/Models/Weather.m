//
//  Weather.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/10.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "Weather.h"

@implementation Weather
/*
 @property (nonatomic, retain)     NSString    *temp;
 @property (nonatomic, retain)     NSString    *des;
 @property (nonatomic, retain)     NSString    *detail;
 @property (nonatomic, retain)     NSString    *logoUrl;
 @property (nonatomic, retain)     NSString    *xiche;
 @property (nonatomic, retain)     NSString    *updateTime;
 @property (nonatomic, retain)     NSString    *other;
 */
- (id)initWithTemp:(NSString*)temp
               des:(NSString*)des
            detail:(NSString*)detail
           logoUrl:(NSString*)logoUrl
             xiche:(NSString*)xiche
        updateTime:(NSString*)updateTime
             other:(NSString*)other{
    if (self = [super init]) {
        _temp = [[NSString alloc] initWithString:temp];
        _des = [[NSString alloc] initWithString:des];
        _detail = [[NSString alloc] initWithString:detail];
        _logoUrl = [[NSString alloc] initWithString:logoUrl];
        _xiche = [[NSString alloc] initWithString:xiche];
        _updateTime = [[NSString alloc] initWithString:updateTime];
        _other = [[NSString alloc] initWithString:other];

    }
    return self;
}





- (void)updateToDB{
    
    NSArray *ws = [[DataBase sharedDataBase] selectWeather];
    if ([ws count] == 0) {
        [[DataBase sharedDataBase] insertWeather:self];
    }else{
        [[DataBase sharedDataBase] updateWeather:self];
    }

}


@end
