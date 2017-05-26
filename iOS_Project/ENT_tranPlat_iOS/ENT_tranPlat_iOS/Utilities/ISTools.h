//
//  ISTools.h
//  iovsp
//
//  Created by 张召岳 on 15/7/29.
//  Copyright (c) 2015年 shenguodian. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Instance_ENT [ISTools shanreIovspInstance]

@interface ISTools : NSObject

@property (nonatomic,strong)NSMutableDictionary * dataDictionary;


@property (nonatomic,strong)NSString * IS_lat;
@property (nonatomic,strong)NSString * IS_lon;

// 创建单例
+(instancetype)shanreIovspInstance;


// 无代理AlertView
-(void)showAlertViewTitle:(NSString*)title;

// 其他类型转换字符串
-(NSString*)stringWithData:(NSObject*)data;

// label某一个特殊字体
-(NSDictionary*)myCustomLabel;

// 自适应高度
//-(CGFloat)TheAdaptive:(NSString*)string font:(CGFloat)font width:(CGFloat)width;

// 字典转换成字符串
- (NSString *)dictionaryToJson:(NSDictionary *)dic;
// json串转换成字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

// 通过经纬度算出两点距离
-(NSString*)getKilometersWithOneLat:(NSString*)ontLat oneLon:(NSString*)ontLon  andWithTwoLat:(NSString*)twoLat withTwoLon:(NSString*)twoLon;

// 获取名字 和 Scheme
- (NSString *)getApplicationName;
- (NSString *)getApplicationScheme;

@end
