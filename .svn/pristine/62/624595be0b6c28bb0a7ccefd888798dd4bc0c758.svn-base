//
//  ActivityCell1.m
//  
//
//  Created by 辛鹏贺 on 16/1/19.
//
//

#import "ActivityCell.h"

@implementation ActivityCell
{
    UIImageView *_iconV;
    UIImageView *_backgroundView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = FONT_SIZE(15, x_6_SCALE);
        _nameLabel.textColor = COLOR_NAV;
        _detailNameLabel = [[UILabel alloc]init];
        _detailNameLabel.textAlignment = NSTextAlignmentCenter;
        _detailNameLabel.textColor = kTextGrayColor;
        _detailNameLabel.font = FONT_SIZE(13, x_6_SCALE);
        _backgroundView = [[UIImageView alloc]init];
        _iconV = [[UIImageView alloc]init];
        _backgroundImg = nil;
        
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_detailNameLabel];
        [self.contentView addSubview:_backgroundView];
        [self.contentView addSubview:_iconV];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _nameLabel.frame = CGRectMake(0, 40*y_6_plus, self.contentView.width, 38*y_6_plus);
    _detailNameLabel.frame = CGRectMake(0, _nameLabel.bottom+20*y_6_plus, self.contentView.width, 28*y_6_plus);
    _iconV.frame = CGRectMake(self.contentView.width-(15+83)*x_6_SCALE, _detailNameLabel.bottom+28*y_6_plus, 178*x_6_plus, 178*x_6_plus);
    _iconV.centerX = self.contentView.boundsCenter.x;

    _backgroundView.frame = self.bounds;
}

- (void)setIcon:(UIImage *)icon{
    _icon = icon;
    _iconV.image = icon;
}

- (void)setBackgroundImg:(UIImage *)backgroundImg{
    if (backgroundImg == nil) {
        [self.contentView sendSubviewToBack:_backgroundView];
    }else{
        _backgroundView.image = backgroundImg;
        [self.contentView bringSubviewToFront:_backgroundView];
    }
}

- (void)configCellWithDic:(NSDictionary *)dic{
    _nameLabel.text = dic[@"name"];
    _detailNameLabel.text = dic[@"subname"];
    self.icon = [UIImage imageNamed:dic[@"icon"]];
    self.backgroundImg = [UIImage imageNamed:dic[@"backImg"]];
}

@end
