//
//  NETHelper.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-10.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "NETHelper.h"

@implementation NETHelper

//检测更新
+ (void)checkAppUpdate{
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:@"yetapi.956122.com"];
    MKNetworkOperation *op = [en operationWithPath:@"androidapk/ver_ios.xml"];
    ENTLog(@"检查更新url=%@", op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        //<root> <appurl_ios> https://itunes.apple.com/us/app/quan-guo-jia-shi-yuan-fu-wu/id862897685?l=zh&ls=1&mt=8 </appurl_ios> <version>2.1.4</version> </root>
        
        NSString *urlString = @"";
        NSString *newVersionString = @"";
        //解析newversion
        NSString *resString = completedOperation.responseString;
        NSRange range = [resString rangeOfString:@"<version>"];
        if (range.location != NSNotFound) {
            newVersionString = [resString substringFromIndex:range.location + range.length];
            range = [newVersionString rangeOfString:@"</version>"];
            newVersionString = [newVersionString substringToIndex:range.location];
        }
        //组成当前版本，新版本 int
        NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSArray *currentVersionA = [currentVersion componentsSeparatedByString:@"."];
        NSArray *newVersionA = [newVersionString componentsSeparatedByString:@"."];
        
        currentVersion = [NSString stringWithFormat:@"%@%@%@",[currentVersionA objectAtIndex:0], [currentVersionA objectAtIndex:1], [currentVersionA objectAtIndex:2]];
        newVersionString = [NSString stringWithFormat:@"%@%@%@",[newVersionA objectAtIndex:0], [newVersionA objectAtIndex:1], [newVersionA objectAtIndex:2]];
        NSInteger currentV = [currentVersion integerValue];
        NSInteger newV = [newVersionString integerValue];
        
        //比较版本
        if (newV > currentV) {//有新版本
            
            //解析url
            range = [resString rangeOfString:@"<appurl_ios>"];
            if (range.location != NSNotFound) {//有AppStore地址
                urlString = [resString substringFromIndex:range.location + range.length];
                range = [urlString rangeOfString:@"</appurl_ios>"];
                urlString = [urlString substringToIndex:range.location];
            }
            
        }
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_APP_UPDATE object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:urlString, @"url", newVersionString, @"version", nil]];
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_APP_UPDATE object:nil userInfo:nil];
    }];
    [en enqueueOperation:op];
}

/**
 *  上传城市编码与车辆品牌信息，用于车友圈推荐相关好友
 */
+ (void)chatModifyCityAndCars{
    
    if(!APP_DELEGATE.loginSuss){
        return;
    }
    NSArray *cars = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId];
    NSString *clpp = @"";
    for (int i = 0; i< [cars count]; i ++) {
        CarInfo *car = [cars objectAtIndex:i];
        if (i == 0) {
            clpp = [clpp stringByAppendingString:car.clpp1];
        }else{
            clpp = [clpp stringByAppendingString:@","];
            clpp = [clpp stringByAppendingString:car.clpp1];
        }
    }
    
    NSString *cityCode = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_CITY_CODE_IN_USERDEFAULT];
    NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_CITY_NAME_IN_USERDEFAULT];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:APP_DELEGATE.userName forKey:@"username"];
    [dict setObject:cityCode forKey:@"citycode"];
    [dict setObject:cityName forKey:@"cityname"];
    [dict setObject:clpp forKey:@"carbrand"];

    [[ChatNetwork sharedChatNetwork] chatPostBody:dict onUrl:@"editUser.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:NO onView:nil callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        
        
    } onError:^(NSString *errorStr) {
        
        
    }];
}


/**
 *  从服务器获取当前用户的（未读）消息
 */
+ (void)fetchNotifycations{
    
    /*
     {
     "listmessage":[
     {
     "message":"1，APP重构，流畅性更高，易用；
     2，开通违法处理功能；
     3，开通违法缴款功能；
     4，增加车友互动；
     5，增加车险易购。",
     "sendtime":"2014-08-08 18:00:00"
     }
     ]
     }
     
     */
    if(!APP_DELEGATE.loginSuss){
        return;
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"getmessage" forKey:@"action"];
    [dict setObject:APP_DELEGATE.userName forKey:@"username"];
    NSArray *messages = [[DataBase sharedDataBase] selectAllMsgByUser:APP_DELEGATE.userName];
    if ([messages count]) {
        Msg *msg = [messages objectAtIndex:0];
        [dict setObject:msg.msg_time forKey:@"updatetime"];
    }
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSArray *resArr = [resDict objectForKey:@"listmessage"];
            for (NSDictionary *dict in resArr) {
                Msg *msg = [[Msg alloc] initWithMsg_ID:@"" msg_time:[dict analysisStrValueByKey:@"sendtime"] msg_title:@"" msg_content:[dict analysisStrValueByKey:@"message"] msg_read_status:MSG_STATUS_READ_NO msg_classify:@"" andMsg_user:APP_DELEGATE.userName];
                [msg addToDB];
            }
            if ([resArr count]){
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FETCH_MESSAGES_FINISHED object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:NOTIFICATION_FETCH_MESSAGES_FINISHED, @"responseMark", nil]];
            }
            
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FETCH_MESSAGES_FINISHED object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"服务器返回异常", @"responseMark", nil]];

        }
    } onError:^(NSString *errorStr) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FETCH_MESSAGES_FINISHED object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"errorStr", @"responseMark", nil]];
        
    }];
    
}

//下载头像

+ (void)asynchronousDownloadPhotoImage{
    NSArray *users = [[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName];
    if ([users count] == 0) {
        return;
    }
    UserInfo *user = [users lastObject];
    //if ([user.photoLocalPath isEqualToString:@""]) {//本地为空
    if (![user.photoServerPath isEqualToString:@""]) {//服务器地址有值
        
        NSURL *imgUrl = [NSURL URLWithString:user.photoServerPath];
        NSURLRequest *rq = [NSURLRequest requestWithURL:imgUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
        [NSURLConnection sendAsynchronousRequest:rq queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            //succ
            if (!connectionError) {
                //[[[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject] path];
                NSString *localPath = [[LOCAL_PATH_CACHES stringByAppendingPathComponent:user.userName] stringByAppendingString:@".jpg"];
                BOOL writeSucc = [data writeToFile:localPath atomically:YES];
                if (writeSucc) {
                    user.photoLocalPath = localPath;
                    [user update];
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FINISH_DOWNLOAD_PHOTO object:nil];
            }else{//failed
                [self performSelector:@selector(asynchronousDownloadPhotoImage) withObject:nil afterDelay:1*10.0f];
            }
        }];
    }
}

@end
