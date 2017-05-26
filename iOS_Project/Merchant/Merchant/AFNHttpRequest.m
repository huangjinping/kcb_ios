//
//  AFNHttpRequest.m
//  testMIdea
//
//  Created by wendy on 15/8/12.
//  Copyright (c) 2015年 pinksun. All rights reserved.
//

#import "AFNHttpRequest.h"
#import "NetworkConfig.h"
#import "JSONKit.h"
//#import "SVProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>


@implementation AFNHttpRequest
+ (NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
+ (void)startAnimation:(UIView *)imageView
{
//    NSTimeInterval duration = 1.0f;
//    CGFloat angle = M_PI / 1.0f;
//    CGAffineTransform rotateTransform = CGAffineTransformRotate(imageView.transform, angle * -1);
//    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionRepeat| UIViewAnimationOptionCurveLinear animations:^{
//        imageView.transform = rotateTransform;
//    } completion:nil];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = .4f;
    animation.fromValue = [NSNumber numberWithFloat:M_PI/5];
    animation.toValue = [NSNumber numberWithFloat:-M_PI/5];
    animation.repeatCount = CGFLOAT_MAX;
    animation.autoreverses = YES;
    
    [imageView.layer addAnimation:animation forKey:nil];
    
}

+ (void)afnHttpRequestUrl:(NSString *)requestInterface param:(NSDictionary *)param success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure progressHUD:(BOOL)hud view:(UIView *)view{
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

    // 组装url
    NSString *url = [NSString stringWithFormat:@"%@%@", kHttpIPAddress, requestInterface];
    NSMutableDictionary *allParam = [NSMutableDictionary dictionary];

    if ([requestInterface isEqualToString:kHttpLogin] || [requestInterface isEqualToString:kHttpChangePwd]) {
        [allParam addEntriesFromDictionary:param];
    }
    else{
        // 组装包头
        NSDictionary *head = @{
                               @"head": @{
                                       @"version": version,
                                       @"tokenId":@""
                                       }
                               };
        
        [allParam addEntriesFromDictionary:head];
        if(param){
            [allParam addEntriesFromDictionary:@{ @"body": param }];
        }
    }
#ifdef  TEST
    NSLog(@"发送的报文:%@", allParam);
    
    NSArray *array = [requestInterface componentsSeparatedByString:@"/"];
    NSString *path = [[NSBundle mainBundle] pathForResource:array[1] ofType:@"json"];
    NSString *valueStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    valueStr = [valueStr stringByReplacingOccurrencesOfString:@"null" withString:@""];
    
    NSDictionary *resultDict = [valueStr objectFromJSONString];
    
    if ([resultDict count]) {
        success(resultDict);
    } else {
        NSError *error = [NSError errorWithDomain:@"模拟报文失败" code:999 userInfo:nil];
        failure(error);
    }
    
#else /* ifdef  TEST */
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15.f;
    NSLog(@"-----接口函数:%@",requestInterface);
    NSLog(@"发送的报文:%@", [self DataTOjsonString:allParam]);
    MBProgressHUD *hudview;
    if (hud) {
        hudview = [[MBProgressHUD alloc] initWithView:view];
        hudview.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_icon"]];
        hudview.mode = MBProgressHUDModeCustomView;
        hudview.color = [UIColor clearColor];
        hudview.customView.size = CGSizeMake(50, 50);
        [self startAnimation:hudview.customView];
        [view addSubview:hudview];
        [hudview show:YES];
    }
 
    [manager POST:url parameters:allParam success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"返回报文%@",operation.responseString);
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        requestTmp = [requestTmp stringByReplacingOccurrencesOfString:@"null" withString:@""];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        
        success(responseDict);
        if (hud) {
//            [MBProgressHUD hideHUDForView:view animated:YES];
            [hudview hide:YES];
        }

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
        failure(error);
        if (hud) {
//            [MBProgressHUD hideHUDForView:view animated:YES];
            [hudview hide:YES];
        }
    }];
    
#endif /* ifdef  TEST */

}
+ (void)afnHttpRequestUrl:(NSString *)requestInterface param:(NSDictionary *)param success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure view:(UIView *)view
{
    [self afnHttpRequestUrl:requestInterface param:param success:success failure:failure progressHUD:YES view:view];
}

+ (void)afnHttpRequestUrlNonHub:(NSString *)requestInterface param:(NSDictionary *)param success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure view:(UIView *)view
{
    [self afnHttpRequestUrl:requestInterface param:param success:success failure:failure progressHUD:NO view:view];
}

#pragma mark 请求报文成功

//+ (void)dismiss
//{
//    [SVProgressHUD dismiss];
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//}
@end