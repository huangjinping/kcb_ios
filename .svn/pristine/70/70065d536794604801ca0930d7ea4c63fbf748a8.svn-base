//
//  ZijiayouBuyVIPCardViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/6.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "ZijiayouBuyVIPCardViewController.h"

@interface ZijiayouBuyVIPCardViewController ()<
UITextFieldDelegate
>
{
    UITextField     *_shrTF;
    UITextField     *_sjhTF;
    UITextField     *_szdqTF;
    UITextField     *_xxdzF;
    UITextField     *_ybTF;
    
    UIImageView     *_orderFormbgImgView;
    UIScrollView    *_rootScrollView;

}
@end

@implementation ZijiayouBuyVIPCardViewController


#define TAG_TF_SHR          111
#define TAG_TF_SJH          112
#define TAG_TF_SZDQ         113
#define TAG_TF_XXDZF        114
#define TAG_TF_YBTF         115

- (void)keyboardWillChangeFrame:(NSNotification*)notify{
    NSDictionary *infoDict = [notify userInfo];
    CGRect frame = [[infoDict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat bottomY = 0;
    CGFloat space = 30*PX_X_SCALE;
    if ([_shrTF isFirstResponder]) {
        bottomY = _shrTF.bottom + _orderFormbgImgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
    }else if ([_sjhTF isFirstResponder]) {
        bottomY = _sjhTF.bottom + _orderFormbgImgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
    }else if ([_szdqTF isFirstResponder]) {
        bottomY = _szdqTF.bottom + _orderFormbgImgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
    }else if ([_xxdzF isFirstResponder]) {
        bottomY = _xxdzF.bottom + _orderFormbgImgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
    }else if ([_ybTF isFirstResponder]) {
        bottomY = _ybTF.bottom + _orderFormbgImgView.top + space + _rootScrollView.top - _rootScrollView.contentOffset.y;
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

    CGFloat buttonBgHeight = 60 + 20 + 20;
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - buttonBgHeight*PX_Y_SCALE)];
    _rootScrollView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_rootScrollView];

    
    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, APP_WIDTH - 15*2, 0)];
    [desLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    desLabel.numberOfLines = 0;
    [desLabel setText:self.card.des];
    [desLabel setSize:[desLabel.text sizeWithFont:desLabel.font constrainedToSize:CGSizeMake(desLabel.width, 1000)]];
    UIImageView *desBgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:30 width:APP_PX_WIDTH height:desLabel.b + 30];
    [_rootScrollView addSubview:desBgView];
    [desBgView addSubview:desLabel];
    
    
    CGFloat singleLineHeightPX = 30*3;
    _orderFormbgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:desBgView.b + 30 width:APP_PX_WIDTH height:singleLineHeightPX*5];
    [_rootScrollView addSubview:_orderFormbgImgView];
    
    //*********************************横线*********************************
    UILabel *lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_orderFormbgImgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 2 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_orderFormbgImgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 3 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_orderFormbgImgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 4 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_orderFormbgImgView addSubview:lineLabel];
    //*********************************收货人*********************************
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"收货人";
    CGSize size = [@"最长四字" sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, 30)];
    label.size = size;
    [_orderFormbgImgView addSubview:label];
    
    _shrTF = [[UITextField alloc] initWithFrame:CGRectMake(label.right + 15, label.top, _orderFormbgImgView.width - (label.right + 15), label.height + 5)];
    _shrTF.delegate = self;
    _shrTF.tag = TAG_TF_SHR;
    [_shrTF setFont:FONT_NOMAL];
    [_shrTF setBorderStyle:UITextBorderStyleNone];
    [_shrTF setPlaceholder:@"请填写收货人姓名"];
    [_orderFormbgImgView addSubview:_shrTF];
    //*********************************手机号*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"手机号";
    label.size = size;
    [_orderFormbgImgView addSubview:label];
    _sjhTF = [[UITextField alloc] initWithFrame:CGRectMake(label.right + 15, label.top, _orderFormbgImgView.width - (label.right + 15), label.height + 5)];
    _sjhTF.delegate = self;
    _sjhTF.tag = TAG_TF_SHR;
    [_sjhTF setFont:FONT_NOMAL];
    [_sjhTF setBorderStyle:UITextBorderStyleNone];
    [_sjhTF setPlaceholder:@"请填写联系人手机号码"];
    [_orderFormbgImgView addSubview:_sjhTF];
    //*********************************手机号*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*2 + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"所在地区";
    label.size = size;
    [_orderFormbgImgView addSubview:label];
    _szdqTF = [[UITextField alloc] initWithFrame:CGRectMake(label.right + 15, label.top, _orderFormbgImgView.width - (label.right + 15), label.height + 5)];
    _szdqTF.delegate = self;
    _szdqTF.tag = TAG_TF_SHR;
    [_szdqTF setFont:FONT_NOMAL];
    [_szdqTF setBorderStyle:UITextBorderStyleNone];
    [_szdqTF setPlaceholder:@"请填写所在地区（省、市）"];
    [_orderFormbgImgView addSubview:_szdqTF];
    //*********************************手机号*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*3 + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"详细地址";
    label.size = size;
    [_orderFormbgImgView addSubview:label];
    _xxdzF = [[UITextField alloc] initWithFrame:CGRectMake(label.right + 15, label.top, _orderFormbgImgView.width - (label.right + 15), label.height + 5)];
    _xxdzF.delegate = self;
    _xxdzF.tag = TAG_TF_SHR;
    [_xxdzF setFont:FONT_NOMAL];
    [_xxdzF setBorderStyle:UITextBorderStyleNone];
    [_xxdzF setPlaceholder:@"请填写详细地址（区、街道、门牌号）"];
    [_orderFormbgImgView addSubview:_xxdzF];
    //*********************************手机号*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*4 + 30, 100, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"邮编";
    label.size = size;
    [_orderFormbgImgView addSubview:label];
    _ybTF = [[UITextField alloc] initWithFrame:CGRectMake(label.right + 15, label.top, _orderFormbgImgView.width - (label.right + 15), label.height + 5)];
    _ybTF.delegate = self;
    _ybTF.tag = TAG_TF_SHR;
    [_ybTF setFont:FONT_NOMAL];
    [_ybTF setBorderStyle:UITextBorderStyleNone];
    [_ybTF setPlaceholder:@"请填写邮政编码"];
    [_orderFormbgImgView addSubview:_ybTF];
    [_rootScrollView setContentSize:CGSizeMake(_rootScrollView.width, _orderFormbgImgView.bottom + 15)];

    
    UIView *buttonBgView = [[UIView alloc] initWithFrame:BGRectMake(0, _rootScrollView.b, APP_PX_WIDTH, buttonBgHeight)];
    buttonBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonBgView];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(0, 0)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH)*PX_X_SCALE, lineLabel.height)];
    [buttonBgView addSubview:lineLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = LGRectMake(30, 15, buttonBgView.w - 30*2, buttonBgView.h - 15*2);
    [button setTitle:@"立即预定" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_NOMAL;
    [button addTarget:self action:@selector(submitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    [buttonBgView addSubview:button];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"填写订单"];

}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}



- (void)submitButtonClicked{

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
