//
//  RegisterDescribeCell.m
//  Merchant
//
//  Created by xinpenghe on 15/12/22.
//  Copyright © 2015年 tranPlat. All rights reserved.
//

#import "RegisterDescribeCell.h"

@implementation RegisterDescribeCell
{
    UITextView *_tv;
    
    UILabel *_holderLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _tv = [[UITextView alloc]init];
        _tv.delegate = self;
        _holderLabel = [[UILabel alloc]init];
        _holderLabel.textColor = [UIColor lightGrayColor];
        _holderLabel.font = SYS_FONT_SIZE(14);
        _holderLabel.text = @"门店描述";
        
        [self.contentView addSubview:_tv];
        [_tv addSubview:_holderLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _tv.frame = LGRectMake(0, 0, APP_WIDTH/PX_X_SCALE, self.height/PX_Y_SCALE);
    _holderLabel.frame = CGRectMake(8*PX_X_SCALE, 2*PX_Y_SCALE, self.width, self.height/3);
}

-(void)textViewDidChange:(UITextView *)textView{
    if ([textView.text isEqualToString:@""] || textView.text == nil) {
        _holderLabel.text = @"门店描述";
    }else{
        _holderLabel.text = nil;
    }
}

@end
