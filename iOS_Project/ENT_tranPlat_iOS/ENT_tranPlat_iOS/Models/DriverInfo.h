//
//  DriverInfo.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-21.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DriverInfo : NSObject

@property (nonatomic, retain) NSString *userId;        //标识
@property (nonatomic, retain) NSString *driversfzmhm;//驾驶员证件号码
@property (nonatomic, retain) NSString *dabh;//档案编号
@property (nonatomic, retain) NSString *xm;//姓名
@property (nonatomic, retain) NSString *driverstatus;//驾驶证验证状态
@property (nonatomic, retain) NSString *ljjf;//累积记分
@property (nonatomic, retain) NSString *zjcx;//准驾车型
@property (nonatomic, retain) NSString *yxqz;//有效期止
@property (nonatomic, retain) NSString *zxbh;//证芯编号
@property (nonatomic, retain) NSString *drivergxsj;//驾驶证信息更新时间
@property (nonatomic, retain) NSString *djzsxxdz;//登记住所详细地址

@property (nonatomic, retain) NSString *driverzt;//驾照状态

//单用于界面(首页违章数据的)显示
@property(nonatomic,strong)NSString                         *peccancyCount;            //驾驶证违法条数
@property(nonatomic,assign)LoadingPeccancyRecordStatus      loadingPeccancyRecordStatus; //是否正在网络刷新


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
                 andUseId:(NSString*)userId;



//向数据库添加一条driver信息
- (void)add;

//解绑
- (void)unbind;

@end
