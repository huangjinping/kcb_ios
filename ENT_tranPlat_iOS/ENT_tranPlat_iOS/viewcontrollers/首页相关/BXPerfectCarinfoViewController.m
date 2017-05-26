//
//  BXPerfectCarinfoViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/9.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BXPerfectCarinfoViewController.h"
#import "BXSelectInsuranceViewController.h"
#import "BXSelectParticularCartypeViewController.h"
#import "Baoxian.h"
#import "SetProvinceViewController.h"


#define TAG_BUTTON_REGIST_DATE      111
#define TAG_BUTTON_JQX_TOUBAO_DATE      222
#define TAG_BUTTON_SYX_TOUBAO_DATE          333
@interface BXPerfectCarinfoViewController ()<
UITextFieldDelegate
>
{
    UITextField     *_hphmTF;
    UITextField     *_czxmTF;
    UITextField     *_sfzhTF;
    UITextField     *_fdjhTF;
    UITextField     *_vinTF;
    UITextField     *_telTF;
    UILabel         *_zcrqL;
    UILabel         *_cityL;
//    UILabel         *_syxDateL;
//    UILabel         *_jqxDateL;

    UIImageView     *_perfectCarinfoFormBgView;
    UIScrollView    *_rootScrollView;
    MBProgressHUD   *_hud;
    
    UIImageView          *_datePickerBgview;
    UIDatePicker         *_datePicker;
}

@property (nonatomic)   Baoxian *baoxian;


@end


@implementation BXPerfectCarinfoViewController


#define TAG_TF_HPHM     100
#define TAG_TF_CZXM     101
#define TAG_TF_SFZH     102
#define TAG_TF_FDJH     103
#define TAG_TF_VIN      104
#define TAG_TF_ZCRQ     105
#define PLACE_HOLDER_ZHU_CE_RIQ     @"车辆注册日期"
#define PLACE_HOLDER_JQX_TOUBAO_RIQ     @"交强险投保日期"
#define PLACE_HOLDER_SYX_TOUBAO_RIQ     @"商业险投保日期"

- (void)keyboardWillChangeFrame:(NSNotification*)notify{
    NSDictionary *infoDict = [notify userInfo];
    CGRect frame = [[infoDict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat bottomY = 0;
    CGFloat space = 30*PX_X_SCALE;
    if ([_hphmTF isFirstResponder]) {
        bottomY = _hphmTF.bottom + _perfectCarinfoFormBgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
    }else if ([_czxmTF isFirstResponder]) {
        bottomY = _czxmTF.bottom + _perfectCarinfoFormBgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
    }else if ([_sfzhTF isFirstResponder]) {
        bottomY = _sfzhTF.bottom + _perfectCarinfoFormBgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
    }else if ([_fdjhTF isFirstResponder]) {
        bottomY = _fdjhTF.bottom + _perfectCarinfoFormBgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
    }else if ([_vinTF isFirstResponder]) {
        bottomY = _vinTF.bottom + _perfectCarinfoFormBgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
    }
    
    
//    else if ([_zcrqTF isFirstResponder]) {
//        bottomY = _zcrqTF.bottom + _perfectCarinfoFormBgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
//    }

    
    
    CGFloat keyBoardStartY = self.view.frame.size.height - self.view.frame.origin.y - frame.size.height;
    if (keyBoardStartY < bottomY) {
        [self.view setFrame:CGRectMake(self.view.left, self.view.top - (bottomY - keyBoardStartY), self.view.width, self.view.height)];
    }
}

- (void)keyboardWillHide:(NSNotification*)notify{
    [self.view setFrame:CGRectMake(self.view.left, 0, self.view.width, self.view.height)];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    Baoxian *bx = [[Baoxian alloc] init];
    self.baoxian = bx;
    
    UserInfo *activeUser = [[[DataBase sharedDataBase] selectActiveUser] lastObject];
   

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
//    UITapGestureRecognizer *tapp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToRMDatePicker)];
//    [self.view addGestureRecognizer:tapp];
    
    CGFloat buttonBgHeight = 60 + 20 + 20;
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - buttonBgHeight*PX_Y_SCALE)];
    _rootScrollView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_rootScrollView];

    
    CGFloat singleLineHeightPX = 30*3;
    _perfectCarinfoFormBgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y: 30 width:APP_PX_WIDTH height:singleLineHeightPX*8];
    [_rootScrollView addSubview:_perfectCarinfoFormBgView];
    
    
    //*********************************横线*********************************
    UILabel *lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 2 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 3 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 4 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 5 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 6 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 7 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
