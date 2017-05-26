//
//  UserInfo.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-15.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject


@property (nonatomic, retain) NSString *userId;     //唯一标识
@property (nonatomic, retain) NSString *userName;   //用户名
@property (nonatomic, retain) NSString *password;   //密码
@property (nonatomic, retain) NSString *email;      //邮箱地址
@property (nonatomic, retain) NSString *contactNum; //联系电话
@property (nonatomic, retain) NSString *postCode;   //邮编地址
@property (nonatomic, retain) NSString *realName;   //真实名字
@property (nonatomic, retain) NSString *addr;       //联系地址
@property (nonatomic, retain) NSString *registTime; //注册时间
@property (nonatomic, retain) NSString *verifyStatus;   //验证状态，0，未验证，1手机验证，2邮箱验证，3邮箱手机都验证
@property (nonatomic, retain) NSString *loadTime;       //登录时间
@property (nonatomic, retain) NSString *citySet;        //城市
@property (nonatomic, retain) NSString *version;        //版本号
@property (nonatomic, retain) NSString *photoLocalPath; //头像的本地地址
@property (nonatomic, retain) NSString *photoServerPath;//头像的服务器地址

@property (nonatomic, retain) NSString *isActive;//是否为当前活跃用户

//初始化
- (id)initWithUserId:(NSString*)userId
            isActive:(NSString*)isActive
            userName:(NSString*)userName
            password:(NSString*)password
               email:(NSString*)email
          contactNum:(NSString*)contactNum
            postCode:(NSString*)postCode
            realName:(NSString*)realName
                addr:(NSString*)addr
          registTime:(NSString*)registTime
        verifyStatus:(NSString*)verifyStatus
            loadTime:(NSString*)loadTime
             citySet:(NSString*)citySet
             version:(NSString*)version
      photoLocalPath:(NSString*)photoLocalPath
  andPhotoServerPath:(NSString*)photoServerPath;

//当前用户是否存在于数据库,根据用户名判断
- (BOOL)isExist;

//更新数据库中该用户信息，根据userid
- (void)update;

//向数据库插入此条用户信息
//- (void)add;



@end
