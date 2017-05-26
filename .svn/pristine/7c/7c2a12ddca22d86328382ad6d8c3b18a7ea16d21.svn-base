
//
//  OutletCell.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/4.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "OutletCell.h"
#import "UILabel+Custom.h"

@implementation OutletCell
{
    UILabel *_nameLabel;
    UILabel *_fwLabel;
    UILabel *_datailLabel;
    UIImageView *_icon;
    UILabel *_distanceLabel;
    UILabel *_locationLabel;
    UILabel *_hplLabel;
    UILabel *_ddlLabel;

    CWStarRateView *_startView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kWhiteColor;
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 600*x_6_plus,50*y_6_plus )];
        _nameLabel.font = V3_38PX_FONT;
      
        _fwLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80*x_6_plus, 40*x_6_plus)];
        _fwLabel.font = V3_30PX_FONT;
        _fwLabel.text=@"服务:";
        _fwLabel.textColor=kTextGrayColor;

        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 210*x_6_plus, 210*x_6_plus)];
        _icon.contentMode = UIViewContentModeScaleAspectFit;
        [_icon addBorderWithWidth:1 color:kLineGrayColor];

        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(26*x_6_SCALE, 24*y_6_SCALE, 360, 38*y_6_plus)
                                               text:nil
                                               font:V3_30PX_FONT
                                          textColor:kTextGrayColor];
        
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(26*x_6_SCALE, 24*y_6_SCALE,320*x_6_plus, 48*y_6_plus)
                                               text:nil
                                               font:V3_30PX_FONT
                                          textColor:COLOR_BUTTON_YELLOW];
        _distanceLabel.textAlignment = NSTextAlignmentRight;
        
        _hplLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,320*x_6_plus, 48*y_6_plus)
                                                   text:nil
                                                   font:V3_30PX_FONT
                                              textColor:COLOR_BUTTON_YELLOW];
        
        _ddlLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,320*x_6_plus, 48*y_6_plus)
                                                   text:nil
                                                   font:V3_30PX_FONT
                                              textColor:COLOR_BUTTON_YELLOW];
        _startView=[[CWStarRateView alloc]initWithFrame:CGRectMake(0, 0, 270*x_6_plus, 50*y_6_plus) numberOfStars:5];
        _startView.userInteractionEnabled = NO;
        
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_icon];
        [self.contentView addSubview:_locationLabel];
        [self.contentView addSubview:_distanceLabel];
        [self.contentView addSubview:_fwLabel];
        [self.contentView addSubview:_startView];
        [self.contentView addSubview:_hplLabel];
        [self.contentView addSubview:_ddlLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
   _icon.origin = CGPointMake(45*x_6_plus,45*y_6_plus);
   
   _nameLabel.origin = CGPointMake(_icon.right+30*x_6_plus,45*y_6_plus);
   _distanceLabel.origin = CGPointMake(APP_WIDTH-40*x_6_plus-_distanceLabel.width,50*y_6_plus);
 _distanceLabel.centerY = _nameLabel.centerY;
    _fwLabel.origin=CGPointMake(_icon.right+30*x_6_plus, 0);
    _fwLabel.centerY = _icon.centerY;
    
    _startView.origin =CGPointMake(_fwLabel.right+10*x_6_plus, 0);
    _startView.centerY = _icon.centerY;
    _locationLabel.frame = CGRectMake(_icon.right+30*x_6_plus, _fwLabel.bottom+5*y_6_plus,350*x_6_plus, 80*y_6_plus);
    _locationLabel.numberOfLines=0;
    _hplLabel.origin = CGPointMake(_fwLabel.x, _locationLabel.bottom+5*y_6_plus);
    _ddlLabel.origin = CGPointMake(_hplLabel.right, _hplLabel.y);
}

- (void)configCellWithDic:(NSDictionary *)dic{
    _nameLabel.text = dic[@"name"];
    _locationLabel.text = dic[@"address"];
    NSURL *url = [NSURL URLWithString:dic[@"logo_pic"]];
    [_icon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"暂无图片"]];
    _distanceLabel.text = [NSString stringWithFormat:@"距离：%.1fKM",[dic[@"distance"] floatValue]/1000];
    self.score = [NSNumber numberWithFloat:[dic[@"level"] floatValue]];
    _hplLabel.text = [NSString stringWithFormat:@"好评率：%@%@",dic[@"hpl"],@"%"];
    _ddlLabel.text = [NSString stringWithFormat:@"订单量：%@",dic[@"ddl"]];
}

- (void)setScore:(NSNumber *)score{
    _startView.scorePercent = [score floatValue]/5;
}

@end
