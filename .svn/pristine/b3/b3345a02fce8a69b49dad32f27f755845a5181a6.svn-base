//
//  BXPerfectCarinfoViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/9.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BYSelectServiceViewController.h"
#import "BYSelectStoreController.h"
#import "SetProvinceViewController.h"
#import "ChoesPackgeController.h"
#import "BLMHttpTool.h"

#define TAG_BUTTON_REGIST_DATE      111
#define TAG_BUTTON_JQX_TOUBAO_DATE      222
#define TAG_BUTTON_SYX_TOUBAO_DATE          333
@interface BYSelectServiceViewController ()<
UITextFieldDelegate
>
{
    UITextField     *_hphmTF;//车牌号
    UITextField     *_sczdTF;//市场指导价格
    UITextField     *_xxlcTF;//行驶里程
    UITextField     *_fdjhTF;//发动机号
    UITextField     *_vinTF;//识别代码
    UILabel         *_zcrqL;//车辆注册日期
    UILabel         *_cityL;
    //    UILabel         *_syxDateL;
    //    UILabel         *_jqxDateL;
    
    UIImageView     *_perfectCarinfoFormBgView;
    UIScrollView    *_rootScrollView;
    MBProgressHUD   *_hud;
    
    UIImageView          *_datePickerBgview;
    UIDatePicker         *_datePicker;
}




@end


@implementation BYSelectServiceViewController


#define TAG_TF_HPHM     100
#define TAG_TF_CZXM     101
#define TAG_TF_SFZH     102
#define TAG_TF_FDJH     103
#define TAG_TF_VIN      104
#define TAG_TF_ZCRQ     105
#define PLACE_HOLDER_ZHU_CE_RIQ     @"车辆注册日期"


