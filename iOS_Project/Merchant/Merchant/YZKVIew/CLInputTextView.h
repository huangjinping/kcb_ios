//
//  CLInputTextView.h
//  RongChuang
//
//  Created by cooperLink on 15/4/15.
//  Copyright (c) 2015年 cooperlink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZKAlertView.h"


@interface CLInputTextView : UIView<UITextViewDelegate>

@property (nonatomic, strong) UITextView *inputView;
@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *contentText;
@property (nonatomic, assign) NSInteger textViewMaxLength;

- (void)creatInputView;

@end
