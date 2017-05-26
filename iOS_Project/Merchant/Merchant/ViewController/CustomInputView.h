//
//  CustomInputView.h
//  Merchant
//
//  Created by Wendy on 16/1/6.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomInputView : UIView
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeholder:(NSString *)placeholder value:(NSString *)text;

- (void)setRightImage:(NSString *)image;
- (void)setTextField:(NSString *)text;

@property (nonatomic, copy)void (^commplete)(void);
@property (nonnull, copy)NSString *text;
@end
