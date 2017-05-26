//
//  HCarModel.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/12.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "BaseEntity.h"

@interface HCarModel : BaseEntity

@property (nonatomic, strong)NSString *LicenseCode;
@property (nonatomic, strong)NSString *carName;
@property (nonatomic, strong)NSString *carModelId;
@property (nonatomic, strong)NSString *carModelName;
@property (nonatomic, strong)NSString *clsbdh;
@property (nonatomic, strong)NSString *runTime;
@property (nonatomic, strong)NSString *travelMileage;

@end
