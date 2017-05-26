//
//  BaoYangServiewModel.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/9/15.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "JSONModel.h"
@protocol BaoYangServiewModel

@end

@interface BaoYangServiewModel : JSONModel
@property (nonatomic, copy) NSString * ext1Int;//服务分类ID
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *id;//服务ID
@property (nonatomic, assign) BOOL isdelete;
@end
