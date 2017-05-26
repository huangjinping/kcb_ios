//
//  InfoViewController.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/10/13.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "InfoViewController.h"
#import "ZKButton.h"
#import "MyAFNetWorkingRequest.h"
#import "BaoYangModel.h"
@interface InfoViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView             *mainScorllView;
@property (nonatomic, strong) MyAFNetWorkingRequest *request;
@property (nonatomic, strong) NSMutableArray        *sevDatas;
@property (nonatomic, assign) int                   typeId;
@property (nonatomic, strong) UIImageView           *firstView;
@property (nonatomic, strong) UIImageView           *secondView;
@property (nonatomic, strong) UIImageView           *ThirdView;
@property (nonatomic, strong) UIImageView           *fourthView;
@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _typeId = 17;
    _sevDatas = [NSMutableArray array];
    [self downloadData];
    [self creatUI];
}
-(void)creatUI{

   // CGFloat buttonBgHeight = 60 + 20 + 20;
    CGFloat scrollViewH = APP_HEIGHT - APP_NAV_HEIGHT;
    CGFloat singleLineHeightPX = 30*3;
    CGFloat contentLineHeight = 70;
    CGFloat height = 90;
    
    _mainScorllView = [[UIScrollView  alloc]initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, scrollViewH)];
    _mainScorllView.backgroundColor=COLOR_FRAME_LINE;
    //关闭弹簧效果
