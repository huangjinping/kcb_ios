//
//  Network.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-14.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

/******************************************************
 * 模块名称:   Network.m
 * 模块功能:   网络请求
 * 创建日期:   14-7-14
 * 创建作者:   闫燕
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/

#import "Network.h"

static Network *_network = nil;
@implementation Network



+ (Network*)sharedNetwork{
    @synchronized(self){
        if (!_network) {
            NSString *hostName;
            if (ENT_DEBUG) {//test588   enc123
                hostName = @"new.956122.com";
            }else{
                hostName = @"yetapi.956122.com";
            }
            _network = [[Network alloc] initWithHostName:hostName customHeaderFields:nil];
        }
    }
    return _network;
}

/*****************************************************************************
 ** 功能:     向服务器发送信息
 ** 参数:     NSMutableDictionary 信息字典；BOOL 返回信息是否为json数据；
             PostParamsFinishedBlock 请求完成block，参数参照PostParamsFinishedBlock定义
             MKNKErrorBlock 请求失败，错误信息block，参数参照MKNKErrorBlock定义
 ** 返回:     MKNetworkOperation
 *****************************************************************************/
-(MKNetworkOperation*)postBody:(NSMutableDictionary*)body isResponseJson:(BOOL)isResJson doShowIndicator:(BOOL)showIndicator callBackWithObj:(NSObject*)obj onCompletion:(ENT_PostParamsFinishedBlock)postParamsFinishedBlock onError:(ENT_NetwokErrorBlock)errorBlock{
    
    __block UIView *clearBgView;
    __block MBProgressHUD *hud;
    if (showIndicator) {
        
        clearBgView = [[UIView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_VIEW_Y - APP_NAV_HEIGHT)];
        clearBgView.backgroundColor = [UIColor clearColor];
        UINavigationController *nav = (UINavigationController*)APP_DELEGATE.window.rootViewController;
        UIViewController *vc = [nav.viewControllers lastObject];
        [vc.view addSubview:clearBgView];
        hud = [[MBProgressHUD alloc] initWithFrame:clearBgView.bounds];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.animationType = MBProgressHUDAnimationFade;
        [clearBgView addSubview:hud];
        [hud show:YES];
    }  
    
    MKNetworkOperation *op = [self operationWithPath:@"andriod.do" params:body httpMethod:@"POST"];
   
        ENTLog(@"\n网络请求地址：%@",op.url);
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        //请求成功
        NSString *responseStr = completedOperation.responseString;
        
            ENTLog(@"\n连接服务器成功，返回字符串：%@",responseStr);
        
        if (isResJson) {
            //解析返回数据
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSObject *responseObj = [parser objectWithString:responseStr];
            if (responseObj) {//解析成功
                postParamsFinishedBlock(postSucc, responseObj, obj);//详细解析在block中，根据具体接口，进行实现
            }else{//解析失败
                //postParamsFinishedBlock(postFailed, [NSString stringWithFormat:@"解析失败，解析器errormsg：%@，服务器返回：%@", parser.error, responseStr], obj);
                
                postParamsFinishedBlock(postFailed, responseStr, obj);
            }
        }else{//此请求非json数据
            NSString *reqCode = [responseStr length] > 0? [responseStr substringToIndex:1] : @"1";
            NSString *reqMsg = [responseStr length] > 1? [responseStr substringFromIndex:2] : @"返回数据格式错误";
            if ([reqCode isEqualToString:@"0"]) {
                postParamsFinishedBlock(postSucc, reqMsg, obj);
            }else if ([reqCode isEqualToString:@"1"]){
                postParamsFinishedBlock(postFailed, reqMsg, obj);
            }else{//服务器异常
                
                    ENTLog(@"\n%@", [NSString stringWithFormat:@"服务器异常返回：%@", responseStr]);
                
                
                postParamsFinishedBlock(postFailed, responseStr, obj);
            }
        }
        [hud hide:YES];
        [clearBgView removeFromSuperview];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        //请求失败
        NSString *errorStr = [NSString stringWithFormat:@"error%@", error];
        ENTLog(@"%@", [NSString stringWithFormat:@"连接服务器失败，错误信息%@,服务器返回：%@", errorStr, completedOperation.responseString]);
            
        NSString *errStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if (!errStr || [errStr isEqualToString:@""]) {
            errStr = @"服务器出错了！";
        }
        errorBlock(errStr);
        
        [hud hide:YES];
        [clearBgView removeFromSuperview];
    }];
    
    [self enqueueOperation:op];
    return op;

}

@end
