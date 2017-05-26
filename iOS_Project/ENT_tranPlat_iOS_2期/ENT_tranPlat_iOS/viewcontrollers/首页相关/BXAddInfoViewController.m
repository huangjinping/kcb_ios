//
//  BXAddAddrViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/21.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BXAddInfoViewController.h"

@interface BXAddInfoViewController ()<
UITextFieldDelegate
>
{
    UITextField     *_nameTF;
    UITextField     *_sfzhmTF;
    UITextField     *_emailTF;
    UITextField     *_telTF;
    
    
    UIScrollView        *_rootScrollView;
    UIImageView         *_bgImgView;
}
@end
#define TAG_TF_NAME     100
#define TAG_TF_SFZHM    101
#define TAG_TF_EMAIL    102
#define TAG_TF_TEL      103
@implementation BXAddInfoViewController


- (void)loadView_{
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    _rootScrollView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_rootScrollView];
    
    
    CGFloat singleLineHeightPX = 30*3;
    _bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y: 30 width:APP_PX_WIDTH height:singleLineHeightPX*4];
    [_rootScrollView addSubview:_bgImgView];
    
    
    //*********************************横线*********************************
    UILabel *lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_bgImgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 2 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_bgImgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 3 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_bgImgView addSubview:lineLabel];
    //*********************************姓名*********************************
    
    _nameTF = [[UITextField alloc] initWithFrame:LGRectMake(30, 30, _bgImgView.w - 30*2, 40)];
    _nameTF.delegate = self;
    _nameTF.tag = TAG_TF_NAME;
    [_nameTF setFont:FONT_NOMAL];
    [_nameTF setBorderStyle:UITextBorderStyleNone];
    [_nameTF setPlaceholder:@"姓名"];
    [_bgImgView addSubview:_nameTF];
    //*********************************身份证号码*********************************
    _sfzhmTF = [[UITextField alloc] initWithFrame:LGRectMake(30, singleLineHeightPX + 30, _bgImgView.w - 30*2, 40)];
    _sfzhmTF.delegate = self;
    _sfzhmTF.tag = TAG_TF_SFZHM;
    [_sfzhmTF setFont:FONT_NOMAL];
    [_sfzhmTF setBorderStyle:UITextBorderStyleNone];
    [_sfzhmTF setPlaceholder:@"身份证号码"];
    [_sfzhmTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_sfzhmTF limitCHTextLength:18];
    [_bgImgView addSubview:_sfzhmTF];
    //*********************************电话号码*********************************
    
    _telTF = [[UITextField alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*2 + 30, _bgImgView.w - 30*2, 40)];
    _telTF.delegate = self;
    _telTF.tag = TAG_TF_TEL;
    [_telTF setFont:FONT_NOMAL];
    [_telTF setBorderStyle:UITextBorderStyleNone];
    [_telTF setPlaceholder:@"电话号码"];
    [_telTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_telTF limitCHTextLength:11];
    [_bgImgView addSubview:_telTF];
    //*********************************邮箱*********************************
    
    _emailTF = [[UITextField alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*3 + 30, _bgImgView.w - 30*2, 40)];
    _emailTF.delegate = self;
    _emailTF.tag = TAG_TF_EMAIL;
    [_emailTF setFont:FONT_NOMAL];
    [_emailTF setBorderStyle:UITextBorderStyleNone];
    [_emailTF setPlaceholder:@"邮箱"];
    [_emailTF setKeyboardType:UIKeyboardTypeEmailAddress];
    [_bgImgView addSubview:_emailTF];
    
    
    [_rootScrollView setContentSize:CGSizeMake(_rootScrollView.width, _bgImgView.bottom + 15)];
}

- (void)gobackPage{
    NSString *email = @"";
    if (_emailTF.text) {
        email = _emailTF.text;
    }
    NSString *name = @"";
    if (_nameTF.text) {
        name = _nameTF.text;
    }
    NSString *sfzhm = @"";
    if (_sfzhmTF.text) {
        sfzhm = _sfzhmTF.text;
    }
    NSString *tel = @"";
    if (_telTF.text) {
        tel = _telTF.text;
    }
    
    [self.infoDict setObject:email forKey:KEY_INS_INFO_EMAIL];
    [self.infoDict setObject:name forKey:KEY_INS_INFO_NAME];
    [self.infoDict setObject:sfzhm forKey:KEY_INS_INFO_SFZHM];
    [self.infoDict setObject:tel forKey:KEY_INS_INFO_TEL];

    [self.navigationController popViewControllerAnimated:YES];
}


- (void)keyboardWillChangeFrame:(NSNotification*)notify{
    NSDictionary *infoDict = [notify userInfo];
    CGRect frame = [[infoDict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat bottomY = 0;
    CGFloat space = 30*PX_X_SCALE;
    if ([_emailTF isFirstResponder]) {
        bottomY = _emailTF.bottom + _bgImgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
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

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self loadView_];
    
    if ([self.identification isEqualToString:IDENTIFICATION_ADD_INS_INFO_CHEZHU]) {
        _sfzhmTF.userInteractionEnabled = NO;
        _nameTF.userInteractionEnabled = NO;
        [_sfzhmTF setTextColor:COLOR_FONT_INFO_SHOW];
        [_nameTF setTextColor:COLOR_FONT_INFO_SHOW];
    }

    [_sfzhmTF setText:[self.infoDict objectForKey:KEY_INS_INFO_SFZHM]];
    [_telTF setText:[self.infoDict objectForKey:KEY_INS_INFO_TEL]];
    [_nameTF setText:[self.infoDict objectForKey:KEY_INS_INFO_NAME]];
    [_emailTF setText:[self.infoDict objectForKeyedSubscript:KEY_INS_INFO_EMAIL]];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    if ([self.identification isEqualToString:IDENTIFICATION_ADD_INS_INFO_BEIBAOREN]) {
         [self setCustomNavigationTitle:@"被保人信息"];
    }else if ([self.identification isEqualToString:IDENTIFICATION_ADD_INS_INFO_CHEZHU]){
        [self setCustomNavigationTitle:@"车主信息"];

    }else if ([self.identification isEqualToString:IDENTIFICATION_ADD_INS_INFO_DELIVER]){
        [self setCustomNavigationTitle:@"收件人信息"];

    }else if ([self.identification isEqualToString:IDENTIFICATION_ADD_INS_INFO_TOUBAOREN]){
        [self setCustomNavigationTitle:@"投保人信息"];

    }
   

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
