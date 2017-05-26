//
//  UsedCarInfoViewController.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/10/30.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "UsedCarInfoViewController.h"

@interface UsedCarInfoViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *mainScorllView;
@property(nonatomic,copy)NSString *string;
@end

@implementation UsedCarInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    CGFloat scrollViewH = APP_HEIGHT - APP_NAV_HEIGHT;
    CGFloat singleLineHeightPX = 30*3;
    _mainScorllView = [[UIScrollView  alloc]initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, scrollViewH)];
    _mainScorllView.backgroundColor=COLOR_FRAME_LINE;
    //关闭弹簧效果
    _mainScorllView.bounces = NO;
    _mainScorllView.delegate = self;
    [self.view addSubview:_mainScorllView];
   
    UIImageView *firstView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y: 0 width:APP_PX_WIDTH height:singleLineHeightPX*4];
    firstView.backgroundColor=[UIColor whiteColor];
    UIImageView *carImage =[[UIImageView alloc]initWithFrame:LGRectMake(10, 40, 160, 160)];
    NSString *urlString = [_dic valueForKey:@"car_logo_url"];

    [carImage setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"home_car_brand_default"]];
    [firstView addSubview:carImage];
    CGFloat firstHeight = 40;
    for (int i = 0; i < 5; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(carImage.w*1.1, i*firstHeight , firstView.w-200, 70)];
        [label convertNewLabelWithFont:SYS_FONT_SIZE(30) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        [firstView addSubview:label];
        NSString *contentStr = @"";
        switch (i) {
            case 0:
                contentStr = [NSString stringWithFormat:@"%@ ", [_dic valueForKey:@"title"]];
                 [label convertNewLabelWithFont:SYS_FONT_SIZE(40) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
                break;
            case 1:
                
       
                
                if([_dic valueForKey:@"discharge_standard"]){
                
                _string=@"未知";
                    
                }else{
               _string=[NSString stringWithFormat:@"%@",[_dic valueForKey:@"discharge_standard"]];
                    
                }
                
                
                contentStr = [NSString stringWithFormat:@"排放标准: %@", _string];
                break;
            case 2:
                contentStr = [NSString stringWithFormat:@"上牌时间: %@", _time];
                break;
            case 3:
                 contentStr = [NSString stringWithFormat:@"行驶里程: %@万公里", _way];
                break;
            case 4:
                contentStr = [NSString stringWithFormat:@"新车指导价格: %@万",[_dic valueForKey:@"price"] ];
                break;
            default:
                break;
        }
        [label setText:contentStr];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(1, firstView.h-140 , firstView.w, 0.5)];
    label.backgroundColor=COLOR_FONT_INFO_SHOW;
    [firstView addSubview:label];
    for(int i=1;i<3;i++){
        UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(firstView.w/3*i, firstView.h-140+10 , 0.5, 140)];
        label.backgroundColor=COLOR_FONT_INFO_SHOW;
    
     [firstView addSubview:label];
    
    }
    UILabel *CLGZ=[[UILabel alloc] initWithFrame:LGRectMake(10, firstView.h-140+20 , firstView.w/3-20, 40)];
    [CLGZ convertNewLabelWithFont:SYS_FONT_SIZE(30) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    CLGZ.text =@"车辆估值";
    
   UILabel *CLGZz=[[UILabel alloc] initWithFrame:LGRectMake(10, firstView.h-140+20+60 , firstView.w/3-20, 40)];
    [CLGZz convertNewLabelWithFont:SYS_FONT_SIZE(40) textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    NSString *clstring=[NSString stringWithFormat:@"%@万",[_dic valueForKey:@"eval_price"]];
    CLGZz.text=clstring;
    [firstView addSubview:CLGZz];
    
    
    //
    
    UILabel *CSSGJ=[[UILabel alloc] initWithFrame:LGRectMake(10+firstView.w/3, firstView.h-140+20 , firstView.w/3-20, 40)];
    [CSSGJ convertNewLabelWithFont:SYS_FONT_SIZE(30) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    CSSGJ.text =@"车商收购价";
    
    UILabel *  cssgj=[[UILabel alloc] initWithFrame:LGRectMake(10+firstView.w/3, firstView.h-140+20+60 , firstView.w/3-20, 40)];
    NSString *csstring=[NSString stringWithFormat:@"%@万",[_dic valueForKey:@"good_price"]];
    [cssgj convertNewLabelWithFont:SYS_FONT_SIZE(40) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    cssgj.text=csstring;
    
    [firstView addSubview:cssgj];
    //
    UILabel *GRJYJ=[[UILabel alloc] initWithFrame:LGRectMake(10+firstView.w/3*2, firstView.h-140+20 , firstView.w/3-20, 40)];
    [GRJYJ convertNewLabelWithFont:SYS_FONT_SIZE(30) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    GRJYJ.text =@"个人交易价";
    
    
   UILabel *gr=[[UILabel alloc] initWithFrame:LGRectMake(10+firstView.w/3*2, firstView.h-140+20+60 , firstView.w/3*2-20, 40)];
    NSString *grstring=[NSString stringWithFormat:@"%@万",[_dic valueForKey:@"individual_price"]];
    [gr convertNewLabelWithFont:SYS_FONT_SIZE(40) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    gr.text=grstring;
    
    [firstView addSubview:gr];
    [firstView addSubview:CLGZ];
    [firstView addSubview:CSSGJ];
    [firstView addSubview:GRJYJ];
    
    [_mainScorllView addSubview:firstView];
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"二手车"];
    

    
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
