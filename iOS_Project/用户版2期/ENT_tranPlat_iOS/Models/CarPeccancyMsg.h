//
//  CarPeccancyDetail.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-23.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarPeccancyMsg : NSObject
/*
 {
 "datasource":"01",
 "vehicles":[
 {
 "xh":"5304017900206538",
 "fkje":"150",
 "fltw":"《中华人民共和国道路交通安全法》第九十条、《云南省道路交通安全条例》第七十九条第(六)项",
 "lddm":"",
 
 
 "wfxw":"1625",
 "fxjgmc":"玉溪市公安局交警支队直属大队",
 "cjjg":"530401000000",
 "wztype":"非现场",
 
 "wfdz":"红塔大道与明珠路交叉口",
 "wfsj":"2014-04-02 23:59:57.0",
 "wfjfs":6,
 "cjjgmc":"玉溪市公安局交警支队直属大队",
 "cjfs":"1",
 "ddms":"",
 "wfdd":"60103",
 "wfgd":"《中华人民共和国道路交通安全法》第三十八条、《中华人民共和国道路交通安全法实施条例》第三十八条、四十条、四十一、四十二、四十三条",
 "wfms":"驾驶机动车违反道路交通信号灯通行的",
 "wfnr":"驾驶机动车违反道路交通信号灯通行的",
 "qrbj":1,
 "cfd":"云南",
 "wzzt":"未确认",
 "sd":"云南"
 },
 {
 "jszh":"532224197811091110",
 "clsj":"2014-04-11 11:45:52.0",
 "fkje":50,
 "fltw":"《中华人民共和国道路交通安全法》第九十条；《云南省道路交通安全条例》第七十七条第（二）项",
 "xxly":"1",
 "wfxw":"1018",
 "fxjgmc":"昆明市公安局交通警察支队八大队事故中队",
 "jdsbh":"530192190106683",
 "dsr":"柴国超",
 "wfdz":"彩云北路与昌宏路交叉路口南口",
 "wfsj":"2014-04-11 11:45:52.0",
 "wfjfs":0,
 "cljg":"530192000300",
 "wfdd":"60001",
 "cljgmc":"昆明市公安局交通警察支队八大队事故中队",
 "wsjyw":"8",
 "fxjg":"530192000300",
 "wfgd":"《中华人民共和国道路交通安全法》第三十六条",
 "znj":0,
 "wfms":"机动车不走机动车道",
 "wfnr":"机动车不在机动车道内行驶的",
 "wzzt":"已确认",
 "sd":"云南"
 }
 ],
 "count":2,
 "yxqz":"2014-03-31",
 "bxzzrq":"2014-03-17",
 "云AM222F":"0,货运,轻型仓栅式货车,,532224197811091110,柴国超"
 }
 
 
 
 有时有，有时无
wfdd1   lddm1   ddms1   wfsj1
 
 */

@property (nonatomic, retain)   NSString    *xh;
@property (nonatomic, retain)   NSString    *fkje;
@property (nonatomic, retain)   NSString    *fltw;
@property (nonatomic, retain)   NSString    *lddm;
@property (nonatomic, retain)   NSString    *lddm1;

@property (nonatomic, retain)   NSString    *wfxw;
@property (nonatomic, retain)   NSString    *fxjgmc;
@property (nonatomic, retain)   NSString    *cjjg;
@property (nonatomic, retain)   NSString    *dsr;
@property (nonatomic, retain)   NSString    *wztype;
@property (nonatomic, retain)   NSString    *wfdz;
@property (nonatomic, retain)   NSString    *wfsj;
@property (nonatomic, retain)   NSString    *wfsj1;

@property (nonatomic, retain)   NSString    *wfjfs;
@property (nonatomic, retain)   NSString    *cjjgmc;
@property (nonatomic, retain)   NSString    *cjfs;
@property (nonatomic, retain)   NSString    *dh;
@property (nonatomic, retain)   NSString    *ddms;
@property (nonatomic, retain)   NSString    *ddms1;

@property (nonatomic, retain)   NSString    *wfdd;
@property (nonatomic, retain)   NSString    *wfdd1;

@property (nonatomic, retain)   NSString    *wfgd;
@property (nonatomic, retain)   NSString    *wfms;
@property (nonatomic, retain)   NSString    *wfnr;
@property (nonatomic, retain)   NSString    *qrbj;
@property (nonatomic, retain)   NSString    *cfd;
@property (nonatomic, retain)   NSString    *wzzt;
@property (nonatomic, retain)   NSString    *sd;

@property (nonatomic, retain)   NSString    *datasource;
@property (nonatomic, retain)   NSString    *count;
@property (nonatomic, retain)   NSString    *yxqz;
@property (nonatomic, retain)   NSString    *bxzzrq;

@property (nonatomic, retain)   NSString    *znj;
@property (nonatomic, retain)   NSString    *jdsbh;
@property (nonatomic, retain)   NSString    *fxjg;
@property (nonatomic, retain)   NSString    *cljg;
@property (nonatomic, retain)   NSString    *cljgmc;
@property (nonatomic, retain)   NSString    *wsjyw;



// "云AM222F":"0,货运,轻型仓栅式货车,,532224197811091110,柴国超"
@property (nonatomic, retain)   NSString    *hphm_head;
@property (nonatomic, retain)   NSString    *syxz;
@property (nonatomic, retain)   NSString    *cllx;
@property (nonatomic, retain)   NSString    *dsrdz;
@property (nonatomic, retain)   NSString    *sfzmhm;
@property (nonatomic, retain)   NSString    *dsr_jsonLastStr;


/*
 android.do  list方法返回照片状态
 张彦明(910780237)  15:59:11
 listall返回的非现场结果增加photostatus字段：
 1:有照片可查看－－－查看
 2:无照片未申请－－－申请
 3:无照片申请中－－－等待
 4:无照片申请成功－－－无法查看
 5:无照片申请失败－－－重新申请

 */
@property (nonatomic, retain)   NSString    *photostatus;



@property (nonatomic, retain)   NSString    *jszh;
@property (nonatomic, retain)   NSString    *clsj;

@end
