//
//  YFInputBar.h
//  test
//
//  Created by 杨峰 on 13-11-10.
//  Copyright (c) 2013年 杨峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@class HPGrowingTextView;
@class YFInputBar;
@protocol YFInputBarDelegate <NSObject>

//-(void)inputBar:(YFInputBar*)inputBar sendBtnPress:(UIButton*)sendBtn withInputString:(NSString*)str;
-(void)inputBar:(YFInputBar*)inputBar  withInputString:(NSString*)str;

@end
@interface YFInputBar : UIView<UITextViewDelegate,HPGrowingTextViewDelegate>

//代理 用于传递btn事件
@property(assign,nonatomic)id<YFInputBarDelegate> delegate;
//这两个可以自己付值
@property(strong,nonatomic) HPGrowingTextView *textView;

@property(strong,nonatomic)UIButton *sendBtn;

//点击btn时候 清空textfield  默认NO
@property(assign,nonatomic)BOOL clearInputWhenSend;
//点击btn时候 隐藏键盘  默认NO
@property(assign,nonatomic)BOOL resignFirstResponderWhenSend;

//初始frame
@property(assign,nonatomic) CGRect originalFrame;

@property (nonatomic, assign) int tagCount;
//判断状态 YES 为评论 NO为回复
@property (nonatomic, assign) BOOL pingOrHui;
//是否为视频界面
@property (nonatomic, assign) BOOL  isMovie;
//是否为车友互动界面
@property (nonatomic, assign) BOOL  isCarH;

//被回复人id
@property (nonatomic ,copy) NSString *peplyuid;
//隐藏键盘
-(BOOL)resignFirstResponder;
@end
