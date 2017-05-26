//
//  MyOrderController.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/9/8.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "MyOrderController.h"
#import "BYPayONlineViewController.h"
#import "MyAFNetWorkingRequest.h"
#import "BLMHttpTool.h"
#import "BYPayInfoViewController.h"




@interface MyOrderController ()<UIScrollViewDelegate>
@property (nonatomic, strong) MyAFNetWorkingRequest *request;
@property(nonatomic,strong)UIScrollView *mainScorllView;
@property(nonatomic,strong)UIImageView *carImage;
@property(nonatomic,copy)NSString *methodLabel;
@property(nonatomic,copy)NSString *orderTimeLabel;
@property(nonatomic,copy)NSString *orderStoreLabel;
@property(nonatomic,copy)NSString *telLabel;
@property(nonatomic,copy)NSString *detailLabel;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSArray *array1;
@property(nonatomic,strong)UIButton *checkbox1;
@property(nonatomic,strong)UIButton *checkbox2;
@property(nonatomic,assign)BOOL ZhiFuBao;
@property(nonatomic,copy)NSString *ordIdUrl;
@property(nonatomic,strong)UIButton *nextButton;
@end

@implementation MyOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CreatUI];
    
    
    
}

-(void)CreatUI{
    
    
    
    CGFloat buttonBgHeight = 60 + 20 + 20;
    CGFloat scrollViewH = APP_HEIGHT - APP_NAV_HEIGHT;
    CGFloat singleLineHeightPX = 30*3;
    //    _perfectCarinfoFormBgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y: 0 width:APP_PX_WIDTH height:singleLineHeightPX*7];
    _mainScorllView = [[UIScrollView  alloc]initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, scrollViewH)];
    _mainScorllView.backgroundColor=COLOR_FRAME_LINE;
    //关闭弹簧效果
    _mainScorllView.bounces = YES;
    _mainScorllView.delegate = self;
    _mainScorllView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainScorllView];
    //firs
    //    UIView *firstView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _mainScorllView.w ,_mainScorllView.h/7                                                                                                                                                                                                                                                   )];
    UIImageView *firstView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y: 0 width:APP_PX_WIDTH height:singleLineHeightPX*2];
    firstView.backgroundColor=[UIColor whiteColor];
    UIImageView *carImage =[[UIImageView alloc]initWithFrame:LGRectMake(10, 20, 160, 140)];
    NSString *urlString = [NSString stringWithFormat:@"http://idc.pic-01.956122.com/allPic/CarLogo/%@.jpg", [[self.car.clsbdh substringToIndex:3] uppercaseString]];
    [carImage setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"home_car_brand_default"]];
    [firstView addSubview:carImage];
    CGFloat firstHeight = 40;
    for (int i = 0; i < 4; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(carImage.w*1.1, i*firstHeight , firstView.w, 70)];
        [label convertNewLabelWithFont:SYS_FONT_SIZE(30) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        [firstView addSubview:label];
        NSString *contentStr = @"";
        switch (i) {
            case 0:
                contentStr = [NSString stringWithFormat:@"%@ ", self.baoyang.hphm];
                break;
            case 1:
                contentStr = [NSString stringWithFormat:@"里程: %ld", self.baoyang.xxlc];
                break;
            case 2:
                contentStr = [NSString stringWithFormat:@"新车上路时间: %@", self.baoyang.zcrq];
                break;
            case 3:
                contentStr = [NSString stringWithFormat:@"识别代码: %@", self.baoyang.vin];
                break;
                
            default:
                break;
        }
        [label setText:contentStr];
    }
    
    
    [_mainScorllView addSubview:firstView];
    /*-------------------------------------服务及到店时间--------------------------------------------*/
    CGFloat height = 90;
    CGFloat contentLineHeight = 70;
    //    UIView *secondView=[[UIView alloc]initWithFrame:CGRectMake( 0, firstView.frame.size.height + 20, screenSize.width, _mainScorllView.h/3)];
    UIImageView *secondView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y:firstView.h + 20 width:APP_PX_WIDTH height:contentLineHeight* 7];
    UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height)];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height)];
    [secondView addSubview:lineL];
    UILabel *titileLabel = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 30, secondView.w - lineL.l*2, 30)];
    titileLabel.font = SYS_FONT_SIZE(35);
    [titileLabel setText:@"服务时间及门店选择"];
    [secondView addSubview:titileLabel];
    secondView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 5; i++) {
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 100+ i*contentLineHeight , secondView.w - lineL.l*2, 70)];
        [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        [secondView addSubview:label];
        
        //删除星期几时间
        NSRange dateStrRange = NSMakeRange(0, 10);
        NSString *dealDateStr = [self.baoyang.peopleDate substringWithRange:dateStrRange];
    
        NSString *contentStr = @"";
        switch (i) {
            case 0:
                contentStr = [NSString stringWithFormat:@"服务形式: 驾车到店"];
                break;
            case 1:
            
                contentStr = [NSString stringWithFormat:@"预约时间: %@ %@",dealDateStr,self.baoyang.peopleTime];
                break;
            case 2:
                contentStr = [NSString stringWithFormat:@"预约门店: %@", self.baoyang.name];
                break;
            case 3:
                contentStr = [NSString stringWithFormat:@"联系电话: %@", self.baoyang.peoplePhone];
                break;
            case 4:
                contentStr = [NSString stringWithFormat:@"详细地址: %@", self.baoyang.address];
                break;
            default:
                break;
        }
        [label setText:contentStr];
    }
    
    [_mainScorllView addSubview:secondView];
    //third
    CGFloat height3 = 90;
    CGFloat contentLineHeight3 = 90;
    
    UIImageView *ThirdView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y: firstView.h + secondView.h + 2*20 width:APP_PX_WIDTH height:contentLineHeight3* (self.baoyang.seletedPacegeArr.count+1)];
    
    
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height3)];
    [ThirdView addSubview:lineL];
    UILabel *titileLabel3 = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 30, ThirdView.w - lineL.l*2, 30)];
    titileLabel3.font = SYS_FONT_SIZE(35);
    [titileLabel3 setText:@"服务项目"];
    [ThirdView addSubview:titileLabel3];
    ThirdView.backgroundColor = [UIColor whiteColor];
    
    
    
    for (int i = 0; i < self.baoyang.seletedPacegeArr.count; i++) {
        BaoYangModel *packgeModel = self.baoyang.seletedPacegeArr[i];
        UILabel *packgeLabel = [[UILabel alloc] initWithFrame:LGRectMake(30, 100+ i*contentLineHeight3 , ThirdView.w - lineL.l*2, 40)];
        [packgeLabel convertNewLabelWithFont:SYS_FONT_SIZE(35) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        packgeLabel.text = packgeModel.packagename;
        [ThirdView addSubview:packgeLabel];
        
        BaoYangServiewModel *sevModel = self.baoyang.seletedSevArr[i];
        UILabel *sevLabel = [[UILabel alloc] initWithFrame:LGRectMake(30, 130+ i*contentLineHeight3 , ThirdView.w - lineL.l*2, 60)];
        [sevLabel convertNewLabelWithFont:SYS_FONT_SIZE(26) textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
        sevLabel.text = sevModel.name;
        sevLabel.numberOfLines = 0;
        [ThirdView addSubview:sevLabel];
    }
    
    [_mainScorllView addSubview:ThirdView];
    
    /* ____________ 保养订单价格_________________*/
    
    
    
    UIImageView *FoundView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y: ThirdView.h + firstView.h + secondView.h + 3*20 width:APP_PX_WIDTH height:contentLineHeight*1.5];
    
    FoundView.backgroundColor=[UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30 , FoundView.h/3 , ThirdView.w - lineL.l*2, 30)];
    label.font=SYS_FONT_SIZE(35);
    NSString *contentStr=@"";
    label.textColor=COLOR_BUTTON_YELLOW;
    contentStr = [NSString stringWithFormat:@"保养订单金额：%.2f", self.baoyang.selectedAllPrice];
    label.text=contentStr;
    [FoundView addSubview:label];
    [_mainScorllView addSubview:FoundView];
    
    /* ____________ 支付方式_________________*/
    
    UIImageView *lastView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y: FoundView.h+ThirdView.h + firstView.h + secondView.h + 4*20 width:APP_PX_WIDTH height:contentLineHeight*3];
    lastView.backgroundColor=[UIColor whiteColor];
    [_mainScorllView addSubview:lastView];
    CGFloat height4 = 90;
    //CGFloat contentLineHeight4 = 70;
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, height4)];
    [lastView addSubview:lineL];
    UILabel *titileLabel4 = [[UILabel alloc] initWithFrame:LGRectMake(lineL.l, 30, ThirdView.w - lineL.l*2, 30)];
    titileLabel4.font = SYS_FONT_SIZE(35);
    [titileLabel4 setText:@"支付方式"];
    [lastView addSubview:titileLabel4];
    label = [[UILabel alloc] initWithFrame:LGRectMake(80, 100 , ThirdView.w - lineL.l*2, 70)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [ThirdView addSubview:label];
    [label setText:@"支付宝"];
    [lastView addSubview:label];
    
    UIImageView *imageView=[[UIImageView alloc]init];
    
    CGRect checkboxRect1 = LGRectMake(30, 115 , 40, 40);
    [imageView setFrame:checkboxRect1];
    imageView.image=[UIImage imageNamed:@"icon__payment_checkbox_checked"];
    
    [lastView addSubview:imageView];
    
    
    
    
    //    for (int i = 0; i < 2; i++) {
    //
    //
    //        UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(80, 100+ i*contentLineHeight4 , ThirdView.w - lineL.l*2, 70)];
    //        [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    //        [ThirdView addSubview:label];
    //        NSString *contentStr = @"";
    //        switch (i) {
    //            case 0:
    //                contentStr = [NSString stringWithFormat:@"支付宝"];
    //                break;
    //            case 1:
    //                contentStr = [NSString stringWithFormat:@"微信"];
    //            default:
    //                break;
    //        }
    //
    //
    //        [label setText:contentStr];
    //        [lastView addSubview:label];
    //    }
    //    _checkbox1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //
    //    CGRect checkboxRect1 = LGRectMake(30, 115 , 40, 40);
    //    [_checkbox1 setFrame:checkboxRect1];
    //
    //    [_checkbox1 setImage:[UIImage imageNamed:@"icon__payment_checkbox_unchecked"] forState:UIControlStateNormal];
    //    [_checkbox1 setImage:[UIImage imageNamed:@"icon__payment_checkbox_checked"] forState:UIControlStateSelected];
    //
    //    [_checkbox1 addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    //    //_checkbox1.selected=YES;
    //    [lastView addSubview:_checkbox1];
    //
    //    _checkbox2 = [UIButton buttonWithType:UIButtonTypeCustom];
    //
    //    CGRect checkboxRect2 = LGRectMake(30, 115+ 70 , 40, 40);
    //    [_checkbox2 setFrame:checkboxRect2];
    //
    //    [_checkbox2 setImage:[UIImage imageNamed:@"icon__payment_checkbox_unchecked"] forState:UIControlStateNormal];
    //    [_checkbox2 setImage:[UIImage imageNamed:@"icon__payment_checkbox_checked"] forState:UIControlStateSelected];
    //
    //    [_checkbox2 addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [lastView addSubview:_checkbox2];
    
    
    
    
    /* ____________  下一步_________________*/
    
    UIImageView *buttonBgView=[UIImageView backgroudTwoLineImageViewWithPXX:0 y: lastView.h+FoundView.h+ThirdView.h + firstView.h + secondView.h + 5*20 width:APP_PX_WIDTH height:contentLineHeight*1.5];
    buttonBgView.backgroundColor = [UIColor whiteColor];
    
    
    
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextButton.frame = LGRectMake(30, 15, buttonBgView.w - 30*2, buttonBgHeight - 15*2);
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    _nextButton.titleLabel.font = FONT_NOMAL;
    [_nextButton addTarget:self action:@selector(nextStepButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_nextButton setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 100, 44, 100)] forState:UIControlStateNormal];
    [_nextButton.titleLabel setTextColor:[UIColor whiteColor]];
    [buttonBgView addSubview:_nextButton];
    [_mainScorllView addSubview:buttonBgView];
    
    _mainScorllView.contentSize = CGSizeMake(screenSize.width, CGRectGetMaxY(buttonBgView.frame));
    
    
    
    
}
-(void)checkboxClick:(UIButton *)btn{
    
    if (_checkbox1.selected==YES) {
        _checkbox1.selected=NO;
        _checkbox2.selected=YES;
        
    }else{
        
        _checkbox1.selected=YES;
        _checkbox2.selected=NO;
        
    }
    
    
    
}

