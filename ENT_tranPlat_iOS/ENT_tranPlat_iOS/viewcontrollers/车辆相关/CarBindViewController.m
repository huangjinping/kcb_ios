//
//  CarBindViewController.m
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-7-15.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "CarBindViewController.h"
#import "CarInfoViewController.h"
#import "SelectCarTypeViewController.h"
#import "SelectCarHphmPreViewController.h"
#import "QuestionNoticeView.h"

@interface CarBindViewController ()<
SelectCarTypeViewControllerDelegate,
SelectCarHphmPreViewControllerDelegate
>
{
    //UIView              *_chezhuView;;
    //UITextField         *_chezhuNameTF;
    //UITextField         *_chezhuIdTF;
    //UIImageView         *_inputBgView;
    //UIButton            *_submitButton;
    //UIView              *_attentionsBgView;
    
    
    // UIButton            *_pickHphmpreButton;
    
    
    //new
    UITextField             *_sbdhTF;//识别码
    UILabel                 *_hphmPrefixLabel;//车牌前缀
    UITextField             *_hphmTF;//车牌
    UILabel                 *_carTypeL;//车辆类型
    UITextField             *_chezhuNameTF;//车主姓名
    UITextField             *_chezhuZhengjianTF;//车主身份证号码
    
    QuestionNoticeView      *_quesNoticeview;
    
    UIImageView                  *_mainBgView;
    UIImageView                  *_chezhuMsgBgView;
    UIView                       *_submitBgView;
    
    UIView                  *_bgDarkView;
    
    NSDictionary            *_hpzlDict;//号牌种类码表
    
}

@property (nonatomic , retain)      NSString                *carTypeCode;
@property (nonatomic, retain)       NSString                *hphmStr;
@property (nonatomic, retain)       NSString                *sbdhStr;

@end

@implementation CarBindViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (id)initWithRebindHphm:(NSString*)hphm{
    if (self = [super init]) {
        _reBindHphm = [[NSString alloc] initWithString:hphm];
    }
    return self;
}

