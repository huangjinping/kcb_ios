//
//  ChangyongModel.h
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 16/1/15.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangyongModel : NSObject

@property(nonatomic,copy)NSString *CanprocessMsg;
@property(nonatomic,copy)NSString *fkje;
@property (nonatomic,copy) NSString *fxjgmc;
@property(nonatomic,copy)NSString *jdsbh;
@property(nonatomic,copy)NSString *wfdz;
@property (nonatomic,copy) NSString *wfjfs;
@property(nonatomic,copy)NSString *wfnr;
@property(nonatomic,copy)NSString *wfsj;
@property (nonatomic,copy) NSString *wfxw;
@property(nonatomic,copy)NSString *wztype;


+(ChangyongModel *)modelWithDic:(NSDictionary *)dic;
@end
