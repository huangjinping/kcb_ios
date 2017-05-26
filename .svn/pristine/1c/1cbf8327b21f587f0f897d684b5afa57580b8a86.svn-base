//
//  YFInputBar.m
//  test
//
//  Created by 杨峰 on 13-11-10.
//  Copyright (c) 2013年 杨峰. All rights reserved.
//

#import "YFInputBar.h"
#import "AppDelegate.h"
@implementation YFInputBar


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        self.alpha = 0.8;
        self.frame = CGRectMake(0, CGRectGetMinY(frame), APP_WIDTH, CGRectGetHeight(frame));
        self.isMovie = NO;
        self.textView.tag = 10000;
        self.sendBtn.tag = 10001;
        
        //注册键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _originalFrame = frame;
}
//_originalFrame的set方法  因为会调用setFrame  所以就不在此做赋值；
-(void)setOriginalFrame:(CGRect)originalFrame
{
    self.frame = CGRectMake(0, CGRectGetMinY(originalFrame), APP_WIDTH, CGRectGetHeight(originalFrame));
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark get方法实例化输入框／btn
-(HPGrowingTextView *)textView
{
    if (!_textView) {
        _textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 5, 240*(APP_WIDTH/320), 40)];
        _textView.isScrollable = NO;
        _textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
        _textView.clipsToBounds = YES;
        _textView.layer.cornerRadius = 8;
        _textView.minNumberOfLines = 1;
        _textView.maxNumberOfLines = 3;
        // you can also set the maximum height in points with maxHeight
        // textView.maxHeight = 200.0f;
        _textView.returnKeyType = UIReturnKeyDone; //just as an example
        _textView.font = [UIFont systemFontOfSize:15.0f];
        _textView.delegate = self;
        _textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        _textView.backgroundColor = [UIColor whiteColor];
        //        _textView.placeholder = @"Type to see the textView grow!";
        [self addSubview:_textView];
    }
    return _textView;
}
//发送
-(UIButton *)sendBtn
{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_sendBtn setFrame:CGRectMake(270*(APP_WIDTH/320), _originalFrame.size.height/2-12, 40, 24)];
        [_sendBtn addTarget:self action:@selector(btnPress) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendBtn];
    }
    return _sendBtn;
}
- (void)btnPress{
    _textView.text = @"";
    [_textView resignFirstResponder];
}
#pragma mark selfDelegate method

-(void)sendBtnPress
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(inputBar:withInputString:)]) {
        [self.delegate inputBar:self  withInputString:self.textView.text];
    }
    if (self.clearInputWhenSend) {
        self.textView.text = @"";
    }
    if (self.resignFirstResponderWhenSend) {
        [self resignFirstResponder];
    }
}

#pragma mark keyboardNotification

- (void)keyboardWillShow:(NSNotification*)notification{
    
//    NSDictionary *infoDict = notification.userInfo;
//    NSString *infoStr = [infoDict objectForKey:UIKeyboardFrameEndUserInfoKey];
//    NSLog(@"-----------------infor = %@",infoStr);
    
    
    
    
    
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //如果self在键盘之下 才做偏移
    if (_isMovie) {
        if ([self convertYToWindow:CGRectGetMaxY(self.originalFrame)]>=_keyboardRect.origin.y)
        {
            //没有偏移 就说明键盘没出来，使用动画
            if (self.frame.origin.y== self.originalFrame.origin.y) {
                
                [UIView animateWithDuration:0.3
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     if ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0) {
                                         self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame)-20);
                                     }
                                     else{
                                         self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame));
                                     }
                                     
                                 } completion:nil];
            }
            else
            {
                if ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0) {
                    self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame)-20);
                }
                else{
                    self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame));
                }
                
            }
            
        }
        else
        {
            
        }
        return;
    }
    if (_isCarH) {
        if ([self convertYToWindow:CGRectGetMaxY(self.originalFrame)]>=_keyboardRect.origin.y)
        {
            //没有偏移 就说明键盘没出来，使用动画
            if (self.frame.origin.y== self.originalFrame.origin.y) {
                
                [UIView animateWithDuration:0.3
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     if ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0) {
                                         self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame)-98 + 34);
                                     }
                                     else{
                                         self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame)-98 + 34);
                                     }
                                     
                                 } completion:nil];
            }
            else
            {
                if ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0) {
                    self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame)-98 + 34);
                }
                else{
                    self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame)-98 + 34);
                }
                
            }
            
        }
        else
        {
            
        }
    }
    else{
        if ([self convertYToWindow:CGRectGetMaxY(self.originalFrame)]>=_keyboardRect.origin.y)
        {
            //没有偏移 就说明键盘没出来，使用动画
            if (self.frame.origin.y== self.originalFrame.origin.y) {
                
                [UIView animateWithDuration:0.3
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     if ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0) {
                                         self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame)-64);
                                     }
                                     else{
                                         self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame));
                                     }
                                     
                                 } completion:nil];
            }
            else
            {
                if ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0) {
                    self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame)-64);
                }
                else{
                    self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame));
                }
                
            }
            
        }
        else
        {
            
        }
    }

    
}

- (void)keyboardWillHide:(NSNotification*)notification{
    

    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
//                         self.transform = CGAffineTransformMakeTranslation(0, 0);
                         self.frame = CGRectMake(0, APP_HEIGHT+APP_Y, APP_WIDTH, 44);
                     } completion:nil];
}
#pragma  mark ConvertPoint
//将坐标点y 在window和superview转化  方便和键盘的坐标比对
-(float)convertYFromWindow:(float)Y
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    CGPoint o = [appDelegate.window convertPoint:CGPointMake(0, Y) toView:self.superview];
    return o.y;
    
}
-(float)convertYToWindow:(float)Y
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    CGPoint o = [self.superview convertPoint:CGPointMake(0, Y) toView:appDelegate.window];
    return o.y;
    
}
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    [_textField resignFirstResponder];
//}
-(float)getHeighOfWindow
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    
    
    return appDelegate.window.frame.size.height;
}
//返回按钮
- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self sendBtnPress];
        return NO;
    }
    return YES;
}

//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([text isEqualToString:@"\n"]) {
//        [self sendBtnPress];
//        return NO;
//    }
//    return YES;
//}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    self.frame = r;
}



//#pragma mark- Lable自适应 博文内容字体
//- (CGSize)getStringHeight:(NSString *)aString {
//    
//    CGSize size;
//    if ([[[UIDevice currentDevice] systemVersion]floatValue] < 7.0) {
//        
//        
//            UIFont *nameFont=[UIFont fontWithName:@"Heiti SC" size:16];
//            size=[aString sizeWithFont:nameFont constrainedToSize:CGSizeMake(250, 400) lineBreakMode:NSLineBreakByCharWrapping];
//    }
//    else{
//       
//            NSDictionary* dic =  @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
//            size = [aString boundingRectWithSize:CGSizeMake(250, 400)  options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
//        }
//    return size;
//}
//
//- (void)textViewDidChange:(UITextView *)textView{
//    
//    CGFloat height = [self getStringHeight:textView.text].height;
//    _textView.frame = CGRectMake(10, 10, 250, height);
//    
//}

-(BOOL)resignFirstResponder
{
    [self.textView resignFirstResponder];
    return [super resignFirstResponder];
}
@end
