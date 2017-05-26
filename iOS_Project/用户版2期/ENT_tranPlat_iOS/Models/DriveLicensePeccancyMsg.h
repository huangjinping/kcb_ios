//
//  DriverLicensePeccancyRecord.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-23.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DriveLicensePeccancyMsg  : NSObject
/*
 {
 "violationhis":[
 {
 "fkje":100,
 "hphm":"渝FP5678",
 "wfxw":"10392",
 "fxjgmc":"重庆市万州区公安局交通巡逻警察支队高笋塘大队",
 "jdsbh":"504500190017025",
 "dsr":"刀建林",
 "wztype":"非现场",
 "jkbj":"0",
 "wfdz":"沙龙路武警医院路口",
 "wfsj":"2014-04-09 18:08:00.0",
 "wfjfs":0,
 "cljg":"504500000000",
 "wfdd":"60008",
 "cljgmc":"重庆市公安局交通巡逻警察总队特勤支队",
 "wsjyw":"0",
 "wfms":"无法获取10392描述信息",
 "wfnr":"无法获取10392内容信息"
 },
 {
 "fkje":20,
 "hphm":"渝FP5678",
 "wfxw":"10391",
 "fxjgmc":"重庆市云阳县公安局交通巡逻警察大队秩序中队",
 "jdsbh":"504500190017026",
 "dsr":"刀建林",
 "wztype":"非现场",
 "jkbj":"0",
 "wfdz":"云江大道路段",
 "wfsj":"2013-07-24 16:25:00.0",
 "wfjfs":0,
 "cljg":"504500000000",
 "wfdd":"65101",
 "cljgmc":"重庆市公å安局交通巡逻警察总队特勤支队",
 "wsjyw":"1",
 "wfms":"无法获取10391描述信息",
 "wfnr":"无法获取10391内容信息"
 },
 {
 "fkje":150,
 "hphm":"云KH6806",
 "wfxw":"1625A",
 "fxjgmc":"西双版纳州景洪市公安局交通警察大队",
 "jdsbh":"532801160173459",
 "dsr":"刀建林",
 "wztype":"未知",
 "jkbj":"1",
 "wfdz":"勐海路与滨江路交叉口",
 "wfsj":"2014-11-15 07:57:00.0",
 "wfjfs":0,
 "cljg":"532801000000",
 "wfdd":"60010",
 "cljgmc":"云南省西双版纳州景洪市公安局交通警察大队",
 "wsjyw":"6",
 "fxjg":"532801000000",
 "znj":0,
 "wfms":"驾驶机动车违反道路交通信号灯通行的",
 "wfnr":"驾驶机动车违反道路交通信号灯通行的"
 }
 ],
 "datasource":"01"
 }
 */

/*
--"cljgmc":"涪陵区公安局交通巡逻警察支队第八勤务大队",
--"jdsbh":"500200100299912",
--"wsjyw":"9",

"dsr":"",---只有云南哟
-- "jszh":"522132198109275419",=====无
车牌、
 车辆类型====无

--"wfsj":"2015-05-26 11:35:00.0",
--"wfdz":"增银大道",
--"wfnr":"在高速公路或城市快速路以外的道路上行驶时，驾驶人未按规定使用安全带的",
-- "wfxw":"60112",

--"wfgd":"《中华人民共和国道路交通安全法》第五十一条",=====无
--"fltw":"《中华人民共和国道路交通安全法》第九十条",====无
--"fkje":200,
--"znj":0  要不要显示？
--"wfjfs":0,
--"clsj":"2015-05-26 11:35:00.0",=====无


*/


@property (nonatomic, retain)   NSString    *fkje;
@property (nonatomic, retain)   NSString    *hphm;
@property (nonatomic, retain)   NSString    *wfxw;
@property (nonatomic, retain)   NSString    *fxjgmc;
@property (nonatomic, retain)   NSString    *jdsbh;
@property (nonatomic, retain)   NSString    *dsr;
@property (nonatomic, retain)   NSString    *jkbj;
@property (nonatomic, retain)   NSString    *wfdz;
@property (nonatomic, retain)   NSString    *wfsj;
@property (nonatomic, retain)   NSString    *wfjfs;
@property (nonatomic, retain)   NSString    *wfdd;
@property (nonatomic, retain)   NSString    *fxjg;
@property (nonatomic, retain)   NSString    *znj;
@property (nonatomic, retain)   NSString    *wfms;
@property (nonatomic, retain)   NSString    *wfnr;
@property (nonatomic, retain)   NSString    *datasource;

@end
