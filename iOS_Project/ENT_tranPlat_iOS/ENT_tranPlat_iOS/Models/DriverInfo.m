//
//  DriverInfo.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-21.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "DriverInfo.h"

@implementation DriverInfo

- (id)initWithDriverfzmhm:(NSString*)driversfzmhm
                     dabh:(NSString*)dabh
                       xm:(NSString*)xm
             driverstatus:(NSString*)driverstatus
                     ljjf:(NSString*)ljjf
                     zjcx:(NSString*)zjcx
                     yxqz:(NSString*)yxqz
                     zxbh:(NSString*)zxbh
               drivergxsj:(NSString*)drivergxsj
                 djzsxxdz:(NSString*)djzsxxdz
                 driverzt:(NSString*)zt
                 andUseId:(NSString*)userId{
    if (self = [super init]) {
        _driversfzmhm = [[NSString alloc] initWithString:driversfzmhm];
        _dabh = [[NSString alloc] initWithString:dabh];
        _xm = [[NSString alloc] initWithString:xm];
        _driverstatus = [[NSString alloc] initWithString:driverstatus];
        _ljjf = [[NSString alloc] initWithString:ljjf];
        _zjcx = [[NSString alloc] initWithString:zjcx];
        _yxqz = [[NSString alloc] initWithString:yxqz];
        _zxbh = [[NSString alloc] initWithString:zxbh];
        _drivergxsj = [[NSString alloc] initWithString:drivergxsj];
        _djzsxxdz = [[NSString alloc] initWithString:djzsxxdz];
        _driverzt = [[NSString alloc] initWithString:zt];
        _userId = [[NSString alloc] initWithString:userId];
    }
    return self;
}


//向数据库添加一条driver信息
- (void)add{
    [[DataBase sharedDataBase] insertDriverInfo:self];
}

//解绑
- (void)unbind{
    [[DataBase sharedDataBase] deleteDriverInfoByDriversfzmhm:self.driversfzmhm];
}



@end
