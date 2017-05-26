//
//  PingzhengViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/5/29.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PingzhengViewController : BasicViewController

/*
 --"cljgmc":"涪陵区公安局交通巡逻警察支队第八勤务大队",
 --"jdsbh":"500200100299912",
 --"wsjyw":"9",

 "dsr":"",---只有云南哟
-- "jszh":"522132198109275419",
 车牌、车辆类型取自车辆信息
 
 --"wfsj":"2015-05-26 11:35:00.0",
 --"wfdz":"增银大道",
 --"wfnr":"在高速公路或城市快速路以外的道路上行驶时，驾驶人未按规定使用安全带的",
 -- "wfxw":"60112",

 --"wfgd":"《中华人民共和国道路交通安全法》第五十一条",
 --"fltw":"《中华人民共和国道路交通安全法》第九十条",
 --"fkje":200,
 --"znj":0  要不要显示？
 --"wfjfs":0,
 --"clsj":"2015-05-26 11:35:00.0",

 
 */
- (id)initWithCljg:(NSString*)cljg
               jdsbh:(NSString*)jdsbh
               wsjyw:(NSString*)wsjyw
                 dsr:(NSString*)dsr
                jszh:(NSString*)jszh
                wfsj:(NSString*)wfsj
                wfdz:(NSString*)wfdz
                wfnr:(NSString*)wfnr
                wfxw:(NSString*)wfxw
                wfgd:(NSString*)wfgd
                fltw:(NSString*)fltw
                fkje:(NSString*)fkje
                 znj:(NSString*)znj
               wfjfs:(NSString*)wfjfs
                clsj:(NSString*)clsj
                cphm:(NSString*)cphm
             andHpzl:(NSString*)hpzl;

@end
