//
//  InputTextView.h
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/1/20.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputTextView : UIView<UITextViewDelegate>

@property (nonatomic, strong) UITextView *inputView;
@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) NSString *contentText;
@property (nonatomic, assign) NSInteger textViewMaxLength;

@property (nonatomic, assign) BOOL hideCountLabel;

- (void)setBorderColor:(UIColor *)color corner:(CGFloat)corner;

@end
