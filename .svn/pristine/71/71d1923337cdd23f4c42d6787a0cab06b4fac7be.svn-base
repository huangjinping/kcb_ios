

//
//  NetworkEngine.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 15/12/24.
//  Copyright © 2015年 ___ENT___. All rights reserved.
//

#import "NetworkEngine.h"

@implementation NetworkEngine

+ (NetworkEngine*)sharedNetwork{
    static NetworkEngine *network;
    __block NSString *host = nil;
    
    @synchronized(self){
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            if (ENT_DEBUG) {
                host = @"new.956122.com";
            }else{
                host = @"yetapi.956122.com";
            }
            network = [[NetworkEngine alloc]initWithHostName:host customHeaderFields:nil];
        });
    }
    
    return network;
}

- (MKNetworkOperation *)postBody:(NSDictionary *)body
                         apiPath:(NSString *)apiPath
                          finish:(void (^)(ResultState, id))finish
                          failed:(MKNKErrorBlock)errorBlock{
    
    MKNetworkOperation *operation = [self operationWithPath:apiPath params:body httpMethod:@"POST"];
    operation.postDataEncoding = MKNKPostDataEncodingTypeJSON;
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString *resposeStr = completedOperation.responseString;
        id responseDic = completedOperation.responseJSON;
        finish(PostSuccess,responseDic);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    
    [self enqueueOperation:operation];
    
    return operation;
}

@end
