
//
//  AppDelegate.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-14.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "BYPayInfoViewController.h"

@implementation AppDelegate

- (void)synchronousDownloadLanchImage{
    NSURL *imageMsgsUrl = [NSURL URLWithString:@"http://cms.956122.com/dataview/dataview_findFreeAdpostion.action?jsonpcallback=?&cid=59"];
    NSURLRequest *imageMsgsRequest = [NSURLRequest requestWithURL:imageMsgsUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    NSData *data = [NSURLConnection sendSynchronousRequest:imageMsgsRequest returningResponse:nil error:nil];
    NSString *resString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSRange range = [resString rangeOfString:@"<img src='"];
    if (range.location != NSNotFound) {//服务器返回 img src
        resString = [resString substringFromIndex:range.location + range.length];
        range = [resString rangeOfString:@"'"];
        resString = [resString substringToIndex:range.location];
        
        NSURLRequest *downloadLaunchImageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:resString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
        NSData *imgData = [NSURLConnection sendSynchronousRequest:downloadLaunchImageRequest returningResponse:nil error:nil];
        [imgData writeToFile:GUIDE_IMG_LOCAL_PATH atomically:YES] ;
    }
}


- (void)setViewControllers{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    UINavigationController  *navVC = [[UINavigationController alloc] init];
    if (iOS7) {
        UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, APP_WIDTH, 20)];
        statusBarView.backgroundColor = COLOR_NAV;
        [navVC.navigationBar addSubview:statusBarView];
        navVC.navigationBar.barTintColor = COLOR_NAV;
    }
    
    NSMutableArray  *array = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *versionStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"version"];
    if (!versionStr) {
        versionStr = @"";
    }
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersionStr = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if (![versionStr isEqualToString:currentVersionStr]) {//第一次启动(包括更新后)
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersionStr forKey:@"version"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:KEY_CITY_NAME_IN_USERDEFAULT];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:KEY_CITY_CODE_IN_USERDEFAULT];
        
        GuideViewController *guideVC = [[GuideViewController alloc] init];
        [array addObject:guideVC];
        //同步下载lanch图片
        [self synchronousDownloadLanchImage];
        
    }else{
        //跳转首页
        TabBarViewController *tabVC = [[TabBarViewController alloc] init];
        [array addObject:tabVC];
        
    }
    
    [navVC setViewControllers:array animated:YES];
    [self.window setRootViewController:navVC];
    [self.window makeKeyAndVisible];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"%@",LOCAL_PATH_CACHES);
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.shouldRefreshFriendsList = YES;
    self.shouldRefreshBlogList = YES;
    
    //self.carOwnerName = nil;
    //self.carOwnerIdnum = nil;
    //self.carDealConditionInfoDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    //self.xianxing = @"false";
    //1.初始化微信Connection
    NSString *appId = @"wx36b95fa7b967bea4";
    [WXApi registerApp:appId];
    
    [self initConfig];
    
    //注册推送
    // iOS8 下需要使用新的 API
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
    // 在 App 启动时注册百度云推送服务，需要提供 Apikey
    [BPush registerChannel:launchOptions apiKey:@"G9CGK1j5yfEIEweROTv1uTVK" pushMode:BPushModeProduction withFirstAction:nil withSecondAction:nil withCategory:nil isDebug:YES];
    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        //        NSLog(@"从消息启动:%@",userInfo);
        [BPush handleNotification:userInfo];
    }
    
    [application setApplicationIconBadgeNumber:0];
    if ([application respondsToSelector:@selector(registerForRemoteNotificationTypes:)]) {
        [application registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeAlert
         | UIRemoteNotificationTypeBadge
         | UIRemoteNotificationTypeSound];
    }
    
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
    }
    
    
    //统计分析
    //统计分析
    if (USE_COUNTLY) {
        if (iOS6) {
            [[Countly sharedInstance] start:@"15d8c9d9151d9d2eff3f40215f6be4fc89ec1685" withHost:@"http://countly.956122.com"];
        }
    }
    
    
    //清空缓存照片data
    NSURL *appUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSString *dirPath = [[appUrl path] stringByAppendingPathComponent:@"photo"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:dirPath error:nil];
    //清空缓存照片msg
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_PHOTO_DICT_IN_USERDEFAULT];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:KEY_PHOTO_DICT_IN_USERDEFAULT];
    
    
    self.userId = @"";//游客
    self.userName = @"";//游客
    self.loginSuss = NO;
    self.firstTimeOnUserPage = NO;
    NSArray *activeUserArr = [[DataBase sharedDataBase] selectActiveUser];
    if ([activeUserArr count]) {
        UserInfo *user = [activeUserArr lastObject];
        self.userId = user.userId;//用户
        self.userName = user.userName;//用户
    }
    
    [self setViewControllers];

    [self configBaiDuAdv];                          //初始化百度广告
    return YES;
    
}

