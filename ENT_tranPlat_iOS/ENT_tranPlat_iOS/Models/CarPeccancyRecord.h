//
//  CarPeccancyRecord.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-21.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarPeccancyRecord : NSObject

@property (nonatomic, retain)   NSString    *userId;        //标识
@property (nonatomic, retain)   NSString    *hpzl;//号牌种类
@property (nonatomic, retain)   NSString    *hphm;//号牌号码
@property (nonatomic, retain)   NSString    *jdcwf_detail;//违法信息,json串
@property (nonatomic, retain)   NSString    *jdcwf_gxsj;//违法更新时间


- (id)initWithHpzl:(NSString*)hpzl
              hphm:(NSString*)hphm
      jdcwf_detail:(NSString*)jdcwf_detail
        jdcwf_gxsj:(NSString*)jdcwf_gxsj
         andUserId:(NSString*)userId;

//更新违章信息，根据userid删除，后添加
- (void)update;

@end
