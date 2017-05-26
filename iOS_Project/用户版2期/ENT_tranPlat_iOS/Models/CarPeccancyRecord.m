//
//  CarPeccancyRecord.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-21.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "CarPeccancyRecord.h"

@implementation CarPeccancyRecord

- (id)initWithHpzl:(NSString*)hpzl
              hphm:(NSString*)hphm
      jdcwf_detail:(NSString*)jdcwf_detail
        jdcwf_gxsj:(NSString*)jdcwf_gxsj
         andUserId:(NSString*)userId
{
    if (self = [super init]) {
        _hpzl = [[NSString alloc] initWithString:hpzl];
        _hphm = [[NSString alloc] initWithString:hphm];
        _jdcwf_detail = [[NSString alloc] initWithString:jdcwf_detail];
        _jdcwf_gxsj = [[NSString alloc] initWithString:jdcwf_gxsj];
        _userId = [[NSString alloc] initWithString:userId];
    }
    return self;
}

//更新违章信息，根据userid删除，后添加
- (void)update{
    [[DataBase sharedDataBase] deleteCarPeccancyRecordByUserId:self.userId andHphm:self.hphm];
    [[DataBase sharedDataBase] insertCarPeccancyRecord:self];
    
}

@end
