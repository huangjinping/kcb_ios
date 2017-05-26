//
//  ZijiayouCard.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/1.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "ZijiayouCard.h"

@implementation ZijiayouCard


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
              andTitlePic:(NSString*)titlePic{
    if (self = [super init]) {
        _actualPrice = [[NSString alloc] initWithString:actualPrice];
        _address = [[NSString alloc] initWithString:address];
        _cityName = [[NSString alloc] initWithString:cityName];
        _createtime = [[NSString alloc] initWithString:createtime];
        _des = [[NSString alloc] initWithString:des];
        _endtime = [[NSString alloc] initWithString:endtime];
        _isdelete = [[NSString alloc] initWithString:isdelete];
        _isrecommend = [[NSString alloc] initWithString:isrecommend];
        _itemCreatetime = [[NSString alloc] initWithString:itemCreatetime];
        _itemDesc = [[NSString alloc] initWithString:itemDesc];
        _itemId = [[NSString alloc] initWithString:itemId];
        _name = [[NSString alloc] initWithString:name];
        _phone = [[NSString alloc] initWithString:phone];
        _pics = [[NSString alloc] initWithString:pics];
        _price = [[NSString alloc] initWithString:price];
        _serviceItemId = [[NSString alloc] initWithString:serviceItemId];
        _shopId = [[NSString alloc] initWithString:shopId];
        _shopInfoName = [[NSString alloc] initWithString:shopInfoName];
        _shopIsdelete = [[NSString alloc] initWithString:shopIsdelete];
        _shopinfoId = [[NSString alloc] initWithString:shopinfoId];
        _starttime = [[NSString alloc] initWithString:starttime];
        _titlePic = [[NSString alloc] initWithString:titlePic];
        
        _shopType = [[NSString alloc] initWithString:shopType];
        _closetime = [[NSString alloc] initWithString:closetime];
        _opentime = [[NSString alloc] initWithString:opentime];
        _grade = [[NSString alloc] initWithString:grade];
        _contacts = [[NSString alloc] initWithString:contacts];
        _detail = [[NSString alloc] initWithString:detail];

    }
    return self;
}

@end