- (void)initConfig{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *cachesPath = [GetCachesPath() stringByAppendingString:DATABASE_NAME_V2];
        
        if (IsFileExists(cachesPath)) {
            [[DataBase sharedDataBase] deleteAllUses];
            [[DataBase sharedDataBase] deleteAllCarInfo];
            [[DataBase sharedDataBase] deleteAllCarPeccancyRecord];
        }
    });
    
    //    NSString *docPath = GetDocumentDirectoryPath();
    
}

-(void)configBaiDuAdv{
    BaiduMobAdSplash *splash = [[BaiduMobAdSplash alloc] init];
    splash.delegate = self;
    splash.AdUnitTag = @"2083890";
    splash.canSplashClick = YES;
    splash.useCache = NO;
    self.splash = splash;
    
    _lunchTempImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT + APP_STATUS_BAR_HEIGHT)];
    _lunchTempImgView.userInteractionEnabled = YES;
    NSString *imgName = @"Default@2x.png";
    if (iPhone5) {
        imgName = @"Default-568h@2x.png";
    }else if (iPhone6){
        imgName = @"Default-375w-667h@2x.png";
        
    }else if (iPhone6_PLUS){
        imgName = @"Default-414w-736h@3x.png";
        
    }
    [_lunchTempImgView setImage:[UIImage imageNamed:imgName]];
    [APP_DELEGATE.window addSubview:_lunchTempImgView];
    
    [splash loadAndDisplayUsingContainerView:_lunchTempImgView];


}
#pragma mark- Baidu iad Delegate

- (NSString *)publisherId {
    return @"b1657535";
}

/**
 *  启动位置信息
 */
-(BOOL) enableLocation{
    return NO;
}


/**
 *  广告展示成功
 */
- (void)splashSuccessPresentScreen:(BaiduMobAdSplash *)splash{
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

/**
 *  广告展示失败
 */
- (void)splashlFailPresentScreen:(BaiduMobAdSplash *)splash withError:(BaiduMobFailReason) reason{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [_lunchTempImgView removeFromSuperview];
    
}

/**
 *  广告展示结束
 */
- (void)splashDidDismissScreen:(BaiduMobAdSplash *)splash{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [_lunchTempImgView removeFromSuperview];
}



#pragma mark-  推送回调
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //NSLog(@"test:%@",deviceToken);
    [BPush registerDeviceToken:deviceToken];
    
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        
    }];
    
}
// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
    [application registerForRemoteNotifications];
    
    
}
- (void) onMethod:(NSString*)method response:(NSDictionary*)data
{
    ENTLog(@"On method:%@", method);
    ENTLog(@"data:%@", [data description]);
    
    NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
    
    if ([BPushRequestMethod_Bind isEqualToString:method])
    {
        //NSString *appid = [res valueForKey:BPushRequestAppIdKey];
        NSString *userid = [res valueForKey:BPushRequestUserIdKey];
        if (!userid) {
            userid = @"";
        }
        
        self.bpushUserId = userid;
        NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
        if (!channelid) {
            channelid = @"";
        }
        self.bpushChannelId = channelid;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PUSH_REGIST_FINISHED object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:userid, KEY_BPUSH_USER_ID, channelid, KEY_BPUSH_CHANNEL_ID, nil]];
        
        //NSString *requestid = [res valueForKey:BPushRequestRequestIdKey];
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        
        if (returnCode == BPushErrorCode_Success) {
            
            
        }
    } else if ([BPushRequestMethod_Unbind isEqualToString:method]) {
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        if (returnCode == BPushErrorCode_Success) {
            
            
        }
    }
}

