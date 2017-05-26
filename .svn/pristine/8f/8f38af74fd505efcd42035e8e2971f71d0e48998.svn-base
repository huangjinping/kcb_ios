/******************************************************
 * 模块名称:   ChatNetwork.h
 * 模块功能:   车友圈网络请求
 * 创建日期:   14-9-10
 * 创建作者:   闫燕
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/

#import <Foundation/Foundation.h>
#import <MKNetworkKit.h>
#import <SBJson.h>
#import <MBProgressHUD.h>
    
    
@interface ChatNetwork : MKNetworkEngine


+ (ChatNetwork*)sharedChatNetwork;


/*****************************************************************************
 ** 功能:     向服务器发送信息
 ** 参数:     NSMutableDictionary 信息字典；BOOL 返回信息是否为json数据；
             PostParamsFinishedBlock 请求完成block，参数参照PostParamsFinishedBlock定义
             MKNKErrorBlock 请求失败，错误信息block，参数参照MKNKErrorBlock定义
 ** 返回:     MKNetworkOperation
 *****************************************************************************/

-(MKNetworkOperation*)chatPostBody:(NSMutableDictionary*)body onUrl:(NSString*)urlString withPostMethod:(NSString*)method isResponseJson:(BOOL)isResJson doShowIndicator:(BOOL)showIndicator onView:(UIView*)view callBackWithObj:(NSObject*)obj onCompletion:(ENT_PostParamsFinishedBlock)postParamsFinishedBlock onError:(ENT_NetwokErrorBlock)errorBlock;



@end
