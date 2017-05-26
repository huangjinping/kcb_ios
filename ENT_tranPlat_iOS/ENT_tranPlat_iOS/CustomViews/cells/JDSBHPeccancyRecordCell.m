//
//  JDSBHPeccancyRecordCell.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-4.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "JDSBHPeccancyRecordCell.h"

@implementation JDSBHPeccancyRecordCell



//@property(nonatomic, retain)  UILabel *sNumL;
//
//
//@property(nonatomic, retain)  UILabel *jdsbhL;
//@property(nonatomic, retain)  UITextView *jgTV;
//@property(nonatomic, retain)  UILabel *sjL;
//@property(nonatomic, retain)  UITextView *ddTV;
//@property(nonatomic, retain)  UILabel *jeL;
//
//
//@property(nonatomic, retain)  UIButton *payButton;


- (void)awakeFromNib
{
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        float bi = APP_WIDTH/320;
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 14, 304*bi, 224)];
        bgImageView.image = [UIImage imageNamed:@"bg_white.png"];
        [self.contentView addSubview:bgImageView];
        _sNumL = [[UILabel alloc]initWithFrame:CGRectMake(9, 14, 156, 153)];
        _sNumL.font = [UIFont systemFontOfSize:139];
        _sNumL.textAlignment = NSTextAlignmentCenter;
        _sNumL.textColor = [UIColor lightGrayColor];
        [bgImageView addSubview:_sNumL];
        
        UILabel *jL = [[UILabel alloc]initWithFrame:CGRectMake(30, 31, 85, 24)];
        jL.text = @"决定书编号:";
        jL.textAlignment = NSTextAlignmentRight;
        jL.textColor = COLOR_FONT_NOMAL;
        jL.font = [UIFont systemFontOfSize:15];
        jL.backgroundColor = [UIColor clearColor];
        [bgImageView addSubview:jL];
        
        _jdsbhL = [[UILabel alloc]initWithFrame:CGRectMake(131, 31, 163*bi, 24)];
        _jdsbhL.font = [UIFont systemFontOfSize:14];
        _jdsbhL.textAlignment = NSTextAlignmentLeft;
        _jdsbhL.textColor = COLOR_FONT_NOMAL;
        [bgImageView addSubview:_jdsbhL];
        
        UILabel *cL = [[UILabel alloc]initWithFrame:CGRectMake(51, 56, 75, 24)];
        cL.text = @"采集机关:";
        cL.textAlignment = NSTextAlignmentLeft;
        cL.textColor = COLOR_FONT_NOMAL;
        cL.font = [UIFont systemFontOfSize:15];
        cL.backgroundColor = [UIColor clearColor];

        [bgImageView addSubview:cL];
        
        _jgTV = [[UITextView alloc]initWithFrame:CGRectMake(125, 50, 169*bi, 43)];
        _jgTV.font = [UIFont systemFontOfSize:14];
        _jgTV.textAlignment = NSTextAlignmentLeft;
        _jgTV.textColor = COLOR_FONT_NOMAL;
        [bgImageView addSubview:_jgTV];

        UILabel *wL = [[UILabel alloc]initWithFrame:CGRectMake(51, 93, 75, 24)];
        wL.text = @"违法时间:";
        wL.textAlignment = NSTextAlignmentLeft;
        wL.textColor = COLOR_FONT_NOMAL;
        wL.font = [UIFont systemFontOfSize:15];
        wL.backgroundColor = [UIColor clearColor];

        [bgImageView addSubview:wL];

        _sjL = [[UILabel alloc]initWithFrame:CGRectMake(131, 93, 163*bi, 21)];
        _sjL.font = [UIFont systemFontOfSize:14];
        _sjL.textAlignment = NSTextAlignmentLeft;
        _sjL.textColor = COLOR_FONT_NOMAL;
        [bgImageView addSubview:_sjL];
        
        UILabel *dL = [[UILabel alloc]initWithFrame:CGRectMake(51, 116, 75, 24)];
        dL.text = @"违法地点:";
        dL.textAlignment = NSTextAlignmentLeft;
        dL.textColor = COLOR_FONT_NOMAL;
        dL.font = [UIFont systemFontOfSize:15];
        dL.backgroundColor = [UIColor clearColor];

        [bgImageView addSubview:dL];

        _ddTV = [[UITextView alloc]initWithFrame:CGRectMake(125, 110, 169*bi, 43)];
        _ddTV.font = [UIFont systemFontOfSize:14];
        _ddTV.textAlignment = NSTextAlignmentLeft;
        _ddTV.textColor = COLOR_FONT_NOMAL;
        [bgImageView addSubview:_ddTV];

        UILabel *fL = [[UILabel alloc]initWithFrame:CGRectMake(51, 156, 75, 24)];
        fL.text = @"罚款金额:";
        fL.textAlignment = NSTextAlignmentLeft;
        fL.textColor = COLOR_FONT_NOMAL;
        fL.font = [UIFont systemFontOfSize:15];
        fL.backgroundColor = [UIColor clearColor];

        [bgImageView addSubview:fL];
        
        _jeL = [[UILabel alloc]initWithFrame:CGRectMake(131, 157, 164*bi, 21)];
        _jeL.font = [UIFont systemFontOfSize:14];
        _jeL.textAlignment = NSTextAlignmentLeft;
        _jeL.textColor = COLOR_FONT_NOMAL;
        [bgImageView addSubview:_jeL];
        
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payButton setTitle:@"立即缴款" forState:UIControlStateNormal];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _payButton.frame = CGRectMake(58, 188, 204*bi, 30);
        _payButton.backgroundColor = [UIColor orangeColor];
        [bgImageView addSubview:_payButton];


    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
