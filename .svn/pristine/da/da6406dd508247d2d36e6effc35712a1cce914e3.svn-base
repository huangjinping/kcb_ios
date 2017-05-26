//
//  CLInputTextView.m
//  RongChuang
//
//  Created by cooperLink on 15/4/15.
//  Copyright (c) 2015年 cooperlink. All rights reserved.
//

#import "CLInputTextView.h"
#import "BaseViewController.h"

// inputView
#define kInputViewTextColor DO_RGB(120, 120, 120)
#define kTextFontSize (17)

@interface CLInputTextView ()

@end

@implementation CLInputTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatInputView];
    }
    return self;
}

#pragma mark - 创建 inputView

-(void)creatInputView
{
    _inputView = [[UITextView alloc] initWithFrame:self.bounds];
    _inputView.height = self.bounds.size.height - 30;
    _inputView.delegate = self;
    [_inputView addBorderWithWidth:0 color:[UIColor colorWithWhite:0.7 alpha:1] corner:7];
    _inputView.backgroundColor = [UIColor whiteColor];
    _inputView.textColor = kInputViewTextColor;
    _inputView.font = [UIFont systemFontOfSize:17];
    _inputView.textContainerInset = UIEdgeInsetsMake(8, 10, 8, 10);
    [self addSubview:_inputView];

    
    _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_inputView.textContainerInset.left+3, _inputView.textContainerInset.top+3, _inputView.width-(_inputView.textContainerInset.left+_inputView.textContainerInset.right), 17)];
    _placeLabel.text            = _placeholder;
    _placeLabel.font            = [UIFont systemFontOfSize:17];
    _placeLabel.backgroundColor = [UIColor clearColor];
    _placeLabel.textColor       = [UIColor colorWithHexString:@"#c7c7c7"];
    [_inputView addSubview:_placeLabel];
    
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(_inputView.x, _inputView.bottom, _inputView.width, 30)];
    _countLabel.text            = [@(_textViewMaxLength) stringValue];
    _countLabel.font            = [UIFont systemFontOfSize:16];
    _countLabel.backgroundColor = [UIColor clearColor];
    _countLabel.textAlignment   = NSTextAlignmentRight;
    _countLabel.textColor       = [UIColor colorWithHexString:@"#979899"];
    [self addSubview:_countLabel];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _placeLabel.text = _placeholder;
}

- (void)setTextViewMaxLength:(NSInteger)textViewMaxLength
{
    _textViewMaxLength = textViewMaxLength;
    _countLabel.text = [@(_textViewMaxLength) stringValue];
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
    if (self.viewController && [self.viewController isKindOfClass:[BaseViewController class]]) {
        [self.viewController.view bringSubviewToFront:((BaseViewController *)self.viewController).endEditControl];
        ((BaseViewController *)self.viewController).endEditControl.hidden = NO;
    }
    
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.viewController && [self.viewController isKindOfClass:[BaseViewController class]]) {
        [self.viewController.view sendSubviewToBack:((BaseViewController *)self.viewController).endEditControl];
        ((BaseViewController *)self.viewController).endEditControl.hidden = YES;
    }
}


@end
