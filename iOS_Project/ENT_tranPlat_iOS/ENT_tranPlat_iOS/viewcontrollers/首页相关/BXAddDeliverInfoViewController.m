//
//  BXAddDeliverInfoViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/23.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BXAddDeliverInfoViewController.h"
#import "BXProvinceListViewController.h"

@interface BXAddDeliverInfoViewController ()<
UITextFieldDelegate
>
{
    UITextField         *_nameTF;
    UITextField         *_telTF;
    //UITextField         *_sfzhmTF;
    UILabel         *_cityL;
    UILabel         *_provinceL;
    UILabel         *_regionL;
    
    UIImageView         *_detailAddrBgImgView;
    UITextField         *_detailAddrTF;
    //UIImageView         *_beibaorenAddrBgImgView;
    //UITextField         *_beibaorenAddrTF;

    UIScrollView        *_rootScrollView;

}


@property (nonatomic)       NSMutableDictionary     *pDict;
@property (nonatomic)       NSMutableDictionary     *cDict;
@property (nonatomic)       NSMutableDictionary     *rDict;
@property (nonatomic)       NSString                *detailAddr;
@end

@implementation BXAddDeliverInfoViewController

- (void)loadView_{
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    _rootScrollView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_rootScrollView];
    
    
    CGFloat singleLineHeightPX = 30*3;
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y: 30 width:APP_PX_WIDTH height:singleLineHeightPX*2];
    [_rootScrollView addSubview:bgImgView];
    
    
    //*********************************横线*********************************
    UILabel *lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [bgImgView addSubview:lineLabel];
    //*********************************姓名*********************************
    _nameTF = [[UITextField alloc] initWithFrame:LGRectMake(30, 30, bgImgView.w - 30*2, 40)];
    _nameTF.delegate = self;
    [_nameTF setFont:FONT_NOMAL];
    [_nameTF setBorderStyle:UITextBorderStyleNone];
    [_nameTF setPlaceholder:@"姓名"];
    [bgImgView addSubview:_nameTF];
//    //*********************************身份证号码*********************************
//    _sfzhmTF = [[UITextField alloc] initWithFrame:LGRectMake(30, singleLineHeightPX + 30, bgImgView.w - 30*2, 40)];
//    _sfzhmTF.delegate = self;
//    [_sfzhmTF setFont:FONT_NOMAL];
//    [_sfzhmTF setBorderStyle:UITextBorderStyleNone];
//    [_sfzhmTF setPlaceholder:@"身份证号码"];
//    [bgImgView addSubview:_sfzhmTF];
    //*********************************电话号码*********************************
    
    _telTF = [[UITextField alloc] initWithFrame:LGRectMake(30, singleLineHeightPX + 30, bgImgView.w - 30*2, 40)];
    _telTF.delegate = self;
    [_telTF setFont:FONT_NOMAL];
    [_telTF setBorderStyle:UITextBorderStyleNone];
    [_telTF setPlaceholder:@"电话号码"];
    [_telTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_telTF limitCHTextLength:11];
    [bgImgView addSubview:_telTF];
    //*********************************地址*********************************

    bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgImgView.b + 30 width:APP_PX_WIDTH height:singleLineHeightPX];
    [_rootScrollView addSubview:bgImgView];
    _provinceL = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 400, 30)];
    [_provinceL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_provinceL setText:@"选择省"];
    [bgImgView addSubview:_provinceL];
    UIImageView *arrowImgV = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 60, (singleLineHeightPX - 30)/2, 30, 30)];
    [arrowImgV setImage:[UIImage imageNamed:@"arrow_right"]];
    [arrowImgV setUserInteractionEnabled:YES];
    [bgImgView addSubview:arrowImgV];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToSelectProvince)];
    [bgImgView addGestureRecognizer:tap];
    
    bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgImgView.b + 30 width:APP_PX_WIDTH height:singleLineHeightPX];
    [_rootScrollView addSubview:bgImgView];
    _cityL = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 400, 30)];
    [_cityL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_cityL setText:@"选择市"];
    [bgImgView addSubview:_cityL];
    arrowImgV = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 60, (singleLineHeightPX - 30)/2, 30, 30)];
    [arrowImgV setImage:[UIImage imageNamed:@"arrow_right"]];
    [arrowImgV setUserInteractionEnabled:YES];
    [bgImgView addSubview:arrowImgV];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToSelectCity)];
    [bgImgView addGestureRecognizer:tap];
    
    bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgImgView.b + 30 width:APP_PX_WIDTH height:singleLineHeightPX];
    [_rootScrollView addSubview:bgImgView];
    _regionL = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 400, 30)];
    [_regionL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_regionL setText:@"选择区"];
    [bgImgView addSubview:_regionL];
    arrowImgV = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 60, (singleLineHeightPX - 30)/2, 30, 30)];
    [arrowImgV setImage:[UIImage imageNamed:@"arrow_right"]];
    [arrowImgV setUserInteractionEnabled:YES];
    [bgImgView addSubview:arrowImgV];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToSelectRegion)];
    [bgImgView addGestureRecognizer:tap];
    
    _detailAddrBgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgImgView.b + 30 width:APP_PX_WIDTH height:singleLineHeightPX];
    [_rootScrollView addSubview:_detailAddrBgImgView];
    _detailAddrTF = [[UITextField alloc] initWithFrame:LGRectMake(30, 30, bgImgView.w - 30*2, 40)];
    _detailAddrTF.delegate = self;
    [_detailAddrTF setFont:FONT_NOMAL];
    [_detailAddrTF setBorderStyle:UITextBorderStyleNone];
    [_detailAddrTF setKeyboardType:UIKeyboardTypeNamePhonePad];
    [_detailAddrBgImgView addSubview:_detailAddrTF];
    
    [_rootScrollView setContentSize:CGSizeMake(_rootScrollView.width, _detailAddrBgImgView.bottom + 15)];
}

