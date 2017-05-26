//
//  MyAFNetWorkingRequest.h
//  掌盟
//
//  Created by MS on 15/7/3.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AFBlock)(NSData *requestData);

@interface MyAFNetWorkingRequest : NSObject

@property(nonatomic,strong) AFBlock tempBlock;

-(id)initWithRequest:(NSString *)urlString andParams:(id)params  andBlock:(AFBlock)block;

@end
