//
//  ZhaohuiMsg.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/5/18.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "ZhaohuiMsg.h"

@implementation ZhaohuiMsg
- (id)initWithBrand:(NSString*)brand
            cartype:(NSString*)cartype
            dealway:(NSString *)dealway
          id_fanhui:(NSString *)id_fanhui
             method:(NSString *)method
             period:(NSString *)period
             reason:(NSString *)reason
             result:(NSString *)result
             clsbdh:(NSString *)clsbdh{
    if (self = [super init]) {
        _brand = [[NSString alloc] initWithString:brand];
        _cartype = [[NSString alloc] initWithString:cartype];
        _dealway = [[NSString alloc] initWithString:dealway];
        _id_fanhui = [[NSString alloc] initWithString:id_fanhui];
        _method = [[NSString alloc] initWithString:method];
        _period = [[NSString alloc] initWithString:period];
        _reason = [[NSString alloc] initWithString:reason];
        _result = [[NSString alloc] initWithString:result];
        _clsbdh = [[NSString alloc] initWithString:clsbdh];
    }
    return self;
}


- (void)updateToDB{
    NSArray *a = [[DataBase sharedDataBase] selectZhaohuiByClsbdh:self.clsbdh];
    if (a.count == 0) {
        [[DataBase sharedDataBase]insertZhaohui:self];
    }else{
        [[DataBase sharedDataBase] updateZhaohui:self];
    }
}
@end
