//
//  HomeCarView.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/7.
//  Copyr (c) 2015年 ___ENT___. All rs reserved.
//

#import "HomeCarView.h"


@interface HomeCarView ()
{
    UIImageView             *_carLogoView;
    //UIButton                *_carXianxingB;
    UIButton                *_carYanzhengB;
    UILabel                 *_carHphmL;
    UILabel                 *_carNianjianL;
    UILabel                 *_carBaoxianL;
    UILabel                 *_carAccidentStatusL;
    UILabel                 *_carWeichuliL;
    UILabel                 *_carFakuanL;
    UILabel                 *_carKoufenL;

    
    UILabel                 *_carAccidentStatusLabel;
    UILabel                 *_carWeichuliLabel;
    UILabel                 *_carFakuanLabel;
    UILabel                 *_carKoufenLabel;
    
    UILabel                 *_carMsgL;
    UIButton                *_carMsgB;
    UIImageView             *_carMsgImgV;
    
    UILabel                 *_shuLine;
    
}
@end

@implementation HomeCarView

- (void)peccancyInfoViewBeTaped{
    if([self.delegate_ respondsToSelector:@selector(homeCarView:tapPeccancyInfoWithHphm:)]){
        [self.delegate_ homeCarView:self tapPeccancyInfoWithHphm:_carHphm];
    }
}

- (void)carinfoViewBeTaped{
    if([self.delegate_ respondsToSelector:@selector(homeCarView:tapCarInfoWithHphm:)]){
        [self.delegate_ homeCarView:self tapCarInfoWithHphm:_carHphm];
    }
}

- (void)carLogoViewBeTaped{
    if([self.delegate_ respondsToSelector:@selector(homeCarView:tapCarLogoWithHphm:)]){
        [self.delegate_ homeCarView:self tapCarLogoWithHphm:_carHphm];
    }
}


- (void)tapYanzheng{
    
}

//- (void)tapXianxing{
//    
//}

- (void)tapMsg{
    if ([self.delegate_ respondsToSelector:@selector(homeCarView:tapZhaohuiWithHphm:)]) {
        [self.delegate_ homeCarView:self tapZhaohuiWithHphm:self.carHphm];
    }
}




