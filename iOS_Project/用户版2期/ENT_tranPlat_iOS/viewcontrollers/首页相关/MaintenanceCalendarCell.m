//
//  MaintenanceCalendarCell.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/11.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "MaintenanceCalendarCell.h"
#import "ABBCalendarView.h"

@interface MaintenanceCalendarCell()<ABBCalendarDelegate>

@end

@implementation MaintenanceCalendarCell
{
    ABBCalendarView *_calendarV;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _calendarV = [[ABBCalendarView alloc]initWithStartDay:startSunday frame:CGRectMake(0, 0, APP_WIDTH, 0)];
        _calendarV.delegate = self;
        
        [self.contentView addSubview:_calendarV];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _calendarV.height = self.contentView.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    self.backgroundColor = [UIColor clearColor];
}

- (void)calendar:(ABBCalendarView *)calendar didSelectDate:(NSDate *)date{
    if (_commplete) {
        _commplete(date);
    }
}

@end
