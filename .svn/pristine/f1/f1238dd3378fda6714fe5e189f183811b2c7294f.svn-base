//
//  YZKAlertView.h
//  TestAlert
//
//  Created by yzk on 14/11/13.
//  Copyright (c) 2014年 Seungbo Cho. All rights reserved.
//

//自定义alertView，可以随意更改颜色样式

//eg:
//YZKAlertView *alert = [[YZKAlertView alloc] init];
//[alert YZKAlertTitle:@"title"
//                body:@"message"
//                left:[RIButtonItem itemWithLabel:@"Cancle"]
//               right:[RIButtonItem itemWithLabel:@"Other"]];

#define DO_RGB(r, g, b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define DO_RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


#define YZKALERT_COLOR                      DO_RGBA(0, 0, 0, 0.4)

#define YZKALERT_TITLE_BACKGROUNDCOLOR      DO_RGBA(255, 255, 255, 0.95)
#define YZKALERT_TITLE_COLOR                DO_RGB(0, 0, 0)
#define YZKALERT_TITLE_FONT                 [UIFont fontWithName:@"Avenir-Heavy" size:17]
#define YZKALERT_TITLE_INSET                UIEdgeInsetsMake(25, 10, 5, 10)

#define YZKALERT_BODY_BACKGROUNDCOLOR       YZKALERT_TITLE_BACKGROUNDCOLOR
#define YZKALERT_BODY_COLOR                 DO_RGB(0, 0, 0)
#define YZKALERT_BODY_FONT                  [UIFont fontWithName:@"Avenir-Medium" size:16]
#define YZKALERT_BODY_INSET                 UIEdgeInsetsMake(0, 10, 20, 10)

#define YZKALERT_BUTTON_BACKGROUNDCOLOR     YZKALERT_TITLE_BACKGROUNDCOLOR
#define YZKALERT_BUTTON_COLOR               DO_RGB(0, 114, 249)
#define YZKALERT_BUTTON_FONT                [UIFont fontWithName:@"Avenir-Medium" size:17]

typedef enum {
    YZKAlertTransitionStyleFade = 0,
    YZKAlertTransitionStyleTopDown,
    YZKAlertTransitionStyleBottomUp,
    YZKAlertTransitionStylePop,
    YZKAlertTransitionStyleLine
}YZKAlertTransitionStyle;

#import <UIKit/UIKit.h>
#import "RIButtonItem.h"

@interface YZKAlertView : UIView

@property (readwrite)   YZKAlertTransitionStyle nAnimationType;
@property (readwrite)   double      dRound;
@property (readonly)    NSInteger   nTag;

- (void)YZKAlertTitle:(NSString *)strTitle
                 body:(NSString *)strBody
                 left:(RIButtonItem *)yes
                right:(RIButtonItem *)no;

- (void)YZKAlertTitle:(NSString *)strTitle
                 body:(NSString *)strBody
             duration:(double)dDuration
                 done:(RIButtonItem *)done;

@end
