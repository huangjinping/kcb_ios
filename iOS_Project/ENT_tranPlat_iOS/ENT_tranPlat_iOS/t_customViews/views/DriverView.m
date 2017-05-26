//
//  DriverView.m
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-7-28.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "DriverView.h"


@implementation DriverView

+ (DriverView *)shareInstance
{
    static DriverView *__singletion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __singletion=[[self alloc] initWithFrame:CGRectMake(0, 0, 300, 160)];
    });
    return __singletion;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(driverTap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (id)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)loadData:(DriverInfo *)driver
{
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    if (driver) {
        self.driver = driver;
        
        [self loadDriverView];
        
    }else{
        
        [self loadAddView];
    }
}

- (void)loadDriverView
{
    //判断是否需要显示
    
    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(38, 15, 120, 50)];
    nameL.textColor = [UIColor whiteColor];
    nameL.font = [UIFont systemFontOfSize:22];
    nameL.backgroundColor = [UIColor clearColor];
    nameL.textAlignment = NSTextAlignmentLeft;
    [self addSubview:nameL];
    
    UILabel *statusL = [[UILabel alloc] initWithFrame:CGRectMake(nameL.right, 20, 100, 20)];
    statusL.userInteractionEnabled = YES;
    statusL.textColor = [UIHelper getColor:@"#a5d7ff"];
    statusL.font = [UIFont systemFontOfSize:14];
    statusL.backgroundColor = [UIColor clearColor];
    [self addSubview:statusL];

    
    UILabel *nsL = [[UILabel alloc] initWithFrame:CGRectMake(statusL.left, statusL.bottom, 300, 20)];
    nsL.textColor = [UIColor whiteColor];
    nsL.font = [UIFont systemFontOfSize:14];
    nsL.backgroundColor = [UIColor clearColor];
    [self addSubview:nsL];
    
    UILabel *sfzhmL = [[UILabel alloc] initWithFrame:CGRectMake(statusL.left, nsL.bottom, 300, 20)];
    sfzhmL.textColor = [UIColor whiteColor];
    sfzhmL.font = [UIFont systemFontOfSize:14];
    sfzhmL.backgroundColor = [UIColor clearColor];
    [self addSubview:sfzhmL];
    
    UIImageView *lineV = [[UIImageView alloc] initWithFrame:CGRectMake(20, self.height/2+10, 260, 1)];
    lineV.backgroundColor = [UIHelper getColor:@"#73acdb"];
    [self addSubview:lineV];

    UILabel *wfjlL = [[UILabel alloc] initWithFrame:CGRectMake(nameL.left, lineV.bottom+20, 300, 20)];
    wfjlL.textColor = [UIColor whiteColor];
    wfjlL.font = [UIFont systemFontOfSize:15];
    wfjlL.backgroundColor = [UIColor clearColor];
    [self addSubview:wfjlL];
    
    UIButton *checkB = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkB setFrame:CGRectMake(0, wfjlL.bottom-5, 150, 30)];
    [checkB setTitleColor:[UIHelper getColor:@"#a5d7ff"] forState:UIControlStateNormal];
    checkB.titleLabel.font = [UIFont systemFontOfSize:16];
    [checkB addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:checkB];

    
    NSRange range = [self.driver.driverstatus rangeOfString:@"成功"];
    if (range.location != NSNotFound) {
        
        lineV.hidden = NO;
        //验证成功
        nameL.text = self.driver.xm;
        statusL.text = @"[绑定成功]";
        //-身份证号码显示
        NSString *str1 = [self.driver.driversfzmhm substringToIndex:6];
        NSString *str2 = @"";
        if (self.driver.driversfzmhm.length == 15) {
            str2 = [self.driver.driversfzmhm substringFromIndex:11];
        } else {
            str2 = [self.driver.driversfzmhm substringFromIndex:14];
        }
        sfzhmL.text = [NSString stringWithFormat:@"%@********%@",str1,str2];
//        NSTimeInterval timeInterval = [[self.driver.yxqz date] timeIntervalSinceNow];
        NSTimeInterval timeInterval = [[self.driver.yxqz convertToDateWithFormat:@"yyyy-MM-dd"] timeIntervalSinceDate:[NSDate date]];
        NSInteger days = timeInterval/24/60/60;
        nsL.text = [NSString stringWithFormat:@"距驾驶证年审    天"];
        
        UILabel *dayL = [[UILabel alloc] initWithFrame:CGRectMake(243, nsL.top, 50, nsL.height)];
        dayL.text = [NSString stringWithFormat:@" %d ",days];
        dayL.textAlignment = NSTextAlignmentLeft;
        dayL.textColor = [UIHelper getColor:@"#ff8d1b"];
        dayL.font = [UIFont systemFontOfSize:14];
        dayL.backgroundColor = [UIColor clearColor];
        //判断日期是否过期
        if (days<0) {
            
            nsL.text = [NSString stringWithFormat:@"距驾驶证年审     天"];
            dayL.text = @" -- ";
        } else if (days>9 && days<100){
            nsL.text = [NSString stringWithFormat:@"距驾驶证年审      天"];
            dayL.text = [NSString stringWithFormat:@" %d ",days];
        } else if (days>99){
            nsL.text = [NSString stringWithFormat:@"距驾驶证年审        天"];
            dayL.text = [NSString stringWithFormat:@" %d ",days];
        }
        
        [self addSubview:dayL];
        
        
        if (self.driver.loadingPeccancyRecordStatus == isloadingPeccancyRecord) {
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(30, 0, 20, 20)];
            [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
            [indicator startAnimating];
            wfjlL.text = @"共有     条违法记录";
            [wfjlL addSubview:indicator];
            
            checkB.hidden = YES;
        }else if (self.driver.loadingPeccancyRecordStatus == loadingPeccancyRecordFailed){
            wfjlL.text = @"驾驶证违法记录加载失败";
            
            [checkB setTitle:@"[重新加载]" forState:UIControlStateNormal];
            checkB.tag = TAG_BUTTON_ACTION_RELOAD_PECCANCY;
        }else if (self.driver.loadingPeccancyRecordStatus == loadingPeccancyRecordSucc){
            
//            wfjlL.text = [NSString stringWithFormat:@"共有%@条违法记录", self.driver.peccancyCount];
            wfjlL.text = [NSString stringWithFormat:@"共有     条违法记录"];
            
            UILabel *listL = [[UILabel alloc] initWithFrame:CGRectMake(60, wfjlL.top, 40, wfjlL.height)];
            listL.text = self.driver.peccancyCount;
            listL.backgroundColor = [UIColor clearColor];
            listL.textColor = [UIHelper getColor:@"#ff8d1b"];
            listL.font = [UIFont systemFontOfSize:20];
            listL.textAlignment = NSTextAlignmentCenter;
            [self addSubview:listL];
            
            [checkB setTitle:@"[点击查看]" forState:UIControlStateNormal];
            checkB.tag = TAG_BUTTON_ACTION_ENTER_PECCANCY;
        }

        
        

    } else {
        //验证失败
        lineV.hidden = YES;
        wfjlL.frame = CGRectMake(20, self.height/2, 300, 20);
        wfjlL.text = self.driver.driverstatus;
        nameL.text = @"驾驶证绑定失败";
        nameL.frame = CGRectMake(20, wfjlL.top-50, 200, 50);
        [checkB setTitle:@"[重新绑定]" forState:UIControlStateNormal];
        checkB.frame = CGRectMake(10, wfjlL.bottom-5, 100, 30);
        checkB.tag = TAG_BUTTON_ACTION_RE_BIND;
    }
}


