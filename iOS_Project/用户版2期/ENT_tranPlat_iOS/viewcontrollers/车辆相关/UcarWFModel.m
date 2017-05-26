//
//  UcarWFModel.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 16/1/18.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "UcarWFModel.h"

@implementation UcarWFModel
+(UcarWFModel *)modelWithDic:(NSDictionary *)dic{
    
    
    return [[UcarWFModel alloc]initWithDic:dic];
    
}
-(id)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        //NSLog(@"%@",dic);
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end
