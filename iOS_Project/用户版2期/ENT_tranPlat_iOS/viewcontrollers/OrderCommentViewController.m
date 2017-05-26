//
//  OrderCommentViewController.m
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/1/29.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "OrderCommentViewController.h"
#import "CWStarRateView.h"
#import "UILabel+Custom.h"
#import "InputTextView.h"
#import "CommentView.h"

@interface OrderCommentViewController ()

@property (nonatomic, strong) UIButton *footerView;

@end

@implementation OrderCommentViewController
{
    CWStarRateView *_starV;
    InputTextView *_inputView;
    CommentView *_cv;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"评价"];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self configUI];
}

- (void)configUI{
    self.view.backgroundColor = kWhiteColor;
    UILabel *outName = [[UILabel alloc]initWithFrame:CGRectMake(30*x_6_plus, APP_VIEW_Y + 40*y_6_plus, 180*x_6_plus, 50*y_6_plus)
                                                text:@"门店评价"
                                                font:V3_38PX_FONT
                                           textColor:kTextGrayColor];
    _starV = [[CWStarRateView alloc]initWithFrame:CGRectMake(outName.right+60*x_6_plus, 0, 360*x_6_plus, 50*y_6_plus) numberOfStars:5];
    _starV.centerY = outName.centerY;
    [self.view addLineWithFrame:CGRectMake(40*x_6_plus, outName.bottom+40*y_6_plus, self.view.width-80*x_6_plus, 1) lineColor:kLineGrayColor];
    
    _cv = [CommentView shareCommentView];
    _cv.origin = CGPointMake(outName.x, outName.bottom+40*y_6_plus);
    
    [self.view addLineWithFrame:CGRectMake(40*x_6_plus, _cv.bottom, self.view.width-80*x_6_plus, 1) lineColor:kLineGrayColor];
    
    UILabel *describtion = [[UILabel alloc]initWithFrame:CGRectMake(20*x_6_plus, _cv.bottom + 40*y_6_plus, 180*x_6_plus, 50*y_6_plus)
                                                text:@"评价描述"
                                                font:V3_38PX_FONT
                                           textColor:kTextGrayColor];
    
    _inputView = [[InputTextView alloc] initWithFrame:CGRectMake(_starV.x, describtion.y, 748*x_6_plus, 436*y_6_plus)];
    _inputView.placeholder = @"您对服务满意吗？可留言评价";
    _inputView.textViewMaxLength = 150;
    
    [self.view addSubview:outName];
    [self.view addSubview:_cv];
    [self.view addSubview:describtion];
    [self.view addSubview:_starV];
    [self.view addSubview:_inputView];
    [self.view addSubview:self.footerView];
}

- (UIButton *)footerView{
    if (_footerView) {
        return _footerView;
    }
    _footerView = [UIButton buttonWithType:UIButtonTypeCustom];
    _footerView.frame = CGRectMake(0, self.view.height-136*y_6_plus, APP_WIDTH, 136*y_6_plus);
    _footerView.backgroundColor = COLOR_NAV;
    [_footerView setTitle:@"提交评价"];
    [_footerView setTitleColor:kWhiteColor];
    __block __typeof(self)weakSelf = self;
    
    [_footerView addActionBlock:^(id weakSender) {
        
//        NSInteger n = (int)floorf(_starV.scorePercent*5);
//        NSInteger a = _cv.index;
//        NSLog(@"%d ,%d",n,a);
        [[NetworkEngine sharedNetwork] postBody:@{@"orderId":_orderId,@"type":[NSString stringWithFormat:@"%ld",(long)_cv.index],@"level":[NSString stringWithFormat:@"%d",(int)floorf(_starV.scorePercent*5)],@"text":_inputView.inputView.text,@"userName":APP_DELEGATE.userName} apiPath:kOrderWattingForComment hasHeader:YES finish:^(ResultState state, id resObj) {
            if (state == StateSucceed) {
                if (_commplete) {
                    _commplete();
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        } failed:^(NSError *error) {
            
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    return _footerView;
}

@end
