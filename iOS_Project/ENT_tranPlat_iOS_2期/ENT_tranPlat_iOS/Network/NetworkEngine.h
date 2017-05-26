//
//  NetworkEngine.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 15/12/24.
//  Copyright © 2015年 ___ENT___. All rights reserved.
//

#import "MKNetworkEngine.h"

typedef NS_ENUM(NSInteger,ResultState) {
    PostSuccess,
    PostFailed
};
@interface NetworkEngine : MKNetworkEngine


+(NetworkEngine *)sharedNetwork;

- (MKNetworkOperation *)postBody:(NSDictionary *)body
                         apiPath:(NSString *)apiPath
                          finish:(void(^)(ResultState,id))finish
                          failed:(MKNKErrorBlock)error;

@end
