//
//  ZijiayouCard.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/1.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZijiayouCard : NSObject
/*
 {
 actualPrice = 800;
 address = "\U4e91\U5357\U7701\U6606\U660e\U5e02\U5b98\U6e21\U533a\U5927\U5546\U6c47\U5bf9\U9762\U534e\U90fd\U82b1\U56ed\U65c1\U590f\U9038\U96c5\U5b9b13\Uff0d5\U53f7\U5546\U94fa";
 cityName = "\U6606\U660e";
 createtime = "2015-06-03 08:47:30";
 des = "\U6d17\U8f66\U3001\U6c7d\U8f66\U7f8e\U5bb9";
 endtime = "2015-07-01 17:04:25";
 isdelete = 0;
 isrecommend = 1;
 itemCreatetime = "2015-06-03 17:01:19";
 itemDesc = "\U6d4b\U8bd5\U670d\U52a1\U9879\U76ee\U4e8c";
 itemId = 5;
 name = "\U6d4b\U8bd5\U670d\U52a1\U9879\U76ee\U4e8c";
 phone = "0871-64649949";
 pics = "http://pic.956122.com/allPic/BussClient/20150520/ff697513-9315-4989-885b-d8fd54275733.png,http://pic.956122.com/allPic/Buss/20150525/634514bb-6849-4be8-954e-a89dc260b8b7.png,http://pic.956122.com/allPic/Buss/20150525/6fa28aeb-37e7-4f75-8a7c-d2194aab83c6.png,http://pic.956122.com/allPic/Buss/20150528/ed11019e-b371-4989-8831-97da5186053c.png,";
 price = 1000;
 serviceItemId = 4;
 shopId = 20400;
 shopInfoName = "\U9ed1\U9ca8\U534e\U90fd\U5e97";
 shopIsdelete = 0;
 shopinfoId = 20400;
 starttime = "2015-06-03 17:05:25";
 },
 */

@property (nonatomic) NSString  *actualPrice;
@property (nonatomic) NSString  *address;
@property (nonatomic) NSString  *cityName;
@property (nonatomic) NSString  *createtime;
@property (nonatomic) NSString  *des;
@property (nonatomic) NSString  *endtime;
@property (nonatomic) NSString  *isdelete;
@property (nonatomic) NSString  *isrecommend;
@property (nonatomic) NSString  *itemCreatetime;
@property (nonatomic) NSString  *itemDesc;
@property (nonatomic) NSString  *itemId;
@property (nonatomic) NSString  *name;
@property (nonatomic) NSString  *phone;
@property (nonatomic) NSString  *pics;
@property (nonatomic) NSString  *price;
@property (nonatomic) NSString  *serviceItemId;
@property (nonatomic) NSString  *shopId;
@property (nonatomic) NSString  *shopInfoName;
@property (nonatomic) NSString  *shopIsdelete;
@property (nonatomic) NSString  *shopinfoId;
@property (nonatomic) NSString  *starttime;
@property (nonatomic) NSString  *titlePic;

@property (nonatomic) NSString  *shopType;
@property (nonatomic) NSString  *closetime;
@property (nonatomic) NSString  *opentime;
@property (nonatomic) NSString  *grade;
@property (nonatomic) NSString  *contacts;
@property (nonatomic) NSString  *detail;




- (id)initWithActualPrice:(NSString*)actualPrice
                    address:(NSString*)address
                   cityName:(NSString*)cityName
                 createtime:(NSString*)createtime
                        des:(NSString*)des
                    endtime:(NSString*)endtime
                   isdelete:(NSString*)isdelete
                isrecommend:(NSString*)isrecommend
             itemCreatetime:(NSString*)itemCreatetime
                   itemDesc:(NSString*)itemDesc
                     itemId:(NSString*)itemId
                       name:(NSString*)name
                      phone:(NSString*)phone
                       pics:(NSString*)pics
                      price:(NSString*)price
              serviceItemId:(NSString*)serviceItemId
                     shopId:(NSString*)shopId
               shopInfoName:(NSString*)shopInfoName
               shopIsdelete:(NSString*)shopIsdelete
                 shopinfoId:(NSString*)shopinfoId
                  starttime:(NSString*)starttime
                 shopType:(NSString*)shopType
                closetime:(NSString*)closetime
                 opentime:(NSString*)opentime
                    grade:(NSString*)grade
                 contacts:(NSString*)contacts
                   detail:(NSString*)detail
              andTitlePic:(NSString*)titlePic;
@end
