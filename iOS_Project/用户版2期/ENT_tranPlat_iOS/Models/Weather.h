//
//  Weather.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/10.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject



//1、temp     (温度)
//2、des  （描述）
//3、detail（详情）
//4、logoUrl （图标地址）
//5、xiche    (洗车指数)
//6、other     (其他)

@property (nonatomic, retain)     NSString    *temp;
@property (nonatomic, retain)     NSString    *des;
@property (nonatomic, retain)     NSString    *detail;
@property (nonatomic, retain)     NSString    *logoUrl;
@property (nonatomic, retain)     NSString    *xiche;
@property (nonatomic, retain)     NSString    *updateTime;
@property (nonatomic, retain)     NSString    *other;


- (id)initWithTemp:(NSString*)temp
               des:(NSString*)des
            detail:(NSString*)detail
           logoUrl:(NSString*)logoUrl
             xiche:(NSString*)xiche
        updateTime:(NSString*)updateTime
             other:(NSString*)other;


- (void)updateToDB;
@end
