//
//  BLMHttpTool.m
//  whiteHorse
//
//  Created by zsx on 15/4/27.
//  Copyright (c) 2015年 lanchong. All rights reserved.
//

#import "BLMHttpTool.h"
#import "AFNetworking.h"

@implementation BLMHttpTool

+(void)postWithURL:(NSString*)url params:(id)params success:(HttpSuccess)success failure:(HttpFailure)failure
{
    AFHTTPRequestOperationManager* operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/plain",@"application/json",@"text/html",nil];
    [operationManager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
   // ENTLog(@"%@",[responseObject class]);
        if (success) {
            id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       

            //NSLog(@"%@",json);
            success(json);
         
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
            //ENTLog(@"%@",[error description]);
        }
    }];
  
}

+(void)getWithURL:(NSString*)url params:(id)params success:(HttpSuccess)success failure:(HttpFailure)failure
{
    AFHTTPRequestOperationManager* operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/plain",@"application/json",@"text/html",nil];
    [operationManager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
           // NSLog(@"%@",responseObject);
            id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
       //    ENTLog(@"%@",[error description]);
        }
    }];
    
}
+(void)kcbgetWithURL:(NSString*)url params:(id)params success:(HttpSuccess)success failure:(HttpFailure)failure
{
    AFHTTPRequestOperationManager* operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/plain",@"application/json",@"text/html",nil];
    [operationManager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            // NSLog(@"%@",responseObject);
            id json =responseObject;
            
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
            //    ENTLog(@"%@",[error description]);
        }
    }];
    
}

@end