// 当 DeviceToken 获取失败时，系统会回调此方法
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //NSLog(@"DeviceToken 获取失败，原因：%@",error);
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    ENTLog(@"Receive Notify: %@", [userInfo JSONString]);
    
    [application setApplicationIconBadgeNumber:0];
    
    [BPush handleNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
   // NSLog(@"接收本地通知啦！！！");
    [BPush showLocalNotificationAtFront:notification identifierKey:nil];
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

#pragma mark-  微信分享回调
-(void) onResp:(BaseResp*)resp{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_WX_CALL_BACK object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:resp.errCode], @"errCode", nil]];
    
}



//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    return  [WXApi handleOpenURL:url delegate:self];
//}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    
//    if ([url.host isEqualToString:@"safepay"]) {
//        //跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            ENTLog(@"reslut = %@",resultDic);
//            if ([[resultDic objectForKey:@"resultStatus"] intValue]==9000) {
//                NSString *string = @"支付成功";
//                BYPayInfoViewController *vc =[[BYPayInfoViewController alloc]init];
//                vc.titLabel=string;
//                vc.isIng =NO;
//                NSArray *array = [_orderNo componentsSeparatedByString:@","]; //从字符A中
//                
//                vc.orderNo=array[0];
//                vc.DDInfo =array[1];
//                
//                
//                
//                vc.isSucceed=YES;
//                [self.window.viewController presentModalViewController:vc animated:YES];
//            }else if([[resultDic objectForKey:@"resultStatus"] intValue]==8000){
//                NSString *string = @"正在处理";
//                BYPayInfoViewController *vc =[[BYPayInfoViewController alloc]init];
//                vc.titLabel=string;
//                vc.isIng =YES;
//                vc.isSucceed=NO;
//                NSArray *array = [_orderNo componentsSeparatedByString:@","]; //从字符A中
//                
//                vc.orderNo=array[0];
//                vc.DDInfo =array[1];
//                [self.window.viewController presentModalViewController:vc animated:YES];
//                
//            }else if([[resultDic objectForKey:@"resultStatus"] intValue]==4000){
//                NSString *string = @"订单支付失败";
//                BYPayInfoViewController *vc =[[BYPayInfoViewController alloc]init];
//                vc.titLabel=string;
//                NSArray *array = [_orderNo componentsSeparatedByString:@","]; //从字符A中
//                
//                vc.orderNo=array[0];
//                vc.DDInfo =array[1];
//                vc.isIng =NO;
//                vc.isSucceed=NO;
//                [self.window.viewController presentModalViewController:vc animated:YES];
//                
//            }else if([[resultDic objectForKey:@"resultStatus"] intValue]==6001){
//                NSString *string = @"用户中途取消";
//                BYPayInfoViewController *vc =[[BYPayInfoViewController alloc]init];
//                vc.titLabel=string;
//                NSArray *array = [_orderNo componentsSeparatedByString:@","]; //从字符A中
//                
//                vc.orderNo=array[0];
//                vc.DDInfo =array[1];
//                vc.isIng =NO;
//                vc.isSucceed=NO;
//                [self.window.viewController presentModalViewController:vc animated:YES];
//                
//            }else if([[resultDic objectForKey:@"resultStatus"] intValue]==6002){
//                NSString *string = @"网路连接错误";
//                BYPayInfoViewController *vc =[[BYPayInfoViewController alloc]init];
//                vc.titLabel=string;
//                NSArray *array = [_orderNo componentsSeparatedByString:@","]; //从字符A中
//                
//                vc.orderNo=array[0];
//                vc.DDInfo =array[1];
//                vc.isIng =NO;
//                vc.isSucceed=NO;
//                [self.window.viewController presentModalViewController:vc animated:YES];
//                
//            }else{
//                NSString *string = @"订单支付失败";
//                BYPayInfoViewController *vc =[[BYPayInfoViewController alloc]init];
//                vc.titLabel=string;
//                NSArray *array = [_orderNo componentsSeparatedByString:@","]; //从字符A中
//                
//                vc.orderNo=array[0];
//                vc.DDInfo =array[1];
//                vc.isIng =NO;
//                vc.isSucceed=NO;
//                [self.window.viewController presentModalViewController:vc animated:YES];
//                
//            }
//            
//            
//            
//        }];
//        
//        return YES;
//        
//    }else{
//        
//        return [WXApi handleOpenURL:url delegate:self];
//        
//    }
//    
//}




- (void)applicationWillResignActive:(UIApplication *)application
{
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end