- (void)gobackPage{
    
    NSString *name = _nameTF.text;
    NSString *tel = _telTF.text;
    //NSString *sfzhm = _sfzhmTF.text;
    NSString *detailAddr = _detailAddrTF.text;
    if (name) {
        [self.infoDict setObject:name forKey:KEY_INS_INFO_NAME];
    }
    if (tel) {
        [self.infoDict setObject:tel forKey:KEY_INS_INFO_TEL];
    }
//    if (sfzhm) {
//        [self.infoDict setObject:sfzhm forKey:KEY_INS_INFO_SFZHM];
//    }
    if (detailAddr) {
        [self.infoDict setObject:detailAddr forKey:KEY_INS_INFO_DETAIL_ADDR];
    }
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)keyboardWillChangeFrame:(NSNotification*)notify{
    NSDictionary *infoDict = [notify userInfo];
    CGRect frame = [[infoDict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat bottomY = 0;
    CGFloat space = 30*PX_X_SCALE;
    if ([_detailAddrTF isFirstResponder]) {
        bottomY = _detailAddrTF.bottom + _detailAddrBgImgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
    }
    
    
    
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

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self loadView_];
    
    [_telTF setText:[self.infoDict objectForKey:KEY_INS_INFO_TEL]];
    [_nameTF setText:[self.infoDict objectForKey:KEY_INS_INFO_NAME]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"收件人信息"];
    
    self.pDict = [self.infoDict objectForKey:KEY_INS_INFO_PROVINCE_DICT];
    if (self.pDict) {
        NSString *p = [[self.pDict allKeys] lastObject];
        NSString *pcode = [[self.pDict allValues] lastObject];
        if (p && pcode) {
            [_provinceL setText:p];
        }
    }else{
        [_provinceL setText:@"选择省"];
        self.pDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    
    self.cDict = [self.infoDict objectForKey:KEY_INS_INFO_CITY_DICT];
    if (self.cDict) {
        NSString *c = [[self.cDict allKeys] lastObject];
        if (c) {
            [_cityL setText:c];
        }
    }else{
        [_cityL setText:@"选择市"];
        self.cDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    self.rDict = [self.infoDict objectForKey:KEY_INS_INFO_REGION_DICT];
    if (self.rDict) {
        NSString *r = [[self.rDict allKeys] lastObject];
        if (r) {
            [_regionL setText:r];
        }
    }else{
        [_regionL setText:@"选择区"];
        self.rDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    self.detailAddr = [self.infoDict objectForKey:KEY_INS_INFO_DETAIL_ADDR];
    if (self.detailAddr) {
        [_detailAddrTF setText:self.detailAddr];
    }else{
        [_detailAddrTF setPlaceholder:@"街道/小区/详细地址"];
    }
    
}


- (void)tapToSelectProvince{
    [self netGetAddrListWithCode:@"0" andType:ADDR_TYPE_PROVINCE];
}

- (void)tapToSelectCity{
    NSString *code = [self codeWithAddrType:ADDR_TYPE_PROVINCE];
    if (code) {
        [self netGetAddrListWithCode:code andType:ADDR_TYPE_CITY];

    }else{
        [self.view showAlertText:@"请先选择省"];
    }
}

- (void)tapToSelectRegion{
    NSString *code = [self codeWithAddrType:ADDR_TYPE_CITY];
    if (code) {
        [self netGetAddrListWithCode:code andType:ADDR_TYPE_REGION];
        
    }else{
        [self.view showAlertText:@"请先选择市"];
    }

}



- (NSString*)codeWithAddrType:(NSString*)type{
    NSDictionary *dict = nil;
    if ([type isEqualToString:ADDR_TYPE_PROVINCE]) {
        dict = [self.infoDict objectForKey:KEY_INS_INFO_PROVINCE_DICT];
    }else if ([type isEqualToString:ADDR_TYPE_CITY]){
        dict = [self.infoDict objectForKey:KEY_INS_INFO_CITY_DICT];

    }else if ([type isEqualToString:ADDR_TYPE_REGION]){
        dict = [self.infoDict objectForKey:KEY_INS_INFO_REGION_DICT];

    }

    return [[dict allValues] lastObject];
}





- (void)netGetAddrListWithCode:(NSString*)code andType:(NSString*)type{
    
    //chexian.sinosig.com/Net/nCityInfoAction!getRegionListByParentCodeForInterface.action?province=0&encoding=GBK&callback=jsonp1045
    
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [bodyDict setObject:code forKey:@"province"];
    [bodyDict setObject:@"GBK" forKey:@"encoding"];
    
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:@"chexian.sinosig.com"];
    MKNetworkOperation *op = [en operationWithPath:@"Net/nCityInfoAction!getRegionListByParentCodeForInterface.action" params:bodyDict httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        ENTLog(@"getRegionListByParentCodeForInterface.action==>%@", completedOperation.responseString);
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *resStr = [[NSString alloc] initWithData:completedOperation.responseData encoding:enc];
        resStr = [resStr substringFromIndex:5];
        resStr = [resStr substringToIndex:resStr.length - 1];
        NSArray *resArr = [parser objectWithString:resStr];
        if (resArr) {
            BXProvinceListViewController *vc = [[BXProvinceListViewController alloc] init];
            vc.infoDict = self.infoDict;
            vc.type = type;
            vc.listDataArr = resArr;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [UIAlertView alertTitle:nil msg:@"获取区域列表失败"];
    }];
    
    [en enqueueOperation:op];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
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