//    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 8 - 1)];
//    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
//    [_perfectCarinfoFormBgView addSubview:lineLabel];
    //*********************************车牌号码*********************************
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"车牌号码："];
    [_perfectCarinfoFormBgView addSubview:label];
    _hphmTF = [[UITextField alloc] initWithFrame:LGRectMake(280, 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    _hphmTF.delegate = self;
    _hphmTF.tag = TAG_TF_HPHM;
    [_hphmTF setFont:FONT_NOMAL];
    [_hphmTF setBorderStyle:UITextBorderStyleNone];
    [_hphmTF setPlaceholder:@"请填写车牌号码"];
    [_hphmTF limitCHTextLength:7];
    [_perfectCarinfoFormBgView addSubview:_hphmTF];
    //*********************************车主姓名*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"车主姓名："];
    [_perfectCarinfoFormBgView addSubview:label];
    _czxmTF = [[UITextField alloc] initWithFrame:LGRectMake(280, singleLineHeightPX + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    _czxmTF.delegate = self;
    _czxmTF.tag = TAG_TF_CZXM;
    [_czxmTF setFont:FONT_NOMAL];
    [_czxmTF setBorderStyle:UITextBorderStyleNone];
    [_czxmTF setPlaceholder:@"车主姓名(请填写真实姓名)"];
    [_czxmTF limitCHTextLength:20];
    [_perfectCarinfoFormBgView addSubview:_czxmTF];
    //*********************************身份证号*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*2 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"身份证号："];
    [_perfectCarinfoFormBgView addSubview:label];
    _sfzhTF = [[UITextField alloc] initWithFrame:LGRectMake(280, singleLineHeightPX*2 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    _sfzhTF.delegate = self;
    _sfzhTF.tag = TAG_TF_SFZH;
    [_sfzhTF setFont:FONT_NOMAL];
    [_sfzhTF setBorderStyle:UITextBorderStyleNone];
    [_sfzhTF setPlaceholder:@"请填写身份证号"];
    [_sfzhTF limitCHTextLength:18];
    [_sfzhTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_perfectCarinfoFormBgView addSubview:_sfzhTF];
    //*********************************发动机号*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*4 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"发动机号："];
    [_perfectCarinfoFormBgView addSubview:label];
    _fdjhTF = [[UITextField alloc] initWithFrame:LGRectMake(280, singleLineHeightPX*4 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    _fdjhTF.delegate = self;
    _fdjhTF.tag = TAG_TF_FDJH;
    [_fdjhTF setFont:FONT_NOMAL];
    [_fdjhTF setBorderStyle:UITextBorderStyleNone];
    [_fdjhTF setPlaceholder:@"请填写发动机号"];
    [_fdjhTF limitCHTextLength:8];
    [_fdjhTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_perfectCarinfoFormBgView addSubview:_fdjhTF];
    
    //*********************************电话号码*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*3 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"电话号码："];
    [_perfectCarinfoFormBgView addSubview:label];
    _telTF = [[UITextField alloc] initWithFrame:LGRectMake(280, singleLineHeightPX*3 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    _telTF.delegate = self;
    _telTF.tag = TAG_TF_VIN;
    [_telTF setFont:FONT_NOMAL];
    [_telTF setBorderStyle:UITextBorderStyleNone];
    [_telTF setPlaceholder:@"请填写联系电话"];
    [_telTF limitCHTextLength:17];
    [_telTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_perfectCarinfoFormBgView addSubview:_telTF];
    
    //*********************************车辆识别代号*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*5 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"车辆识别代号："];
    [_perfectCarinfoFormBgView addSubview:label];
    _vinTF = [[UITextField alloc] initWithFrame:LGRectMake(280, singleLineHeightPX*5 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    _vinTF.delegate = self;
    _vinTF.tag = TAG_TF_VIN;
    [_vinTF setFont:FONT_NOMAL];
    [_vinTF setBorderStyle:UITextBorderStyleNone];
    [_vinTF setPlaceholder:@"请填写车辆识别代号"];
    [_vinTF limitCHTextLength:17];
    [_vinTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_perfectCarinfoFormBgView addSubview:_vinTF];
    
    //*********************************车辆注册日期*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*6 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"车辆注册日期："];
    [_perfectCarinfoFormBgView addSubview:label];
    
    _zcrqL = [[UILabel alloc] initWithFrame:LGRectMake(280, singleLineHeightPX*6 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
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
   
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*7 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"投保城市："];
    [_perfectCarinfoFormBgView addSubview:label];
    
    _cityL = [[UILabel alloc] initWithFrame:LGRectMake(280, singleLineHeightPX*7 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [_cityL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_LINK textAlignment:NSTextAlignmentLeft];
    [_cityL setText:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_CITY_NAME_IN_USERDEFAULT]];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeCity:) name:NOTIFICATION_CITY_SET_CHANGEDBX object:nil];
    [_perfectCarinfoFormBgView addSubview:_cityL];
    UITapGestureRecognizer *tapCity= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToChangeCity)];
    [_cityL setUserInteractionEnabled:YES];
    [_cityL addGestureRecognizer:tapCity];
    
    
    
    
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:LGRectMake(30, _perfectCarinfoFormBgView.b + 10, APP_PX_WIDTH - 30*2, 60)];
    [noticeLabel convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    noticeLabel.numberOfLines = 0;
    [noticeLabel setText:@"温馨提示：请确保您的车辆保险到期时间前后不超过90天的才可进行投保。"];
    [_rootScrollView addSubview:noticeLabel];
    
    [_rootScrollView setContentSize:CGSizeMake(_rootScrollView.width, noticeLabel.bottom + 15)];
    UIView *buttonBgView = [[UIView alloc] initWithFrame:BGRectMake(0, _rootScrollView.b, APP_PX_WIDTH, buttonBgHeight)];
    buttonBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonBgView];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(0, 0)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH)*PX_X_SCALE, lineLabel.height)];
    [buttonBgView addSubview:lineLabel];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = LGRectMake(30, 15, buttonBgView.w - 30*2, buttonBgView.h - 15*2);
    [button setTitle:@"选择险种" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_NOMAL;
    [button addTarget:self action:@selector(nextStepButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    [buttonBgView addSubview:button];
    

    if (self.car) {
        _hphmTF.text = self.car.hphm;
        _czxmTF.text = self.car.syr;
        _sfzhTF.text = self.car.sfzmhm;
        _vinTF.text = self.car.clsbdh;
        _zcrqL.text = self.car.ccdjrq;
        _telTF.text = activeUser.contactNum;
       
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
-(void)changeCity:(NSNotification*)noti{
    
    
    _cityL.text=[noti.userInfo valueForKey:@"name"];
    
    //_SZDQ.text=_szdq;
    
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"车辆信息"];

    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark- actions

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


- (void)tapToChangeCity{
    SetProvinceViewController *vc = [[SetProvinceViewController alloc] init];

    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)validInputTexts{
    if (!_hphmTF.text || !_czxmTF.text || !_sfzhTF.text || !_vinTF.text || [_zcrqL.text isEqualToString:PLACE_HOLDER_ZHU_CE_RIQ] || !_fdjhTF.text) {// || [_jqxDateL.text isEqualToString:PLACE_HOLDER_JQX_TOUBAO_RIQ] || [_syxDateL.text isEqualToString:PLACE_HOLDER_SYX_TOUBAO_RIQ]
        [UIAlertView alertTitle:nil msg:@"请完善车辆信息，任意信息不能为空！"];
        return NO;
    }
    if ([_hphmTF.text isEqualToString:@""] || [_czxmTF.text isEqualToString:@""] || [_sfzhTF.text isEqualToString:@""] || [_vinTF.text isEqualToString:@""] || [_zcrqL.text isEqualToString:PLACE_HOLDER_ZHU_CE_RIQ]|| [_fdjhTF.text isEqualToString:@""]) {// || [_jqxDateL.text isEqualToString:PLACE_HOLDER_JQX_TOUBAO_RIQ] || [_syxDateL.text isEqualToString:PLACE_HOLDER_SYX_TOUBAO_RIQ]
        [UIAlertView alertTitle:nil msg:@"请完善车辆信息，任意信息不能为空！"];
        return NO;
    }
    if (![_sfzhTF.text isValidIDNumber]) {
        [UIAlertView alertTitle:nil msg:@"身份证号码有误，请检查并修改！"];
        return NO;
    }
    if (!_telTF.text || ![_telTF.text isValidPhoneNum]) {
        [UIAlertView alertTitle:@"被保人信息" msg:@"被保人手机号码填写有误，请检查并修改后重新提交！"];
        return NO;
    }
    
    
    return YES;

}
- (void)nextStepButtonClicked{
    
    
    if ([self validInputTexts]) {
        self.baoxian.hphm = _hphmTF.text;
        self.baoxian.syr = _czxmTF.text;
        self.baoxian.sfzhm = _sfzhTF.text;
        self.baoxian.vin = _vinTF.text;
        self.baoxian.zcrq = _zcrqL.text;
        self.baoxian.fdjh = _fdjhTF.text;
        self.baoxian.city = _cityL.text;
//        self.baoxian.syxToubaoDate = _syxDateL.text;
//        self.baoxian.jqxToubaoDate = _jqxDateL.text;
        [self netGetCityCodeWithCityName:_cityL.text];
    }
    
    
    
}

- (void)gotoNextPageWithCityCode:(NSString*)cityCode andParticularCartype:(NSArray*)pCartypeArr{
    self.baoxian.citycode = cityCode;
    self.baoxian.pCartypeArr = pCartypeArr;
    
    if ([pCartypeArr count] == 0) {
        [UIAlertView alertTitle:nil msg:@"未找到与您的车辆相关的车型，如有疑问请联系客服！"];
        return;
    }
    
    if ([pCartypeArr count] == 1) {
        BXSelectInsuranceViewController *bxsiVC = [[BXSelectInsuranceViewController alloc] init];
        bxsiVC.baoxian = self.baoxian;
        [self.navigationController pushViewController:bxsiVC animated:YES];
    }else{
        BXSelectParticularCartypeViewController *bxspcVC = [[BXSelectParticularCartypeViewController alloc] init];
        bxspcVC.baoxian = self.baoxian;
        [self.navigationController pushViewController:bxspcVC animated:YES];
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}



- (void)netGetCityCodeWithCityName:(NSString*)cityName{
    
    /*
     http://chexian.sinosig.com/travelCity!getTravelCityForInterface.action?hotSign=4&limit=0&queryCon=邯郸&contName=&encoding=GBK&callback=jsonp1045
     */
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeText;
    _hud.labelText = @"查询城市编码...";
    NSString *urlStr = [NSString stringWithFormat:@"http://chexian.sinosig.com/travelCity!getTravelCityForInterface.action?hotSign=4&limit=0&queryCon=%@&contName=&encoding=GBK&callback=", cityName];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *rq = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:rq queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        

        if (connectionError) {//failed
            [_hud hide:YES];
            [UIAlertView alertTitle:@"网络故障" msg:@"获取城市编码失败"];
        }else{
            if (data) {//succ
                NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                

                NSString *rqstr = [[NSString alloc] initWithData:data encoding:enc];
                NSRange range = [rqstr rangeOfString:@"\"id\":\""];
                if (range.location != NSNotFound) {
                    NSString *idStr = [rqstr substringFromIndex:range.location + range.length];
                    range = [idStr rangeOfString:@"\""];
                    if (range.location != NSNotFound) {
                        idStr = [idStr substringToIndex:range.location];
                        [self netGetParticularCartypeListWithVin:_vinTF.text andCityCode:idStr];

                    }else{//failed
                        [_hud hide:YES];
                        [UIAlertView alertTitle:@"返回数据格式错误" msg:@"获取城市编码失败"];

                    }

                }else{//failed
                    [_hud hide:YES];
                    [UIAlertView alertTitle:@"返回数据格式错误" msg:@"获取城市编码失败"];

                }


            }else{//failed
                [_hud hide:YES];
                [UIAlertView alertTitle:@"" msg:@"获取城市编码失败"];

            }
        }
        
    }];
    
}


- (void)netGetParticularCartypeListWithVin:(NSString*)vin andCityCode:(NSString*)cityCode{


    _hud.labelText = @"获取车型列表...";
    NSString *urlStr = [NSString stringWithFormat:@"http://chexian.sinosig.com/Partner/netVehicleModel.action?page=1&pageSize=100000&searchCode=%@&searchType=1&encoding=GBK&isSeats=1&callback=", vin];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *rq = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:rq queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (connectionError) {//failed
            [UIAlertView alertTitle:@"网络故障" msg:@"获取车型列表失败"];
        }else{
            if (data) {//succ
                NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                
                
                NSString *restr = [[NSString alloc] initWithData:data encoding:enc];
                restr = [restr substringWithRange:NSMakeRange(1, restr.length - 2)];
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                NSDictionary *resDict = [parser objectWithString:restr];
                NSArray *dataArr = [resDict analysisArrValueByKey:@"rows"];
                
                [self gotoNextPageWithCityCode:cityCode andParticularCartype:dataArr];
            }else{//failed
                [UIAlertView alertTitle:@"" msg:@"获取车型列表失败"];
                
            }
        }
        
    }];
    

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
