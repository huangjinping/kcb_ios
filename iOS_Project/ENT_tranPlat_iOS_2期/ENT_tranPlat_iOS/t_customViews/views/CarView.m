//
//  CarView.m
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-7-16.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "CarView.h"

@implementation CarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;

}

//初始化视图
- (void)setViewWithCar:(CarInfo *)car
{
    self.car = car;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/2)];
    view.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCar:)];
    [view addGestureRecognizer:tap];
    [self addSubview:view];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height/2, self.bounds.size.width, self.bounds.size.height/2)];
    view.backgroundColor = [UIColor clearColor];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBlank:)];
    [view addGestureRecognizer:tap];
    [self addSubview:view];
    
    CGFloat startY = 16;
    if (iPhone5) {
        startY = 16 + (CAR_VIEW_HEIGHT - 200)/2;
    }
    
    _carNumL = [[UILabel alloc] initWithFrame:CGRectMake(65, startY, 125, 30)];
    _carNumL.textColor = [UIColor blackColor];
    _carNumL.textAlignment = NSTextAlignmentLeft;
    _carNumL.font = [UIFont systemFontOfSize:25];
    _carNumL.backgroundColor = [UIColor clearColor];
    _carNumL.text = [car.hphm uppercaseString];
    [self addSubview:_carNumL];
    
    _statusL = [[UILabel alloc] initWithFrame:CGRectMake(_carNumL.right+5, _carNumL.top + 2, 80, 20)];
    _statusL.textColor = [UIHelper getColor:@"#72a0c5"];
    _statusL.font = [UIFont systemFontOfSize:14];
    _statusL.backgroundColor = [UIColor clearColor];
    [self addSubview:_statusL];
    
    UILabel *timeL = [[UILabel alloc] initWithFrame:CGRectMake(_carNumL.left-20, _carNumL.bottom+5, 200, 20)];
    timeL.textColor = [UIHelper getColor:@"#9e9e9e"];
    timeL.font = [UIFont systemFontOfSize:14];
    timeL.textAlignment = NSTextAlignmentCenter;
    timeL.backgroundColor = [UIColor clearColor];
    [self addSubview:timeL];
    
    _lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, timeL.bottom+10, self.width-20, 1)];
    _lineImgView.image = [UIImage imageNamed:@"line02.png"];
    [self addSubview:_lineImgView];
    
    
    _recordL = [[UILabel alloc] initWithFrame:CGRectMake(_carNumL.left-30, _lineImgView.bottom + 6, 200, 30)];
    _recordL.textColor = [UIHelper getColor:@"#757575"];
    _recordL.font = [UIFont systemFontOfSize:18];
    [self addSubview:_recordL];
    
    UIButton *reloadOrEnterOrRebindButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [reloadOrEnterOrRebindButton setFrame:CGRectMake(_carNumL.left-190, _recordL.bottom, 400, 20)];
    [reloadOrEnterOrRebindButton setTitleColor:[UIHelper getColor:@"#72a0c5"] forState:UIControlStateNormal];
    reloadOrEnterOrRebindButton.titleLabel.font = [UIFont systemFontOfSize:16];
    reloadOrEnterOrRebindButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [reloadOrEnterOrRebindButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reloadOrEnterOrRebindButton];
        
    
    //判断绑定是否成功状态
    _bindStatus = bindFailed;
    NSRange succRange = [car.vehiclestatus rangeOfString:@"成功"];
    if (succRange.location != NSNotFound) {
        _bindStatus = bindSucc;
    }
    
    if (_bindStatus == bindSucc) {//绑定成功
        
        _statusL.text = @"[绑定成功]";
        NSTimeInterval timeInterval = [[car.yxqz convertToDateWithFormat:@"yyyy-MM-dd"] timeIntervalSinceDate:[NSDate date]];
        int days = timeInterval/60/60/24;
        
        timeL.text = @"距车辆年审         天";
        UILabel *daysL = [[UILabel alloc] initWithFrame:CGRectMake(108, 0, 40, 20)];
        daysL.backgroundColor = [UIColor clearColor];
        daysL.textAlignment = NSTextAlignmentCenter;
        daysL.text = [NSString stringWithFormat:@"%d", days];
        daysL.textColor = [UIHelper getColor:@"#ff8d1b"];
        daysL.font = [UIFont systemFontOfSize:15];
        //daysL.backgroundColor = [UIColor yellowColor];

        if (days<0) {
            daysL.text = @"--";
        }
        
        [timeL addSubview:daysL];
        
        LoadingPeccancyRecordStatus loadingPeccancyRecordStatus = car.loadingPeccancyRecordStatus;
        
        if (loadingPeccancyRecordStatus == loadingPeccancyRecordFailed) {
            
            _recordL.text = @"车辆违法信息加载失败";
            
            [reloadOrEnterOrRebindButton setTitle:@"[重新加载]" forState:UIControlStateNormal];
            reloadOrEnterOrRebindButton.tag = TAG_BUTTON_ACTION_RELOAD_PECCANCY;
            
        }else if (loadingPeccancyRecordStatus == isloadingPeccancyRecord){
            
            
            _recordL.text = @"共有     条违法记录";
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(38, 5, 20, 20)];
            [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
            [indicator startAnimating];
            [_recordL addSubview:indicator];
            
            reloadOrEnterOrRebindButton.hidden = YES;
            
        }else if (loadingPeccancyRecordStatus == loadingPeccancyRecordSucc){
            
            NSString *peccancyCount = car.peccancyCount;
            if (!peccancyCount) {
                peccancyCount = @"";
            }else{
                peccancyCount = car.peccancyCount;
            }
            //_recordL.text = [NSString stringWithFormat:@"共有%@条违法记录",peccancyCount];
            _recordL.text = @"共有        条违法记录";
            UILabel *peccancyCountL = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 40, 20)];
            peccancyCountL.backgroundColor = [UIColor clearColor];
            peccancyCountL.textAlignment = NSTextAlignmentCenter;
            peccancyCountL.text = [NSString stringWithFormat:@"%@", peccancyCount];
            peccancyCountL.textColor = [UIHelper getColor:@"#ff8d1b"];
            peccancyCountL.font = [UIFont systemFontOfSize:25];
            [_recordL addSubview:peccancyCountL];
            
            
            [reloadOrEnterOrRebindButton setTitle:@"[点击查看]" forState:UIControlStateNormal];
            reloadOrEnterOrRebindButton.tag = TAG_BUTTON_ACTION_ENTER_PECCANCY;
        }
        
    }else{
        _statusL.text = @"[绑定失败]";
        timeL.text = @"距车辆年审--天";
        _recordL.text = car.vehiclestatus;
        [reloadOrEnterOrRebindButton setTitle:@"[重新绑定车辆]" forState:UIControlStateNormal];
        reloadOrEnterOrRebindButton.frame = CGRectMake(_carNumL.left-175, _recordL.bottom-5, 400, 20);
        reloadOrEnterOrRebindButton.tag = TAG_BUTTON_ACTION_RE_BIND;
    }
    
    

}


