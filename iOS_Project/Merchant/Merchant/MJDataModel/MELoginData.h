//
//  MELoginData.h
//  Merchant
//
//  Created by Wendy on 16/1/18.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
@class Userdata,Paytype,OrderStatus;
@interface MELoginData : NSObject<NSCoding>

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) Userdata *userdata;

@property (nonatomic, copy) NSString *loginmessang;

@end
@interface Userdata : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger mid;

@property (nonatomic, copy) NSString *mername;

@property (nonatomic, copy) NSString *ismust;

@property (nonatomic, strong) NSArray *paytype;

@property (nonatomic, copy) NSString *isnew;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *logo;

@property (nonatomic, strong) NSArray *order;

@property (nonatomic, copy) NSString *logined;

@property (nonatomic, copy) NSString *telphone;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) NSInteger vnum;

@property (nonatomic, copy) NSString *jwd;
@end

@interface Paytype : NSObject<NSCoding>

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *value;

@end

@interface OrderStatus : NSObject<NSCoding>

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *value;

@end