-(void)nextStepButtonClicked{
   [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   // _ordIdUrl =@"http://132.96.77.199/createOrder.do?";
    _ordIdUrl =@"http://buss.956122.com/createOrder.do?";
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    //预约信息
    NSMutableDictionary *dicBook = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicBook setObject:self.baoyang.peopleName forKey:@"actualName"];
    [dicBook setObject:@"null" forKey:@"address"];
    [dicBook setObject:self.baoyang.peopleDate forKey:@"maintainDate"];
    [dicBook setObject:self.baoyang.peopleTime forKey:@"maintainTime"];
    [dicBook setObject:self.baoyang.peoplePhone forKey:@"phone"];
    //商户信息
    NSMutableDictionary *dicBusines = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicBusines setObject:self.baoyang.address forKey:@"address"];
    
    [dicBusines setObject:self.baoyang.city forKey:@"cityName"];
    [dicBusines setObject:@"null" forKey:@"closetime"];
    [dicBusines setObject:@"null" forKey:@"contacts"];
    NSNumber *gradeNum = [NSNumber numberWithInt:0];
    [dicBusines setObject:gradeNum forKey:@"grade"];
    [dicBusines setObject:@"null" forKey:@"opentime"];
    [dicBusines setObject:self.baoyang.phone forKey:@"phone"];
    [dicBusines setObject:@"汽车保养、维修；车漆修复、玻璃修补" forKey:@"shopDetail"];
    NSNumber *shopIdNum = [NSNumber numberWithInt:[self.baoyang.id intValue]];
    [dicBusines setObject:shopIdNum forKey:@"shopId"];
    [dicBusines setObject:@"http://hzidc.pic-01.956122.com/allPic/Buss/20150916/34bfcbcb-20cd-46cb-8df1-fce02b9fb553.png" forKey:@"shopPic"];
    [dicBusines setObject:@"小矮人人民西路店" forKey:@"shopInfoName"];
    NSNumber *shopTypeNum = [NSNumber numberWithInt:0];
    [dicBusines setObject:shopTypeNum forKey:@"shopType"];
    
    //车辆信息
    NSMutableDictionary *dicvehic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicvehic  setObject:self.car.ccdjrq forKey:@"ccdjrq"];
    [dicvehic  setObject:self.car.clsbdh forKey:@"clsbdm"];
    [dicvehic  setObject:self.baoyang.hphm forKey:@"hphm"];
    NSNumber *sczdNum = [NSNumber numberWithFloat:self.baoyang.sczd];
    [dicvehic  setObject:sczdNum forKey:@"marketPrice"];//市场指导价格
    NSNumber *xxlcNum = [NSNumber numberWithLong:self.baoyang.xxlc];
    [dicvehic  setObject:xxlcNum forKey:@"mileage"];//公里数
    
