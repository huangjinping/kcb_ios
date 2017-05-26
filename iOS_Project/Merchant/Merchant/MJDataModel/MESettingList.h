//
//  MESettingList.h
//  Merchant
//
//  Created by Wendy on 16/1/11.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Lm;
@interface MESettingList : NSObject

@property (nonatomic, assign) NSInteger ids;

@property (nonatomic, strong) NSArray *lm;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign)BOOL on;

@end
@interface Lm : NSObject

@property (nonatomic, copy) NSString *merid;

@property (nonatomic, assign) NSInteger sid;

@property (nonatomic, copy) NSString *mid;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *type;
@end

