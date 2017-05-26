//
//  MEOrderInfo.m
//  Merchant
//
//  Created by Wendy on 16/1/5.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import "MEOrderInfo.h"

@implementation MEOrderInfo


+ (NSDictionary *)objectClassInArray{
    return @{@"evaluationList" : [Evaluationlist class], @"suborderdetailList" : [Suborderdetaillist class], @"suborder" : [Suborder class], @"serviceList" : [Servicelist class]};
}
@end


@implementation Order

+ (NSDictionary *)objectClassInArray{
    return @{@"consumer" : [Consumer class]};
}
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ids":@"id"};
}

@end


@implementation Consumer
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ids":@"id"};
}

@end


@implementation Evaluationlist

+ (NSDictionary *)objectClassInArray{
    return @{@"evaluationpicList" : [Evaluationpiclist class]};
}
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ids":@"id"};
}

@end


@implementation Evaluationpiclist
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ids":@"id"};
}

@end


@implementation Suborderdetaillist
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ids":@"id"};
}
@end


@implementation Suborder
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ids":@"id"};
}

@end


@implementation Servicelist

+ (NSDictionary *)objectClassInArray{
    return @{@"suborderdetail" : [Suborderdetail class]};
}
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ids":@"id"};
}

@end


@implementation Suborderdetail
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ids":@"id"};
}

@end


