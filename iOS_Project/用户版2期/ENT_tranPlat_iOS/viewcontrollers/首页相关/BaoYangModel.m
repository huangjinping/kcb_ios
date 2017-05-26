//
//  BaoYangModel.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/9/15.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BaoYangModel.h"

@implementation BaoYangModel
//这个方法的作用是:系统方法,让没有使用的属性变成可选
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end
