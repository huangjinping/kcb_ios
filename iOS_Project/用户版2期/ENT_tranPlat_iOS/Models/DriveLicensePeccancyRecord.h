//
//  DriveLicensePeccancyRecord.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-21.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DriveLicensePeccancyRecord : NSObject



@property (nonatomic, retain)   NSString    *userId;        //标识
@property (nonatomic, retain)   NSString    *driversfzmhm;//驾驶员证件号码
@property (nonatomic, retain)   NSString    *jszwf_detail;//违法信息，json串
@property (nonatomic, retain)   NSString    *jszwf_gxsj;//违法更新时间


- (id)initWithDriversfzmhm:(NSString*)driversfzmhm
              jszwf_detail:(NSString*)jszwf_detail
                jszwf_gxsj:(NSString*)jszwf_gxsj
                  andUseId:(NSString*)userId;


//更新违章信息，根据userid删除，后添加
- (void)update;
@end
