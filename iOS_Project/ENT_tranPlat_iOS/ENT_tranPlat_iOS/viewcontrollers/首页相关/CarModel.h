//
//  CarModel.h
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/11/2.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject

@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *initial;
@property (nonatomic, copy) NSString *name;

+(CarModel *)modelWithDic:(NSDictionary *)dic;
@end
