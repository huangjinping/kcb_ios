//
//  BaiduMobSspConfig.h
//  BaiduMobSsp
//
//  Created by dengjinxiang on 14-5-13.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CJSONDeserializer.h"

@class BaiduMobSspConfig;
@protocol BaiduMobSspConfigDelegate<NSObject>

@optional
- (void)baiduMobSspConfigDidReceiveConfig:(BaiduMobSspConfig *)config;
- (void)baiduMobSspConfigDidFail:(BaiduMobSspConfig *)config error:(NSError *)error;
- (NSURL *)baiduMobSspConfigURL;

@end

typedef enum {
    BMSBannerAnimationTypeNone           = 0,
    BMSBannerAnimationTypeFlipFromLeft   = 1,
    BMSBannerAnimationTypeFlipFromRight  = 2,
    BMSBannerAnimationTypeCurlUp         = 3,
    BMSBannerAnimationTypeCurlDown       = 4,
    BMSBannerAnimationTypeSlideFromLeft  = 5,
    BMSBannerAnimationTypeSlideFromRight = 6,
    BMSBannerAnimationTypeFadeIn         = 7,
    BMSBannerAnimationTypeRandom         = 8,
} BMSBannerAnimationType;

@class BaiduMobSspAdNetworkConfig;
@class BaiduMobSspAdNetworkRegistry;

@interface BaiduMobSspConfig : NSObject {
    NSString *appKey;
    NSURL *configURL;
    
    BOOL adsAreOff;
    
    NSMutableArray *adNetworkConfigs;
    NSMutableArray *otherAdNetworkConfigs;
    
    UIColor *backgroundColor;
    UIColor *textColor;
    NSTimeInterval refreshInterval;
    BOOL locationOn;
    BMSBannerAnimationType bannerAnimationType;
    NSInteger fullscreenWaitInterval;
    NSInteger fullscreenMaxAds;
    
    NSMutableArray *delegates;
    BOOL hasConfig;
    
    BaiduMobSspAdNetworkRegistry *adNetworkRegistry;
    
    NSInteger adType;
    NSInteger configFileMaxAge;
    NSString* sid;
}

- (id)initWithAppKey:(NSString *)ak delegate:(id<BaiduMobSspConfigDelegate>)delegate;
- (BOOL)parseConfig:(NSData *)data error:(NSError **)error;
- (BOOL)addDelegate:(id<BaiduMobSspConfigDelegate>)delegate;
- (BOOL)removeDelegate:(id<BaiduMobSspConfigDelegate>)delegate;
- (void)notifyDelegatesOfFailure:(NSError *)error;

@property (nonatomic,readonly) NSString* sid;
@property (nonatomic,readonly) NSString *appKey;
@property (nonatomic,readonly) NSURL *configURL;

@property (nonatomic,readonly) BOOL hasConfig;
@property (nonatomic,readonly) BOOL parseFail;
@property (nonatomic,readonly) BOOL adsAreOff;
@property (nonatomic,readonly) NSArray *adNetworkConfigs;
@property (nonatomic,readonly) NSArray *otherAdNetworkConfigs;
@property (nonatomic,readonly) UIColor *backgroundColor;
@property (nonatomic,readonly) UIColor *textColor;
@property (nonatomic,readonly) NSTimeInterval refreshInterval;
@property (nonatomic,readonly) BOOL locationOn;
@property (nonatomic,readonly) BMSBannerAnimationType bannerAnimationType;
@property (nonatomic,readonly) NSInteger fullscreenWaitInterval;
@property (nonatomic,readonly) NSInteger fullscreenMaxAds;

@property (nonatomic,assign) BaiduMobSspAdNetworkRegistry *adNetworkRegistry;
@property (nonatomic,readonly) NSInteger adType;
@property (nonatomic,readonly) NSInteger configFileMaxAge;

@end