- (void)loadAddView
{
    //添加单机手势
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapForAdd:)];
    [imageView addGestureRecognizer:tap];
    [self addSubview:imageView];
    
    UIImageView *addView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 40, 30, 30)];
    addView.image = [UIImage imageNamed:@"picchoose.png"];
    addView.alpha = 0.4;
    [self addSubview:addView];
    
    
    UILabel *driverLabel = [[UILabel alloc] initWithFrame:CGRectMake(addView.right+5, 40, 125, 30)];
    driverLabel.text = @"驾驶证绑定";
    driverLabel.textColor = [UIColor whiteColor];
    driverLabel.font = [UIFont systemFontOfSize:18];
    driverLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:driverLabel];
    
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(addView.left-50, addView.bottom+5, 243, 50)];
    titleLabel2.text = @"成功绑定驾驶证后，可获得驾驶证违法信息、年审提醒等提示。";
    titleLabel2.font = [UIFont systemFontOfSize:13];
    titleLabel2.backgroundColor = [UIColor clearColor];
    titleLabel2.textColor = [UIColor whiteColor];
    titleLabel2.textAlignment = NSTextAlignmentLeft;
    titleLabel2.numberOfLines = 0;
    [self addSubview:titleLabel2];


}


- (void)buttonAction:(UIButton*)button{
    if (button.tag == TAG_BUTTON_ACTION_RE_BIND) {
        if ([self._delegate respondsToSelector:@selector(driverView:driver:didRespondAction:)]) {
            [self._delegate driverView:self driver:self.driver didRespondAction:actionRebind];
        }
        
    }else if (button.tag == TAG_BUTTON_ACTION_RELOAD_PECCANCY){
        
        if ([self._delegate respondsToSelector:@selector(driverView:driver:didRespondAction:)]) {
            [self._delegate driverView:self driver:self.driver didRespondAction:actionReloadPeccancyRecord];
        }
        
    }else if (button.tag == TAG_BUTTON_ACTION_ENTER_PECCANCY){
        
        if([self.driver.peccancyCount integerValue] == 0){
            [self showAlertText:@"没有可查看的违法记录"];
            return;
        }
        
        if ([self._delegate respondsToSelector:@selector(driverView:driver:didRespondAction:)]) {
            [self._delegate driverView:self driver:self.driver didRespondAction:actionEnterPeccancyRecord];
        }

    }
}

