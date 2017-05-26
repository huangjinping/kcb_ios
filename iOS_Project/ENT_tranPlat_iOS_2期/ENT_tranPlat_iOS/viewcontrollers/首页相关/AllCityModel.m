//
//  AllCityModel.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/10/30.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "AllCityModel.h"

@implementation AllCityModel
+(AllCityModel *)modelWithDic:(NSDictionary *)dic{
    
    
    return [[AllCityModel alloc]initWithDic:dic];
    
}
-(id)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        //NSLog(@"%@",dic);
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end
