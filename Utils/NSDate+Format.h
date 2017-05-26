//
//  NSDate+Format.h
//  xiwu
//
//  Created by yzk on 14-7-21.
//  Copyright (c) 2014年 cooperLink. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    
    DateFormatWithAll,               // 2014-03-04 13:23:35:67
    DateFormatWithAllOther,          // 2014-03-04 13:23:35.67
    DateFormatWithDateAndTime,       // 2014-03-04 13:23:35
    DateFormatWithDateAndMinite,     // 2014-03-04 13:23
    
    DateFormatWithTime,              // 13:23:35
    DateFormatWithPreciseTime,       // 13:23:35:67
    DateFormatWithPreciseHour,       // 13
    DateFormatWithPreciseMin,        // 25
    
    DateFormatWithYearMonthDay,      // 2014-03-04
    DateFormatWithYearMonthDayOther, // 2014年03月04日
    DateFormatWithMonthDayMinte,     // 03月04日13时23分
    DateFormatWithMonthWithDay,      // 03月04日
    DateFormatWithHourWithMinte,     // 13时23分
    DateFormatWithMonthDayWithMinte, // 03月04日-13:23
    DateFormatWithYearMonth,         // 2014-03
    DateFormatWithMonthDay,          // 03-04
    DateFormatWithMonthDayAndMinte,  // 03-04 13:23
    DateFormatWithYear,              // 2014
    DateFormatWithMonth,             // 03
    DateFormatWithDay,               // 04
} DateFormat;

@interface NSDate (Format)

- (NSString *)stringWithDateFormat:(DateFormat)format;
- (NSDateComponents *)dateComponents;

@end

@interface NSString (Format)

- (NSString *)stringConverToDateFormat:(DateFormat)toFormat
                        fromDateFormat:(DateFormat)fromFormat;
- (NSDate *)dateWithDateFormat:(DateFormat)format;

@end
