//
//  DateSelectView.m
//  ywjk
//
//  Created by 李蒙 on 14-5-28.
//  Copyright (c) 2014年 picc. All rights reserved.
//

#import "DateSelectView.h"

@implementation DateSelectView

singleton_implementation(DateSelectView)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        [self createView:frame];
    }

    return self;
}

- (void)createView:(CGRect)frame
{
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, APP_HEIGHT - 216, APP_WIDTH, 216)];
    _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans"];
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    _datePicker.date = [NSDate date];

    [self addSubview:_datePicker];

    // 构造工具栏按钮
    UIButton *rightBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(10, 0, 60, 30);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"完成11"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor]];
    [rightBtn addTarget:self action:@selector(okButtonClick)];
    
    UIBarButtonItem *itemOK       = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];

//    UIBarButtonItem *itemOK = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(okButtonClick)];
    
    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 0, 60, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-4"] forState:UIControlStateNormal];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(cancelButtonClick)];
    UIBarButtonItem *itemCancel        = [[UIBarButtonItem alloc] initWithCustomView:btn];
//
//    UIBarButtonItem *itemCancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonClick)];
    NSArray *buttons = [NSArray arrayWithObjects:itemCancel, itemSpace, itemOK, nil];

    // 构造工具栏
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, APP_HEIGHT - 44 - 216, APP_WIDTH, 44)];
    toolbar.barStyle = UIBarStyleDefault;
    toolbar.translucent = YES;

    toolbar.items = buttons;

    [self addSubview:toolbar];

    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

#pragma mark 显示选择日期

- (void)showWithCompletion:(CompletionBlock)okButtonClickBlock
{
    self.okButtonClickBlock = okButtonClickBlock;

//    self.frame = CGRectMake(0, IPHONE_HEIGHT, IPHONE_WIDTH, IPHONE_HEIGHT);
    
    [UIView animateWithDuration:.5
                     animations:^{
        self.frame = CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT);
    }];
}

#pragma mark 点击确定

- (void)okButtonClick
{
    if (self.okButtonClickBlock) {
        self.okButtonClickBlock(_datePicker.date);
    }
    [self cancelButtonClick];
}

#pragma mark 点击取消

- (void)cancelButtonClick
{
    [UIView animateWithDuration:.25
                     animations:^{
        self.frame = CGRectMake(0, APP_HEIGHT, APP_WIDTH, APP_HEIGHT);
    }
                     completion:nil];

    [self.datePicker setMinimumDate:nil];
    [self.datePicker setMaximumDate:nil];
}

@end
