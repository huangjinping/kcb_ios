//
//  UserInfo.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-15.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "UserInfo.h"


@implementation UserInfo


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
  andPhotoServerPath:(NSString*)photoServerPath{
    if (self = [super init]) {
        _userId = [[NSString alloc] initWithString:userId];
        _isActive = [[NSString alloc] initWithString:isActive];
        _userName = [[NSString alloc] initWithString:userName];
        _password = [[NSString alloc] initWithString:password];
        _email = [[NSString alloc] initWithString:email];
        _contactNum = [[NSString alloc] initWithString:contactNum];
        _postCode = [[NSString alloc] initWithString:postCode];
        _realName = [[NSString alloc] initWithString:realName];
        _addr = [[NSString alloc] initWithString:addr];
        _registTime = [[NSString alloc] initWithString:registTime];
        _verifyStatus = [[NSString alloc] initWithString:verifyStatus];
        _loadTime = [[NSString alloc] initWithString:loadTime];
        _citySet = [[NSString alloc] initWithString:citySet];
        _version = [[NSString alloc] initWithString:version];
        _photoLocalPath = [[NSString alloc] initWithString:photoLocalPath];
        _photoServerPath = [[NSString alloc] initWithString:photoServerPath];
    }
    return self;
}



//当前用户是否存在于数据库,根据用户名判断
- (BOOL)isExist{
    NSArray *a = [[DataBase sharedDataBase] selectUserByName:self.userName];
    if ([a count]) {
        return YES;
    }else{
        return NO;
    }
}

//更新数据库中该用户信息，根据userid
- (void)update{
    NSArray *arr = [[DataBase sharedDataBase] selectUserByName:self.userName];
    if ([arr count]) {
        //将新登录的用户userid与数据库<同名用户>userid'同步'
        self.userId = ((UserInfo*)[arr lastObject]).userId;
        [[DataBase sharedDataBase] updateUserInfo:self];
    }else{
        [self add];
    }
}

//向数据库插入此条用户信息
- (void)add{
    [[DataBase sharedDataBase] insertUserInfo:self];
}


@end