#define INPUT_BGVIEW_HEIGHT    180
//初始化子视图
- (void)loadView_
{
    
    UILabel *l = [[UILabel alloc] initWithFrame:LGRectMake(30, APP_VIEW_Y/PX_X_SCALE + 20, 200, 30)];
    [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    l.text = @"车辆信息";
    [self.view addSubview:l];
    
    CGFloat singleLineHeightPX = 30*3;
    _mainBgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:l.b + 20 width:APP_PX_WIDTH height:singleLineHeightPX*3];
    [self.view addSubview:_mainBgView];
    
    
    
    //*********************************车牌号码*********************************
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"车牌号码";
    CGSize size = [l.text sizeWithFont:l.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [_mainBgView addSubview:label];
    
    _hphmPrefixLabel = [[UILabel alloc] initWithFrame:LGRectMake(label.r + 30, label.t, 0, 30)];
    [_hphmPrefixLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_LINK textAlignment:NSTextAlignmentLeft];
    _hphmPrefixLabel.text = @"琼";
    [_hphmPrefixLabel setSize:[_hphmPrefixLabel.text sizeWithFont:_hphmPrefixLabel.font constrainedToSize:CGSizeMake(1000, 30)]];
    [_mainBgView addSubview:_hphmPrefixLabel];
    UIImageView *rightArrowImgView = [[UIImageView alloc] initWithFrame:LGRectMake(_hphmPrefixLabel.r + 4, _hphmPrefixLabel.t + 7, 24, 24)];
    [rightArrowImgView setImage:[UIImage imageNamed:@"arrow_right"]];
    [rightArrowImgView setUserInteractionEnabled:YES];
    [_mainBgView addSubview:rightArrowImgView];
    UIButton *hphmPrefixButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hphmPrefixButton setBackgroundColor:[UIColor clearColor]];
    [hphmPrefixButton setFrame:LGRectMake(_hphmPrefixLabel.l, _hphmPrefixLabel.t, rightArrowImgView.r - _hphmPrefixLabel.l, _hphmPrefixLabel.h)];
    [hphmPrefixButton addTarget:self action:@selector(hphmPrefixButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_mainBgView addSubview:hphmPrefixButton];
    
    _hphmTF = [UITextField mainTextFieldWithFrame:LGRectMake(hphmPrefixButton.r + 15, hphmPrefixButton.t, _mainBgView.w - hphmPrefixButton.r - 15 - 30, 40) placeholder:@"输入车牌号码" tag:0 delegate:self];
    [_mainBgView addSubview:_hphmTF];
    //*********************************识别代号*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"识别代号";
    label.size = size;
    [_mainBgView addSubview:label];
    _sbdhTF = [UITextField mainTextFieldWithFrame:LGRectMake(label.r + 30, label.t, _mainBgView.w - label.r - 35 - 30 - 50, 40) placeholder:@"输入车辆识别代号" tag:0 delegate:self];
    [_mainBgView addSubview:_sbdhTF];
    UIButton *iButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [iButton setFrame:LGRectMake(_sbdhTF.r + 5, _sbdhTF.t, 40, 40)];
    [iButton setImage:[UIImage imageNamed:@"warn_logo"] forState:UIControlStateNormal];
    [iButton addTarget:self action:@selector(iButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_mainBgView addSubview:iButton];
    //*********************************车辆类型*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*2 + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"车辆类型";
    label.size = size;
    [_mainBgView addSubview:label];
    _carTypeL = [[UILabel alloc] initWithFrame:LGRectMake(label.r + 30, label.t, _mainBgView.w - label.r - 30 - 30 - 30, 30)];
    [_carTypeL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    [_carTypeL setText:@"小型汽车"];
    self.carTypeCode = @"02";
    [_mainBgView addSubview:_carTypeL];
    rightArrowImgView = [[UIImageView alloc] initWithFrame:LGRectMake(_mainBgView.w - 30 - 30, label.t + 7, 24, 24)];
    [rightArrowImgView setImage:[UIImage imageNamed:@"arrow_right"]];
    [rightArrowImgView setUserInteractionEnabled:YES];
    [_mainBgView addSubview:rightArrowImgView];
    UIButton *carTypeB = [UIButton buttonWithType:UIButtonTypeCustom];
    [carTypeB setBackgroundColor:[UIColor clearColor]];
    [carTypeB setFrame:LGRectMake(_carTypeL.l, _carTypeL.t, rightArrowImgView.r - _carTypeL.l, _carTypeL.h)];
    [carTypeB addTarget:self action:@selector(carTypeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_mainBgView addSubview:carTypeB];
    //*********************************横线*********************************
    UILabel *lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_mainBgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 2 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_mainBgView addSubview:lineLabel];
    
    
    _submitBgView = [[UIView alloc] initWithFrame:LGRectMake(0, _mainBgView.b + 30, APP_PX_WIDTH, 90 + 30 + 60)];
    _submitBgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_submitBgView];
    UIButton *submitB = [UIButton mainButtonWithPXY:0 title:@"完 成" target:self action:@selector(submitButtonClicked:)];
    [_submitBgView addSubview:submitB];
    UIImageView *baomiImgView = [[UIImageView alloc] initWithFrame:LGRectMake(30, submitB.b + 30, 45 , 52)];
    [baomiImgView setImage:[UIImage imageNamed:@"home_secret"]];
    [_submitBgView addSubview:baomiImgView];
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:LGRectMake(baomiImgView.r + 20, baomiImgView.t, APP_PX_WIDTH - baomiImgView.r - 20 - 30, 60)];
    [noticeLabel convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    noticeLabel.numberOfLines = 0;
    noticeLabel.text = @"以上信息仅用于本次违法查询和缴款，开车邦将严格保密，请您放心填写！";
    [_submitBgView addSubview:noticeLabel];
    
    //*********************************车主信息*********************************
    _chezhuMsgBgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:(_mainBgView.b + 30) width:APP_PX_WIDTH height:singleLineHeightPX*2];
    _chezhuMsgBgView.hidden = YES;
    [self.view addSubview:_chezhuMsgBgView];
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"车主姓名";
    label.size = size;
    [_chezhuMsgBgView addSubview:label];
    _chezhuNameTF = [UITextField mainTextFieldWithFrame:LGRectMake(label.r + 30, label.t, _chezhuMsgBgView.w - label.r - 35 - 30 - 50, 40) placeholder:@"输入车主姓名" tag:0 delegate:self];
    [_chezhuMsgBgView addSubview:_chezhuNameTF];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_chezhuMsgBgView addSubview:lineLabel];
    label = [[UILabel alloc] initWithFrame:LGRectMake(30,  singleLineHeightPX + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"证件号码";
    label.size = size;
    [_chezhuMsgBgView addSubview:label];
    _chezhuZhengjianTF = [UITextField mainTextFieldWithFrame:LGRectMake(label.r + 30, label.t, _chezhuMsgBgView.w - label.r - 35 - 30 - 50, 40) placeholder:@"输入车主证件号码" tag:0 delegate:self];
    [_chezhuMsgBgView addSubview:_chezhuZhengjianTF];
    
    if (self.reBindHphm) {
        NSArray *arr = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId andHphm:self.reBindHphm];
        CarInfo *car = [arr lastObject];
        //车辆类型
        _carTypeL.text = [_hpzlDict objectForKey:car.hpzl];
        self.carTypeCode = car.hpzl;
        ;
        //车牌号码
        _hphmPrefixLabel.text = [car.hphm substringToIndex:1];
        if ([_hphmPrefixLabel.text isEqualToString:@"渝"]) {
            [self hiddenChezhuView:NO];
        }
        _hphmTF.text = [car.hphm substringFromIndex:1];
        //识别码
        _sbdhTF.text = car.clsbdh;
        
        hphmPrefixButton.userInteractionEnabled = NO;
        _hphmTF.userInteractionEnabled = NO;
    }
    
    //*********************************弹出框背景等*********************************
    _bgDarkView = [[UIView alloc] initWithFrame:self.view.bounds]
    ;
    _bgDarkView.backgroundColor = [UIHelper getColor:@"#000000"];
    _bgDarkView.alpha = 0.4;
    _bgDarkView.hidden = YES;
    [self.view addSubview:_bgDarkView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfviewTaped)];
    [_bgDarkView addGestureRecognizer:tap];
    
    _quesNoticeview = [[QuestionNoticeView alloc] initWithFrame:CGRectMake(30, self.view.height, APP_WIDTH - 30*2, 200) image:[UIImage imageNamed:@"xsz.png"] andTitle:@"怎样查找识别代码?"];
    [self.view addSubview:_quesNoticeview];
    
}

