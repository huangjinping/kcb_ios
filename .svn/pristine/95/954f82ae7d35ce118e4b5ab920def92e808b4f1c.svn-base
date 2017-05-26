/******************************************************
 * 模块名称:   ChatNetwork.m
 * 模块功能:   车友圈网络请求
 * 创建日期:   14-9-10
 * 创建作者:   闫燕
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/


#import "ChatNetwork.h"

static ChatNetwork *_chatNetwork = nil;

@implementation ChatNetwork



+ (ChatNetwork*)sharedChatNetwork{
    
    if (_chatNetwork) {
        return _chatNetwork;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *hostName;
        if (ENT_DEBUG) {//修改 by yanyan 暂时为无论何种环境，互动均使用正式环境
            hostName = @"appsns.956122.com/app";//@"132.96.77.62:8080/tranSns/app";
        }else{
            hostName = @"appsns.956122.com/app";
        }
        _chatNetwork = [[ChatNetwork alloc] initWithHostName:hostName customHeaderFields:nil];
    });
    return _chatNetwork;
}

/*****************************************************************************
 ** 功能:     向服务器发送信息
 ** 参数:     NSMutableDictionary 信息字典；BOOL 返回信息是否为json数据；
             PostParamsFinishedBlock 请求完成block，参数参照PostParamsFinishedBlock定义
             MKNKErrorBlock 请求失败，错误信息block，参数参照MKNKErrorBlock定义
 ** 返回:     MKNetworkOperation
 *****************************************************************************/
-(MKNetworkOperation*)chatPostBody:(NSMutableDictionary*)body onUrl:(NSString*)urlString withPostMethod:(NSString*)method isResponseJson:(BOOL)isResJson doShowIndicator:(BOOL)showIndicator onView:(UIView*)view callBackWithObj:(NSObject*)obj onCompletion:(ENT_PostParamsFinishedBlock)postParamsFinishedBlock onError:(ENT_NetwokErrorBlock)errorBlock{
    
    __block UIView *clearBgView;
    __block MBProgressHUD *hud;
    if (showIndicator) {
        
        clearBgView = [[UIView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
        clearBgView.backgroundColor = [UIColor clearColor];
        [view addSubview:clearBgView];
        hud = [[MBProgressHUD alloc] initWithFrame:clearBgView.bounds];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.animationType = MBProgressHUDAnimationFade;
        [clearBgView addSubview:hud];
        [hud show:YES];
    }
    
    MKNetworkOperation *op = [self operationWithPath:urlString params:body httpMethod:method];
   
    ENTLog(@"\n网络请求地址：%@",op.url);
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        
        [hud hide:YES];
        [clearBgView removeFromSuperview];
        
        //请求成功
        NSString *responseStr = completedOperation.responseString;
        
            ENTLog(@"\n连接服务器成功，返回字符串：%@",responseStr);
        
        if (isResJson) {
            //解析返回数据
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSObject *responseObj = [parser objectWithString:responseStr];
            if (responseObj) {//解析成功
                
                    NSDictionary *resDict = (NSDictionary*)responseObj;
                    NSString *contents_ = [resDict objectForKey:@"contents"];
                NSInteger statusCode = [[resDict objectForKey:@"status"] integerValue];
                    if (statusCode == 0) {//失败
                        
                        postParamsFinishedBlock(postFailed, contents_, obj);
                        
                    }else{
                        postParamsFinishedBlock(postSucc, responseObj, obj);
                    }
                
                //详细解析在block中，根据具体接口，进行实现
                
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
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [hud hide:YES];
        [clearBgView removeFromSuperview];
        
        //请求失败
        NSString *errorStr = [NSString stringWithFormat:@"error%@", error];
        ENTLog(@"%@", [NSString stringWithFormat:@"连接服务器失败，错误信息%@,服务器返回：%@", errorStr, completedOperation.responseString]);
            
        NSString *errStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if (!errStr || [errStr isEqualToString:@""]) {
            errStr = @"服务器出错了！";
        }
        errorBlock(errStr);
        
        
    }];
    
    [self enqueueOperation:op];
    return op;

}

@end
