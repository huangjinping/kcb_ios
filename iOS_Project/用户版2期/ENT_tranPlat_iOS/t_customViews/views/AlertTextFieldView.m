//
//  ENTAlertTextFieldView.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-26.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "AlertTextFieldView.h"

@implementation AlertTextFieldView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//- (void)finishedEntry{
//    if ([self._delegate respondsToSelector:@selector(entAlertTextFieldView:didFinishedEntry:)]) {
//        NSMutableArray *texts = [[NSMutableArray alloc] initWithCapacity:0];
//        for (id obj in self.subviews) {
//            if ([obj isKindOfClass:[UITextField class]]) {
//                [texts addObject:((UITextField*)obj).text];
//            }
//        }
//        
//        [self._delegate entAlertTextFieldView:self didFinishedEntry:texts];
//    }
//}

- (void)removeView{
    [_bgView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)addView{
    
    _bgView = [[UIView alloc] initWithFrame:_sender.view.bounds];
    _bgView.backgroundColor = [UIColor lightGrayColor];
    _bgView.alpha = 0.5f;
    [_sender.view addSubview:_bgView];
    [_sender.view addSubview:self];

}

- (void)show{
    CGRect frame = self.frame;
    [self setFrame:CGRectMake(frame.origin.x, APP_HEIGHT, frame.size.width, frame.size.height)];
    
//    for (UIView *v in self.subviews) {
//        v.hidden = YES;
//    }
    [self addView];
    
    [UIView animateWithDuration:0.5f animations:^{
        [self setFrame:frame];
        
        
    } completion:^(BOOL finished) {
//        for (UIView *v in self.subviews) {
//            v.hidden = NO;
//        }

        
    }];
    
    
}

- (id)initWithTarget:(UIViewController*)sender selector:(SEL)sel placehoders:(NSArray*)placehoderStrings{
    
    
    CGFloat space_x = 30;
    CGFloat rowHeight = 40;
    CGFloat tfHeight = 30;
    CGFloat tfSpace_x = 20;
    CGFloat tfSpace_y = 25;

    CGFloat height = rowHeight * (placehoderStrings.count +1) + 40;
    CGRect frame = CGRectMake(space_x, (APP_HEIGHT - APP_VIEW_Y - APP_NAV_HEIGHT - height)/2, APP_WIDTH - space_x*2, height);
    
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
        
        _sender = sender;
        _sel = sel;
        
        [self setImage:[UIImage imageNamed:@"bg_alert_tf.png"]];
        for (int i = 0; i <= [placehoderStrings count]; i++) {
            
            CGRect rect = CGRectMake(tfSpace_x, tfSpace_y + rowHeight*i, frame.size.width - 2*tfSpace_x, tfHeight);
            
            if (i == [placehoderStrings count]) {
                UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [cancelButton setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width/2 - 10, rect.size.height)];
                [cancelButton setBackgroundColor:COLOR_BUTTON_BLUE];
                [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
                [cancelButton addTarget:self action:@selector(cancelEntry) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:cancelButton];
                
                UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
                [Button setFrame:CGRectMake(cancelButton.right + 10, cancelButton.top, cancelButton.width, cancelButton.height)];
                [Button setBackgroundColor:COLOR_BUTTON_BLUE];
                [Button setTitle:@"确定" forState:UIControlStateNormal];
                [Button addTarget:self action:@selector(didFinishEntry) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:Button];
                break;
            }
            
            NSString *placeholder = [placehoderStrings objectAtIndex:i];
            UITextField *tf = [[UITextField alloc] initWithFrame:rect];
            [self addSubview:tf];
            tf.placeholder = placeholder;
            tf.textAlignment = NSTextAlignmentLeft;
            tf.borderStyle = UITextBorderStyleLine;
            tf.delegate = self;
        }
        
    }
    return self;
}

- (void)didFinishEntry{
    
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [obj resignFirstResponder];
        }
    }

    
    if ([_sender respondsToSelector:_sel]) {
        [_sender performSelector:_sel withObject:self];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [self removeView];
    }
}

- (void)cancelEntry{
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [obj resignFirstResponder];
        }
    }
    [UIView animateWithDuration:0.5 animations:^{
        
        [self setFrame:CGRectMake(self.frame.origin.x, 600, self.width, self.height)];

    } completion:^(BOOL finished) {
        [self removeView];

    }];
    
}


- (NSString*)textAtIndex:(NSInteger)index{
    id obj = [self.subviews objectAtIndex:index];
    if (obj) {
        if ([obj isKindOfClass:[UITextField class]]) {
            return ((UITextField*)obj).text;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
    
}

- (void)keyboardWillAppear:(NSNotification*)notify{
    NSDictionary *userInfo = [notify userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    CGPoint point = self.frame.origin;

    CGFloat tfTail = point.y + self.frame.size.height;
    _offset =  tfTail + keyboardRect.size.height - APP_HEIGHT;
    
    
    if (_offset > 0) {
        
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y - _offset, self.frame.size.width, self.frame.size.height)];
    }

}



#pragma mark- text filed delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + _offset, self.frame.size.width, self.frame.size.height)];
    _offset = 0;
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