//    NSMutableArray *ArrPacke=[[NSMutableArray alloc]init];
    
    NSMutableArray *packageList = [[NSMutableArray alloc]init];
    for (int j = 0; j < self.baoyang.seletedPacegeArr.count; j++)
    {
        NSMutableDictionary *itmesDic1= [[NSMutableDictionary alloc] initWithCapacity:0];
        NSMutableArray *serviceItems=[[NSMutableArray alloc]init];
        [serviceItems removeAllObjects];
        BaoYangServiewModel *seletedSevModel = self.baoyang.seletedSevArr[j];
        if(seletedSevModel.isdelete != NO){
            NSNumber *forTypeNum = [NSNumber numberWithInt:[seletedSevModel.ext1Int intValue]];
            [itmesDic1 setObject:forTypeNum forKey:@"forType"];
            [itmesDic1 setObject:seletedSevModel.name forKey:@"itemDesc"];
            NSNumber *itemIdNum = [NSNumber numberWithInt:[seletedSevModel.id intValue]];
            [itmesDic1 setObject:itemIdNum forKey:@"itemId"];//
            [itmesDic1 setObject:seletedSevModel.name forKey:@"itemName"];
            [itmesDic1 setObject:seletedSevModel.price forKey:@"price"];
            [serviceItems addObject:itmesDic1];
        }
        
        
        BaoYangModel *seletedBYModel = self.baoyang.seletedPacegeArr[j];
        
        NSMutableDictionary *packegeDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [packegeDic setObject:seletedBYModel.packagename forKey:@"packageDetail"];
        NSNumber *packageIdNum = [NSNumber numberWithInt:[seletedBYModel.id intValue]];
        [packegeDic setObject:packageIdNum forKey:@"packageId"];
        [packegeDic setObject:seletedBYModel.packagename forKey:@"packageName"];
        [packegeDic setObject:@"" forKey:@"packagePrice"];
        NSNumber *packageTypeNum = [NSNumber numberWithInt:[seletedBYModel.extInt1 intValue]];
        [packegeDic setObject:packageTypeNum forKey:@"packageType"];
        [packegeDic setObject:serviceItems forKey:@"serviceItems"];
        [packageList addObject:packegeDic];

    }
    
    
    [bodyDict setObject:APP_DELEGATE.userName forKey:@"userName"];//用户
    NSNumber *totalPriceNum = [NSNumber numberWithFloat:self.baoyang.selectedAllPrice];
    [bodyDict setObject:totalPriceNum forKey:@"totalPrice"];//总价格
    NSNumber *totalAmountNum = [NSNumber numberWithLong:self.baoyang.seletedPacegeArr.count];
    [bodyDict setObject:totalAmountNum forKey:@"totalAmount"];//数组count
    NSNumber *serviceTypeNum = [NSNumber numberWithInt:0];//0这个要写在model里 0是驾车到店 1是上门取车
    [bodyDict setObject:serviceTypeNum forKey:@"serviceType"];//不懂
    NSNumber *payByNum = [NSNumber numberWithInt:1];
    [bodyDict setObject:payByNum forKey:@"payBy"];//支付方式
    [bodyDict setObject:dicBook forKey:@"bookingInfo"];
    [bodyDict setObject:dicBusines forKey:@"businesInfo"];
    [bodyDict setObject:dicvehic forKey:@"vehicleInfo"];
    [bodyDict setObject:packageList forKey:@"packageList"];
    
    
    NSString *json=[Instance_ENT dictionaryToJson:bodyDict];
    
//    NSLog(@"json:%@",json);
    [Instance_ENT.dataDictionary setValue:json forKey:@"json"];
    
    
    [BLMHttpTool postWithURL:_ordIdUrl params:Instance_ENT.dataDictionary
                     success:^(id json) {
                         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

                         BYPayONlineViewController *vc=[[BYPayONlineViewController alloc]init];
                         vc.baoyang = self.baoyang;
                         vc.ZhiFuBao =_checkbox1.selected;
                         NSString *string=[json objectForKey:@"msg"];
                         
                         vc.orderNo=string;
                         
                         [self.navigationController pushViewController:vc animated:YES];
       
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *errStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if (!errStr || [errStr isEqualToString:@""]) {
            errStr = @"服务器出错了！";
        }
        [UIAlertView alertTitle:nil msg:errStr];
                         
    }];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"爱车保养预约"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
