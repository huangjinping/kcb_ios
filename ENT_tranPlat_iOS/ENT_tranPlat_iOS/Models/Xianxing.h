//
//  Xianxing.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/14.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Xianxing : NSObject

//限行信息表
/***************************************************************
 1、start_date
 2、end_date
 3、special_date
 4、monday
 5、tuesday
 6、wednesday
 7、thursday
 8、friday
 9、saturday
 10、sunday
 ***************************************************************/

@property (nonatomic , retain)  NSString    *startDate;
@property (nonatomic , retain)  NSString    *endDate;
@property (nonatomic , retain)  NSString    *specialDate;
@property (nonatomic , retain)  NSString    *monday;
@property (nonatomic , retain)  NSString    *tuesday;
@property (nonatomic , retain)  NSString    *wednesday;
@property (nonatomic , retain)  NSString    *thursday;
@property (nonatomic , retain)  NSString    *friday;
@property (nonatomic , retain)  NSString    *saturday;
@property (nonatomic , retain)  NSString    *sunday;

- (id)initWithStartDate:(NSString*)startDate
                endDate:(NSString*)endDate
            specialDate:(NSString*)specialDate
                 monday:(NSString*)monday
                tuesday:(NSString*)tuesday
              wednesday:(NSString*)wednesday
               thursday:(NSString*)thursday
                 friday:(NSString*)friday
               saturday:(NSString*)saturday
                 sunday:(NSString*)sunday;

- (void)addToDB;
- (void)updateToDB;

@end