//    _mainScorllView.bounces = NO;
    _mainScorllView.delegate = self;
    
    [self.view addSubview:_mainScorllView];
    
    UILabel * lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height)];
    
    
    
    _firstView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y: 0 width:APP_PX_WIDTH height:singleLineHeightPX];
    _firstView.backgroundColor=[UIColor whiteColor];
    //商户标题
    UILabel *titileLabel = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 30, _firstView.w, 30)];
    titileLabel.font = BOLD_FONT_SIZE(40)  ;
    [titileLabel setText:_model.name];
    [_firstView addSubview:titileLabel];
    [_mainScorllView addSubview:_firstView];
    
    //第二个背景
    _secondView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y: _firstView.h + 20 width:APP_PX_WIDTH height:contentLineHeight*4-20];
    
    _secondView.backgroundColor = [UIColor whiteColor];
     lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height*2)];
    [_secondView addSubview:lineL];
    //商户图片
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:LGRectMake(20, 20, 180 , 150)];
    [imgView setImageWithURL:[NSURL URLWithString:_model.titlePic] placeholderImage:[UIImage imageNamed:@"car.png"]];
    imgView.clipsToBounds = YES;
    imgView.layer.cornerRadius = 5;
    [_secondView addSubview:imgView];
    
    //营业label
    UILabel *yylabel=[[UILabel alloc] initWithFrame:LGRectMake(210, 20, 90 , 40)];
    [yylabel convertNewLabelWithFont:SYS_FONT_SIZE(26) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentCenter];
    yylabel.clipsToBounds = YES;
    yylabel.layer.cornerRadius = 5;
    [yylabel setText:@"营业中"];
    yylabel.backgroundColor=COLOR_NAV;
    yylabel.textColor=[UIColor whiteColor];
    [_secondView addSubview:yylabel];
    //营业时间
    UILabel *timelabel=[[UILabel alloc] initWithFrame:LGRectMake(310, 20, APP_PX_WIDTH - 310 , 50)];
    [timelabel convertNewLabelWithFont:SYS_FONT_SIZE(26) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    NSString *timeString=[NSString stringWithFormat:@"营业时间: %@~%@",_model.opentime,_model.closetime];
    [timelabel setText:timeString];
    [_secondView addSubview:timelabel];
    
    //联系人
    UILabel *peolabel=[[UILabel alloc] initWithFrame:LGRectMake(210, 20 +50, APP_PX_WIDTH - 210  , 50)];
    [peolabel convertNewLabelWithFont:SYS_FONT_SIZE(26) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    NSString *peoString=[NSString stringWithFormat:@"联系人: %@",_model.contacts];
    [peolabel setText:peoString];
    [_secondView addSubview:peolabel];
    //联系电话
    UILabel *tellabel=[[UILabel alloc] initWithFrame:LGRectMake(210, 20 +50 +50, APP_PX_WIDTH - 310 , 50)];
    [tellabel convertNewLabelWithFont:SYS_FONT_SIZE(26) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    NSString *telString=[NSString stringWithFormat:@"电话: %@",_model.phone];
    [tellabel setText:telString];
    [_secondView addSubview:tellabel];
    //电话图标
    UIImageView *telView=[[UIImageView alloc] initWithFrame:LGRectMake(APP_PX_WIDTH-85, 100, 65 , 65)];
    UIImage *telimage=[UIImage imageNamed:@"tel"];
    telView.image=telimage;
    telView.clipsToBounds = YES;
    telView.layer.cornerRadius = 5;
    [_secondView addSubview:telView];
    ZKButton *Telbutton=[ZKButton  blockButtonWithFrame:LGRectMake(210 +320, 100, 70 , 70) type:UIButtonTypeCustom title:@"" backgroundImage:@"" andBlock:^(ZKButton *button) {
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_model.phone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        
    }];
    [_secondView addSubview:Telbutton];

    //商户地址
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 100 +height, _secondView.w , 80)];
    [label convertNewLabelWithFont:SYS_FONT_SIZE(34) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    [_secondView addSubview:label];
    [label setText:_model.address];
    [_mainScorllView addSubview:_secondView];
    
    //第三个背景
    _ThirdView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y: _firstView.h + _secondView.h + 2*20 width:APP_PX_WIDTH height:contentLineHeight* 3-20];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height)];
    [_ThirdView addSubview:lineL];
    [_mainScorllView addSubview:_ThirdView];
    //商户介绍
    UILabel *storeTitle = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 30, _ThirdView.w - lineL.l*2, 30)];
    storeTitle.font = BOLD_FONT_SIZE(38);
    [storeTitle setText:@"商户介绍"];
    storeTitle.textColor = COLOR_NAV;
    [_ThirdView addSubview:storeTitle];
    _ThirdView.backgroundColor = [UIColor whiteColor];

    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30+ contentLineHeight , _ThirdView.w - lineL.l*2, 73)];
    [label convertNewLabelWithFont:SYS_FONT_SIZE(32) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_ThirdView addSubview:label];
    [label setText:_model.des];
    
    

    //第四个背景
    _fourthView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y: _firstView.h + _secondView.h + _ThirdView.h + 3*20 width:APP_PX_WIDTH height:contentLineHeight* 8-30];
    _fourthView.backgroundColor = [UIColor whiteColor];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height)];
    [_fourthView addSubview:lineL];
    [_mainScorllView addSubview:_fourthView];
    
    //服务介绍
    UILabel *sevTitle = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 30, _ThirdView.w - lineL.l*2, 30)];
    sevTitle.font = BOLD_FONT_SIZE(38);
    [sevTitle setText:@"服务介绍"];
    sevTitle.textColor=COLOR_NAV;
    [_fourthView addSubview:sevTitle];
    
    
}
-(void)setupSevLabel
{
    //服务项目
    for (int i =0 ; i < _sevDatas.count; i++)
    {
        BaoYangModel *packgeModel = _sevDatas[i];
        
        UILabel *sevLabel = [[UILabel alloc] initWithFrame:LGRectMake(30, 50*i+ 70 +30 ,300, 70)];
        [sevLabel convertNewLabelWithFont:SYS_FONT_SIZE(32) textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
        [_fourthView addSubview:sevLabel];
        [sevLabel setText:packgeModel.packagename];
    }
}
-(void)downloadData
{
    NSString *path = [NSString stringWithFormat:@"http://%@/getPackage.do?typeId=%d&shopId=%@",NET_ADDR_BUSS_956122,_typeId,_model.id];
    _request = [[MyAFNetWorkingRequest alloc]initWithRequest:path andParams:nil andBlock:^(NSData *requestData) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArr = dic[@"msg"];
        _sevDatas = [BaoYangModel arrayOfModelsFromDictionaries:dataArr];
        _mainScorllView.contentSize = CGSizeMake(screenSize.width, _firstView.height + _secondView.height + _ThirdView.height + _fourthView.height + 40);
        [self setupSevLabel];
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setCustomNavigationTitle:@"商户信息"];
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
