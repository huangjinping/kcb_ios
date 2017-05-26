//
//  Network.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-14.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

/******************************************************
 * 模块名称:   Network.h
 * 模块功能:   网络请求
 * 创建日期:   14-7-14
 * 创建作者:   闫燕
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"
#import "SBJson.h"
#import "MBProgressHUD.h"

typedef enum{
    postSucc = 1,
    postFailed = 0
} PostResult;



typedef enum{
    loadingPeccancyRecordSucc = 0,
    loadingPeccancyRecordFailed = 1,
    isloadingPeccancyRecord = 2
} LoadingPeccancyRecordStatus;
    
    
@interface Network : MKNetworkEngine




+ (Network*)sharedNetwork;


/*****************************************************************************
 ** 功能:     向服务器发送信息
 ** 参数:     NSMutableDictionary 信息字典；BOOL 返回信息是否为json数据；
             PostParamsFinishedBlock 请求完成block，参数参照PostParamsFinishedBlock定义
             MKNKErrorBlock 请求失败，错误信息block，参数参照MKNKErrorBlock定义
 ** 返回:     MKNetworkOperation
 *****************************************************************************/
typedef void (^ENT_PostParamsFinishedBlock)(PostResult result, id requestObj, NSObject *callBackObj);
typedef void (^ENT_NetwokErrorBlock)(NSString *errorStr);
-(MKNetworkOperation*)postBody:(NSMutableDictionary*)body isResponseJson:(BOOL)isResJson doShowIndicator:(BOOL)showIndicator callBackWithObj:(NSObject*)obj onCompletion:(ENT_PostParamsFinishedBlock)postParamsFinishedBlock onError:(ENT_NetwokErrorBlock)errorBlock;

///*****************************************************************************
// ** 功能:     向服务器发送信息(弥补上个网络请求无path的情况)
// ** 参数:     NSMutableDictionary 信息字典；BOOL 返回信息是否为json数据；
// PostParamsFinishedBlock 请求完成block，参数参照PostParamsFinishedBlock定义
// MKNKErrorBlock 请求失败，错误信息block，参数参照MKNKErrorBlock定义
// path 路径（例：peccancy.do）
// ** 返回:     MKNetworkOperation
// *****************************************************************************/
//-(MKNetworkOperation*)postBody:(NSMutableDictionary*)body isResponseJson:(BOOL)isResJson doShowIndicator:(BOOL)showIndicator onCompletion:(ENT_PostParamsFinishedBlock)postParamsFinishedBlock onError:(ENT_NetwokErrorBlock)errorBlock withPath:(NSString*)path;
@end
