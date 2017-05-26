//
//  MovieInfo.m
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-12-8.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "MovieInfo.h"

@implementation MovieInfo

- (id)init{
    if (self = [super init]) {
        _movieContent = [[MovieContent alloc]init];
        _user = [[ChatUser alloc]init];
    }
    return self;
}

@end
