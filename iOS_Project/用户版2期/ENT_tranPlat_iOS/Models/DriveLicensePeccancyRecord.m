//
//  DriveLicensePeccancyRecord.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-21.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "DriveLicensePeccancyRecord.h"

@implementation DriveLicensePeccancyRecord


- (id)initWithDriversfzmhm:(NSString*)driversfzmhm
              jszwf_detail:(NSString*)jszwf_detail
                jszwf_gxsj:(NSString*)jszwf_gxsj
                  andUseId:(NSString*)userId
{
    if (self = [super init]) {
        _driversfzmhm = [[NSString alloc] initWithString:driversfzmhm];
        _jszwf_detail = [[NSString alloc] initWithString:jszwf_detail];
        _jszwf_gxsj = [[NSString alloc] initWithString:jszwf_gxsj];
        _userId = [[NSString alloc] initWithString:userId];
    }
    return self;
}


//更新违章信息，根据userid删除，后添加
- (void)update{
    [[DataBase sharedDataBase] deleteDriveLicensePeccancyRecordByUserId:self.userId];
    [[DataBase sharedDataBase] insertDriveLicensePeccancyRecord:self];
}





@end
