   //
//  Baoxian.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/9.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "Baoxian.h"

@implementation Baoxian


- (id)init{
    if (self =  [super init]) {
        _pCartypeArr = [NSArray arrayWithObjects: nil];
        
        _ins_chesun = @"0";
        _ins_daoqiang = @"0";
        _ins_ziran = @"0";
        _ins_buji = @"0";
        _ins_forceFlag = @"0";
        _ins_fdjx = @"0";
        
        _ins_boli = @"不投保";
        _ins_sanze = @"不投保";
        _ins_c_zuo = @"不投保";
        _ins_s_zuo = @"不投保";
        _ins_huahen = @"不投保";
        
        _ins_boli_code = @"0";
        _ins_sanze_code = @"0";
        _ins_c_zuo_code = @"0";
        _ins_s_zuo_code = @"0";
        _ins_huahen_code = @"0";

        _insSelectedArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)count{
    //count
    //int count = 0;
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:0];
    if (![self.ins_chesun isEqualToString:@"0"]) {
        //count ++;
        [tempArr addObject:INS_CHE_SUN_CHINESE];
    }
    if (![self.ins_daoqiang isEqualToString:@"0"]) {
        //count ++;
        [tempArr addObject:INS_DAO_QIANG_CHINESE];

    }
    if (![self.ins_ziran isEqualToString:@"0"]) {
        //count ++;
        [tempArr addObject:INS_ZI_RAN_CHINESE];

    }
    if (![self.ins_buji isEqualToString:@"0"]) {
        //count ++;
        [tempArr addObject:INS_BU_JI_CHINESE];

    }
    if (![self.ins_forceFlag isEqualToString:@"0"]) {
        //count = count + 2;
        [tempArr addObject:INS_FORCE_CHINESE];
        [tempArr addObject:INS_TAX_CHINESE];

    }
    if (![self.ins_fdjx isEqualToString:@"0"]) {
        //count ++;
        [tempArr addObject:INS_FDJX_CHINESE];

    }
    if (![self.ins_boli_code isEqualToString:@"0"]) {
        //count ++;
        [tempArr addObject:[NSString stringWithFormat:@"%@(%@)",INS_BO_LI_CHINESE, self.ins_boli]];

    }
    if (![self.ins_sanze_code isEqualToString:@"0"]) {
        //count ++;
        [tempArr addObject:[NSString stringWithFormat:@"%@(%@)",INS_SAN_ZHE_CHINESE, self.ins_sanze]];

    }
    if (![self.ins_c_zuo_code isEqualToString:@"0"]) {
        //count ++;
        [tempArr addObject:[NSString stringWithFormat:@"%@(%@)",INS_CHENG_KE_CHINESE, self.ins_c_zuo]];

    }
    if (![self.ins_s_zuo_code isEqualToString:@"0"]) {
        //count ++;
        [tempArr addObject:[NSString stringWithFormat:@"%@(%@)",INS_SI_JI_CHINESE, self.ins_s_zuo]];

    }
    if (![self.ins_huahen_code isEqualToString:@"0"]) {
        //count ++;
        [tempArr addObject:[NSString stringWithFormat:@"%@(%@)",INS_HUA_HEN_CHINESE, self.ins_huahen]];

    }
    //_ins_count = count;
    _insSelectedArr = [NSMutableArray arrayWithArray:tempArr];
}

- (void)setIns_chesun:(NSString *)ins_chesun{
    _ins_chesun = [[NSString alloc] initWithString:ins_chesun];
    [self count];
}

- (void)setIns_daoqiang:(NSString *)ins_daoqiang{
    _ins_daoqiang = [[NSString alloc] initWithString:ins_daoqiang];
    [self count];
}

- (void)setIns_ziran:(NSString *)ins_ziran{
    _ins_ziran = [[NSString alloc] initWithString:ins_ziran];
    [self count];
}

- (void)setIns_buji:(NSString *)ins_buji{
    _ins_buji = [[NSString alloc] initWithString:ins_buji];
    [self count];
}

- (void)setIns_forceFlag:(NSString *)ins_forceFlag{
    _ins_forceFlag = [[NSString alloc] initWithString:ins_forceFlag];
    [self count];
}

- (void)setIns_fdjx:(NSString *)ins_fdjx{
    _ins_fdjx = [[NSString alloc] initWithString:ins_fdjx];
    [self count];
}

- (void)setIns_boli_code:(NSString *)ins_boli_code{
    _ins_boli_code = [[NSString alloc] initWithString:ins_boli_code];
    [self count];
}

- (void)setIns_sanze_code:(NSString *)ins_sanze_code{
    _ins_sanze_code = [[NSString alloc] initWithString:ins_sanze_code];
    [self count];
}

- (void)setIns_c_zuo_code:(NSString *)ins_c_zuo_code{
    _ins_c_zuo_code = [[NSString alloc] initWithString:ins_c_zuo_code];
    [self count];
}

- (void)setIns_s_zuo_code:(NSString *)ins_s_zuo_code{
    _ins_s_zuo_code = [[NSString alloc] initWithString:ins_s_zuo_code];
    [self count];
}

- (void)setIns_huahen_code:(NSString *)ins_huahen_code{
    _ins_huahen_code = [[NSString alloc] initWithString:ins_huahen_code];
    [self count];
}


@end