#pragma mark - TapAction
- (void)buttonAction:(UIButton*)button
{
    if (button.tag == TAG_BUTTON_ACTION_RE_BIND) {
        if ([self._delegate respondsToSelector:@selector(carView:respondAction:)]) {
            [self._delegate carView:self respondAction:actionRebind];
        }
    }else if (button.tag == TAG_BUTTON_ACTION_ENTER_PECCANCY) {
        
        if ([self.car.peccancyCount isEqualToString:@"0"]) {
            [self showAlertText:@"没有可查看的违法记录"];
            return;
        }
        
        if ([self._delegate respondsToSelector:@selector(carView:respondAction:)]) {
            [self._delegate carView:self respondAction:actionEnterPeccancyRecord];
        }
    }else if (button.tag == TAG_BUTTON_ACTION_RELOAD_PECCANCY) {
        if ([self._delegate respondsToSelector:@selector(carView:respondAction:)]) {
            [self._delegate carView:self respondAction:actionReloadPeccancyRecord];
        }
    }
    
}

- (void)tapCar:(UITapGestureRecognizer*)tap{
    if ([self._delegate respondsToSelector:@selector(carView:tapCar:)]) {
        [self._delegate carView:self tapCar:self.car];
    }
}

- (void)tapBlank:(UITapGestureRecognizer*)tap{
    if ([self._delegate respondsToSelector:@selector(carViewDidTapBlank)]) {
        [self._delegate carViewDidTapBlank];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