- (void)keyboardDidShow:(NSNotification*)notify{
    //    NSDictionary *infoDict = [notify userInfo];
    //    CGRect frame = [[infoDict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //
    //    CGFloat bottonY = _mainBgView.bottom;
    //    if (!_chezhuMsgBgView.hidden) {
    //        bottonY = _chezhuMsgBgView.bottom;
    //    }
    //    CGFloat keyBoardStartY = self.view.frame.size.height - frame.size.height;
    //    if (keyBoardStartY < bottonY) {
    //        [self.view setFrame:CGRectMake(self.view.left, self.view.top - (bottonY - keyBoardStartY), self.view.width, self.view.height)];
    //    }
}
- (void)keyboardWillHide:(NSNotification*)notify{
    [self.view setFrame:CGRectMake(self.view.left, 0, self.view.width, self.view.height)];
    
    
}
- (void)keyboardWillChangeFrame:(NSNotification*)notify{
    NSDictionary *infoDict = [notify userInfo];
    CGRect frame = [[infoDict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat bottomY = 0;
    CGFloat space = 30*PX_X_SCALE;
    if ([_sbdhTF isFirstResponder]) {
        bottomY = _sbdhTF.bottom + _mainBgView.top + space;
    }else if ([_hphmTF isFirstResponder]) {
        bottomY = _hphmTF.bottom + _mainBgView.top + space;
    }else if ([_chezhuNameTF isFirstResponder]) {
        bottomY = _chezhuNameTF.bottom + _chezhuMsgBgView.top + space;
    }else if ([_chezhuZhengjianTF isFirstResponder]) {
        bottomY = _chezhuZhengjianTF.bottom + _chezhuMsgBgView.top + space;
    }
    
    CGFloat keyBoardStartY = self.view.frame.size.height - self.view.frame.origin.y - frame.size.height;
    if (keyBoardStartY < bottomY) {
        [self.view setFrame:CGRectMake(self.view.left, self.view.top - (bottomY - keyBoardStartY), self.view.width, self.view.height)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    //初始化数据
    _hpzlDict = @{@"01":@"大型汽车",@"02":@"小型汽车",@"03":@"使馆汽车",@"04":@"领馆汽车",@"05":@"境外汽车",@"06":@"外籍汽车",@"07":@"两、三轮摩托车",@"08":@"轻便摩托车",@"09":@"使馆摩托车",@"10":@"领馆摩托车",@"11":@"境外摩托车",@"12":@"外籍摩托车",@"13":@"农用运输车",@"14":@"拖拉机",@"15":@"挂车",@"16":@"教练汽车",@"17":@"教练摩托车",@"18":@"试验汽车",@"19":@"试验摩托车",@"20":@"临时入境汽车",@"21":@"临时入境摩托车",@"22":@"临时行驶车",@"23":@"警用汽车",@"24":@"警用摩托",@"25":@"非机动车"};
    //初始化子视图
    [self loadView_];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"车辆绑定"];
    
    
    if ([_hphmPrefixLabel.text isEqualToString:@"渝"]) {
        DriverInfo *driver = [[[DataBase sharedDataBase] selectDriverByUserId:APP_DELEGATE.userId] lastObject];
        NSRange range = [driver.driverstatus rangeOfString:@"成功"];
        if (!driver || range.location == NSNotFound) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"重庆车辆绑定时，请先正确绑定驾驶证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去绑定", nil];
            alert.tag = TAG_ALERT_GO_TO_DRIVER_BIND;
            [alert show];
        }
        [self  hiddenChezhuView:NO];
    }else{
        [self  hiddenChezhuView:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}




#pragma mark - button clicked!!
- (void)hphmPrefixButtonClicked:(UIButton*)button{
    [_hphmTF resignFirstResponder];
    [_sbdhTF resignFirstResponder];
    
    SelectCarHphmPreViewController *schpvc = [[SelectCarHphmPreViewController alloc] init];
    schpvc.delegate_ = self;
    [self.navigationController pushViewController:schpvc animated:YES];
}

- (void)iButtonClicked:(UIButton*)button{
    if (_quesNoticeview.frame.origin.y > self.view.height/2) {
        [UIView animateWithDuration:0.3 animations:^{
            _bgDarkView.hidden = NO;
            
            [_quesNoticeview setFrame:CGRectMake(30, self.view.height/4, _quesNoticeview.width, _quesNoticeview.height)];
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            _bgDarkView.hidden = YES;
            
            [_quesNoticeview setFrame:CGRectMake(30, self.view.height, _quesNoticeview.width, _quesNoticeview.height)];
            
        }];
    }
    
}

- (void)selfviewTaped{
    if (_quesNoticeview.frame.origin.y > self.view.height/2) {
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            _bgDarkView.hidden = YES;
            [_quesNoticeview setFrame:CGRectMake(30, self.view.height, _quesNoticeview.width, _quesNoticeview.height)];
            
        }];
    }
}

- (void)carTypeButtonClicked:(UIButton*)button{
    [_hphmTF resignFirstResponder];
    [_sbdhTF resignFirstResponder];
    
    SelectCarTypeViewController *sctvc = [[SelectCarTypeViewController alloc] init];
    sctvc.delegate_ = self;
    [self.navigationController pushViewController:sctvc animated:YES];
}

- (void)submitButtonClicked:(UIButton*)button{
    [_hphmTF resignFirstResponder];
    [_sbdhTF resignFirstResponder];
    
    if (![self keepAndRuleText]) {
        return;
    }else{
        [self netSubmitToBandcar];
        //        if (self.reBindHphm) {
        //            //无论绑定是否成功，结果都是替换数据库中的车辆数据
        //        }
        //        else{
        //            //
        //        }
    }
}


- (void)hiddenChezhuView:(BOOL)hidden{
    
    if (_chezhuMsgBgView.hidden == hidden) {
        return;
    }
    _chezhuMsgBgView.hidden = hidden;
    if (hidden) {
        [_submitBgView setFrame:LGRectMake(_submitBgView.l, _submitBgView.t - (90*2 + 30), _submitBgView.w, _submitBgView.h)];
    }else{
        
        [_submitBgView setFrame:LGRectMake(_submitBgView.l, _submitBgView.t + 90*2 + 30, _submitBgView.w, _submitBgView.h)];
    }
}



#pragma mark- 选择车辆类型-回调
- (void)selectCarTypeViewController:(SelectCarTypeViewController *)vc selectCarType:(NSString *)carType andCarTypeCode:(NSString *)code{
    _carTypeL.text = carType;
    self.carTypeCode = code;
}

#pragma mark- 选择车牌前缀-回调
- (void)selectCarHphmPreViewController:(SelectCarHphmPreViewController *)vc selectHphmPre:(NSString *)hphmPre{
    _hphmPrefixLabel.text = hphmPre;
    
    //    if ([_hphmPrefixLabel.text isEqualToString:@"渝"]) {
    //        DriverInfo *driver = [[[DataBase sharedDataBase] selectDriverByUserId:APP_DELEGATE.userId] lastObject];
    //        NSRange range = [driver.driverstatus rangeOfString:@"成功"];
    //        if (!driver || range.location == NSNotFound) {
    //
    //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"重庆车辆绑定时，请先正确绑定驾驶证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去绑定", nil];
    //            alert.tag = TAG_ALERT_GO_TO_DRIVER_BIND;
    //            [alert show];
    //        }
    //        [self  hiddenChezhuView:NO];
    //    }else{
    //        [self  hiddenChezhuView:YES];
    //    }
}


#pragma mark-  alertview delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == TAG_ALERT_GO_TO_DRIVER_BIND) {
        if (buttonIndex == alertView.cancelButtonIndex) {
            SelectCarHphmPreViewController *schpvc = [[SelectCarHphmPreViewController alloc] init];
            schpvc.delegate_ = self;
            [self.navigationController pushViewController:schpvc animated:YES];
        }else{
            DriverInfo *driver = [[[DataBase sharedDataBase] selectDriverByUserId:APP_DELEGATE.userId] lastObject];
            if (driver) {//reBindDriver
                DriverBindViewController *vc = [[DriverBindViewController alloc] init];
                vc.reBindDriver = driver;
                [self.navigationController  pushViewController:vc animated:YES];
            }else{
                DriverBindViewController *vc = [[DriverBindViewController alloc] init];
                [self.navigationController  pushViewController:vc animated:YES];
            }
        }
    }else{
        
        CarInfoViewController *carInfoVC = [[CarInfoViewController alloc] initWithHphm:[_hphmPrefixLabel.text stringByAppendingString:_hphmTF.text]];
        [self.navigationController pushViewController:carInfoVC animated:YES];
    }
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 提交前校验

