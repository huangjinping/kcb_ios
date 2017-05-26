//
//  NETHelper.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-10.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatNetwork.h"

@interface NETHelper : NSObject

//检测更新
+ (void)checkAppUpdate;


/**
 *  上传城市编码与车辆品牌信息，用于车友圈推荐相关好友
 */
+ (void)chatModifyCityAndCars;

/**
 *  从服务器获取当前用户的（未读）消息
 */
+ (void)fetchNotifycations;


//下载头像
+ (void)asynchronousDownloadPhotoImage;
   
@end
