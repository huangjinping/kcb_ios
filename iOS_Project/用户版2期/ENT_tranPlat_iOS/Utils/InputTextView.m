//
//  InputTextView.m
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/1/20.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "InputTextView.h"

// inputView
#define kInputViewTextColor [UIColor colorWithHex:0xe5e5e5]  //b2b2b2
#define kTextFontSize (17)

@implementation InputTextView
{
    UIControl *_endEditControl;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatInputView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _countLabel.hidden = self.hideCountLabel;
    
    if (_endEditControl) {
        return;
    }
    _endEditControl = [[UIControl alloc] initWithFrame:self.viewController.view.bounds];
    _endEditControl.backgroundColor = [UIColor clearColor];
    _endEditControl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [_endEditControl addTarget:self action:@selector(endEditEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.viewController.view addSubview:_endEditControl];
    _endEditControl.hidden = YES;
}

- (void)endEditEvent {
    [self.viewController.view endEditing:YES];
}

#pragma mark - 创建 inputView

-(void)creatInputView
{
    UIFont *font = FONT_SIZE(15, x_6_SCALE);
    
    _inputView = [[UITextView alloc] initWithFrame:self.bounds];
    _inputView.height             = self.bounds.size.height - 30;
    _inputView.delegate           = self;
    [_inputView addBorderWithWidth:1 color:kInputViewTextColor corner:3];
    _inputView.backgroundColor    = [UIColor whiteColor];
    _inputView.font               = font;
    _inputView.textContainerInset = UIEdgeInsetsMake(8, 10, 8, 10);
    [self addSubview:_inputView];
    
    
    _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_inputView.textContainerInset.left+3, _inputView.textContainerInset.top+3, _inputView.width-(_inputView.textContainerInset.left+_inputView.textContainerInset.right), 17)];
    _placeLabel.font            = font;
    _placeLabel.backgroundColor = [UIColor clearColor];
    _placeLabel.textColor       = kInputViewTextColor;
    [_inputView addSubview:_placeLabel];
    
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(_inputView.x, _inputView.bottom, _inputView.width, 25)];
    _countLabel.text            = [@(_textViewMaxLength) stringValue];
    _countLabel.font            = FONT_SIZE(16, x_6_SCALE);
    _countLabel.backgroundColor = [UIColor clearColor];
    _countLabel.textAlignment   = NSTextAlignmentRight;
    _countLabel.textColor       = kTextGrayColor;
//    [self addSubview:_countLabel];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeLabel.text = placeholder;
}
- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    _placeLabel.attributedText = attributedPlaceholder;
}

- (void)setTextViewMaxLength:(NSInteger)textViewMaxLength
{
    _textViewMaxLength = textViewMaxLength;
    _countLabel.text = [@(_textViewMaxLength) stringValue];
}

- (void)setBorderColor:(UIColor *)color corner:(CGFloat)corner{
    [_inputView addBorderWithWidth:1 color:color corner:corner];
}

#pragma mark - textView delegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *string = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (string.length > _textViewMaxLength) {
        textView.text = [string substringToIndex:_textViewMaxLength];
        _countLabel.text = @"0";
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.placeLabel.hidden = !(textView.text.length == 0);
    
    if ( _textViewMaxLength - (NSInteger)textView.text.length >=0 ) {
        _countLabel.text = [@(_textViewMaxLength - textView.text.length) stringValue];
    }
}


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self.viewController.view bringSubviewToFront:_endEditControl];
    _endEditControl.hidden = NO;
    
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [self.viewController.view sendSubviewToBack:_endEditControl];
    _endEditControl.hidden = YES;
}

@end
