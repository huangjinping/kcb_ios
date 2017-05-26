//
//  ZhaohuiMsg.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/5/18.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhaohuiMsg : NSObject


@property (nonatomic, retain)       NSString *brand;
@property (nonatomic, retain)       NSString *   cartype;
@property (nonatomic, retain)       NSString *   dealway;
@property (nonatomic, retain)       NSString *   id_fanhui;
@property (nonatomic, retain)       NSString *   method;
@property (nonatomic, retain)       NSString *   period;
@property (nonatomic, retain)       NSString *   reason;
@property (nonatomic, retain)       NSString *   result;
@property (nonatomic, retain)       NSString *   clsbdh;


- (id)initWithBrand:(NSString*)brand
            cartype:(NSString*)cartype
            dealway:(NSString *)dealway
          id_fanhui:(NSString *)id_fanhui
             method:(NSString *)method
             period:(NSString *)period
             reason:(NSString *)reason
             result:(NSString *)result
             clsbdh:(NSString *)clsbdh;

- (void)updateToDB;

@end
