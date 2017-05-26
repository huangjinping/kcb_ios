//
//  BaoyangViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/7.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BaoyangSelectCarViewController.h"

#import "BYSelectServiceViewController.h"
#import "ZKButton.h"
@interface BaoyangSelectCarViewController ()<UIScrollViewDelegate>

@property (nonatomic, retain)   NSArray *cars;
@property (nonatomic, strong) UIScrollView *rootScr;
@property (nonatomic,strong) UIView *firstView;
@property (nonatomic, copy) NSString *carImageUrl;
@end

@implementation BaoyangSelectCarViewController

//添加用户已绑定车辆信息
- (void)addCar:(CarInfo*)car carIndex:(NSInteger)index onView:(UIView*)v{
    
   
    
    UIImageView *imgVv = [[UIImageView alloc] initWithFrame:LGRectMake(30, 30, 160, 140)];
    [v addSubview:imgVv];
    UIImageView *carLogoView = [[UIImageView alloc] initWithFrame:LGRectMake((imgVv.w -100)/2+10-10, (imgVv.h - 100)/2, 120, 100)];
    [imgVv addSubview:carLogoView];
    _carImageUrl = [NSString stringWithFormat:@"http://idc.pic-01.956122.com/allPic/CarLogo/%@.jpg", [[car.clsbdh substringToIndex:3] uppercaseString]];
    [carLogoView setImageWithURL:[NSURL URLWithString:_carImageUrl] placeholderImage:[UIImage imageNamed:@"home_car_brand_default"]];
    
    UILabel *carNumL = [[UILabel alloc] initWithFrame:LGRectMake((imgVv.w -100)/2+20, imgVv.h +15, 0, 40)];//(50, 20, 130, 30)];
    [carNumL convertNewLabelWithFont:BOLD_FONT_SIZE(30) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    carNumL.text = [car.hphm uppercaseString];
    [carNumL setSize:[carNumL.text sizeWithFont:carNumL.font constrainedToSize:CGSizeMake(1000, carNumL.height)]];
    [v addSubview:carNumL];
    
    UIButton *b=[[UIButton alloc]init];
    b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b setBackgroundColor:[UIColor clearColor]];
    [b setFrame:v.bounds];
    [v addSubview:b];
    //[v bringSubviewToFront:b];
    b.tag = index;
    [b addTarget:self action:@selector(selectForCar:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _firstView=[[UIView alloc]initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT/4)];
    _firstView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview: _firstView];
    NSArray *cars = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId];
    self.cars = [NSArray arrayWithArray:cars];
    
    if ([cars count]==0) {
        

        UIImageView *imgVv = [[UIImageView alloc] initWithFrame:LGRectMake(30, 30, 160, 140)];
        UIImageView *bgImgView = [[UIImageView alloc ]initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT/4)];
        [_firstView addSubview:bgImgView];
        bgImgView.backgroundColor=[UIColor whiteColor];
        
        [bgImgView addSubview:imgVv];
        UILabel *addCarLabel = [[UILabel alloc] initWithFrame:LGRectMake(1/2.0*_firstView.w - 90+40, (_firstView.h -66)/2+5, 60, 102)];
        [addCarLabel convertNewLabelWithFont:BOLD_FONT_SIZE(30) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        [addCarLabel setText:@"其他车辆"];
        [addCarLabel setSize:[addCarLabel.text sizeWithFont:addCarLabel.font constrainedToSize:CGSizeMake(1000, addCarLabel.height)]];
        [bgImgView addSubview:addCarLabel];
        UIImageView *jiahaoImgV1 = [[UIImageView alloc] initWithFrame:LGRectMake(1/2.0*_firstView.w - 90*2, (_firstView.h -66)/2, 60, 52)];//60*52
        [jiahaoImgV1 setImage:[UIImage imageNamed:@"jiahao.jpg"]];
        [bgImgView addSubview:jiahaoImgV1];
        
        [bgImgView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCar)];
        [bgImgView addGestureRecognizer:tap];
        
    }else{
    for (int i = 0; i < [cars count]; i ++) {
        CarInfo *car  = [cars objectAtIndex:i];
        NSRange succRange = [car.vehiclestatus rangeOfString:@"成功"];
        if (succRange.location != NSNotFound) {//绑定成功
            UIView *carView=[[UIView alloc]initWithFrame:CGRectMake(APP_WIDTH/3*i, 0, APP_WIDTH/3, APP_HEIGHT/4)];
            carView.backgroundColor=[UIColor whiteColor];
            
          
            [self addCar:car carIndex:i onView:carView];
            [_firstView addSubview:carView];

        }
        
        
    }
        
        UIImageView *imgVv = [[UIImageView alloc] initWithFrame:LGRectMake(30, 30, 140, 140)];
        UIImageView *bgImgView = [[UIImageView alloc ]initWithFrame:CGRectMake(APP_WIDTH/3*2, 0, APP_WIDTH/3, APP_HEIGHT/4)];
        [_firstView addSubview:bgImgView];
        bgImgView.backgroundColor=[UIColor whiteColor];
        
        [bgImgView addSubview:imgVv];
        UILabel *addCarLabel = [[UILabel alloc] initWithFrame:LGRectMake((imgVv.w -100)/2+20, imgVv.h +15, 0, 40)];
        [addCarLabel convertNewLabelWithFont:BOLD_FONT_SIZE(30) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        [addCarLabel setText:@"其他车辆"];
        [addCarLabel setSize:[addCarLabel.text sizeWithFont:addCarLabel.font constrainedToSize:CGSizeMake(1000, addCarLabel.height)]];
        [bgImgView addSubview:addCarLabel];
        
        UIImageView *jiahaoImgV = [[UIImageView alloc]initWithFrame:LGRectMake((imgVv.w -100)/2+40, (imgVv.h - 100)/2+40, 80   , 80)];;//60*52--80*80
        [jiahaoImgV setImage:[UIImage imageNamed:@"jiahao.jpg"]];
        [bgImgView addSubview:jiahaoImgV];
        
        jiahaoImgV.userInteractionEnabled = YES;
        [bgImgView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCar)];
        [bgImgView addGestureRecognizer:tap];
        
    }
    
   
    
    UIImageView *bgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, APP_HEIGHT/4-40*PX_Y_SCALE , APP_WIDTH, 40*PX_Y_SCALE)];
    bgView.image=[UIImage imageNamed:@"bg02"];
    
    [_firstView addSubview:bgView];
    [_firstView bringSubviewToFront:bgView];
    
    [self addimg];
    
}
//图片
-(void)addimg{
    _rootScr=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_firstView.frame), APP_WIDTH, APP_HEIGHT/4*3)];
    [self.view addSubview:_rootScr];
   
    //关闭弹簧效果
    _rootScr.bounces = NO;
     _rootScr.showsVerticalScrollIndicator = NO;//垂直滚动条是否显示
    _rootScr .backgroundColor=[UIColor whiteColor];
    _rootScr.delegate = self;
    _rootScr.contentSize = CGSizeMake(screenSize.width, (370+140*5)*PX_Y_SCALE);
    UIImageView *imgeFirstView=[[UIImageView alloc]initWithFrame:CGRectMake(60*PX_X_SCALE, 20*PX_Y_SCALE, APP_WIDTH-120*PX_X_SCALE, 220*PX_Y_SCALE)];
    imgeFirstView.image=[UIImage imageNamed:@"A2"];
    [_rootScr addSubview:imgeFirstView];
    for (int i =0; i<5; i++) {
        UIImageView *picImageview=[[UIImageView alloc]initWithFrame:CGRectMake(60*PX_X_SCALE,(280 +40+i*140)*PX_Y_SCALE, 100*PX_X_SCALE, 80*PX_Y_SCALE)];
        picImageview.image=[UIImage imageNamed:[NSString stringWithFormat:@"by%d",i]];
        [_rootScr addSubview:picImageview];
        UIImageView *LabelImageview=[[UIImageView alloc]initWithFrame:CGRectMake((160+20)*PX_X_SCALE,(300 +i*140)*PX_Y_SCALE, 400*PX_X_SCALE, 30*PX_Y_SCALE)];
        LabelImageview.image=[UIImage imageNamed:[NSString stringWithFormat:@"by0%d",i]];
        [_rootScr addSubview:LabelImageview];
        
    }
    UILabel *label1=[[UILabel alloc]init];
    label1.frame=CGRectMake((160+20)*PX_X_SCALE,(330)*PX_Y_SCALE, 420*PX_X_SCALE, 100*PX_Y_SCALE);
    label1.text=@"开车邦,按车型为您自动推荐最佳保养套餐。";
    label1.numberOfLines =0;
    label1.backgroundColor=[UIColor redColor];
    [label1 convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_rootScr addSubview:label1];
    UILabel *label2=[[UILabel alloc]init];
    label2.frame=CGRectMake((160+20)*PX_X_SCALE,(330+140)*PX_Y_SCALE, 420*PX_X_SCALE, 100*PX_Y_SCALE);
    label2.text=@"您亦可以自主按需制定保养服务套餐。";
    label2.numberOfLines =0;
    label2.backgroundColor=[UIColor redColor];
    [label2 convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_rootScr addSubview:label2];
    UILabel *label3=[[UILabel alloc]init];
    label3.frame=CGRectMake((160+20)*PX_X_SCALE,(330+140*2)*PX_Y_SCALE, 420*PX_X_SCALE, 100*PX_Y_SCALE);
    label3.text=@"购买成功后,您可就近预约保养店,到店享服务。";
    label3.numberOfLines =0;
    label3.backgroundColor=[UIColor redColor];
    [label3 convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_rootScr addSubview:label3];
    UILabel *label4=[[UILabel alloc]init];
    label4.frame=CGRectMake((160+20)*PX_X_SCALE,(330+140*3)*PX_Y_SCALE, 420*PX_X_SCALE, 100*PX_Y_SCALE);
    label4.text=@"使用手机在线支付功能,便捷、享保障。";
    label4.numberOfLines =0;
    label4.backgroundColor=[UIColor redColor];
    [label4 convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_rootScr addSubview:label4];
    UILabel *label5=[[UILabel alloc]init];
    label5.frame=CGRectMake((160+20)*PX_X_SCALE,(330+140*4)*PX_Y_SCALE, 420*PX_X_SCALE, 100*PX_Y_SCALE);
    label5.text=@"保养用品均有诚泰保险公司承保,您可放心选用。";
    label5.numberOfLines =0;
    label5.backgroundColor=[UIColor redColor];
    [label5 convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_rootScr addSubview:label5];


}

//添加车辆
- (void)addCar
{
    
    BYSelectServiceViewController *carInfoVC = [[BYSelectServiceViewController alloc] init];
    
    [self.navigationController pushViewController:carInfoVC animated:YES];
    
}

- (void)selectForCar:(UIButton*)button{
    CarInfo *car = [self.cars objectAtIndex:button.tag];
    BYSelectServiceViewController *carInfoVC = [[BYSelectServiceViewController alloc] init];
    carInfoVC.car = car;

    [self.navigationController pushViewController:carInfoVC animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"车辆选择"];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
