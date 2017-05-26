//
//  HomeWeatherView.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/10.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "HomeWeatherView.h"

@interface HomeWeatherView ()

{
    UIImageView         *_weatherLogoImgView;
    UILabel             *_weatherTempL;
    UILabel             *_updateTimeL;
    UILabel             *_weatherDescripeL;
    
    UILabel             *_xianxingLabel;
    UILabel             *_xianxingL0;
    UILabel             *_xianxingL1;

}

@end

@implementation HomeWeatherView

- (id)init{
    if (self = [super init]) {
        self.backgroundColor = COLOR_NAV;
        //30 + 25 + 30
        _weatherLogoImgView = [[UIImageView alloc] initWithFrame:LGRectMake(30, 50, 30 + 25 + 30, 30 + 25 + 30)];
        [self addSubview:_weatherLogoImgView];
        _weatherTempL = [[UILabel alloc] initWithFrame:LGRectMake(_weatherLogoImgView.r + 30, 50, 0, 30)];
        [_weatherTempL convertNewLabelWithFont:FONT_NOMAL textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
        [self addSubview:_weatherTempL];
        _updateTimeL = [[UILabel alloc] initWithFrame:LGRectMake(_weatherTempL.r + 5, 50 + 3, 0, 24)];
        [_updateTimeL convertNewLabelWithFont:FONT_NOTICE textColor:[UIColor redColor] textAlignment:NSTextAlignmentLeft];
        [self addSubview:_updateTimeL];
        _weatherDescripeL = [[UILabel alloc] initWithFrame:LGRectMake(_weatherLogoImgView.r + 30, _weatherTempL.b + 15, 0, 30)];
        [_weatherDescripeL convertNewLabelWithFont:FONT_NOMAL textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
        [self addSubview:_weatherDescripeL];
        
        _xianxingLabel = [[UILabel alloc] initWithFrame:LGRectMake(APP_PX_WIDTH - 120 - 30, 50, 120, 30)];
        [_xianxingLabel convertNewLabelWithFont:FONT_NOMAL textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
        _xianxingLabel.text = @"今日限行";
        [self addSubview:_xianxingLabel];
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:LGRectMake(APP_PX_WIDTH- 30 - 30, _xianxingLabel.b + 15, 30, 30)];
        [imgView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:imgView];
        _xianxingL1 = [[UILabel alloc] initWithFrame:LGRectMake(APP_PX_WIDTH- 30 - 30, _xianxingLabel.b + 15, 30, 30)];
        [_xianxingL1 convertNewLabelWithFont:FONT_NOMAL textColor:[UIColor redColor] textAlignment:NSTextAlignmentCenter];
        [self addSubview:_xianxingL1];

        imgView = [[UIImageView alloc]initWithFrame:LGRectMake(_xianxingL1.l - 15 - 30, _xianxingL1.t, 30, 30)];
        [imgView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:imgView];
        _xianxingL0 = [[UILabel alloc] initWithFrame:LGRectMake(_xianxingL1.l - 15 - 30, _xianxingL1.t, 30, 30)];
        [_xianxingL0 convertNewLabelWithFont:FONT_NOMAL textColor:[UIColor redColor] textAlignment:NSTextAlignmentCenter];
        [self addSubview:_xianxingL0];
        
        //判断数据库是否有天气数据
        NSArray *arr = [[DataBase sharedDataBase] selectWeather];
        if ([arr count]) {
            [self reloadWeather];
        }
        //判断数据库是否有限行数据
        arr = [[DataBase sharedDataBase] selectXianxing];
        if ([arr count]) {
            [self reloadXianxing];
        }
    }
    return self;
}


- (void)reloadWeather{
    
    Weather *wea = [[[DataBase sharedDataBase] selectWeather] lastObject];
    //http://api.map.baidu.com/images/weather/day/qing.png
    NSArray *urlComponents = [wea.logoUrl componentsSeparatedByString:@"/"];
    NSString *package = [urlComponents objectAtIndex:5];
    NSString *imageName = [urlComponents objectAtIndex:6];
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"" inDirectory:[NSString stringWithFormat:@"百度天气接口图标/%@", package]];
    [_weatherLogoImgView setImage:[UIImage imageWithContentsOfFile:path]];
    
    [_weatherTempL setText:wea.temp];
    [_weatherTempL setSize:[_weatherTempL.text sizeWithFont:_weatherTempL.font constrainedToSize:CGSizeMake(10000, _weatherTempL.height)]];
    [_updateTimeL setFrame:LGRectMake(_weatherTempL.r + 50, 50 + 5, 0, 24)];
    
    NSTimeInterval interval = -[[wea.updateTime date] timeIntervalSinceNow];
    NSInteger day = interval/(60*60*24);
    NSInteger hou = (interval - day*60*60*24)/(60*60);
    NSInteger min = (interval - day*60*60*24 - hou*60*60)/60;
    NSString *str = @"";
    if (day > 0 ) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%d天前", (int)day]];
    }else if (hou > 0) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%d小时前", (int)hou]];
    }else if (min > 1) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%d分钟前", (int)min]];
    }
    [_updateTimeL setText:str];
    [_updateTimeL setSize:[_updateTimeL.text sizeWithFont:_updateTimeL.font constrainedToSize:CGSizeMake(10000, _updateTimeL.height)]];
    
    [_weatherDescripeL setText:[NSString stringWithFormat:@"%@  %@洗车", wea.des, wea.xiche]];
    [_weatherDescripeL setSize:[_weatherDescripeL.text sizeWithFont:_weatherDescripeL.font constrainedToSize:CGSizeMake(10000, _weatherDescripeL.height)]];
    

}

