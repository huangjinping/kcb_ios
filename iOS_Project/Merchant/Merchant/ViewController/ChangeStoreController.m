//
//  ChangeStoreController.m
//  Merchant
//
//  Created by Wendy on 16/1/25.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import "ChangeStoreController.h"
//#import "CustomInputView.h"
#import "DateSelectView.h"
#import "ABBDropDatepickerView.h"
#import "CLInputTextView.h"

@interface ChangeStoreController ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *rightTextView;
//@property (nonatomic,strong) CustomInputView *startTime;
//@property (nonatomic,strong) CustomInputView *endTime;
@property (nonatomic,strong) ABBDropDatepickerView *startT;
@property (nonatomic,strong) ABBDropDatepickerView *endT;
@property (nonatomic,strong) CLInputTextView *contentInputView;
@end

@implementation ChangeStoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorBackgroud;
    
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 55, 25);
    [btn addBorderWithWidth:1 color:RGB(140, 198, 142) corner:1];
    [btn setTitle:@"修改" forState:UIControlStateNormal];
    btn.titleLabel.font = V3_36PX_FONT;
    [btn setTitleColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(editStoreInfo:)];
    
    UIBarButtonItem *right        = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = right;

    if (_changeType == 17) {
        [self workTimeInfoChangeView];
    }else if(_changeType == 19){
        [self changeStoreDesp];
    }
    else{
        [self basicInfoChangeView];
    }
    
    [self setNavigationTitle];

}
- (void)editStoreInfo:(UIButton *)sender{
    
    if (_changeType == 0) {
        _info.form_num = _rightTextView.text;
    }else if(_changeType == 10){
        _info.name = _rightTextView.text;
    }else if(_changeType == 11){
        _info.address = _rightTextView.text;
    }else if(_changeType == 12){
        _info.contacts = _rightTextView.text;
    }else if(_changeType == 13){
        _info.telno = _rightTextView.text;
    }else if(_changeType == 14){
        _info.phone_no = _rightTextView.text;
    }else if(_changeType == 17){
        _info.open_time = _startT.textField.text;
        _info.close_time = _endT.textField.text;
    }else if(_changeType == 19){
        _info.describe_m = _contentInputView.inputView.text;
    }
    NSInteger merid = ApplicationDelegate.shareLoginData.userdata.mid;
    NSInteger userid = ApplicationDelegate.shareLoginData.userdata.userId;
    NSDictionary *param = @{@"merid":[NSNumber numberWithInteger:merid].stringValue,
                            @"userid":[NSNumber numberWithInteger:userid].stringValue,
                            @"address":BLANK(_info.address),
                            @"close_time":BLANK(_info.close_time),
                            @"contacts":BLANK(_info.contacts),
                            @"describe_m":BLANK(_info.describe_m),
                            @"form_num":BLANK(_info.form_num),
                            @"name":BLANK(_info.name),
                            @"open_time":BLANK(_info.open_time),
                            @"phone_no":BLANK(_info.phone_no),
                            @"telno":BLANK(_info.telno)
                            };
    [AFNHttpRequest afnHttpRequestUrl:kHttpEditMerchant param:param success:^(id responseObject) {
        if (kRspCode(responseObject) == 0) {
            _commplete();
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [UIHelper alertWithMsg:kRspMsg(responseObject)];
        }
    } failure:^(NSError *error) {
        [UIHelper alertWithMsg:kNetworkErrorDesp];
    } view:self.view];
}
- (void)setNavigationTitle{
    NSString * title = nil;
    if (_changeType == 0) {
        title = @"修改服务设置";
        _rightTextView.text = _info.form_num;
        _rightTextView.keyboardType = UIKeyboardTypeNumberPad;
    }else if(_changeType == 10){
        title = @"修改门店名称";
        _rightTextView.text = _info.name;
    }else if(_changeType == 11){
        title = @"修改门店地址";
        _rightTextView.text = _info.address;
    }else if(_changeType == 12){
        title = @"修改联系人";
        _rightTextView.text = _info.contacts;
    }else if(_changeType == 13){
        title = @"修改联系电话";
        _rightTextView.text = _info.telno;
    }else if(_changeType == 14){
        title = @"修改手机号码";
        _rightTextView.text = _info.phone_no;
        _rightTextView.keyboardType = UIKeyboardTypeNumberPad;
    }else if(_changeType == 17){
        title = @"修改营业时间";
//        [_startTime setTextField:_info.open_time];
//        [_endTime setTextField:_info.close_time];
        _startT.textField.text = _info.open_time;
        _endT.textField.text = _info.close_time;
    }else if(_changeType == 19){
        title = @"修改门店描述";
        if (_info.describe_m.length > 0) {
            _contentInputView.placeholder = nil;
            _contentInputView.inputView.text = _info.describe_m;
        }
    }
    [self setNavTitle:title];
}

