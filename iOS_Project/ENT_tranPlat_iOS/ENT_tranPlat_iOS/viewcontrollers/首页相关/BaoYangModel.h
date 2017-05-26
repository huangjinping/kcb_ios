//
//  BaoYangModel.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/9/15.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//


#import "JSONModel.h"
#import "BaoYangServiewModel.h"
@interface BaoYangModel : JSONModel


/****************car信息*********************/
@property (nonatomic)   NSString    *hphm;
@property (nonatomic)   NSString    *vin;
@property (nonatomic)   NSString    *zcrq;
@property (nonatomic)   NSString    *fdjh;
@property (nonatomic)   NSString    *city;
@property (nonatomic,assign)   float    sczd;
@property (nonatomic,assign)   long    xxlc;
@property (nonatomic) NSString *carImageUrl;

/****************store信息*********************/
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *name;//商户名称
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *id;//商户ID
@property(nonatomic,copy)NSString *cityName;
@property(nonatomic,copy)NSString *shopType;//商户类型
@property(nonatomic,copy)NSString *contacts;
@property(nonatomic,copy)NSString *titlePic;
@property(nonatomic,copy)NSString *des;
@property(nonatomic,copy)NSString *createtime;
@property(nonatomic,copy)NSString *grade;
@property(nonatomic,copy)NSString *opentime;
@property(nonatomic,copy)NSString *closetime;
@property(nonatomic,copy)NSString *loginName;
@property(nonatomic,copy)NSString *loginPassword;
@property(nonatomic,copy)NSString *ext1Int;
@property(nonatomic,copy)NSString *longitude;
@property(nonatomic,copy)NSString *latitude;

/****************服务项目*********************/
@property (nonatomic, copy) NSString * extInt1;//服务分类ID
//@property (nonatomic, copy) NSString *sevId;
@property (nonatomic, copy) NSString *packagename;//服务名称
@property (nonatomic, copy) NSString *totalPrivce;//服务价格
@property (nonatomic, assign) BOOL isdelete;
@property (nonatomic, copy) NSArray<BaoYangServiewModel>  *serviceItemList;//服务项目
//传值用
@property (nonatomic, strong) NSMutableArray *seletedSevArr;//选中的小服务项目数组
@property (nonatomic, strong) NSMutableArray *seletedPacegeArr;//选中的大服务项目数组
@property (nonatomic, assign) float           selectedAllPrice;
@property (nonatomic, assign) BOOL            isDefaultSelected;

/****************预约时间*********************/
@property (nonatomic, copy) NSString *peopleName;
@property (nonatomic, copy) NSString *peoplePhone;
@property (nonatomic, copy) NSString *peopleDate;
@property (nonatomic, copy) NSString *peopleTime;


@end
