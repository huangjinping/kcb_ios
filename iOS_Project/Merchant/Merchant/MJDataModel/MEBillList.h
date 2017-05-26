//
//  MEBillList.h
//  Merchant
//
//  Created by Wendy on 16/2/1.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Mybill;
@interface MEBillList : NSObject

@property (nonatomic, strong) NSArray *myBill;

@property (nonatomic, copy) NSString *sumPrice;

@end
@interface Mybill : NSObject

@property (nonatomic, copy) NSString *successTime;

@property (nonatomic, copy) NSString *ids;

@property (nonatomic, copy) NSString *serviceName;

@property (nonatomic, copy) NSString *carName;

@property (nonatomic, copy) NSString *orderNo;

@property (nonatomic, copy) NSString *sr;

@property (nonatomic, copy) NSString *sectionTime;
@end

