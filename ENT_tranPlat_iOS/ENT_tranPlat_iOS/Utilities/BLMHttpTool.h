//
//  BLMHttpTool.h
//  whiteHorse
//
//  Created by zsx on 15/4/27.
//  Copyright (c) 2015年 lanchong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HttpSuccess)(id json);
typedef void(^HttpFailure)(NSError* error);

@interface BLMHttpTool : NSObject

+(void)postWithURL:(NSString*)url params:(id)params success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)getWithURL:(NSString*)url params:(NSDictionary*)params success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)kcbgetWithURL:(NSString*)url params:(NSDictionary*)params success:(HttpSuccess)success failure:(HttpFailure)failure;
@end
