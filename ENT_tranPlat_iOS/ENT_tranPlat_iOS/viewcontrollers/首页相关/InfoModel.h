//
//  InfoModel.h
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/10/22.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoModel : NSObject

@property(nonatomic,copy)NSString *createtime;
@property(nonatomic,strong)NSDictionary *orderInfo;
@property(nonatomic,copy)NSString *ordid;
@property(nonatomic,copy)NSString *payType;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *sumAmount;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *isdelete;
@property(nonatomic,copy)NSString *verifycode;

+(InfoModel *)modelWithDic:(NSDictionary *)dic;
@end
