//
//  SHModel.h
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/10/12.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHModel : NSObject
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *cityName;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *contacts;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *titlePic;
@property(nonatomic,copy)NSString *des;
@property(nonatomic,copy)NSString *createtime;
@property(nonatomic,copy)NSString *isdelete;
@property(nonatomic,assign)int grade;
@property(nonatomic,copy)NSString *opentime;
@property(nonatomic,copy)NSString *closetime;
@property(nonatomic,copy)NSString *loginName;
@property(nonatomic,copy)NSString *loginPassword;
@property(nonatomic,copy)NSString *shopType;
@property(nonatomic,copy)NSString *ext1Int;
@property(nonatomic,copy)NSString *longitude;
@property(nonatomic,copy)NSString *latitude;
+(SHModel *)modelWithDic:(NSDictionary *)dic;

@end
