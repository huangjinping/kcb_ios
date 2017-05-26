//
//  DealingViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-28.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "DealingViewController.h"
#import "MarkupParser.h"
#import "CustomLabel.h"

#import "CarInfo.h"
#import "CarPeccancyMsg.h"

#define TAG_ALERT_REQ_SUCC          103
#define TAG_ALERT_REQ_FAILED        104
@interface DealingViewController ()<
UIAlertViewDelegate
>

{
    UILabel        *_personNameL;
    UILabel        *_idNumberL;
    UILabel        *_addrL;
    CustomLabel        *_contentL;
    //UIImageView         *_bgImgView;
    UIScrollView    *_rootScrollView;
    //UIButton           *_confirmYesButton;
    //UIButton           *_confirmNoButton;
    
    UIAlertView         *_alertWhileSubmiting;
}
@end

@implementation DealingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView_{
    
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(APP_X , APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    [_rootScrollView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_rootScrollView];
    
    //    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    //    _bgImgView.userInteractionEnabled = YES;
    //    //[_bgImgView setImage:[UIImage imageNamed:@"bg_white.png"]];
    //    [_rootScrollView addSubview:_bgImgView];
    
    CGFloat lableHeight = 15;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, _rootScrollView.width - 20*2, lableHeight)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"全国道路交通违法自助服务平台确认通知";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [_rootScrollView addSubview:label];
    
    
    
    DriverInfo *driver = [[[DataBase sharedDataBase] selectDriverByUserId:APP_DELEGATE.userId] lastObject];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(label.left, label.bottom + 20, 80, lableHeight)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"被处罚人：";
    label.font = [UIFont systemFontOfSize:13];
    [_rootScrollView addSubview:label];
    _personNameL = [[UILabel alloc] initWithFrame:CGRectMake(label.right, label.top, 150, lableHeight)];
    _personNameL.backgroundColor = [UIColor clearColor];
    _personNameL.font = [UIFont systemFontOfSize:13];
    
    if (_isYunnan) {
        _personNameL.text = self.car.syr;
    }else{
        _personNameL.text = driver.xm;
    }
    [_rootScrollView addSubview:_personNameL];;
    
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(label.left, label.bottom + 5, 80, lableHeight)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13];
    [_rootScrollView addSubview:label];
    _idNumberL = [[UILabel alloc] initWithFrame:CGRectMake(label.right, label.top, 250, lableHeight)];
    _idNumberL.backgroundColor = [UIColor clearColor];
    _idNumberL.font = [UIFont systemFontOfSize:13];
    if (_isYunnan) {
        label.text = @"身份证号码：";
        _idNumberL.text = self.car.sfzmhm;
    }else{
        label.text = @"驾驶证号码：";
        if (driver) {
            _idNumberL.text = driver.driversfzmhm;
        }
    }
    [_rootScrollView addSubview:_idNumberL];;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(label.left, label.bottom + 5, 80, lableHeight)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13];
    [_rootScrollView addSubview:label];
    _addrL = [[UILabel alloc] initWithFrame:CGRectMake(label.right, label.top, 180, lableHeight)];
    _addrL.backgroundColor = [UIColor clearColor];
    _addrL.font = [UIFont systemFontOfSize:13];
    _addrL.lineBreakMode = NSLineBreakByCharWrapping;
    _addrL.numberOfLines = 0;
    if (_isYunnan) {
        label.text = @"联系方式：";
        _addrL.text = self.carPeccancyMsg.dsrdz;
    }else{
        label.text = @"档案编号：";
        if (driver) {
            _addrL.text = driver.dabh;
        }
    }
    _addrL.size = [_addrL.text sizeWithFont:_addrL.font constrainedToSize:CGSizeMake(160, 1000) lineBreakMode:_addrL.lineBreakMode];
    [_rootScrollView addSubview:_addrL];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //    label = [[UILabel alloc] initWithFrame:CGRectMake(_contentL.left, _contentL.bottom + 10, 150, lableHeight)];
    //    label.backgroundColor = [UIColor clearColor];
    //    label.text = @"对上述内容是否确认：";
    //    label.font = [UIFont systemFontOfSize:15];
    //    [bgImgView addSubview:label];
    
    
    //    _confirmYesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [_confirmYesButton setFrame:CGRectMake(label.right, label.bottom + 5, 20, 20)];
    //    [_confirmYesButton setImage:[UIImage imageNamed:@"btn_agree_no.png"] forState:UIControlStateNormal];
    //    [_confirmYesButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    //    [bgImgView addSubview:_confirmYesButton];
    //    label = [[UILabel alloc] initWithFrame:CGRectMake(_confirmYesButton.right + 5, _confirmYesButton.top, 30, lableHeight)];
    //    label.backgroundColor = [UIColor clearColor];
    //    label.text = @"是";
    //    label.font = [UIFont systemFontOfSize:15];
    //    [bgImgView addSubview:label];
    //
    //
    //    _confirmNoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [_confirmNoButton setFrame:CGRectMake(label.right + 10, _confirmYesButton.top, 20, 20)];
    //    [_confirmNoButton setImage:[UIImage imageNamed:@"btn_agree_no.png"] forState:UIControlStateNormal];
    //    [_confirmNoButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    //    [bgImgView addSubview:_confirmNoButton];
    //    label = [[UILabel alloc] initWithFrame:CGRectMake(_confirmNoButton.right + 5, _confirmNoButton.top, 30, lableHeight)];
    //    label.backgroundColor = [UIColor clearColor];
    //    label.text = @"否";
    //    label.font = [UIFont systemFontOfSize:15];
    //    [bgImgView addSubview:label];
    
    
    
    
    
    //    label = [[UILabel alloc] initWithFrame:CGRectMake(bgImgView.left + 20, bgImgView.bottom + 20, 122, 20)];
    //    label.text = @"注意事项提示：";
    //    label.font = [UIFont italicSystemFontOfSize:16];
    //    label.textColor = [UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:1];
    //    label.backgroundColor = [UIColor clearColor];
    //    [rootScrollView addSubview:label];
    //
    //    label = [[UILabel alloc] initWithFrame:CGRectMake(label.left, label.bottom + 10, (APP_WIDTH - label.left*2), 80)];
    //    label.numberOfLines = 0;
    //    label.text = @"1. 网上处理违法将在24小时内完成处理\n2. 年检车辆请提前48小时进行处理;\n3. 所有违法处理由交警信息系统自动处理，请确保信息的真实性;";
    //    label.lineBreakMode = NSLineBreakByWordWrapping;
    //    label.font = [UIFont systemFontOfSize:14];
    //    label.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
    //    label.backgroundColor = [UIColor clearColor];
    //    [label fitSpace:5];
    //    [rootScrollView addSubview:label];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadView_];
    
    //    _confirmNoButton.tag = TAG_BUTTON_UN_SELECTED;
    //    _confirmYesButton.tag = TAG_BUTTON_SELECTED;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"违法处理"];
    //[self setBackButtonHidden:YES];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //[MBProgressHUD animateWithDuration:100000
    //                      animations:
    //^{
    
    _contentL = [[CustomLabel alloc] initWithFrame:CGRectMake(20, _addrL.bottom + 15, APP_WIDTH - 2*20, 80)];
    _contentL.backgroundColor = [UIColor clearColor];
    _contentL.lineBreakMode = NSLineBreakByClipping;
    _contentL.numberOfLines = 0;
    CGFloat lineSpace = 5;
    CGFloat fontSize = 13.0;
    
    //make color   make space
    NSString *newcontent = [[NSString alloc] initWithFormat:@"您处罚的机动车 <font color=\"red\">%@%@,<font color=\"black\">于<font color=\"red\">%@<font color=\"black\">在<font color=\"red\">%@<font color=\"black\">处实施了%@违法行为(代码<font color=\"red\">%@<font color=\"black\">),违反了%@规定,根据<font color=\"red\">%@<font color=\"black\">,决定处以<font color=\"red\">%@<font color=\"black\">元罚款。",[self.car.hphm uppercaseString], self.carPeccancyMsg.cllx, self.carPeccancyMsg.wfsj, self.carPeccancyMsg.wfdz, self.carPeccancyMsg.wfms, self.carPeccancyMsg.wfxw, self.carPeccancyMsg.wfgd, self.carPeccancyMsg.fltw, self.carPeccancyMsg.fkje];
    MarkupParser *p = [[MarkupParser alloc]init ];
    NSAttributedString *attString = [p attrStringFromMarkup:newcontent withFontSize:fontSize andLineSpace:5];
    [_contentL setAttString:attString];
    
    NSString *content = [[NSString alloc] initWithFormat:@"您处罚的机动车 %@%@,于%@在%@处实施了%@违法行为(代码%@),违反了%@规定,根据%@,决定处以%@元罚款。",[self.car.hphm uppercaseString], self.carPeccancyMsg.cllx, self.carPeccancyMsg.wfsj, self.carPeccancyMsg.wfdz, self.carPeccancyMsg.wfms, self.carPeccancyMsg.wfxw, self.carPeccancyMsg.wfgd, self.carPeccancyMsg.fltw, self.carPeccancyMsg.fkje];
    _contentL.size = [content sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(_contentL.width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat numberOfLines = content.length/30 + 3;
    _contentL.size = CGSizeMake(_contentL.size.width, _contentL.size.height + numberOfLines * lineSpace) ;
    [_rootScrollView addSubview:_contentL];
    
    
    
    UIView  *buttonBgView = [[UIView alloc] initWithFrame:YYRectMake(0, self.view.height/PX_X_SCALE - 100, APP_PX_WIDTH, 100)];
    [buttonBgView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:buttonBgView];
    UILabel *line = [UILabel lineLabelWithPXPoint:CGPointMake(0, 0)];
    [buttonBgView addSubview:line];
    CGFloat width = APP_PX_WIDTH/2;
    CGFloat height = 60;
//    UIButton *cancelButton = [UIButton mainButtonWithPXY:20 title:@"取消处理" target:self action:@selector(cancel:)];
//    [cancelButton setFrame:YYRectMake(0, 20, width, height)];
//    [buttonBgView addSubview:cancelButton];
    UIButton *submitButton = [UIButton mainButtonWithPXY:20 title:@"确认处理" target:self action:@selector(submit:)];
    [submitButton setFrame:YYRectMake(width/2, 20, width, height)];
    [buttonBgView addSubview:submitButton];
    
    //if (submitButton.bottom >= _rootScrollView.height) {
        [_rootScrollView setContentSize:CGSizeMake(APP_WIDTH, _contentL.bottom + 20)];
    //}
    
    // }];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

//- (IBAction)confirm:(UIButton*)btn{
//    [btn setImage:[UIImage imageNamed:@"btn_agree_yes.png"] forState:UIControlStateNormal];
//    btn.tag = TAG_BUTTON_SELECTED;
//    if ([btn isEqual:_confirmYesButton]) {
//
//        [_confirmNoButton setImage:[UIImage imageNamed:@"btn_agree_no.png"] forState:UIControlStateNormal];
//        _confirmNoButton.tag = TAG_BUTTON_UN_SELECTED;
//    }else{
//        [_confirmYesButton setImage:[UIImage imageNamed:@"btn_agree_no.png"] forState:UIControlStateNormal];
//        _confirmYesButton.tag = TAG_BUTTON_UN_SELECTED;
//
//    }
//
//
//}
- (void)cancel:(UIButton*)btn{
    [self gobackPage];
}

- (IBAction)submit:(UIButton*)btn{
    //    if (_confirmYesButton.tag != TAG_BUTTON_SELECTED) {
    //        [self.view showAlertText:@"请确认以上内容"];
    //        return;
    //    }
    
    _alertWhileSubmiting = [[UIAlertView alloc] initWithTitle:@"注意事项提示"
                                                      message:@"1. 网上处理违法将在24小时内完成处理\n2. 年检车辆请提前48小时进行处理;\n3. 所有违法处理由交警信息系统自动处理，请确保信息的真实性;"
                                                     delegate:self
                                            cancelButtonTitle:@"正在为您提交处理..."
                                            otherButtonTitles:nil, nil];
    [_alertWhileSubmiting show];
    
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *xh = @"";
    if ([self.carPeccancyMsg.xh rangeOfString:SERVER_BACK_WITHOUT].location == NSNotFound) {
        xh = self.carPeccancyMsg.xh;
    }
    
    
    [bodyDict setObject:xh forKey:@"xh"];
    [bodyDict setObject:self.carPeccancyMsg.sfzmhm forKey:@"sfzmhm"];
    [bodyDict setObject:self.carPeccancyMsg.cfd forKey:@"cfd"];
    [bodyDict setObject:self.car.hpzl forKey:@"hpzl"];
    [bodyDict setObject:self.car.hphm forKey:@"hphm"];
    [bodyDict setObject:self.carPeccancyMsg.cjjg forKey:@"cjjg"];
    [bodyDict setObject:self.carPeccancyMsg.wfxw forKey:@"wfxw"];
    [bodyDict setObject:self.carPeccancyMsg.fkje forKey:@"fkje"];
    [bodyDict setObject:self.carPeccancyMsg.wfdd1 forKey:@"wfdd1"];
    [bodyDict setObject:self.carPeccancyMsg.lddm1 forKey:@"lddm1"];
    [bodyDict setObject:self.carPeccancyMsg.ddms1 forKey:@"ddms1"];
    [bodyDict setObject:self.carPeccancyMsg.cjfs forKey:@"cjfs"];
    [bodyDict setObject:self.carPeccancyMsg.wfsj1 forKey:@"wfsj1"];
    [bodyDict setObject:self.carPeccancyMsg.wfjfs forKey:@"wfjfs"];
    [bodyDict setObject:APP_DELEGATE.userName forKey:@"username"];
    
    if ([self.car.hphm hasPrefix:@"云"]) {
        [bodyDict setObject:@"ynvioconfirm" forKey:@"action"];
        [bodyDict setObject:self.car.syr forKey:@"syr"];
        //新增改动
        [bodyDict setObject:self.car.sfzmhm forKey:@"sfzmhm"];
        
    }else{
        [bodyDict setObject:@"vioconfirm" forKey:@"action"];
        [bodyDict setObject:self.carPeccancyMsg.dsr forKey:@"dsr"];
        [bodyDict setObject:APP_DELEGATE.userName forKey:@"username"];
    }
    
    
    
    [[Network sharedNetwork] postBody:bodyDict isResponseJson:YES doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        [_alertWhileSubmiting dismissWithClickedButtonIndex:0 animated:YES];
        
        if (result == postSucc) {
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSInteger code = [[resDict analysisStrValueByKey:@"code"] integerValue];
            NSString *message = [resDict analysisStrValueByKey:@"message"];
            if (code == 0) {//成功
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                                message:message
                                                               delegate:self
                                                      cancelButtonTitle:@"确认"
                                                      otherButtonTitles:nil, nil];
                alert.tag = TAG_ALERT_REQ_SUCC;
                [alert show];
                
            }else{//失败
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                                message:message
                                                               delegate:self
                                                      cancelButtonTitle:@"确认"
                                                      otherButtonTitles:nil, nil];
                alert.tag = TAG_ALERT_REQ_FAILED;
                [alert show];
            }
        }else{//失败
            //服务器返回为空
            if ([(NSString*)requestObj isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                                message:@"提交成功！请等待查看处理结果。"
                                                               delegate:self
                                                      cancelButtonTitle:@"确认"
                                                      otherButtonTitles:nil, nil];
                alert.tag = TAG_ALERT_REQ_SUCC;
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                                message:(NSString*)requestObj
                                                               delegate:self
                                                      cancelButtonTitle:@"确认"
                                                      otherButtonTitles:nil, nil];
                alert.tag = TAG_ALERT_REQ_FAILED;
                [alert show];
            }
            
            
        }
        
    } onError:^(NSString *errorStr) {
        [_alertWhileSubmiting dismissWithClickedButtonIndex:0 animated:YES];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:errorStr
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil, nil];
        alert.tag = TAG_ALERT_REQ_FAILED;
        [alert show];
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == TAG_ALERT_REQ_SUCC) {
        [self gobackPage];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
