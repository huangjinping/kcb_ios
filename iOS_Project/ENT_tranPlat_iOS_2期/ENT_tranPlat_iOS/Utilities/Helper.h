//
//  Helper.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-14.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//


/******************************************************
 * 模块名称:   Helper.h
 * 模块功能:   工具类方法
 * 创建日期:   14-7-14
 * 创建作者:   闫燕
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/

#import <Foundation/Foundation.h>

#import "UserInfo.h"
#import "DriverInfo.h"
#import "CarInfo.h"
#import "CarPeccancyMsg.h"
#import "DriveLicensePeccancyMsg.h"
#import "PeccancyMsg.h"

#define KEY_FILTRATE_CAR_PECCANCY_MSGS_RESULT_PAY_MSG       @"pay"
#define KEY_FILTRATE_CAR_PECCANCY_MSGS_RESULT_DEAL_MSG      @"deal"

@interface Helper : NSObject

+ (BOOL)netAvailible;
+ (BOOL)locationServiceEnable;



#pragma mark- 违章信息过滤
+ (NSDictionary*)filtrateCarPeccancyRecordMessages:(NSArray*)carPeccancyMessages withHpzl:(NSString*)hpzl andHphm:(NSString*)hphm;



#pragma mark- 网络数据解析
+ (UserInfo*)loginAnalysisUser:(NSDictionary*)resDict withUserId:(NSString*)userId userName:(NSString*)userName andPassword:(NSString*)password;

+ (NSArray*)loginAnalysisDriver:(NSDictionary*)resDict withUserId:(NSString*)userId;

+ (NSArray*)loginAnalysisCarInfo:(NSDictionary*)resDict withUserId:(NSString*)userId;

+ (NSArray *)carPeccancyMsgAnalysis:(NSString*)jsonStr withHphm:(NSString*)hphm;

+ (NSArray *)drivePeccancyMsgAnalysis:(NSString*)jsonStr;


+ (NSArray *)jdsbhSearchPeccancyMsgAnalysis:(NSArray*)violationArr;

@end
