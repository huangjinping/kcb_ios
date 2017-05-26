//
//  AllCityModel.h
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/10/30.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllCityModel : NSObject

@property(nonatomic,copy)NSString *cityId;
@property(nonatomic,copy)NSString *cityName;
@property(nonatomic,copy)NSString *provId;
@property(nonatomic,copy)NSString *provName;
+(AllCityModel *)modelWithDic:(NSDictionary *)dic;
@end
