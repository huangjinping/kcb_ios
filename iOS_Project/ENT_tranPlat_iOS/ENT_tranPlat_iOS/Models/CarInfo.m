//
//  CarInfo.m
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-7-18.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "CarInfo.h"

@implementation CarInfo

- (id)initWithHpzl:(NSString *)hpzl
          hpzlname:(NSString *)hpzlname
              hphm:(NSString *)hphm
            clsbdh:(NSString *)clsbdh
             clpp1:(NSString *)clpp1
   vehicletypename:(NSString *)vehicletypename
        vehiclepic:(NSString *)vehiclepic
     vehiclestatus:(NSString *)vehiclestatus
              yxqz:(NSString *)yxqz
            bxzzrq:(NSString *)bxzzrq
            ccdjrq:(NSString *)ccdjrq
       vehiclegxsj:(NSString *)vehiclegxsj
          isupdate:(NSString *)isupdate
        createTime:(NSString *)createTime
                zt:(NSString *)zt
            sfzmhm:(NSString *)sfzmhm
               syr:(NSString *)syr
              fdjh:(NSString *)fdjh
          andUseId:(NSString*)userId
{
    if (self = [super init]) {
        _hpzl = [[NSString alloc] initWithString:hpzl];
        _hpzlname = [[NSString alloc] initWithString:hpzlname];
        _hphm = [[NSString alloc] initWithString:hphm];
        _clsbdh = [[NSString alloc] initWithString:clsbdh];
        _clpp1 = [[NSString alloc] initWithString:clpp1];
        _vehicletypename = [[NSString alloc] initWithString:vehicletypename];
        _vehiclepic = [[NSString alloc] initWithString:vehiclepic];
        _vehiclestatus = [[NSString alloc] initWithString:vehiclestatus];
        _yxqz = [[NSString alloc] initWithString:yxqz];
        _bxzzrq = [[NSString alloc] initWithString:bxzzrq];
        _ccdjrq = [[NSString alloc] initWithString:ccdjrq];
        _vehiclegxsj = [[NSString alloc] initWithString:vehiclegxsj];
        _isupdate = [[NSString alloc] initWithString:isupdate];
        _createTime = [[NSString alloc]initWithString:createTime];
        _userId = [[NSString alloc] initWithString:userId];
        
        _zt = [[NSString alloc] initWithString:zt];
        _sfzmhm = [[NSString alloc] initWithString:sfzmhm];
        _syr = [[NSString alloc] initWithString:syr];
        _fdjh = [[NSString alloc] initWithString:fdjh];
        
    }
    return self;
}


//向数据库添加一条car信息
- (void)add{
    [[DataBase sharedDataBase] insertCarInfo:self];
}

//解绑
- (void)unbind{
    [[DataBase sharedDataBase] deleteCarInfoByHphm:self.hphm andUserId:APP_DELEGATE.userId];
}



@end