- (void)tapForAdd:(UITapGestureRecognizer*)tap{
    if ([self._delegate respondsToSelector:@selector(driverViewDidTapForAdd)]) {
        [self._delegate driverViewDidTapForAdd];
    }
}

- (void)driverTap:(UIGestureRecognizer*)tap{
    if ([self._delegate respondsToSelector:@selector(driverView:didTapDriver:)]) {
        [self._delegate driverView:self didTapDriver:self.driver];
    }
}


//- (void)buttonAction:(UIButton*)button{
//    if (button.tag == TAG_BUTTON_ACTION_RE_BIND) {
//        if ([self._delegate respondsToSelector:@selector(didRespondAction:)]) {
//            [self._delegate didRespondAction:actionRebind];
//        }
//        
//    }else if (button.tag == TAG_BUTTON_ACTION_RELOAD_PECCANCY){
//        
//        if ([self._delegate respondsToSelector:@selector(didRespondAction:)]) {
//            [self._delegate didRespondAction:actionReloadPeccancyRecord];
//        }
//        
//    }else if (button.tag == TAG_BUTTON_ACTION_ENTER_PECCANCY){
//        
//        if([self.driver.peccancyCount integerValue] == 0){
//            [self showAlertText:@"没有可查看的违法记录"];
//            return;
//        }
//        
//        if ([self._delegate respondsToSelector:@selector(didRespondAction:)]) {
//            [self._delegate didRespondAction:actionEnterPeccancyRecord];
//        }
//        
//    }
//}
//
//- (void)tapForAdd:(UITapGestureRecognizer*)tap{
//    if ([self._delegate respondsToSelector:@selector(driverViewAdd)]) {
//        [self._delegate driverViewAdd];
//    }
//}
//
//- (void)driverTap:(UIGestureRecognizer*)tap{
//    if ([self._delegate respondsToSelector:@selector(didTap:)]) {
//        [self._delegate didTap:self.driver];
//    }
//}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