- (id)initWithCar:(NSString*)carHphm{
    if (self = [super init]) {
        self.carHphm = [[NSString alloc] initWithString:carHphm];
        
        UIView *carInfoView = [[UIView alloc] initWithFrame:LGRectMake(0, 0, APP_PX_WIDTH,  CAR_VIEW_INFO_HEIGHT)];
        UIView *peccancyInfoView = [[UIView alloc] initWithFrame:LGRectMake(carInfoView.l, carInfoView.b, carInfoView.w, CAR_VIEW_PECCANCY_HEIGHT)];
        [self addSubview:carInfoView];
        [self addSubview:peccancyInfoView];
        carInfoView.backgroundColor = [UIColor whiteColor];
        peccancyInfoView.backgroundColor = [UIColor whiteColor];

        
/*-----------------------------------carInfoView--------------------------------------------------*/
        UIImageView *imgVv = [[UIImageView alloc] initWithFrame:LGRectMake(30, 30, 140, 140)];
        UIImage *img = [[UIImage imageNamed:@"home_car_brand_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
        [imgVv setImage:img];
        [carInfoView addSubview:imgVv];
        _carLogoView = [[UIImageView alloc] initWithFrame:LGRectMake((imgVv.w - 100*250/200)/2, (imgVv.h - 100)/2, 100*250/200, 100)];
        [imgVv addSubview:_carLogoView];
        //车牌
        _carHphmL = [[UILabel alloc] initWithFrame:LGRectMake(imgVv.r + 30, imgVv.t, 140, 30)];
        [_carHphmL convertNewLabelWithFont:BOLD_FONT_SIZE(30) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        [carInfoView addSubview:_carHphmL];
        //验证
        _carYanzhengB = [UIButton buttonWithType:UIButtonTypeCustom];
        [_carYanzhengB setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [_carYanzhengB setFrame:LGRectMake(_carHphmL.r + 30, _carHphmL.t, 35, 35)];
        [_carYanzhengB addTarget:self action:@selector(tapYanzheng) forControlEvents:UIControlEventTouchUpInside];
        [carInfoView addSubview:_carYanzhengB];
        //限行
//        _carXianxingB = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_carXianxingB setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//        [_carXianxingB setFrame:LGRectMake(_carYanzhengB.r + 5, _carYanzhengB.t, _carYanzhengB.w, _carYanzhengB.h)];
//        [_carXianxingB addTarget:self action:@selector(tapXianxing) forControlEvents:UIControlEventTouchUpInside];
//        [_carXianxingB setImage:[UIImage imageNamed:@"baoxue"] forState:UIControlStateNormal];
//        [carInfoView addSubview:_carXianxingB];
        //年检
        _carNianjianL = [[UILabel alloc] initWithFrame:LGRectMake(_carHphmL.l, _carHphmL.b + 25, 250, 30)];
        [_carNianjianL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        [carInfoView addSubview:_carNianjianL];
        //保险
        _carBaoxianL = [[UILabel alloc] initWithFrame:LGRectMake(_carNianjianL.l, _carNianjianL.b + 15, 250, 30)];
        [_carBaoxianL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        [carInfoView addSubview:_carBaoxianL];
        
        //竖线
        _shuLine = [[UILabel alloc] init];
        _shuLine.backgroundColor = COLOR_FRAME_LINE;
        [carInfoView addSubview:_shuLine];
        //车辆状态
        _carAccidentStatusLabel = [[UILabel alloc] initWithFrame:LGRectMake(_carNianjianL.r + 40 + 1, _carNianjianL.t, 1, 30)];
        [_carAccidentStatusLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        _carAccidentStatusLabel.text = @"车辆状态";
        [_carAccidentStatusLabel setSize:[_carAccidentStatusLabel.text sizeWithFont:_carAccidentStatusLabel.font constrainedToSize:YYSizeMake(10000, 30)]];
        [carInfoView addSubview:_carAccidentStatusLabel];
        _carAccidentStatusL = [[UILabel alloc] initWithFrame:LGRectMake(_carBaoxianL.r + 40 + 1, _carBaoxianL.t, 100, 30)];
        [_carAccidentStatusL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
        [carInfoView addSubview:_carAccidentStatusL];
        
        UILabel *line = [UILabel lineLabelWithPXPoint:CGPointMake(carInfoView.l, carInfoView.h - 1)];
//                          alloc] initWithFrame:LGRectMake(carInfoView.l, carInfoView.h - 1, carInfoView.w, 1)];
//        [line setBackgroundColor:COLOR_FRAME_LINE];
        [carInfoView addSubview:line];
        
/*----------------------------------------peccancyInfoView---------------------------------------------*/
        CGFloat width = APP_PX_WIDTH/3.0;
        _carWeichuliLabel = [[UILabel alloc] initWithFrame:LGRectMake(0, 20, width, 30)];
        [_carWeichuliLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
        [_carWeichuliLabel setText:@"未处理"];
        [peccancyInfoView addSubview:_carWeichuliLabel];
        _carWeichuliL = [[UILabel alloc] initWithFrame:LGRectMake(_carWeichuliLabel.l, _carWeichuliLabel.b + 20, _carWeichuliLabel.w, _carWeichuliLabel.h)];
        [_carWeichuliL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
        [peccancyInfoView addSubview:_carWeichuliL];
        
        _carFakuanLabel = [[UILabel alloc] initWithFrame:LGRectMake(width, 20, width, 30)];
        [_carFakuanLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
        [_carFakuanLabel setText:@"罚款"];
        [peccancyInfoView addSubview:_carFakuanLabel];
        _carFakuanL = [[UILabel alloc] initWithFrame:LGRectMake(_carFakuanLabel.l, _carFakuanLabel.b + 20, _carFakuanLabel.w, _carFakuanLabel.h)];
        [_carFakuanL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
        [peccancyInfoView addSubview:_carFakuanL];;
        
        _carKoufenLabel = [[UILabel alloc] initWithFrame:LGRectMake(width*2, 20, width, 30)];
        [_carKoufenLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
        [_carKoufenLabel setText:@"扣分"];
        [peccancyInfoView addSubview:_carKoufenLabel];
        _carKoufenL = [[UILabel alloc] initWithFrame:LGRectMake(_carKoufenLabel.l, _carKoufenLabel.b + 20, _carKoufenLabel.w, _carKoufenLabel.h)];
        [_carKoufenL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
        [peccancyInfoView addSubview:_carKoufenL];
        
        line = [UILabel lineLabelWithPXPoint:CGPointMake(peccancyInfoView.l, peccancyInfoView.h - 1)];
                 //alloc] initWithFrame:LGRectMake(peccancyInfoView.l, peccancyInfoView.h - 1, peccancyInfoView.w, 1)];
        //[line setBackgroundColor:COLOR_FRAME_LINE];
        [peccancyInfoView addSubview:line];
        //竖线
        CGFloat hengxianHeight = 20 + 30 + 20 + 30 + 20;
        line = [[UILabel alloc] initWithFrame:LGRectMake(_carWeichuliL.r - 1, 0, 1, hengxianHeight)];
        [line setBackgroundColor:COLOR_FRAME_LINE];
        [peccancyInfoView addSubview:line];
        line = [[UILabel alloc] initWithFrame:LGRectMake(_carFakuanL.r - 1, 0, 1, hengxianHeight)];
        [line setBackgroundColor:COLOR_FRAME_LINE];
        [peccancyInfoView addSubview:line];
        line = [[UILabel alloc] initWithFrame:LGRectMake(_carKoufenL.r - 1, 0, 1, hengxianHeight)];
        [line setBackgroundColor:COLOR_FRAME_LINE];
        [peccancyInfoView addSubview:line];
        
        _carMsgImgV = [[UIImageView alloc] initWithFrame:LGRectMake(30, peccancyInfoView.b + 20, CAR_VIEW_NOTICE_HEIGHT, CAR_VIEW_NOTICE_HEIGHT)];
        [_carMsgImgV setImage:[UIImage imageNamed:@"warn_logo.png"]];
        [self addSubview:_carMsgImgV];
        _carMsgL = [[UILabel alloc] initWithFrame:LGRectMake(_carMsgImgV.r + 10, _carMsgImgV.t, 100, CAR_VIEW_NOTICE_HEIGHT)];
        [_carMsgL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentCenter];
        [self addSubview:_carMsgL];
        _carMsgB = [UIButton buttonWithType:UIButtonTypeCustom];
        [_carMsgB setTitleColor:COLOR_LINK forState:UIControlStateNormal];
        [_carMsgB.titleLabel setFont:FONT_NOTICE];
        [_carMsgB setFrame:LGRectMake(_carMsgL.r + 5, _carMsgImgV.t, 0, 0)];
        [_carMsgB setTitle:@"查看详情" forState:UIControlStateNormal];
        [_carMsgB addTarget:self action:@selector(tapMsg) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_carMsgB];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carinfoViewBeTaped)];
        [carInfoView setUserInteractionEnabled:YES];
        [carInfoView addGestureRecognizer:tap];
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(peccancyInfoViewBeTaped)];
        [peccancyInfoView addGestureRecognizer:tap];
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carLogoViewBeTaped)];
        [_carLogoView addGestureRecognizer:tap];
        
        [self viewReloadAllInfo];

    }
    
    return self;
}



- (void)viewReloadOtherInfo{
    CarInfo *car = [[[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId andHphm:_carHphm] lastObject];
    //图
    NSString *urlstr = [NSString stringWithFormat:@"http://idc.pic-01.956122.com/allPic/CarLogo/%@.jpg", [[car.clsbdh substringToIndex:3] uppercaseString]];
    [_carLogoView setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageNamed:@"home_car_brand_default"]];
//    //限行
//    NSString *x = [_carHphm substringFromIndex:_carHphm.length - 1];
//    BOOL hidden = YES;
//    if (![APP_DELEGATE.xianxing isEqualToString:@"false"]){
//        NSArray *a = [APP_DELEGATE.xianxing componentsSeparatedByString:@","];
//        if ([a count] == 2) {
//            if ([[a objectAtIndex:0] isEqualToString:x] || [[a objectAtIndex:1] isEqualToString:x]) {
//                //xianxing
//                hidden = NO;
//            }
//        }else{
//            if ([APP_DELEGATE.xianxing isEqualToString:x]) {
//                //xianxing
//                hidden = NO;
//            }
//        }
//    }
//    [_carXianxingB setHidden:hidden];
    
    //消息
    NSArray *arr = [[DataBase sharedDataBase] selectZhaohuiByClsbdh:car.clsbdh];
    [_carMsgB setHidden:NO];
    [_carMsgImgV setImage:[UIImage imageNamed:@"warn_logo"]];
    if ([arr count] == 0) {
        [_carMsgL setText:@"当前车辆无召回信息"];
        [_carMsgB setHidden:YES];
        [_carMsgImgV setImage:[UIImage imageNamed:@"warn_logo_blue"]];
    }else{
        ZhaohuiMsg *z = [arr lastObject];
        [_carMsgL setText:z.reason];
        if ([z.reason rangeOfString:@"无召回信息"].length != 0) {
            [_carMsgB setHidden:YES];
            [_carMsgImgV setImage:[UIImage imageNamed:@"warn_logo_blue"]];
        }else if ([z.reason rangeOfString:@"加载失败"].length != 0){
            [_carMsgB setHidden:YES];
            [_carMsgImgV setImage:[UIImage imageNamed:@"warn_logo_blue"]];
        }
    }

    [_carMsgL setSize:[_carMsgL.text sizeWithFont:_carMsgL.font constrainedToSize:CGSizeMake(APP_WIDTH - 100*PX_X_SCALE - 30*4*PX_X_SCALE, _carMsgL.height)]];
    [_carMsgB setFrame:LGRectMake(_carMsgL.r + 20, _carMsgB.t, 100, CAR_VIEW_NOTICE_HEIGHT)];
    
}

- (void)viewReloadCarInfo{
    CarInfo *car = [[[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId andHphm:_carHphm] lastObject];
    _carHphmL.text = [car.hphm uppercaseString];
    [_carHphmL setSize:[_carHphmL.text sizeWithFont:_carHphmL.font constrainedToSize:CGSizeMake(1000, _carHphmL.height)]];
    
    
    //判断验证是否成功状态
    BOOL bandSucc = NO;
    NSRange succRange = [car.vehiclestatus rangeOfString:@"成功"];
    if (succRange.location != NSNotFound) {
        bandSucc = YES;
    }
    
    if (bandSucc) {//验证成功
        
        //[_carYanzhengB setTitle:@"验" forState:UIControlStateNormal];
        [_carYanzhengB setImage:[UIImage imageNamed:@"yanzheng_succ"] forState:UIControlStateNormal];
        //年检
        NSTimeInterval timeInterval = [[car.yxqz convertToDateWithFormat:@"yyyy-MM-dd"] timeIntervalSinceDate:[NSDate date]];
        int days = timeInterval/60/60/24;
        if (days < 0) {
            if (iOS6) {
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"年检已到期"];
                [str addAttribute:NSForegroundColorAttributeName value:COLOR_NAV range:NSMakeRange(0, [str length])];
                [_carNianjianL setAttributedText:str];
            }else{
                _carNianjianL.text = @"年检已到期";
            }
        }else{
            NSString *daysStr = [NSString stringWithFormat:@"%d", days];
            if ([car.yxqz isEqualToString:@""]) {
                daysStr = @"--";
            }
            if (iOS6) {
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"距离年检 %@ 天", daysStr]];
                [str addAttribute:NSForegroundColorAttributeName value:COLOR_NAV range:NSMakeRange(5, [daysStr length])];
                [_carNianjianL setAttributedText:str];
            }else{
                _carNianjianL.text = [NSString stringWithFormat:@"距离年检 %@ 天", daysStr];
            }
        }
        //保险
        timeInterval = [[car.bxzzrq convertToDateWithFormat:@"yyyy-MM-dd"] timeIntervalSinceDate:[NSDate date]];
        days = timeInterval/60/60/24;
        if (days < 0) {
            if (iOS6) {
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"保险已过期"];
                [str addAttribute:NSForegroundColorAttributeName value:COLOR_BUTTON_YELLOW range:NSMakeRange(0, [ str length])];
                [_carBaoxianL setAttributedText:str];
            }else{
                _carBaoxianL.text = @"保险已过期";
            }
        }else{
            NSString *daysStr = [NSString stringWithFormat:@"%d", days];
            if ([car.bxzzrq isEqualToString:@""]) {
                daysStr = @"--";
            }
            if (iOS6) {
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"保险到期 %@ 天", daysStr]];
                [str addAttribute:NSForegroundColorAttributeName value:COLOR_BUTTON_YELLOW range:NSMakeRange(5, [daysStr length])];
                [_carBaoxianL setAttributedText:str];
            }else{
                _carBaoxianL.text = [NSString stringWithFormat:@"保险到期 %@ 天", daysStr];
            }
            
        }
        //车辆状态
        _carAccidentStatusL.text = car.zt;
        
        //-------------make new size
        [_carNianjianL setSize:[_carNianjianL.text sizeWithFont:_carNianjianL.font constrainedToSize:CGSizeMake(1000, _carNianjianL.height)]];
        [_carBaoxianL setSize:[_carBaoxianL.text sizeWithFont:_carBaoxianL.font constrainedToSize:CGSizeMake(1000, _carBaoxianL.height)]];
        //竖线
        [_shuLine setFrame:LGRectMake(_carNianjianL.r + 20, _carNianjianL.t, 1, 30 + 20 + 30)];
        CGFloat right = (_carNianjianL.r > _carBaoxianL.r)? _carNianjianL.r:_carBaoxianL.r;
        [_carAccidentStatusLabel setFrame:LGRectMake(right + 40 + 1, _carNianjianL.t, 0, 0)];
        [_carAccidentStatusLabel setSize:[_carAccidentStatusLabel.text sizeWithFont:_carAccidentStatusLabel.font constrainedToSize:CGSizeMake(1000, _carAccidentStatusLabel.height)]];
        [_carAccidentStatusL setFrame:LGRectMake(right + 40 + 1, _carBaoxianL.t, 0, 0)];
        [_carAccidentStatusL setSize:[_carAccidentStatusL.text sizeWithFont:_carAccidentStatusL.font constrainedToSize:CGSizeMake(1000, _carAccidentStatusL.height)]];
        
    }else{
        [_carYanzhengB setImage:[UIImage imageNamed:@"yanzheng_failed"] forState:UIControlStateNormal];
        //车辆状态
        _carAccidentStatusL.text = @"未知";
        [_carAccidentStatusL setSize:[_carAccidentStatusL.text sizeWithFont:_carAccidentStatusL.font constrainedToSize:CGSizeMake(1000, _carAccidentStatusL.height)]];
        _carNianjianL.text = @"距离年检 - 天";
        _carBaoxianL.text = @"保险到期 - 天";
        
        
        //-----------------make new size
        [_carNianjianL setSize:[_carNianjianL.text sizeWithFont:_carNianjianL.font constrainedToSize:CGSizeMake(1000, _carNianjianL.height)]];
        [_carBaoxianL setSize:[_carBaoxianL.text sizeWithFont:_carBaoxianL.font constrainedToSize:CGSizeMake(1000, _carBaoxianL.height)]];
        //竖线
        [_shuLine setFrame:LGRectMake(_carNianjianL.r + 20, _carNianjianL.t, 1, 30 + 20 + 30)];
        CGFloat right = (_carNianjianL.r > _carBaoxianL.r)? _carNianjianL.r:_carBaoxianL.r;
        [_carAccidentStatusLabel setFrame:LGRectMake(right + 40 + 1, _carNianjianL.t, 0, 0)];
        [_carAccidentStatusLabel setSize:[_carAccidentStatusLabel.text sizeWithFont:_carAccidentStatusLabel.font constrainedToSize:CGSizeMake(1000, _carAccidentStatusLabel.height)]];
        [_carAccidentStatusL setFrame:LGRectMake(right + 40 + 1, _carBaoxianL.t, 0, 0)];
        [_carAccidentStatusL setSize:[_carAccidentStatusL.text sizeWithFont:_carAccidentStatusL.font constrainedToSize:CGSizeMake(1000, _carAccidentStatusL.height)]];
        
    }
}

- (void)viewReloadCarPeccancyInfo{
    
    CarInfo *car = [[[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId andHphm:_carHphm] lastObject];
    CarPeccancyRecord *carPeccancyRecord = [[[DataBase sharedDataBase] selectCarPeccancyRecordByUserId:APP_DELEGATE.userId andHphm:car.hphm] lastObject];
    if (!carPeccancyRecord) {
        _carWeichuliL.text = @" - 条";
        _carFakuanL.text = @" - 元";
        _carKoufenL.text = @" - 分";
    }else{
        
        NSArray *pmsArr = [Helper carPeccancyMsgAnalysis:carPeccancyRecord.jdcwf_detail withHphm:car.hphm];
        NSDictionary *peccancyRDict = [Helper filtrateCarPeccancyRecordMessages:pmsArr withHpzl:car.hpzl andHphm:car.hphm];
        NSArray *payArr = [peccancyRDict objectForKey:KEY_FILTRATE_CAR_PECCANCY_MSGS_RESULT_PAY_MSG];
        NSArray *dealArr = [peccancyRDict objectForKey:KEY_FILTRATE_CAR_PECCANCY_MSGS_RESULT_DEAL_MSG];
        _carWeichuliL.text = [NSString stringWithFormat:@"%d条", (int)[payArr count] + (int)[dealArr count]];
        
        NSInteger fkje = 0;
        NSInteger koufen = 0;
        for (CarPeccancyMsg *msg in payArr) {
            fkje = fkje + [msg.fkje integerValue];
            koufen = koufen + [msg.wfjfs integerValue];
        }
        for (CarPeccancyMsg *msg in dealArr) {
            fkje = fkje + [msg.fkje integerValue];
            koufen = koufen + [msg.wfjfs integerValue];
        }
        _carFakuanL.text = [NSString stringWithFormat:@"%d元",(int)fkje];
        _carKoufenL.text = [NSString stringWithFormat:@"%d分",(int)koufen];;
    }
    
    
}



- (void)viewReloadAllInfo{
    [self viewReloadCarInfo];
    [self viewReloadOtherInfo];
    [self viewReloadCarPeccancyInfo];
    
    
}








/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
