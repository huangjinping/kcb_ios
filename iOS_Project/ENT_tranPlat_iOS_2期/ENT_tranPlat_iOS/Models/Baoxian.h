//
//  Baoxian.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/9.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

#define INS_CHE_SUN_CHINESE            @"机动车损失险"
#define INS_DAO_QIANG_CHINESE          @"机动车盗抢险"
#define INS_ZI_RAN_CHINESE             @"自燃损失险"
#define INS_BU_JI_CHINESE              @"不计免赔险"
#define INS_TAX_CHINESE                @"车船使用税"
#define INS_FORCE_CHINESE              @"机动车交通事故责任强制险"
#define INS_FDJX_CHINESE               @"发动机特别损失险（涉水险）"
#define INS_BO_LI_CHINESE              @"玻璃单独破碎险"
#define INS_SAN_ZHE_CHINESE            @"机动车第三者责任险"
#define INS_CHENG_KE_CHINESE           @"车上人员责任险（乘客）"
#define INS_SI_JI_CHINESE              @"车上人员责任险（司机）"
#define INS_HUA_HEN_CHINESE            @"车身划痕损失险"

#define INS_BU_JI_SANZHE_CHINESE        @"不计免赔-机动车第三者责任险"
#define INS_BU_JI_DAOQIANG_CHINESE      @"不计免赔-机动车盗抢险"
#define INS_BU_JI_SIJI_CHINESE          @"不计免赔-车上人员责任险（司机）"
#define INS_BU_JI_CHENGKE_CHINESE       @"不计免赔-车上人员责任险（乘客）"
#define INS_BU_JI_CHESUN_CHINESE        @"不计免赔-机动车损失险"
#define INS_BU_JI_FDJ_CHINESE           @"不计免赔-发动机特别损失险（涉水险）"


#define INS_KEY_SUM_PRICE            @"总价格"
#define INS_KEY_SESSION_ID            @"sessionid"

#define KEY_INS_INFO_EMAIL                              @"email"
#define KEY_INS_INFO_TEL                                @"tel"
#define KEY_INS_INFO_NAME                               @"name"
#define KEY_INS_INFO_SFZHM                              @"sfzhm"
#define KEY_INS_INFO_PROVINCE_DICT                      @"province"
#define KEY_INS_INFO_CITY_DICT                          @"city"
#define KEY_INS_INFO_REGION_DICT                        @"region"
#define KEY_INS_INFO_DETAIL_ADDR                        @"detail_address"

#define IDENTIFICATION_ADD_INS_INFO_TOUBAOREN       @"投保人"
#define IDENTIFICATION_ADD_INS_INFO_BEIBAOREN       @"被保人"
#define IDENTIFICATION_ADD_INS_INFO_CHEZHU          @"车主"
#define IDENTIFICATION_ADD_INS_INFO_DELIVER         @"收件人"




#define TAG_REN_BAO         10
#define TAG_YANG_GUANG      11
#define TAG_PING_AN         12
#define TAG_TAI_PING_YANG   13
@interface Baoxian : NSObject

@property (nonatomic)   NSString    *hphm;
@property (nonatomic)   NSString    *syr;
@property (nonatomic)   NSString    *sfzhm;
@property (nonatomic)   NSString    *vin;
@property (nonatomic)   NSString    *zcrq;
@property (nonatomic)   NSString    *fdjh;
@property (nonatomic)   NSString    *citycode;
@property (nonatomic)   NSString    *city;

@property (nonatomic)   NSArray     *pCartypeArr;
//switch
@property (nonatomic)   NSString     *ins_chesun;
@property (nonatomic)   NSString     *ins_daoqiang;
@property (nonatomic)   NSString     *ins_ziran;
@property (nonatomic)   NSString     *ins_buji;
@property (nonatomic)   NSString     *ins_forceFlag;
@property (nonatomic)   NSString     *ins_fdjx;
//choose value
@property (nonatomic)   NSString     *ins_boli;
@property (nonatomic)   NSString     *ins_sanze;
@property (nonatomic)   NSString     *ins_c_zuo;
@property (nonatomic)   NSString     *ins_s_zuo;
@property (nonatomic)   NSString     *ins_huahen;

@property (nonatomic)   NSString     *ins_boli_code;
@property (nonatomic)   NSString     *ins_sanze_code;
@property (nonatomic)   NSString     *ins_c_zuo_code;
@property (nonatomic)   NSString     *ins_s_zuo_code;
@property (nonatomic)   NSString     *ins_huahen_code;


////传值__订单
//@property (nonatomic, retain)   NSString     *dDName;
//@property (nonatomic, retain)   NSString     *dDManey;
//@property (nonatomic, retain)   NSString     *dDStata;
////投保项目
//@property (nonatomic, retain)   NSArray     *bXPro;
//
////投保人信息insuredInfo
//@property (nonatomic, retain)   NSString     *insuredName;
//@property (nonatomic, retain)   NSString     *insuredMobile;
//@property (nonatomic, retain)   NSString     *insuredIdNo;
//@property (nonatomic, retain)   NSString     *insuredaddresseeDetails;
////收件人信息deliverInfo
//@property (nonatomic, retain)   NSString     *addresseeName;
//@property (nonatomic, retain)   NSString     *addresseeMobile;
//@property (nonatomic, retain)   NSString     *addresseeDetails;
////被保人人信息applicantInfo
//@property (nonatomic, retain)   NSString     *applicantName;
//@property (nonatomic, retain)   NSString     *applicantMobile;
//@property (nonatomic, retain)   NSString     *applicantIdNo;
////车主信息ownerInfo
//@property (nonatomic, retain)   NSString     *ownerName;
//@property (nonatomic, retain)   NSString     *ownerMobile;
//@property (nonatomic, retain)   NSString     *ownerIdNo;





@property (nonatomic, strong, readonly)     NSMutableArray              *insSelectedArr;

@end
