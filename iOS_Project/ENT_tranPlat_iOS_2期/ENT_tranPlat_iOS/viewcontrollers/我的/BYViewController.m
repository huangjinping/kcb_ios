//
//  BYViewController.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/9/30.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BYViewController.h"
#import "BaoYangModel.h"
#import "BYPayONlineViewController.h"
#import "MyOrderController.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "BYPayInfoViewController.h"



@interface BYViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *mainScorllView;
@property(nonatomic,copy)NSString *string;
@property(nonatomic,strong)UIButton *nextButton;
@property(nonatomic,copy)NSString *ordIdUrl;
@property (nonatomic, assign) NSInteger  number;

@end

@implementation BYViewController

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
    if ([[_model valueForKey:@"status"]isEqualToString:@"3"]){
    
        _number =8;
    }else{
        _number =7;
    
    }
    UIImageView *firstView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y: 0 width:APP_PX_WIDTH height:singleLineHeightPX*_number-20];
    firstView.backgroundColor=[UIColor whiteColor];
    UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height)];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height)];
    [firstView addSubview:lineL];
    UILabel *titileLabel = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 30, firstView.w - lineL.l*2, 30)];
    titileLabel.font = SYS_FONT_SIZE(36);
    [titileLabel setText:@"订单基本信息"];
    [firstView addSubview:titileLabel];
    id a=[[_model valueForKey:@"orderInfo"]valueForKey:@"payBy"];
    _string= [NSString stringWithFormat:@"%@",a];
    
    for (int i = 0; i < 7; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 100+i*contentLineHeight , firstView.w, 70)];
        [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        [firstView addSubview:label];

        //[[[_model valueForKey:@"orderInfo"]valueForKey:@"vehicleInfo"]valueForKey:@"hphm"]
        NSString *contentStr = @"";
        switch (i) {
            case 0:
                contentStr = [NSString stringWithFormat:@"车牌号码: %@" ,[[[_model valueForKey:@"orderInfo"]valueForKey:@"vehicleInfo"]valueForKey:@"hphm"]];
                break;
            case 1:
                contentStr = [NSString stringWithFormat:@"订单编号：%@",[_model valueForKey:@"ordid"]];
                break;
            case 2:
                
                contentStr = [NSString stringWithFormat:@"订单时间：%@",[_model valueForKey:@"createtime"]];
                break;
            case 3:
                
                contentStr = [NSString stringWithFormat:@"收款单位：开车邦"];
                break;
            case 4:
                
                contentStr = [NSString stringWithFormat:@"产品名称：车辆预约订单"];
                break;
            case 5:
                
                
                
                if ([_string isEqualToString:@"1"]) {
                    
                    
                    
                    contentStr = [NSString stringWithFormat:@"支付方式：支付宝支付"];
                }else{
                    
                    contentStr = [NSString stringWithFormat:@"支付方式：微信支付"];
                    
                }
                break;
            case 6:
                if ([[_model valueForKey:@"status"]isEqualToString:@"3"]) {
                    
                    
                    contentStr = [NSString stringWithFormat:@"支付状态：已支付"];
                }else{
                    
                    contentStr = [NSString stringWithFormat:@"支付状态：未支付"];
                    
                }
                
                
                break;
            default:
                break;
        }
        [label setText:contentStr];
        
     
      
        
    }
    if ([[_model valueForKey:@"status"]isEqualToString:@"3"]) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 100 + 7*contentLineHeight , firstView.w, 70)];
        [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_BUTTON_BLUE textAlignment:NSTextAlignmentLeft];
        [firstView addSubview:label];
        NSString *string=[NSString stringWithFormat:@"服务验证码: %@",[_model valueForKey:@"verifycode"]];
        label.text=string;
        
        
    }
    
    [_mainScorllView addSubview:firstView];
    UIImageView *secondView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y: firstView.h + 20 width:APP_PX_WIDTH height:contentLineHeight*7-20];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height)];
    [secondView addSubview:lineL];
    titileLabel = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 30, secondView.w - lineL.l*2, 30)];
    titileLabel.font = SYS_FONT_SIZE(36);
    [titileLabel setText:@"服务门店信息"];
    [secondView addSubview:titileLabel];
    secondView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 5; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 100+ i*contentLineHeight , secondView.w - lineL.l*2, 80)];
        label .numberOfLines=0;
        [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        [secondView addSubview:label];
        NSString *contentStr = @"";
        NSString *Str = @"";
        switch (i) {
            case 0:
                contentStr = [NSString stringWithFormat:@"服务形式：驾车到店"];
                break;
            case 1:
              
                

//                NSString *str2=[self.baoyang.peopleDate substringToIndex:10];
//                
//                [lable setText:[NSString stringWithFormat:@"%@  %@",str2,self.baoyang.peopleTime]];
                
               // contentStr = [NSString stringWithFormat:@"预约时间：%@ %@",[[[_model valueForKey:@"orderInfo"]valueForKey:@"bookingInfo"]valueForKey:@"maintainDate"],[[[_model valueForKey:@"orderInfo"]valueForKey:@"bookingInfo"]valueForKey:@"maintainTime"]];
                Str=[[[[_model valueForKey:@"orderInfo"]valueForKey:@"bookingInfo"]valueForKey:@"maintainDate"] substringToIndex:10];;
                contentStr =[NSString stringWithFormat:@"预约时间：%@ %@",Str,[[[_model valueForKey:@"orderInfo"]valueForKey:@"bookingInfo"]valueForKey:@"maintainTime"]];
                
                
                break;
            case 2:
                contentStr = [NSString stringWithFormat:@"预约门店：%@",[[[_model valueForKey:@"orderInfo"]valueForKey:@"businesInfo"]valueForKey:@"shopInfoName"]];
                break;
            case 3:
                contentStr = [NSString stringWithFormat:@"联系电话：%@",[[[_model valueForKey:@"orderInfo"]valueForKey:@"bookingInfo"]valueForKey:@"phone"]];
                break;
            case 4:
                contentStr = [NSString stringWithFormat:@"详细地址：%@.",[[[_model valueForKey:@"orderInfo"]valueForKey:@"businesInfo"]valueForKey:@"address"]];
                break;
                
            default:
                break;
        }
        [label setText:contentStr];
    }
    [_mainScorllView addSubview:secondView];
    
    NSArray *infoArray=[[NSArray alloc]init];
    infoArray=[[_model valueForKey:@"orderInfo"]valueForKey:@"packageList"];
 
    
    UIImageView *thirdView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y: secondView.h+firstView.h + 40 width:APP_PX_WIDTH height:contentLineHeight*(infoArray.count+3)];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height)];
    [thirdView addSubview:lineL];
    
    titileLabel = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 30, thirdView.w - lineL.l*2, 30)];
    titileLabel.font = SYS_FONT_SIZE(36);
    [titileLabel setText:@"服务项目"];
    [thirdView addSubview:titileLabel];
    thirdView.backgroundColor = [UIColor whiteColor];
    CGFloat contentLineHeight3 = 90;
    for (int i = 0; i < infoArray.count; i++) {
        // BaoYangModel *packgeModel = infoArray[i];
        UILabel *packgeLabel = [[UILabel alloc] initWithFrame:LGRectMake(30, 100+ i*contentLineHeight3 , thirdView.w - lineL.l*2, 40)];
        [packgeLabel convertNewLabelWithFont:SYS_FONT_SIZE(35) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        packgeLabel.text = [infoArray[i]valueForKey:@"packageName"];
        [thirdView addSubview:packgeLabel];
    
        
        UILabel *sevLabel = [[UILabel alloc] initWithFrame:LGRectMake(30, 130+ i*contentLineHeight3 , thirdView.w - 190, 80)];
        
        [sevLabel convertNewLabelWithFont:SYS_FONT_SIZE(26) textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
        
        //数据有误 等待跟新..
       // sevLabel.text = [infoArray[i]valueForKey:@"packageDetail"];
        NSArray *arr=[infoArray[i]valueForKey:@"serviceItems"];
    
        if(arr.count){
            
        NSDictionary *dict=arr[0];
            sevLabel.text = [dict valueForKey:@"itemName"];
        }else{
        sevLabel.text = [infoArray[i]valueForKey:@"packageDetail"];
        }
        sevLabel.numberOfLines = 0;
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:LGRectMake(thirdView.w - 140, 130+ i*contentLineHeight3 , 140, 60)];
        [sevLabel convertNewLabelWithFont:SYS_FONT_SIZE(26) textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
        
        //数据有误 等待跟新..
        // sevLabel.text = [infoArray[i]valueForKey:@"packageDetail"];
        NSArray *arrPrice=[infoArray[i]valueForKey:@"serviceItems"];
        
        if(arrPrice.count){
            
            NSDictionary *dict=arr[0];
            NSString *priceString =[NSString stringWithFormat:@"%@元", [dict valueForKey:@"price"]];
            priceLabel.text =priceString;
        }else{
             priceLabel.text =@"";
        }
      [priceLabel convertNewLabelWithFont:SYS_FONT_SIZE(26) textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
         [thirdView addSubview:sevLabel];
        
        [thirdView addSubview:priceLabel];
    }
     [_mainScorllView addSubview:thirdView];
    
    UIImageView *founView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y: thirdView.h+secondView.h+firstView.h + 60 width:APP_PX_WIDTH height:contentLineHeight*1+20];
    
    titileLabel = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, founView.w , 30)];
    titileLabel.font = SYS_FONT_SIZE(36);
    NSString *string=[NSString stringWithFormat:@"订单金额 :%@元",[[_model valueForKey:@"orderInfo"]valueForKey:@"totalPrice"]];
    [titileLabel setText:string];
    titileLabel.textColor=COLOR_BUTTON_YELLOW;
    [founView addSubview:titileLabel];
    founView.backgroundColor = [UIColor whiteColor];
    
    [_mainScorllView addSubview:founView];
    
    if ([[_model valueForKey:@"status"]isEqualToString:@"3"]){
        _mainScorllView.contentSize = CGSizeMake(screenSize.width,CGRectGetMaxY(founView.frame)+10);
        
    }else{
        // CGFloat height = 90;
        CGFloat contentLineHeight = 70;
        UIImageView *buttonBgView =[UIImageView backgroudTwoLineImageViewWithPXX:0 y: thirdView.h+founView.h+ firstView.h + secondView.h + 4*20 width:APP_PX_WIDTH height:contentLineHeight*1.5];
        buttonBgView.backgroundColor = [UIColor whiteColor];
        
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.frame = LGRectMake(30, 15, buttonBgView.w - 30*2, buttonBgHeight - 15*2);
        [_nextButton setTitle:@"继续支付" forState:UIControlStateNormal];
        _nextButton.titleLabel.font = FONT_NOMAL;
        [_nextButton addTarget:self action:@selector(nextStepButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [_nextButton setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 100, 44, 100)] forState:UIControlStateNormal];
        [_nextButton.titleLabel setTextColor:[UIColor whiteColor]];
        [buttonBgView addSubview:_nextButton];
        [_mainScorllView addSubview:buttonBgView];
        
        _mainScorllView.contentSize = CGSizeMake(screenSize.width, CGRectGetMaxY(buttonBgView.frame)+20);
    
        
    }
    
    /*_    服务门店信息 */
}
-(void)nextStepButtonClicked{
    
    BYPayONlineViewController *vc=[[BYPayONlineViewController alloc]init];
    BaoYangModel *model = [[BaoYangModel alloc]init];
    vc.baoyang = model;
    
    vc.infoModel=_model;
    vc.baoyang.hphm =[[[_model valueForKey:@"orderInfo"]valueForKey:@"vehicleInfo"]valueForKey:@"hphm"];
    vc.baoyang.peopleDate=[[[_model valueForKey:@"orderInfo"]valueForKey:@"bookingInfo"]valueForKey:@"maintainDate"];
    vc.baoyang.peopleTime=[[[_model valueForKey:@"orderInfo"]valueForKey:@"bookingInfo"]valueForKey:@"maintainTime"];
    vc.baoyang.name=[[[_model valueForKey:@"orderInfo"]valueForKey:@"businesInfo"]valueForKey:@"shopInfoName"];
    vc.baoyang.address=[[[_model valueForKey:@"orderInfo"]valueForKey:@"businesInfo"]valueForKey:@"address"];
    vc.orderNo=[NSString stringWithFormat:@"%@,%@",[_model valueForKey:@"ordid"],[_model valueForKey:@"verifycode"]];
    float number =[[[_model valueForKey:@"orderInfo"]valueForKey:@"totalPrice"]integerValue];;
    vc.baoyang.selectedAllPrice=number;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
    
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