- (BOOL)threeCharInString:(NSString*)str{
    int count = 0;
    for (int i = 0; i < [str length]; i++) {
        NSString *subStr = [str substringWithRange:NSMakeRange(i, 1)];
        const char *c = [subStr UTF8String];
        if ((*c >= 'a' && *c <= 'z') || (*c >= 'A' && *c <= 'Z')) {
            count ++ ;
        }
    }
    if (count >= 3) {
        return YES;
    }
    return NO;
}


- (BOOL)keepAndRuleText{
    if ([_hphmPrefixLabel.text isEqualToString:@"渝"]) {
        
        DriverInfo *driver = [[[DataBase sharedDataBase] selectDriverByUserId:APP_DELEGATE.userId] lastObject];
        if (!driver || [driver.driverstatus rangeOfString:@"成功"].location == NSNotFound) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"重庆车辆绑定时，请先正确绑定驾驶证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去绑定", nil];
            alert.tag = TAG_ALERT_GO_TO_DRIVER_BIND;
            [alert show];
            return NO;
        }
        
        if (!_chezhuZhengjianTF.text) {
            _chezhuZhengjianTF.text = @"";
        }
        if (!_chezhuNameTF.text) {
            _chezhuNameTF.text = @"";
        }
        
        if(![driver.xm isEqualToString:_chezhuNameTF.text] || ![driver.driversfzmhm isEqualToString:_chezhuZhengjianTF.text]){
            [UIAlertView alertTitle:@"信息提示" msg:@"车主信息与驾驶员信息不一致"];
            return NO;
        }
        
        
    }
    if (!_hphmTF.text) {
        _hphmTF.text = @"";
    }
    self.hphmStr = [[_hphmPrefixLabel.text stringByAppendingString:_hphmTF.text] uppercaseString];
    self.sbdhStr = _sbdhTF.text;
    
    if (!_carTypeL.text || [_carTypeL.text isEqualToString:@""]) {
        
        [UIAlertView alertTitle:@"信息提示" msg:@"车辆类型不能为空"];
        return  NO;
        
    }else if (!self.hphmStr || [self.hphmStr isEqualToString:@""]){
        [UIAlertView alertTitle:@"信息提示" msg:@"车辆号码不能为空"];
        return  NO;
        
    }else if (!self.sbdhStr || [self.sbdhStr isEqualToString:@""]){
        [UIAlertView alertTitle:@"信息提示" msg:@"车辆识别码不能为空"];
        return  NO;
        
    }else if (self.sbdhStr.length < 17){
        [UIAlertView alertTitle:@"信息提示" msg:@"车辆识别码应不小于17位"];
        return  NO;
        //原为琼的车辆，车辆识别码不小于6位。现改为不小于17位。
    }else if (![self threeCharInString:[self.sbdhStr substringToIndex:8]]) {
        [UIAlertView alertTitle:@"信息提示" msg:@"车辆识别码格式错误！前8位至少包含3个字母。"];
        return  NO;
        //原为琼的车辆，车辆识别码前8位必须包含至少3个字母。现改为所有车辆都做此验证。
        
    }else if (_hphmTF.text.length != 6){
        [UIAlertView alertTitle:@"信息提示" msg:@"请输入正确的车牌号码"];
        return  NO;
        
    }
    return  YES;
}



