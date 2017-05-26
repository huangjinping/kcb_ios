//
//  FiltViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/5/5.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "FiltViewController.h"

@interface FiltViewController ()
{
    NSMutableArray      *_hphms;
    NSMutableArray      *_dates;
    
    UIImageView             *_carBgImgView;
    UIImageView             *_dateBgImgView;

    NSMutableArray          *_carImgViews;
    NSMutableArray          *_dateImgViews;
}


@property (nonatomic, retain)   NSArray     *condition_hphm;
@property (nonatomic, retain)   NSString     *condition_date;
@end

@implementation FiltViewController

- (id)initWithChosenHphm:(NSArray*)hphms chosenDate:(NSString*)date andHphmDatasource:(NSArray*)hphmDatasource{
    if (self = [super init]) {
        if (hphms) {
            self.condition_hphm = [NSArray arrayWithArray:hphms];
        }
        if (date) {
            self.condition_date = [NSString stringWithString:date];
        }
        _hphms = [[NSMutableArray alloc] initWithCapacity:0];
        [_hphms addObjectsFromArray:hphmDatasource];
        
    }
    
    return self;
}
#define TAG_HPHM_LINE0        301
#define TAG_DATE_LINE0        401

- (void)viewDidLoad {
    [super viewDidLoad];
    _carImgViews = [[NSMutableArray alloc] initWithCapacity:0];
    _dateImgViews = [[NSMutableArray alloc] initWithCapacity:0];
    _dates = [[NSMutableArray alloc] initWithObjects:@"30天以内", @"三个月以内", @"三个月之前", nil];
    
    CGFloat singleLineHeight = 30*3;
    
    UILabel *topL = [[UILabel alloc] initWithFrame:LGRectMake(30, APP_VIEW_Y/PX_X_SCALE + 30, APP_PX_WIDTH - 30*2, 30)];
    [topL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    topL.text = @"筛选车辆";
    [self.view addSubview:topL];
    _carBgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:topL.b + 20   width:APP_PX_WIDTH height:singleLineHeight*_hphms.count];
    [self.view addSubview:_carBgImgView];
    for (int i = 0; i < _hphms.count; i ++) {
        NSString *hphm = [_hphms objectAtIndex:i];
        if (i != 0) {
            UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(0, singleLineHeight*i - 1)];
            [_carBgImgView addSubview:lineL];
        }
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeight*i + 30, 200, 30)];
        [leftLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        [leftLabel setText:[hphm uppercaseString]];
        [_carBgImgView addSubview:leftLabel];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:LGRectMake(APP_PX_WIDTH - 30 - 30, leftLabel.t, 30, 30)];
        [imgV setImage:[UIImage imageNamed:@"duihao_green"]];
        imgV.tag = TAG_HPHM_LINE0 + i;
        imgV.hidden = YES;
        [_carBgImgView addSubview:imgV];
        [_carImgViews addObject:imgV];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:LGRectMake(30, singleLineHeight*i, APP_PX_WIDTH, singleLineHeight)];
        [btn setBackgroundColor:[UIColor clearColor]];
        btn.tag = TAG_HPHM_LINE0 + i;
        [btn addTarget:self action:@selector(buttonCarClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_carBgImgView addSubview:btn];
        
        for (NSString *conditionhphm in _condition_hphm) {
            if ([conditionhphm isEqualToString:hphm]) {
                btn.selected = YES;
                imgV.hidden = NO;
            }else{
                btn.selected = NO;
                imgV.hidden = YES;
            }
        }
        
    }
    
    topL = [[UILabel alloc] initWithFrame:LGRectMake(30, _carBgImgView.b + 30, APP_PX_WIDTH - 30*2, 30)];
    [topL convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    topL.text = @"筛选时间";
    [self.view addSubview:topL];
    _dateBgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:topL.b + 20   width:APP_PX_WIDTH height:singleLineHeight*_dates.count];
    [self.view addSubview:_dateBgImgView];
    for (int i = 0; i < _dates.count; i ++) {
        NSString *dateString = [_dates objectAtIndex:i];
        if (i != 0) {
            UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(0, singleLineHeight*i - 1)];
            [_dateBgImgView addSubview:lineL];
            
        }
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeight*i + 30, 200, 30)];
        [leftLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
        [leftLabel setText:dateString];
        [_dateBgImgView addSubview:leftLabel];
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:LGRectMake(APP_PX_WIDTH - 30 - 30, leftLabel.t, 30, 30)];
        [imgV setImage:[UIImage imageNamed:@"duihao_green"]];
        imgV.hidden = YES;
        imgV.tag = TAG_DATE_LINE0 + i;
        [_dateBgImgView addSubview:imgV];
        [_dateImgViews addObject:imgV];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:LGRectMake(30, singleLineHeight*i, APP_PX_WIDTH, singleLineHeight)];
        [btn setBackgroundColor:[UIColor clearColor]];
        btn.tag = TAG_DATE_LINE0 + i;
        [btn addTarget:self action:@selector(buttonDateClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_dateBgImgView addSubview:btn];
        
//        NSString *conditionDateStr = @"";
//        if (_condition_date) {
//            NSDate *date = [_condition_date convertToDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
//            NSTimeInterval interval = -[date timeIntervalSinceNow];
//            if (interval < 30*24*60*60) {//30天以内
//                conditionDateStr = @"30天以内";
//            }else if (interval < 3*30*24*60*60){
//                conditionDateStr = @"三个月以内";
//            }else{
//                conditionDateStr = @"三个月之前";
//            }
//        }
        
        if ([dateString isEqualToString:_condition_date]) {
            btn.selected = YES;
            imgV.hidden = NO;
        }else{
            btn.selected = NO;
            imgV.hidden = YES;
        }
        
    }
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setCustomNavigationTitle:@"筛选条件"];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton setBackgroundColor:[UIColor clearColor]];
    [doneButton.titleLabel setFont:FONT_NOMAL];
    [doneButton setFrame:LGRectMake(_navigationImgView.w - 100, (_navigationImgView.h - 30)/2, 60, 30)];
    [doneButton addTarget:self action:@selector(doneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_navigationImgView addSubview:doneButton];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (void)doneButtonClicked{
    NSMutableArray *hphmSeletedArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (UIView *v in _carBgImgView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *b = (UIButton*)v;
            if (b.selected) {
                [hphmSeletedArr addObject:[_hphms objectAtIndex:(b.tag - TAG_HPHM_LINE0)]];
            }
        }
    }
    NSString *dateS = @"";
    for (UIView *v in _dateBgImgView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *b = (UIButton*)v;
            if (b.selected) {
                dateS = [_dates objectAtIndex:(b.tag - TAG_DATE_LINE0)];
                break;
            }
        }
    }
    if ([self.delegate_ respondsToSelector:@selector(filtViewController:chooseHphm:andDate:)]) {
        [self.delegate_ filtViewController:self chooseHphm:hphmSeletedArr andDate:dateS];
    }
    [self gobackPage];
}

- (void)buttonCarClicked:(UIButton*)button{
    button.selected = !button.selected;
    for (UIImageView *imgv in _carImgViews) {
        if (imgv.tag == button.tag) {
            if (button.selected) {
                imgv.hidden = NO;
            }else{
                imgv.hidden = YES;
            }
        }
    }
}

- (void)buttonDateClicked:(UIButton*)button{
    button.selected = !button.selected;
    for (UIImageView *imgv in _dateImgViews) {
        if (imgv.tag == button.tag) {
            if (button.selected) {
                imgv.hidden = NO;
            }else{
                imgv.hidden = YES;
            }
        }
    }
    
    for (UIView *v in _dateBgImgView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            if (((UIButton*)v).tag != button.tag) {
                ((UIButton*)v).selected = NO;
                for (UIImageView *imgv in _dateImgViews) {
                    if (imgv.tag == ((UIButton*)v).tag) {
                        imgv.hidden = YES;
                    }
                }
            }
        }
    }
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
