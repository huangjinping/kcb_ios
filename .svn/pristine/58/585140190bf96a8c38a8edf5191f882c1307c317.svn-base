//
//  OderViewController.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/9/25.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "OderViewController.h"


@interface OderViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *mainScorllView;
@property(nonatomic,copy)NSString *modelLabel;
@property(nonatomic,copy)NSString *roadLabel;
@property(nonatomic,copy)NSString *firstTimeLabel;
@property(nonatomic,copy)NSString *wordLabel;
@property(nonatomic,strong)UIImageView *carImage;
@property(nonatomic,copy)NSString *methodLabel;
@property(nonatomic,copy)NSString *orderTimeLabel;
@property(nonatomic,copy)NSString *orderStoreLabel;
@property(nonatomic,copy)NSString *telLabel;
@property(nonatomic,copy)NSString *detailLabel;
@property(nonatomic,strong)NSArray *array;
@property (nonatomic,strong)UILabel *maneyLabel;


@end

@implementation OderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    
    
}
-(void)creatUI{
    CGFloat buttonBgHeight = 60 + 20 + 20;
    CGFloat scrollViewH = APP_HEIGHT - APP_NAV_HEIGHT;
    CGFloat singleLineHeightPX = 30*3;
    //    _perfectCarinfoFormBgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y: 0 width:APP_PX_WIDTH height:singleLineHeightPX*7];
    _mainScorllView = [[UIScrollView  alloc]initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, scrollViewH)];
    _mainScorllView.backgroundColor=COLOR_FRAME_LINE;
    //关闭弹簧效果
    _mainScorllView.bounces = NO;
    _mainScorllView.delegate = self;
    
   
    
    [self.view addSubview:_mainScorllView];
    CGFloat height = 90;
    CGFloat contentLineHeight = 70;

    UIImageView *firstView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y: 0 width:APP_PX_WIDTH height:singleLineHeightPX*4-20];
    firstView.backgroundColor=[UIColor whiteColor];
    UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height)];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height)];
    [firstView addSubview:lineL];
    UILabel *titileLabel = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 30, firstView.w - lineL.l*2, 30)];
    titileLabel.font = [UIFont boldSystemFontOfSize:17];
    [titileLabel setText:@"订单基本信息"];
    [firstView addSubview:titileLabel];

    for (int i = 0; i < 4; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 100+i*contentLineHeight , firstView.w, 70)];
        [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        [firstView addSubview:label];
        NSString *contentStr = @"";
        switch (i) {
            case 0:
                contentStr = [NSString stringWithFormat:@"保险公司名称: %@",[_baoxian valueForKey:@"beizhu"]];
                break;
            case 1:
                contentStr = [NSString stringWithFormat:@"保单金额：%@元",[[_baoxian valueForKey:@"orderdata"]valueForKey:@"totalPrice"] ];
                break;
            case 2:
                
              
            
                if ([[_baoxian valueForKey:@"hbstatus"] isEqualToString:@"0"]) {
                     self.orderStoreLabel = @"核保失败";
                }else if ([[_baoxian valueForKey:@"hbstatus"] isEqualToString:@"1"]) {
                     self.orderStoreLabel = @"核保成功";
                }

                contentStr = [NSString stringWithFormat:@"核保状态：%@", self.orderStoreLabel];
                break;
            default:
                break;
        }
        [label setText:contentStr];
    }
    
    
    [_mainScorllView addSubview:firstView];
    NSDictionary *orderdataArr = [_baoxian valueForKey:@"orderdata"];
    NSArray *prodoctsArr = [orderdataArr objectForKey:@"prodocts"];
    /*-------------------------------------服务及到店时间--------------------------------------------*/
    
    UIImageView *secondView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y:firstView.h + 20 width:APP_PX_WIDTH height:contentLineHeight* (prodoctsArr.count+3)];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height)];
    [secondView addSubview:lineL];
    titileLabel = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 30, secondView.w - lineL.l*2, 30)];
    titileLabel.font = [UIFont boldSystemFontOfSize:17];
    [titileLabel setText:@"投保项目"];
    [secondView addSubview:titileLabel];
    secondView.backgroundColor = [UIColor whiteColor];
   
    NSMutableArray *newProdoctsArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *newProdoctsArr1 = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *newProdoctsArr2 = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *dict in prodoctsArr) {
        NSString *name = [dict objectForKey:@"productName"];
        if ([name rangeOfString:@"不计免赔"].location == NSNotFound) {
            [newProdoctsArr addObject:dict];
        }else{
            if ([name isEqualToString:@"不计免赔险"] || [name isEqualToString:@"不计免赔"]) {
                [newProdoctsArr1 addObject:dict];
            }else{
                [newProdoctsArr2 addObject:dict];
            }
        }
    }
    [newProdoctsArr addObjectsFromArray:newProdoctsArr1];
    [newProdoctsArr addObjectsFromArray:newProdoctsArr2];
   
     for (int i = 0; i < [newProdoctsArr count]; i ++) {
         NSDictionary *prodoctDict = [newProdoctsArr objectAtIndex:i];
         NSString *productName = [prodoctDict objectForKey:@"productName"];
         NSString *productPrice = [prodoctDict objectForKey:@"productPrice"];
         UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 100+ i*contentLineHeight , secondView.w - lineL.l*7, 80)];
         [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
         label .numberOfLines=0;
         [secondView addSubview:label];
         if ([productName rangeOfString:@"不计免赔"].location != NSNotFound) {
             if (![productName isEqualToString:@"不计免赔险"]) {
                 [label setText:[NSString stringWithFormat:@"  --%@", productName]];
                 [label convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
             }else{
                 [label setText:productName];
                 [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
             }
         }else{
             [label setText:productName];
             [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
         }
         
         [secondView addSubview:label];
         label = [[UILabel alloc] initWithFrame:LGRectMake(30, 100+i*contentLineHeight, secondView.w - lineL.l*2, 70)];
         [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
       
         if ([[productPrice substringToIndex:1] isEqualToString:@"0"]) {
             productPrice = @"不可投保";
         }
         [label setText:productPrice];
         
         [secondView addSubview:label];
        
        
     }
    int number=newProdoctsArr.count-1;
    
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30,100+ (number+1)*contentLineHeight)];
    _maneyLabel = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l,  140+ (number+1)*contentLineHeight , secondView.w - lineL.l*2, 30)];
    _maneyLabel.font = [UIFont boldSystemFontOfSize:17];
   
    NSString *tatel=[NSString stringWithFormat:@"共计%d个险种,总价%@元",number,[[_baoxian valueForKey:@"orderdata"]valueForKey:@"totalPrice"]];
    _maneyLabel.textColor=[UIColor greenColor];
    
    
    [_maneyLabel setText:tatel];
    [secondView addSubview:_maneyLabel];
    

    [secondView addSubview:lineL];
    [_mainScorllView addSubview:secondView];
    //third
    CGFloat height3 = 90;
 
    UIImageView *ThirdView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y: firstView.h + secondView.h + 2*20 width:APP_PX_WIDTH height:contentLineHeight* 9-20];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height3)];
    [ThirdView addSubview:lineL];
    UILabel *titileLabel3 = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 30, ThirdView.w - lineL.l*2, 30)];
    titileLabel3.font = [UIFont boldSystemFontOfSize:17];
    [titileLabel3 setText:@"车辆信息"];
    [ThirdView addSubview:titileLabel3];
    ThirdView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 7; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 100+ i*contentLineHeight , ThirdView.w - lineL.l*2, 70)];
        [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        [ThirdView addSubview:label];
        NSString *contentStr = @"";
        switch (i) {
            case 0:
                contentStr = [NSString stringWithFormat:@"投保城市：%@", [[_baoxian valueForKey:@"orderdata"]valueForKey:@"cityName" ]];
                break;
            case 1:
                contentStr = [NSString stringWithFormat:@"车牌号码：%@", [_baoxian valueForKey :@"hphm"]];
                break;
            case 2:
                contentStr = [NSString stringWithFormat:@"车主姓名：%@",[[[_baoxian valueForKey:@"orderdata"]valueForKey:@"ownerInfo"]valueForKey:@"ownerName"]];
                break;
            case 3:
                contentStr = [NSString stringWithFormat:@"身份证号：%@", [[[_baoxian valueForKey:@"orderdata"]valueForKey:@"ownerInfo"]valueForKey:@"ownerIdNo"]];
                break;
            case 4:
                contentStr = [NSString stringWithFormat:@"注册日期：%@",[_baoxian valueForKey :@"hbtime"]];
                break;
            case 5:
                contentStr = [NSString stringWithFormat:@"发动机号：%@", [[[_baoxian valueForKey:@"orderdata"]valueForKey:@"vehicle"]valueForKey:@"fdjh"]];

                break;
            case 6:
                contentStr = [NSString stringWithFormat:@"车辆识别代号：%@", [[[_baoxian valueForKey:@"orderdata"]valueForKey:@"vehicle"]valueForKey:@"sfzhm"]];
                break;

            default:
                break;
        }
        [label setText:contentStr];
    }
    
    [_mainScorllView addSubview:ThirdView];
    
    /* ____________ 投保人信息_________________*/
    
  
    UIImageView *FoundView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y: ThirdView.h + firstView.h + secondView.h + 3*20 width:APP_PX_WIDTH height:contentLineHeight*6-20];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height3)];
    [FoundView addSubview:lineL];
    titileLabel3 = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 30, FoundView.w - lineL.l*2, 30)];
    titileLabel3.font = [UIFont boldSystemFontOfSize:17];
    [titileLabel3 setText:@"投保人信息"];
    [FoundView addSubview:titileLabel3];
    FoundView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 4; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 100+ i*contentLineHeight , FoundView.w - lineL.l*2, 80)];
         label .numberOfLines=0;
        [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        [FoundView addSubview:label];
        NSString *contentStr = @"";
        switch (i) {
            case 0:
                contentStr = [NSString stringWithFormat:@"投保城市：%@", [[[_baoxian valueForKey:@"orderdata"]valueForKey:@"insuredInfo" ]valueForKey:@"insuredName"]];
                break;
            case 1:
                contentStr = [NSString stringWithFormat:@"身份证号：%@", [[[_baoxian valueForKey:@"orderdata"]valueForKey:@"insuredInfo" ]valueForKey:@"insuredIdNo"]];
                break;
            case 2:
                contentStr = [NSString stringWithFormat:@"手机号码：%@",[[[_baoxian valueForKey:@"orderdata"]valueForKey:@"insuredInfo" ]valueForKey:@"insuredMobile"]];
                break;
            case 3:
                contentStr = [NSString stringWithFormat:@"详细地址：%@", [[[_baoxian valueForKey:@"orderdata"]valueForKey:@"deliverInfo" ]valueForKey:@"insuredaddresseeDetails"]];
                break;
                
            default:
                break;
        }
        [label setText:contentStr];
    }
    [_mainScorllView addSubview:FoundView];
    /* ____________ 车主信息_________________*/
    
    
    UIImageView *FiveView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y: FoundView.h+ThirdView.h + firstView.h + secondView.h + 4*20 width:APP_PX_WIDTH height:contentLineHeight*5-20];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height3)];
    [FiveView addSubview:lineL];
    titileLabel3 = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 30, FiveView.w - lineL.l*2, 30)];
    titileLabel3.font = [UIFont boldSystemFontOfSize:17];
    [titileLabel3 setText:@"车主信息"];
    [FiveView addSubview:titileLabel3];
    FiveView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 3; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 100+ i*contentLineHeight , FiveView.w - lineL.l*2, 70)];
       // label .numberOfLines=0;
        [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        [FiveView addSubview:label];
        NSString *contentStr = @"";
        switch (i) {
            case 0:
                contentStr = [NSString stringWithFormat:@"姓名：%@", [[[_baoxian valueForKey:@"orderdata"]valueForKey:@"ownerInfo" ]valueForKey:@"ownerName"]];
                break;
            case 1:
                contentStr = [NSString stringWithFormat:@"身份证号：%@", [[[_baoxian valueForKey:@"orderdata"]valueForKey:@"ownerInfo" ]valueForKey:@"ownerIdNo"]];
                break;
            case 2:
                contentStr = [NSString stringWithFormat:@"手机号码：%@",[[[_baoxian valueForKey:@"orderdata"]valueForKey:@"ownerInfo" ]valueForKey:@"ownerMobile"]];
                break;
        
            default:
                break;
        }
        [label setText:contentStr];
    }
    [_mainScorllView addSubview:FiveView];
    /* ____________ 被保人信息_________________*/
    
    
    UIImageView *SixView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y: FiveView.h+FoundView.h+ThirdView.h + firstView.h + secondView.h + 5*20 width:APP_PX_WIDTH height:contentLineHeight*5-20];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height3)];
    [SixView addSubview:lineL];
    titileLabel3 = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 30, SixView.w - lineL.l*2, 30)];
    titileLabel3.font = [UIFont boldSystemFontOfSize:17];
    [titileLabel3 setText:@"被保人信息"];
    [SixView addSubview:titileLabel3];
    SixView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 3; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 100+ i*contentLineHeight , SixView.w - lineL.l*2, 70)];
       // label .numberOfLines=0;
        [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        [SixView addSubview:label];
        NSString *contentStr = @"";
        switch (i) {
            case 0:
                contentStr = [NSString stringWithFormat:@"姓名：%@", [[[_baoxian valueForKey:@"orderdata"]valueForKey:@"applicantInfo" ]valueForKey:@"applicantName"]];
                break;
            case 1:
                contentStr = [NSString stringWithFormat:@"身份证号：%@", [[[_baoxian valueForKey:@"orderdata"]valueForKey:@"applicantInfo" ]valueForKey:@"applicantIdNo"]];
                break;
            case 2:
                contentStr = [NSString stringWithFormat:@"手机号码：%@",[[[_baoxian valueForKey:@"orderdata"]valueForKey:@"applicantInfo" ]valueForKey:@"applicantMobile"]];
                break;
                
            default:
                break;
        }
        [label setText:contentStr];
    }
    [_mainScorllView addSubview:SixView];
    
    /* ____________ 收件人信息_________________*/
    
    
    UIImageView *SevView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y: SixView.h+FiveView.h+FoundView.h+ThirdView.h + firstView.h + secondView.h + 6*20 width:APP_PX_WIDTH height:contentLineHeight*5-20];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height3)];
    [SevView addSubview:lineL];
    titileLabel3 = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 30, SevView.w - lineL.l*2, 30)];
    titileLabel3.font = [UIFont boldSystemFontOfSize:17];
    [titileLabel3 setText:@"收件人信息"];
    [SevView addSubview:titileLabel3];
    SevView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 3; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 100+ i*contentLineHeight , SevView.w - lineL.l*2, 80)];
        label .numberOfLines=0;
        [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        [SevView addSubview:label];
        NSString *contentStr = @"";
        switch (i) {
            case 0:
                contentStr = [NSString stringWithFormat:@"姓名：%@", [[[_baoxian valueForKey:@"orderdata"]valueForKey:@"deliverInfo" ]valueForKey:@"addresseeName"]];
                break;
            case 1:
                contentStr = [NSString stringWithFormat:@"手机号：%@", [[[_baoxian valueForKey:@"orderdata"]valueForKey:@"deliverInfo" ]valueForKey:@"addresseeMobile"]];
                break;
            case 2:
                contentStr = [NSString stringWithFormat:@"详细地址：%@",[[[_baoxian valueForKey:@"orderdata"]valueForKey:@"deliverInfo" ]valueForKey:@"addresseeDetails"]];
                break;
                
            default:
                break;
        }
        [label setText:contentStr];
    }
    [_mainScorllView addSubview:SevView];
    _mainScorllView.contentSize = CGSizeMake(screenSize.width, CGRectGetMaxY(SevView.frame)+20);


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"订单详情"];
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
