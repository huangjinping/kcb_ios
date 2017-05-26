//
//  MyAFNetWorkingRequest.m
//  掌盟
//
//  Created by MS on 15/7/3.
//  Copyright (c) 2015年 MS. All rights reserved.
//

#import "MyAFNetWorkingRequest.h"
#import "AFHTTPRequestOperationManager.h"
@implementation MyAFNetWorkingRequest


-(id)initWithRequest:(NSString *)urlString andParams:(id)params andBlock:(AFBlock)block
{
    if (self = [super init])
    {
        if (_tempBlock != nil)
        {
            _tempBlock = nil;
        }
        _tempBlock = block;
        [self httpRequestWith:urlString andParams:(id)params];
    }
    return self;
    
    
}
-(void)httpRequestWith:(NSString *)urlString andParams:(id)params
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:self success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _tempBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}


@end
