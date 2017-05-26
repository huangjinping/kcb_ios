//
//  storesCell.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15-8-14.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "storesCell.h"
#import "BaoYangModel.h"
#import "ChoesPackgeController.h"
@implementation storesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
  
        self.backgroundColor = [UIColor whiteColor];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 120, APP_WIDTH, 10)];
        view.backgroundColor = COLOR_FRAME_LINE;
        [self addSubview:view];
        
        [self createSubView];
        
 
    }
    return self;
}
-(void)createSubView
{
    //商户名称
    UILabel *titileLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, screenSize.width-20, 30)];
    titileLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.contentView addSubview:titileLabel];
    _nameLabel = titileLabel;
    //地址
    UILabel *adresLabel = [[UILabel alloc]init];
    adresLabel.font = [UIFont systemFontOfSize:15];
        //文字自适应
    adresLabel.text = _adressString;//关键,必须接收不然会出现复用导致换行位置提前
    adresLabel.numberOfLines = 0;
    [adresLabel sizeToFit];
    adresLabel.frame = CGRectMake(10, CGRectGetMaxY(titileLabel.frame), screenSize.width-20, 50);
    adresLabel.textColor = COLOR_FONT_NOTICE;
    [self.contentView addSubview:adresLabel];
    _adressLabel = adresLabel;
    
 
    //电话图片
    UIImageView *telImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 95, 20, 20)];
    telImage.image = [UIImage imageNamed:@"tel.png"];
    [self addSubview:telImage];
    //拨打电话按钮
    UIButton *telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    telBtn.frame = CGRectMake(0, 90, screenSize.width/2, 30);
    telBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    telBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 33, 0, 0);
    [telBtn setTitleColor:COLOR_LINK forState:UIControlStateNormal];
    [self.contentView addSubview:telBtn];
        //设置button边框
    [telBtn.layer setMasksToBounds:YES];
    [telBtn.layer setBorderWidth:0.5];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.8, 0.8, 0.8, 1 });
    [telBtn.layer setBorderColor:colorref];//边框颜色
     telBtn.titleLabel.adjustsFontSizeToFitWidth = YES;//字体大小自适应button宽度
    [telBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    telBtn.tag = 100;
    _phoneBtn = telBtn;
    

    
    //立即处理按钮
    UIButton *dealButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dealButton.frame = CGRectMake(CGRectGetMaxX(telBtn.frame), 90, screenSize.width/2, 30);
    [dealButton setTitleColor:COLOR_LINK forState:UIControlStateNormal];
    [dealButton setTitle:@"预约保养" forState:UIControlStateNormal];
    [self.contentView addSubview:dealButton];
    //设置button边框
    [dealButton.layer setMasksToBounds:YES];
    [dealButton.layer setBorderWidth:0.5];
    [dealButton.layer setBorderColor:colorref];//边框颜色
    dealButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [dealButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    dealButton.tag = 101;
    _dealBtn = dealButton;
    
    
}
-(void)buttonClicked:(UIButton *)button
{
    if (100 == button.tag)
    {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",button.titleLabel.text];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self addSubview:callWebview];
    }

}
-(void)setModel:(BaoYangModel *)model
{
    _model = model;
    
    _nameLabel.text = model.name;
    
    _adressString = model.address;
    _adressLabel.text = _adressString;
    
    [_phoneBtn setTitle:model.phone forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
