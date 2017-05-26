

//
//  FilterView.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/4.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "FilterView.h"

@interface FilterView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation FilterView
{
    UIView *_backGroundView;
    UIView *_popView;
    
    UILabel *_titleLabel;
    UIButton *_selectBtn;
    
    UIControl *_control;
}

+ (FilterView *)shareFilterView{
    FilterView *fv = [[self alloc]init];
    
    return fv;
}

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
    if (self) {
        [self configUI];
    }
    
    return self;
}

- (void)configUI{
    _backGroundView = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
    _backGroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7f];
    [self addSubview:_backGroundView];
    
    _control = [[UIControl alloc]initWithFrame:self.frame];
    [_control addTarget:self
                 action:@selector(dismissView)
       forControlEvents:UIControlEventTouchUpInside];
    [_backGroundView addSubview:_control];
    
    [self initPopView];
    [self initText];
}

- (void)initPopView{
    _popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 290*x_6_SCALE, (180+44*2)*y_6_SCALE)];
    _popView.backgroundColor = [UIColor whiteColor];
    _popView.layer.masksToBounds = YES;
    _popView.layer.cornerRadius = 10;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, _popView.width, _popView.height-44*2)];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
//    [_popView addSubview:_tableView];
    [_backGroundView addSubview:_popView];
}

- (void)initText{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _popView.width, 44)];
    _titleLabel.backgroundColor = [UIColor colorWithHex:0x0e1a00];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = kWhiteColor;
    [_popView addSubview:_titleLabel];
    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectBtn.frame = CGRectMake(0, _popView.height-44, _popView.width, 44);
    [_selectBtn setTitle:@"我选好了" forState:UIControlStateNormal];
    [_selectBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [_selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _selectBtn.backgroundColor = COLOR_NAV;
    [_popView addSubview:_selectBtn];
}

- (void)setFilterType:(FilterType)filterType{
    _filterType = filterType;
    switch (filterType) {
        case FilterOnDistance:
            _titleLabel.text = @"按距离查询";
            break;
            
         case FilterOnService:
            _titleLabel.text = @"按服务查询";
            break;
            
        case FilterOnPopularity:
            _titleLabel.text = @"按人气查询";
            break;
        default:
            break;
    }
}

#pragma mark - event method

- (void)confirm{
 
    [self dismissView];
}

- (void)dismissView{
    [self dismissCompletion:nil];
}

- (void)dismissCompletion:(void (^)(void))completion
{
    [UIView animateWithDuration:0.15
                     animations:^{
                         self.alpha = 0;
                     } completion:^(BOOL finished) {
                         if (completion) {
                             completion();
                         }
                      
                         [self removeFromSuperview];
                     }];
}

- (void)showWithView:(UIView *)view{
    [view addSubview:self];
    
    _popView.center = self.boundsCenter;
    _popView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:0.25
                     animations:^{
                         _popView.transform = CGAffineTransformIdentity;
                     }];
    
}

@end
