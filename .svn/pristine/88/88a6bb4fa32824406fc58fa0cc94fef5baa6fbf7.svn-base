//
//  BYPayInfoViewController.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/9/17.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BYPayInfoViewController.h"

@interface BYPayInfoViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *rootScrollView;

@end

@implementation BYPayInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat buttonBgHeight = 60 + 20 + 20;
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y-64, APP_WIDTH, APP_HEIGHT+64 - APP_NAV_HEIGHT - buttonBgHeight*PX_Y_SCALE)];
    [_rootScrollView setScrollEnabled:YES];
    _rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_rootScrollView];
    CGFloat contentLineHeight = 90;
    CGFloat space = 25;
    UIImageView *statusBgImgView =[UIImageView alloc];
    if(iPhone4){
    statusBgImgView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y:20  width:APP_PX_WIDTH height:contentLineHeight*4+30];
    
    }else{
     statusBgImgView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y:0  width:APP_PX_WIDTH height:contentLineHeight*4+10];
    }
    
    statusBgImgView.backgroundColor =[UIColor clearColor];
    [_rootScrollView addSubview:statusBgImgView];
    UILabel *lable = [[UILabel alloc]init];
    if (_isSucceed ==YES){
        lable = [[UILabel alloc] initWithFrame:LGRectMake(0, APP_VIEW_Y*PX_Y_SCALE + 100, APP_PX_WIDTH, 30)];
        [lable setText:@"订单支付成功"];
        [lable convertNewLabelWithFont:SYS_FONT_SIZE(60) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
        [statusBgImgView addSubview:lable];
        lable = [[UILabel alloc] initWithFrame:LGRectMake(0, lable.b + 30, APP_PX_WIDTH, 50)];
        NSString *string=[NSString stringWithFormat:@"消费密钥 :%@",_DDInfo];
        [lable setText:string];
       // lable.textColor=COLOR_NAV;
        [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_BUTTON_BLUE textAlignment:NSTextAlignmentCenter];
        [statusBgImgView addSubview:lable];
        lable = [[UILabel alloc] initWithFrame:LGRectMake(10, lable.b + 50, APP_PX_WIDTH-20, 80)];
        lable.numberOfLines=0;
        NSString *string1=@"您的预约已成功，返回首页点击“我的-我的订单”查询订单详细.";
        [lable setText:string1];
      //  lable.textColor=COLOR_NAV;
        [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
        [statusBgImgView addSubview:lable];
        
    }else if(_isIng ==YES){
        
        lable = [[UILabel alloc] initWithFrame:LGRectMake(0, APP_VIEW_Y*PX_Y_SCALE + 100, APP_PX_WIDTH, 30)];
        [lable setText:@"订单正在处理"];
        [lable convertNewLabelWithFont:SYS_FONT_SIZE(60) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
        [statusBgImgView addSubview:lable];
        lable = [[UILabel alloc] initWithFrame:LGRectMake(0, lable.b + 30, APP_PX_WIDTH, 60)];
        
        [lable setText:self.titLabel];
       // lable.textColor=COLOR_NAV;
        [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
        [statusBgImgView addSubview:lable];
        lable = [[UILabel alloc] initWithFrame:LGRectMake(10, lable.b + 50, APP_PX_WIDTH-20, 80)];
        lable.numberOfLines=0;
        NSString *string1=@"订单正在处理，请稍后..";
        [lable setText:string1];
       // lable.textColor=COLOR_NAV;
        [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
        [statusBgImgView addSubview:lable];
        
    }else{
        
        lable = [[UILabel alloc] initWithFrame:LGRectMake(0, APP_VIEW_Y*PX_Y_SCALE + 100, APP_PX_WIDTH, 30)];
        [lable setText:@"订单支付失败"];
        [lable convertNewLabelWithFont:SYS_FONT_SIZE(60) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
        [statusBgImgView addSubview:lable];
        lable = [[UILabel alloc] initWithFrame:LGRectMake(0, lable.b + 30, APP_PX_WIDTH, 60)];
        
        [lable setText:self.titLabel];
        [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
        [statusBgImgView addSubview:lable];
        lable = [[UILabel alloc] initWithFrame:LGRectMake(10, lable.b + 50, APP_PX_WIDTH-20, 80)];
        lable.numberOfLines=0;
        NSString *string1=@"您的预约失败，返回首页点击“我的-我的订单”继续支付订单.";
        [lable setText:string1];
        [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
        [statusBgImgView addSubview:lable];
        
        
        
    }
    
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:statusBgImgView.b  width:APP_PX_WIDTH height:contentLineHeight*6];
    [_rootScrollView addSubview:bgImgView];
    
  
    
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [lable setText:@"订单编号: "];
    [bgImgView addSubview:lable];
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30,   space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [lable setText:self.orderNo];
    [bgImgView addSubview:lable];
    
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [lable setText:@"车牌号码："];
    [bgImgView addSubview:lable];
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [lable setText:self.baoyang.hphm];
    [bgImgView addSubview:lable];
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight*2 + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [lable setText:@"预约时间："];
    [bgImgView addSubview:lable];
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight*2 + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    //    [lable setText:[NSString stringWithFormat:@"%@,%@",self.baoyang.peopleDate,self.baoyang.peopleTime]];
    
    
    NSString *str2=[self.baoyang.peopleDate substringToIndex:10];
    
    [lable setText:[NSString stringWithFormat:@"%@  %@",str2,self.baoyang.peopleTime]];
    
    
    [bgImgView addSubview:lable];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight*3 + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [lable setText:@"预约门店："];
    [bgImgView addSubview:lable];
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight*3 + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [lable setText:self.baoyang.name];
    [bgImgView addSubview:lable];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight*4 + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [lable setText:@"门店地址："];
    [bgImgView addSubview:lable];
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight*4 + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [lable setText:self.baoyang.address];
    [bgImgView addSubview:lable];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight*5 + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [lable setText:@"联系电话："];
    [bgImgView addSubview:lable];
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight*5 + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [lable setText:self.baoyang.peoplePhone];
    [bgImgView addSubview:lable];
     _rootScrollView.contentSize = CGSizeMake(screenSize.width, CGRectGetMaxY(bgImgView.frame));
    //bgImgView
    /*_______________________下一步____________________________________________*/
    
    UIView *buttonBgView = [[UIView alloc] initWithFrame:BGRectMake(0, _rootScrollView.b, APP_PX_WIDTH, buttonBgHeight)];
    buttonBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonBgView];
    UILabel *lineLabel=[[UILabel alloc]init];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(0, 0)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH)*PX_X_SCALE, lineLabel.height)];
    [buttonBgView addSubview:lineLabel];
    UIButton *button=[[UIButton alloc]init];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = LGRectMake(30, 15, buttonBgView.w - 30*2, buttonBgView.h - 15*2);
    [button setTitle:@"返   回" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_NOMAL;
    [button addTarget:self action:@selector(nextStepButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    [buttonBgView addSubview:button];
    
    
    
    
}
- (void)nextStepButtonClicked{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setCustomNavigationTitle:@"爱车保养预约"];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
