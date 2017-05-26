//
//  SHModel.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/10/12.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "SHModel.h"

@implementation SHModel
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"Id":@"id",
             };
}
+(SHModel *)modelWithDic:(NSDictionary *)dic{
    
    
    return [[SHModel alloc]initWithDic:dic];
    
}
-(id)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        //NSLog(@"%@",dic);
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end
