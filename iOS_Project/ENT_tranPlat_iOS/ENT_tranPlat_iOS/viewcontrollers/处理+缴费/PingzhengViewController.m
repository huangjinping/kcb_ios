//
//  PingzhengViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/5/29.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "PingzhengViewController.h"
#import "CustomLabel.h"

@interface PingzhengViewController ()
{
    NSString    *_cljg;
    NSString    *_jdsbh;
    NSString    *_wsjyw;
    NSString    *_dsr;
    NSString    *_jszh;
    
    NSString    *_wfsj;
    NSString    *_wfdz;
    NSString    *_wfnr;
    NSString    *_wfxw;
    NSString    *_wfgd;
    
    NSString    *_fltw;
    NSString    *_fkje;
    NSString    *_znj;
    NSString    *_wfjfs;
    NSString    *_clsj;
    
    NSString    *_cphm;
    NSString    *_hpzl;
    
    
    CustomLabel     *_customL;
    UILabel         *_normalL;
    UIScrollView    *_scrollV;

}
@end

@implementation PingzhengViewController

- (id)initWithCljg:(NSString*)cljg
             jdsbh:(NSString*)jdsbh
             wsjyw:(NSString*)wsjyw
               dsr:(NSString*)dsr
              jszh:(NSString*)jszh
              wfsj:(NSString*)wfsj
              wfdz:(NSString*)wfdz
              wfnr:(NSString*)wfnr
              wfxw:(NSString*)wfxw
              wfgd:(NSString*)wfgd
              fltw:(NSString*)fltw
              fkje:(NSString*)fkje
               znj:(NSString*)znj
             wfjfs:(NSString*)wfjfs
              clsj:(NSString*)clsj
              cphm:(NSString*)cphm
           andHpzl:(NSString*)hpzl{
    if (self = [super init]) {
        _cljg = [[NSString alloc] initWithString:cljg];
        _jdsbh = [[NSString alloc] initWithString:jdsbh];
        _wsjyw = [[NSString alloc] initWithString:wsjyw];
        _dsr = [[NSString alloc] initWithString:dsr];
        _jszh = [[NSString alloc] initWithString:jszh];
        
        _wfsj = [[NSString alloc] initWithString:wfsj];
        _wfdz = [[NSString alloc] initWithString:wfdz];
        _wfnr = [[NSString alloc] initWithString:wfnr];
        _wfxw = [[NSString alloc] initWithString:wfxw];
        _wfgd = [[NSString alloc] initWithString:wfgd];
        
        _fltw = [[NSString alloc] initWithString:fltw];
        _fkje = [[NSString alloc] initWithString:fkje];
        _znj = [[NSString alloc] initWithString:znj];
        _wfjfs = [[NSString alloc] initWithString:wfjfs];
        _clsj = [[NSString alloc] initWithString:clsj];
        
        _cphm = [[NSString alloc] initWithString:cphm];
        _hpzl = [[NSString alloc] initWithString:hpzl];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    _scrollV.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollV];

    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 20, APP_PX_WIDTH - 30*2, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentCenter];
    label.text = _cljg;
    [label setSize:[label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.width, 10000)]];
    label.numberOfLines = 0;
    [_scrollV addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, label.b + 20, APP_PX_WIDTH - 30*2, 40)];
    [label convertNewLabelWithFont:SYS_FONT_SIZE(40) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
    label.text = @"公安交通管理简易处罚决定书";
    [_scrollV addSubview:label];
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, label.b + 20, APP_PX_WIDTH - 30*2, 40)];
    [label convertNewLabelWithFont:SYS_FONT_SIZE(40) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
    label.text = @"电  子  凭  证";
    [_scrollV addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, label.b + 30, APP_PX_WIDTH - 30*2, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    label.text = [NSString stringWithFormat:@"编号：%@", [_jdsbh stringByAppendingString:_wsjyw]];
    [_scrollV addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, label.b + 15, APP_PX_WIDTH - 30*2, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    label.text = [NSString stringWithFormat:@"当事人：%@", _dsr];
    [_scrollV addSubview:label];
    
    if ([_jszh hasPrefix:@"53"]) {
        label = [[UILabel alloc] initWithFrame:LGRectMake(30, label.b + 15, APP_PX_WIDTH - 30*2, 30)];
        [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        label.text = [NSString stringWithFormat:@"居民身份证号码：%@", _jszh];
        [_scrollV addSubview:label];
    }
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, label.b + 15, APP_PX_WIDTH - 30*2, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    label.text = [NSString stringWithFormat:@"车牌号码：%@", _cphm];
    [_scrollV addSubview:label];
    
    
    
    NSDictionary *dict = @{@"01":@"大型汽车",@"02":@"小型汽车",@"03":@"使馆汽车",@"04":@"领馆汽车",@"05":@"境外汽车",@"06":@"外籍汽车",@"16":@"教练汽车",@"18":@"试验汽车",@"20":@"临时入境汽车",@"23":@"警用汽车",@"07":@"两、三轮摩托车",@"08":@"轻便摩托车",@"09":@"使馆摩托车",@"10":@"领馆摩托车",@"11":@"境外摩托车",@"12":@"外籍摩托车",@"13":@"农用运输车",@"14":@"拖拉机",@"15":@"挂车",@"17":@"教练摩托车",@"19":@"试验摩托车",@"21":@"临时入境摩托车",@"22":@"临时行驶车",@"24":@"警用摩托",@"25":@"非机动车"};
    NSString *hpzlstr = [dict objectForKey:_hpzl];
    
    _normalL = [[UILabel alloc] initWithFrame:LGRectMake(30, label.b + 15, APP_PX_WIDTH - 30*2, 30)];
    [_normalL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    _normalL.text = [NSString stringWithFormat:@"车辆类型：%@", hpzlstr];
    [_scrollV addSubview:_normalL];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self setCustomNavigationTitle:@"缴费凭证"];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    _customL = [[CustomLabel alloc] initWithFrame:LGRectMake(30, _normalL.b + 40, APP_PX_WIDTH - 30*2, 0)];
    [_customL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    NSString *content = [NSString stringWithFormat:@"    被处罚人所有的机动车于%@，在%@实施%@违法行为（代码%@），违反了%@的规定。根据%@，决定处以：扣%@分，罚款%@元，滞纳金%@元。 （处罚决定书编号：%@）", _wfsj, _wfdz, _wfnr, _wfxw, _wfgd, _fltw, _wfjfs, _fkje, _znj, [_jdsbh stringByAppendingString:_wsjyw]];
    CGSize size = [content sizeWithFont:_customL.font constrainedToSize:CGSizeMake(_customL.width, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    [_customL setSize:CGSizeMake(size.width, size.height)];
    _customL.numberOfLines = 0;
    [_scrollV addSubview:_customL];
    
    content = [NSString stringWithFormat:@"    被处罚人所有的机动车于<font color=\"red\">%@<font color=\"black\">，在<font color=\"red\">%@<font color=\"black\">实施<font color=\"red\">%@<font color=\"black\">违法行为（代码<font color=\"red\">%@<font color=\"black\">），违反了<font color=\"red\">%@<font color=\"black\">的规定。根据<font color=\"red\">%@<font color=\"black\">，决定处以：扣<font color=\"red\">%@<font color=\"black\">分，罚款<font color=\"red\">%@<font color=\"black\">元，滞纳金<font color=\"red\">%@<font color=\"black\">元。 （处罚决定书编号：<font color=\"red\">%@<font color=\"black\">）", _wfsj, _wfdz, _wfnr, _wfxw, _wfgd, _fltw, _wfjfs, _fkje, _znj, [_jdsbh stringByAppendingString:_wsjyw]];
    MarkupParser *p = [[MarkupParser alloc]init];
    NSAttributedString *attString = [p attrStringFromMarkup:content withFontSize:30*PX_X_SCALE andLineSpace:0];
    [_customL setAttString:attString];

    
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, _customL.b + 20, APP_PX_WIDTH - 30*2, 0)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    label.text = @"    持此电子凭证在十五日内到指定银行各营业网点缴纳罚款。逾期不缴纳的，每日按罚款数额的3%加处罚款。";
    [label setSize:[label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.width, 10000)]];
    label.numberOfLines = 0;
    [_scrollV addSubview:label];
    
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(APP_PX_WIDTH - 30 - 300, label.b + 20, 300, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:[UIColor redColor] textAlignment:NSTextAlignmentRight];
    label.text = [NSString stringWithFormat:@"%@", _clsj];
    [_scrollV addSubview:label];

    
    label = [[UILabel alloc] initWithFrame:LGRectMake(APP_PX_WIDTH - 30 - 300 - 150, label.t, 150, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:[UIColor blackColor] textAlignment:NSTextAlignmentRight];
    label.text = @"处理时间：";
    [_scrollV addSubview:label];

    
    
    if (label.bottom > _scrollV.height) {
        [_scrollV setContentSize:CGSizeMake(_scrollV.width, label.bottom)];
    }
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
