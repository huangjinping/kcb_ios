//
//  ABBDropDatepickerView.h
//  ReimbursementForABB
//
//  Created by Crystal on 15/11/9.
//  Copyright © 2015年 wendy. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ABBDropDatepickerView : UIView
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) UIDatePicker *picker;
@property (nonatomic,copy) void(^commplete)(id string);

- (void)setDateTitle:(NSString *)title;
@end