- (void)keyboardWillChangeFrame:(NSNotification*)notify{
    NSDictionary *infoDict = [notify userInfo];
    CGRect frame = [[infoDict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat bottomY = 0;
    CGFloat space = 30*PX_X_SCALE;
    if ([_hphmTF isFirstResponder]) {
        bottomY = _hphmTF.bottom + _perfectCarinfoFormBgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
    }else if ([_sczdTF isFirstResponder]) {
        bottomY = _sczdTF.bottom + _perfectCarinfoFormBgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
    }else if ([_fdjhTF isFirstResponder]) {
        bottomY = _fdjhTF.bottom + _perfectCarinfoFormBgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
    }else if ([_vinTF isFirstResponder]) {
        bottomY = _vinTF.bottom + _perfectCarinfoFormBgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
    }
    
    
    
    
    
    
    CGFloat keyBoardStartY = self.view.frame.size.height - self.view.frame.origin.y - frame.size.height;
    if (keyBoardStartY < bottomY) {
        [self.view setFrame:CGRectMake(self.view.left, self.view.top - (bottomY - keyBoardStartY), self.view.width, self.view.height)];
    }
}

- (void)keyboardWillHide:(NSNotification*)notify{
    [self.view setFrame:CGRectMake(self.view.left, 0, self.view.width, self.view.height)];
    
    
}

//-(void)download{
//    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
//    NSString *string=[self.car.clsbdh substringToIndex:8];
//    [bodyDict setObject:string forKey:@"vin8"];
//    
//    [BLMHttpTool postWithURL:@"http://132.96.77.199/getVehicleByVin8.do?" params:bodyDict success:^(id json) {
//        //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        NSLog(@"json");
//
//        
//        
//    } failure:^(NSError *error) {
//        
//        
//        
//    }];
//   
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.baoyang = [[BaoYangModel alloc]init];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    CGFloat buttonBgHeight = 60 + 20 + 20;
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - buttonBgHeight*PX_Y_SCALE)];
    _rootScrollView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_rootScrollView];
    
    
    CGFloat singleLineHeightPX = 30*3;
    _perfectCarinfoFormBgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y: 0 width:APP_PX_WIDTH height:singleLineHeightPX*7];
    [_rootScrollView addSubview:_perfectCarinfoFormBgView];
    
    
    //*********************************横线*********************************
    UILabel *lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(0, singleLineHeightPX - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH )*PX_X_SCALE, lineLabel.height+10)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 2 - 1+10)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 3 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 4 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(0, singleLineHeightPX * 5 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH)*PX_X_SCALE, lineLabel.height+10)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 6 - 1+10)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
    
    
    //*********************************行驶城市*********************************
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"行驶城市："];
    [_perfectCarinfoFormBgView addSubview:label];
    
    _cityL = [[UILabel alloc] initWithFrame:LGRectMake(280, 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [_cityL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_perfectCarinfoFormBgView addSubview:_cityL];
//    UITapGestureRecognizer *tapCity= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToChangeCity)];
//    [_cityL setUserInteractionEnabled:YES];
//    [_cityL addGestureRecognizer:tapCity];
    
    //*********************************车牌号码*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX + 45, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"车牌号码："];
    [_perfectCarinfoFormBgView addSubview:label];
    
    _hphmTF = [[UITextField alloc] initWithFrame:LGRectMake(280, singleLineHeightPX + 45, _perfectCarinfoFormBgView.w - 30*2, 40)];
    _hphmTF.delegate = self;
    _hphmTF.tag = TAG_TF_HPHM;
    [_hphmTF setFont:FONT_NOMAL];
    [_hphmTF setBorderStyle:UITextBorderStyleNone];
    [_hphmTF setPlaceholder:@"请填写车牌号码"];
    [_hphmTF limitCHTextLength:7];
    [_perfectCarinfoFormBgView addSubview:_hphmTF];
    
    //*********************************发动机号*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*2 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"发动机号："];
    [_perfectCarinfoFormBgView addSubview:label];
    
    _fdjhTF = [[UITextField alloc] initWithFrame:LGRectMake(280, singleLineHeightPX*2 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    _fdjhTF.delegate = self;
    _fdjhTF.tag = TAG_TF_FDJH;
    [_fdjhTF setFont:FONT_NOMAL];
    [_fdjhTF setBorderStyle:UITextBorderStyleNone];
    [_fdjhTF setPlaceholder:@"请填写发动机号"];
    [_fdjhTF limitCHTextLength:8];
    [_fdjhTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_perfectCarinfoFormBgView addSubview:_fdjhTF];
    
    
    //*********************************车辆识别代号*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*3 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"车辆识别代号："];
    [_perfectCarinfoFormBgView addSubview:label];
    
    _vinTF = [[UITextField alloc] initWithFrame:LGRectMake(280, singleLineHeightPX*3 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    _vinTF.delegate = self;
    _vinTF.tag = TAG_TF_VIN;
    [_vinTF setFont:FONT_NOMAL];
    [_vinTF setBorderStyle:UITextBorderStyleNone];
    [_vinTF setPlaceholder:@"请填写车辆识别代号"];
    [_vinTF limitCHTextLength:17];
    [_vinTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_perfectCarinfoFormBgView addSubview:_vinTF];
    
    //*********************************车辆注册日期*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*4 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"车辆注册日期："];
    [_perfectCarinfoFormBgView addSubview:label];
    
    _zcrqL = [[UILabel alloc] initWithFrame:LGRectMake(280, singleLineHeightPX*4 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [_zcrqL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_LINK textAlignment:NSTextAlignmentLeft];
    [_zcrqL setText:PLACE_HOLDER_ZHU_CE_RIQ];
    [_perfectCarinfoFormBgView addSubview:_zcrqL];
    [_zcrqL setUserInteractionEnabled:YES];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:_zcrqL.bounds];
    [button setBackgroundColor:[UIColor clearColor]];
    [button addTarget:self action:@selector(setDateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = TAG_BUTTON_REGIST_DATE;
    [_zcrqL addSubview:button];
    
    
    
    //*********************************市场指导价格*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*5 + 35, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"市场指导价格："];
    [_perfectCarinfoFormBgView addSubview:label];
    
    _sczdTF = [[UITextField alloc] initWithFrame:LGRectMake(280, singleLineHeightPX*5 + 35, _perfectCarinfoFormBgView.w - 30*2, 40)];
    _sczdTF.delegate = self;
    //    _sczdTF.tag = TAG_TF_VIN;
    [_sczdTF setFont:FONT_NOMAL];
    [_sczdTF setBorderStyle:UITextBorderStyleNone];
    [_sczdTF setPlaceholder:@"请填写车辆价格"];
    [_sczdTF limitCHTextLength:17];
    [_sczdTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_perfectCarinfoFormBgView addSubview:_sczdTF];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(APP_PX_WIDTH-80, singleLineHeightPX*5 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"万元"];
    [_perfectCarinfoFormBgView addSubview:label];
    //*********************************市场指导价格*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*6 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"累计行驶里程："];
    [_perfectCarinfoFormBgView addSubview:label];
    
    _xxlcTF = [[UITextField alloc] initWithFrame:LGRectMake(280, singleLineHeightPX*6 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    _xxlcTF.delegate = self;
    //    _xxlcTF.tag = TAG_TF_VIN;
    [_xxlcTF setFont:FONT_NOMAL];
    [_xxlcTF setBorderStyle:UITextBorderStyleNone];
    [_xxlcTF setPlaceholder:@"请填写车辆行驶里程"];
    [_xxlcTF limitCHTextLength:17];
    [_xxlcTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    
    [_perfectCarinfoFormBgView addSubview:_xxlcTF];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(APP_PX_WIDTH-80, singleLineHeightPX*6 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"公里"];
    [_perfectCarinfoFormBgView addSubview:label];
    //温馨提示，暂时无用
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:LGRectMake(30, _perfectCarinfoFormBgView.b + 10, APP_PX_WIDTH - 30*2, 60)];
    [noticeLabel convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    noticeLabel.numberOfLines = 0;
    [_rootScrollView addSubview:noticeLabel];
    //
    [_rootScrollView setContentSize:CGSizeMake(_rootScrollView.width, noticeLabel.bottom + 15)];
    
    UIView *buttonBgView = [[UIView alloc] initWithFrame:BGRectMake(0, _rootScrollView.b, APP_PX_WIDTH, buttonBgHeight)];
    buttonBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonBgView];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(0, 0)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH)*PX_X_SCALE, lineLabel.height)];
    [buttonBgView addSubview:lineLabel];
    
    
    //下一步View
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = LGRectMake(30, 15, buttonBgView.w - 30*2, buttonBgView.h - 15*2);
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_NOMAL;
    [button addTarget:self action:@selector(nextStepButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    [buttonBgView addSubview:button];
    
    //添加车辆信息
    if (self.car)
    {
        _hphmTF.text = self.car.hphm;
        _vinTF.text = self.car.clsbdh;
        _zcrqL.text = self.car.ccdjrq;
        
        NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        NSString *string=[self.car.clsbdh substringToIndex:8];
        [bodyDict setObject:string forKey:@"vin8"];
  
        [BLMHttpTool postWithURL:@"http://buss.956122.com/getVehicleByVin8.do?" params:bodyDict success:^(id json) {
//            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         
            id resDic = [json valueForKey:@"msg"];
            if ([resDic isKindOfClass:[NSDictionary class]]) {
           
                NSString *string=[NSString stringWithFormat:@"%@",[resDic valueForKey:@"zdjg"]];

                _sczdTF.text = string;
            }else{
                
                if ([resDic isKindOfClass:[NSString class]]) {
                    
                }
            }
    
         //   _sczdTF.text=string;
        } failure:^(NSError *error) {
            
            
            
        }];
        
        
        if (![self.car.hphm hasPrefix:@"渝"]) {//非重庆
            _fdjhTF.text = self.car.fdjh;
        }
        
    }
    
    
    _datePickerBgview = [[UIImageView alloc] initWithFrame:LGRectMake(0, self.view.h, APP_PX_WIDTH, 500)];
    //_datePickerBgview.backgroundColor = [UIColor whiteColor];
    [_datePickerBgview setImage:[UIImage imageNamed:@"bg_date_picker.png"]];
    _datePickerBgview.userInteractionEnabled = YES;
    [self.view addSubview:_datePickerBgview];
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_datePicker setFrame:LGRectMake(0, 80, APP_PX_WIDTH, _datePicker.h)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    [_datePickerBgview addSubview:_datePicker];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:LGRectMake(_datePickerBgview.w - 100, 10, 100, 50)];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:COLOR_LINK forState:UIControlStateNormal];
    [button addTarget:self action:@selector(datePickerDone) forControlEvents:UIControlEventTouchUpInside];
    [_datePickerBgview addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:LGRectMake(0, 10, 100, 50)];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:COLOR_LINK forState:UIControlStateNormal];
    [button addTarget:self action:@selector(datePickerCancel) forControlEvents:UIControlEventTouchUpInside];
    [_datePickerBgview addSubview:button];
  
    
    
}
//控制市场指导价格和行驶里程只能输入数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSCharacterSet *cs;
    
    if(textField == _xxlcTF || textField == _sczdTF)
    {
        
        cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.\n"] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        BOOL basicTest = [string isEqualToString:filtered];
        
        if(!basicTest)
            
            return NO;
        
    }
    
    return YES;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"车辆信息"];
     // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_cityL setText:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_CITY_NAME_IN_USERDEFAULT]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark- actions
//picker的格式设置
- (void)datePickerDone{
    NSString *date = [_datePicker.date stringWithFormat:@"yyyy-MM-dd"];
    if (_datePicker.tag == TAG_BUTTON_REGIST_DATE) {
        [_zcrqL setText:date];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [_datePickerBgview setFrame:LGRectMake(0, self.view.h, APP_PX_WIDTH, 500)];
    }];
    
}

- (void)datePickerCancel{
    [UIView animateWithDuration:0.5 animations:^{
        [_datePickerBgview setFrame:LGRectMake(0, self.view.h, APP_PX_WIDTH, 500)];
    }];
}


- (void)setDateButtonClicked:(UIButton*)button{
    _datePicker.tag = button.tag;

    if (button.tag == TAG_BUTTON_REGIST_DATE){
        if (![_zcrqL.text isEqualToString:PLACE_HOLDER_ZHU_CE_RIQ]) {
            NSDate *date = [_zcrqL.text convertToDateWithFormat:@"yyyy-MM-dd"];
            [_datePicker setDate:date animated:YES];
        }
        _datePicker.maximumDate = [NSDate date];
        _datePicker.minimumDate = nil;
        
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [_datePickerBgview setFrame:LGRectMake(0, self.view.h - 500, APP_PX_WIDTH, 500)];
        
    }];
    
}

//更换城市
- (void)tapToChangeCity
{
    
    SetProvinceViewController *vc = [[SetProvinceViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)validInputTexts
{
    if (!_hphmTF.text || !_xxlcTF.text || !_sczdTF.text || !_vinTF.text || [_zcrqL.text isEqualToString:PLACE_HOLDER_ZHU_CE_RIQ] || !_fdjhTF.text)
    {
        [UIAlertView alertTitle:nil msg:@"请完善车辆信息，任意信息不能为空！"];
        return NO;
    }
    if ([_hphmTF.text isEqualToString:@""] || [_sczdTF.text isEqualToString:@""] || [_vinTF.text isEqualToString:@""] || [_xxlcTF.text isEqualToString:@""]|| [_fdjhTF.text isEqualToString:@""])
    {
        [UIAlertView alertTitle:nil msg:@"请完善车辆信息，任意信息不能为空！"];
        return NO;
    }
    
    
    return YES;
    
}
#pragma mark 下一步跳转
- (void)nextStepButtonClicked{
    if ([self validInputTexts])
    {
        self.baoyang.hphm = _hphmTF.text;
        self.baoyang.vin = _vinTF.text;
        self.baoyang.zcrq = _zcrqL.text;
        self.baoyang.fdjh = _fdjhTF.text;
        self.baoyang.sczd = [_sczdTF.text floatValue];
        self.baoyang.xxlc = [_xxlcTF.text floatValue];
        self.baoyang.city = _cityL.text;
        BYSelectStoreController *storesVC = [[BYSelectStoreController alloc]init];
        storesVC.baoyang = self.baoyang;
        storesVC.car = self.car;
        [self.navigationController pushViewController:storesVC animated:YES];
    }

    
}
//相关车型
- (void)gotoNextPageWithCityCode:(NSString*)cityCode andParticularCartype:(NSArray*)pCartypeArr{
    
    
    if ([pCartypeArr count] == 0) {
        [UIAlertView alertTitle:nil msg:@"未找到与您的车辆相关的车型，如有疑问请联系客服！"];
        return;
    }
    
    if ([pCartypeArr count] == 1) {
        
    }else{
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([textField isEqual:_hphmTF] || [textField isEqual:_vinTF]) {
        textField.text = [textField.text uppercaseString];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