//基本信息修改，单行
- (void)basicInfoChangeView{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, APP_WIDTH, 40)];
    backView.backgroundColor = [UIColor whiteColor];
    _rightTextView = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, APP_WIDTH-20, 40)];
    _rightTextView.font = V3_38PX_FONT;
    _rightTextView.placeholder = nil;
    _rightTextView.delegate = self;
    [backView addSubview:_rightTextView];
    [self.view addSubview:backView];
}
//修改时间
- (void)workTimeInfoChangeView{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, APP_WIDTH, 80)];
    backView.backgroundColor = [UIColor whiteColor];
    
    _startT = [[ABBDropDatepickerView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 40)];
    [_startT setDateTitle:@"开始时间："];
    _startT.commplete = ^(id string){
    };
    _startT.type = @"1";
    [backView addSubview:_startT];
    
    _endT = [[ABBDropDatepickerView alloc]initWithFrame:CGRectMake(0, _startT.bottom, APP_WIDTH, 40)];
    _endT.type = @"1";
    _endT.commplete = ^(id string){
    };

    [_endT setDateTitle:@"结束时间"];
    [backView addSubview:_endT];
    [self.view addSubview:backView];
}
//修改店铺描述
- (void)changeStoreDesp{
    _contentInputView = [[CLInputTextView alloc] initWithFrame:CGRectMake(10, 20, APP_WIDTH-20, 180)];
    _contentInputView.textViewMaxLength = 200;
    _contentInputView.placeholder = @"请输入服务描述";
    [self.view addSubview:_contentInputView];
}
/*
- (void)workTimeInfoChangeView1{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, APP_WIDTH, 80)];
    backView.backgroundColor = [UIColor whiteColor];
    
    __weak __typeof(self)weakSelf = self;
    
    _startTime = [[CustomInputView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 40) title:@"开始时间：" placeholder:@"" value:@""];
    _startTime.commplete = ^{
        [[DateSelectView sharedDateSelectView].datePicker setDatePickerMode:UIDatePickerModeTime];
        [[DateSelectView sharedDateSelectView] showWithCompletion:^(NSDate *date)
         {
             NSString *text = [date stringWithDateFormat:DateFormatWithTime];
             [weakSelf.startTime setTextField:text];
         }];
        
    };
    [backView addSubview:_startTime];
    
    //结束时间
    _endTime = [[CustomInputView alloc] initWithFrame:CGRectMake(0, _startTime.bottom, APP_WIDTH, 40) title:@"结束时间：" placeholder:@"" value:@""];
    _endTime.commplete = ^{
        [[DateSelectView sharedDateSelectView] showWithCompletion:^(NSDate *date)
         {
             NSString *text = [date stringWithDateFormat:DateFormatWithTime];
             [weakSelf.endTime setTextField:text];
         }];
        
    };
    
    [backView addSubview:_endTime];

    [self.view addSubview:backView];

}
 */
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
- (UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title{
    UILabel *settingLab = [[UILabel alloc] initWithFrame:frame];
    settingLab.text = title;
    settingLab.textColor = kColor0X666666;
    settingLab.font = V3_36PX_FONT;
    return settingLab;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (_changeType != 14) {
        return YES;
    }
    if (string == nil || [string isEqualToString:@""]) {
        return YES;
    }
    
    if (range.location >= 11) {
        return NO;
    }
    
    return YES;

}
@end