- (void)reloadXianxing{
    
    NSArray *xianxingArr = [[DataBase sharedDataBase] selectXianxing];
    if ([xianxingArr count] == 0) {
        return;
    }
    Xianxing *xianxing = [xianxingArr lastObject];
    NSDate *sd = [xianxing.startDate convertToDateWithFormat:@"yy/MM/dd"];
    NSDate *ed = [xianxing.endDate convertToDateWithFormat:@"yy/MM/dd"];
    NSTimeInterval timeF = [sd timeIntervalSinceNow];//应为负数
    NSTimeInterval timeZ = [ed timeIntervalSinceNow];//应为正数
    if (timeF < 0 && timeZ > 0) {
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *specialDict = [parser objectWithString:xianxing.specialDate];
        NSArray *specialDates = [specialDict allKeys];
        NSString *now = [[NSDate date] stringWithFormat:@"yy/MM/dd"];
        NSString *xianxingString = @"";
        for (NSString *specialDate in specialDates) {
            if ([now isEqualToString:specialDate]) {
                xianxingString = [specialDict objectForKey:specialDate];
                break;
            }
        }
        if ([xianxingString isEqualToString:@""]) {
            NSString *weekDay = [[NSDate date] weekDay];
            if ([weekDay isEqualToString:@"星期一"]) {
                xianxingString = xianxing.monday;
            }else if ([weekDay isEqualToString:@"星期二"]) {
                xianxingString = xianxing.tuesday;
                
            }else if ([weekDay isEqualToString:@"星期三"]) {
                xianxingString = xianxing.wednesday;
                
            }else if ([weekDay isEqualToString:@"星期四"]) {
                xianxingString = xianxing.thursday;
                
            }else if ([weekDay isEqualToString:@"星期五"]) {
                xianxingString = xianxing.friday;
                
            }else if ([weekDay isEqualToString:@"星期六"]) {
                xianxingString = xianxing.saturday;
                
            }else if ([weekDay isEqualToString:@"星期日"]) {
                xianxingString = xianxing.sunday;
                
            }
            
        }
        NSArray *a = [xianxingString componentsSeparatedByString:@","];
        //APP_DELEGATE.xianxing = xianxingString;
        if ([a count] == 2) {
            [_xianxingL0 setText:[a objectAtIndex:0]];
            [_xianxingL1 setText:[a objectAtIndex:1]];
        }else{
            if ([xianxingString isEqualToString:@"false"]) {
                [_xianxingL1 setText:@"限"];
                [_xianxingL0 setText:@"不"];
            }else{
                [_xianxingL1 setText:@""];
                [_xianxingL0 setText:xianxingString];
            }
            
        }

    }else{
        [_xianxingL1 setText:@"知"];
        [_xianxingL0 setText:@"未"];
    }
    
    
    

   

}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