#pragma mark-  网络请求
- (void)netSubmitToBandcar
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:self.carTypeCode forKey:@"hpzl"];
    [dict setObject:self.hphmStr forKey:@"hphm"];
    [dict setObject:self.sbdhStr forKey:@"clsbdh"];
    [dict setObject:APP_DELEGATE.userName forKey:@"username"];
    if ([_hphmPrefixLabel.text isEqualToString:@"渝"]) {
        [dict setObject:_chezhuZhengjianTF.text forKey:@"sfzmhm"];
        [dict setObject:_chezhuNameTF.text forKey:@"syr"];
    }
    
    
    CarInfo *rebindCarOldInfo = nil;;
    if (self.reBindHphm) {
        [dict setObject:@"updatecar" forKey:@"action"];
        NSArray *rebindCars = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId andHphm:_reBindHphm];
        rebindCarOldInfo = [rebindCars lastObject];
    }else{
        [dict setObject:@"addcar" forKey:@"action"];
        
    }
    
    
    
    
    
    
    
    
    [[Network sharedNetwork] postBody:dict isResponseJson:NO doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            //更新数据库
            //clpp1,yxqz,bxzzrq,ccdjrq：成功
            NSString *reqStr = (NSString*)requestObj;
            NSArray *arr = [reqStr componentsSeparatedByString:@","];
            NSString *clpp1 = @"";
            NSString *yxqz = @"";
            NSString *bxzzrq = @"";
            NSString *ccdjrq = @"";
            NSString *createTime = @"";
            
            NSString *zt = @"";
            NSString *sfzmhm = @"";
            NSString *syr = @"";
            NSString *fdjh = @"";
            
            if ([arr count] == 8) {
                clpp1 = [arr objectAtIndex:0];
                yxqz = [arr objectAtIndex:1];
                bxzzrq = [arr objectAtIndex:2];
                ccdjrq = [arr objectAtIndex:3];
                
                zt = [arr objectAtIndex:4];
                sfzmhm = [arr objectAtIndex:5];
                syr = [arr objectAtIndex:6];
                fdjh = [arr objectAtIndex:7];
            }
            CarInfo *car = [[CarInfo alloc] initWithHpzl:self.carTypeCode
                                                hpzlname:_carTypeL.text
                                                    hphm:self.hphmStr
                                                  clsbdh:self.sbdhStr
                                                   clpp1:clpp1
                                         vehicletypename:@""
                                              vehiclepic:@""
                                           vehiclestatus:@"验证成功"
                                                    yxqz:yxqz
                                                  bxzzrq:bxzzrq
                                                  ccdjrq:ccdjrq
                                             vehiclegxsj:[[NSDate date] string]
                                                isupdate:@""
                                              createTime:@""
                                                      zt:zt
                                                  sfzmhm:sfzmhm
                                                     syr:syr
                                                    fdjh:fdjh
                                                andUseId:APP_DELEGATE.userId];
            if (self.reBindHphm) {
                [rebindCarOldInfo unbind];
                //[[DataBase sharedDataBase] deleteCarInfoByVehiclegxsj:rebindCarOldInfo.vehiclegxsj];
                
            }
            [car add];
            //[[DataBase sharedDataBase] insertCarInfo:car];
            
            ENTLog(@"DB车辆数量%d", (int)[[[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId] count]);
            //提示成功
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"绑定车辆成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            alert.tag = TAG_ALERT_BIND_SUCC;
            [alert show];
            
            
            
        } else {
            NSString *vehiclestatus = @"";
            
            NSRange range = [(NSString*)requestObj rangeOfString:@"服务器异常返回"];
            if (range.location != NSNotFound) {
                //服务器异常返回
                vehiclestatus = [(NSString*)requestObj substringFromIndex:8];
            }else{
                //绑定失败，返回正常1
                vehiclestatus = (NSString*)requestObj;
            }
            
            //更新数据库
            CarInfo *car = [[CarInfo alloc] initWithHpzl:self.carTypeCode
                                                hpzlname:_carTypeL.text
                                                    hphm:self.hphmStr
                                                  clsbdh:self.sbdhStr
                                                   clpp1:@""
                                         vehicletypename:@""
                                              vehiclepic:@""
                                           vehiclestatus:vehiclestatus
                                                    yxqz:@""
                                                  bxzzrq:@""
                                                  ccdjrq:@""
                                             vehiclegxsj:[[NSDate date] string]
                                                isupdate:@""
                                              createTime:@""
                                                      zt:@""
                                                  sfzmhm:@""
                                                     syr:@""
                                                    fdjh:@""
                                                andUseId:APP_DELEGATE.userId];
            
            if (self.reBindHphm) {
                [rebindCarOldInfo unbind];
                //[[DataBase sharedDataBase] deleteCarInfoByVehiclegxsj:rebindCarOldInfo.vehiclegxsj];
                [car add];
                //[[DataBase sharedDataBase] insertCarInfo:car];
                ENTLog(@"DB车辆数量%d", (int)[[[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId] count]);
                
            }else{
                if([(NSString*)requestObj rangeOfString:@"已绑定两辆车"].location == NSNotFound){
                    [car add];
                    //[[DataBase sharedDataBase] insertCarInfo:car];
                    ENTLog(@"DB车辆数量%d",  (int)[[[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId] count]);
                    
                }
                
            }
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:[NSString stringWithFormat:@"绑定车辆失败:%@",(NSString*)requestObj] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            alert.tag = TAG_ALERT_BIND_FAILED;
            [alert show];
        }
    } onError:^(NSString *errorStr) {
        [UIAlertView alertTitle:@"提示信息" msg:errorStr];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
