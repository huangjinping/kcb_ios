//
//  CarManagerViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-1.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "CarManagerViewController.h"
#import "CarBindViewController.h"
#import "CarInfoViewController.h"

@interface CarManagerViewController ()

@end

@implementation CarManagerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)addBlankviewOnView:(UIView*)v{
    UIImageView *carBindView = [[UIImageView alloc] initWithFrame:LGRectMake((v.w - 339)/2, (v.h - 45)/2, 339, 45)];
    carBindView.image = [UIImage imageNamed:@"add_car"];
    carBindView.userInteractionEnabled = YES;
    [v addSubview:carBindView];
    
    UILabel *l = [[UILabel alloc] initWithFrame:LGRectMake(30, v.h + 5, APP_PX_WIDTH - 30,30)];
    [l convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    l.numberOfLines = 0;
    l.text = @"添加车辆后可查看违法、年检、保险等信息";
    [v addSubview:l];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToAddcar)];
    [v addGestureRecognizer:tap];
}

- (void)addCar:(CarInfo*)car carIndex:(NSInteger)index onView:(UIView*)v{
    
    UIImageView *imgVv = [[UIImageView alloc] initWithFrame:LGRectMake(30, 30, 140, 140)];
    UIImage *img = [[UIImage imageNamed:@"home_car_brand_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
    [imgVv setImage:img];
    [v addSubview:imgVv];
    UIImageView *carLogoView = [[UIImageView alloc] initWithFrame:LGRectMake((imgVv.w - 100*250/200)/2, (imgVv.h - 100)/2, 100*250/200, 100)];
    [imgVv addSubview:carLogoView];
    NSString *urlstr = [NSString stringWithFormat:@"http://idc.pic-01.956122.com/allPic/CarLogo/%@.jpg", [[car.clsbdh substringToIndex:3] uppercaseString]];
    [carLogoView setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageNamed:@"home_car_brand_default"]];
    
    UILabel *carNumL = [[UILabel alloc] initWithFrame:LGRectMake(imgVv.r + 30, 50, 0, 40)];//(50, 20, 130, 30)];
    [carNumL convertNewLabelWithFont:BOLD_FONT_SIZE(30) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    carNumL.text = [car.hphm uppercaseString];
    [carNumL setSize:[carNumL.text sizeWithFont:carNumL.font constrainedToSize:CGSizeMake(1000, carNumL.height)]];
    [v addSubview:carNumL];
    
    UILabel *bangdingL = [[UILabel alloc] initWithFrame:LGRectMake(carNumL.r + 30, carNumL.t + 3, 140, 30)];
    [bangdingL convertNewLabelWithFont:FONT_NOTICE textColor:[UIHelper getColor:@"#72a0c5"] textAlignment:NSTextAlignmentLeft];
    NSRange succRange = [car.vehiclestatus rangeOfString:@"成功"];
    if (succRange.location != NSNotFound) {
        [bangdingL setText:@"[绑定成功]"];
    }else{
        [bangdingL setText:@"[绑定失败]"];
        [bangdingL setTextColor:[UIColor redColor]];
    }
    [v addSubview:bangdingL];
    
    
    UILabel *timeL = [[UILabel alloc] initWithFrame:LGRectMake(carNumL.l, carNumL.b + 20, 500, 40)];//(carNumL.left-20, carNumL.bottom+5, 200, 20)];
    [timeL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    [v addSubview:timeL];
    
    if (succRange.location != NSNotFound) {
        NSTimeInterval timeInterval = [[car.yxqz convertToDateWithFormat:@"yyyy-MM-dd"] timeIntervalSinceDate:[NSDate date]];
        int days = timeInterval/60/60/24;
        if (days < 0) {
            if (iOS6) {
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"年检已到期"];
                [str addAttribute:NSForegroundColorAttributeName value:COLOR_NAV range:NSMakeRange(0, [str length])];
                [timeL setAttributedText:str];
            }else{
                timeL.text = @"年检已到期";
            }
        }else{
            NSString *daysStr = [NSString stringWithFormat:@"%d", days];
            if (days == 0) {
                daysStr = @"--";
            }
            if (iOS6) {
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"距离年检 %@ 天", daysStr]];
                [str addAttribute:NSForegroundColorAttributeName value:COLOR_NAV range:NSMakeRange(5, [daysStr length])];
                [timeL setAttributedText:str];
            }else{
                timeL.text = [NSString stringWithFormat:@"距离年检 %@ 天", daysStr];
            }
        }
    }else{
        
        timeL.text = @"距离年检 - 天";
    }
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b setBackgroundColor:[UIColor clearColor]];
    [b setFrame:v.bounds];
    [v addSubview:b];
    b.tag = index;
    [b addTarget:self action:@selector(tapToCarinfo:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self setCustomNavigationTitle:@"我的车辆"];
    
    NSArray *array = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId];
    self.cars = [[NSMutableArray alloc] initWithArray:array];
    
    for (UIView *v in self.view.subviews) {
        [v removeFromSuperview];
    }
    CGFloat y = APP_VIEW_Y/PX_X_SCALE;
    for (int i = 0; i < [self.cars count]; i ++) {
        CarInfo *car  = [self.cars objectAtIndex:i];
        UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y: y + 30 width:APP_PX_WIDTH height:200];
        y = bgImgView.b;
        [self.view addSubview:bgImgView];
        [self addCar:car carIndex:i onView:bgImgView];
    }
    if ([self.cars count] < 2) {
        UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y: y + 30 width:APP_PX_WIDTH height:200];
        [self.view addSubview:bgImgView];
         y = bgImgView.b;
        [self addBlankviewOnView:bgImgView];
    }
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)tapToAddcar{
    CarBindViewController *carBindVC = [[CarBindViewController alloc] init];
    [self.navigationController pushViewController:carBindVC animated:YES];
}

- (void)tapToCarinfo:(UIButton*)btn{
    CarInfo *carInfo = [self.cars objectAtIndex:btn.tag];
    CarInfoViewController *carInfoVC = [[CarInfoViewController alloc] initWithHphm:carInfo.hphm];
    [self.navigationController pushViewController:carInfoVC animated:YES];
}


//- (void)_initView
//{
//
//    
//    
//    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Action)];
//    [imgV2 addGestureRecognizer:tap2];
//    [self.view addSubview:imgV2];
//    
//    if (self.cars.count == 0) {
//        for (int i=0; i<2; i++) {
//            
//            
//            
//            
//            if (i==0) {
//                [imgV1 addSubview:carBindView];
//                [imgV1 addSubview:titleLabel1];
//            } else {
//                [imgV2 addSubview:carBindView];
//                [imgV2 addSubview:titleLabel1];
//            }
//        }
//    } else if (self.cars.count == 1){
//        CarInfo *car = [self.cars lastObject];
//        
//        
//        
//        CGFloat imgWidth = 243/1.9;
//        CGFloat imgHeight = 51/1.9;
//        UIImageView *carBindView = [[UIImageView alloc] initWithFrame:CGRectMake((imgV1.width - imgWidth)/2, 20, imgWidth, imgHeight)];
//        carBindView.image = [UIImage imageNamed:@"jdcbd.png"];
//        [imgV2 addSubview:carBindView];
//        
//        UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake((imgV1.width - 243)/2 + 10, carBindView.bottom-10, 243, 60)];
//        titleLabel1.backgroundColor = [UIColor clearColor];
//        titleLabel1.text = @"成功绑定车辆后，可获得车辆违法信息、车辆年审提醒、保险到期提醒等提示。";
//        titleLabel1.font = [UIFont systemFontOfSize:13];
//        titleLabel1.textColor = [UIHelper getColor:@"#a0a0a0"];
//        titleLabel1.textAlignment = NSTextAlignmentLeft;
//        titleLabel1.numberOfLines = 0;
//        titleLabel1.lineBreakMode = NSLineBreakByClipping;
//        [imgV2 addSubview:titleLabel1];
//        
//    } else {
//        for (int i=0; i<2; i++) {
//            CarInfo *car = self.cars[i];
//            
//            UILabel *carNumL = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 130, 30)];
//            carNumL.textColor = COLOR_FONT_NOMAL;
//            carNumL.textAlignment = NSTextAlignmentLeft;
//            carNumL.font = [UIFont systemFontOfSize:25];
//            carNumL.backgroundColor = [UIColor clearColor];
//            carNumL.text = [car.hphm uppercaseString];
//            
//            
//            UILabel *statusL = [[UILabel alloc] initWithFrame:CGRectMake(carNumL.right+5, carNumL.top + 2, 80, 20)];
//            statusL.textColor = [UIHelper getColor:@"#72a0c5"];
//            statusL.font = [UIFont systemFontOfSize:14];
//            statusL.backgroundColor = [UIColor clearColor];
//            statusL.text = @"[绑定失败]";
//            NSRange succRange = [car.vehiclestatus rangeOfString:@"成功"];
//            if (succRange.location != NSNotFound) {
//                statusL.text = @"[绑定成功]";
//            }
//            
//            UILabel *timeL = [[UILabel alloc] initWithFrame:CGRectMake(carNumL.left-20, carNumL.bottom+5, 200, 20)];
//            timeL.textColor = [UIHelper getColor:@"#9e9e9e"];
//            timeL.font = [UIFont systemFontOfSize:14];
//            timeL.textAlignment = NSTextAlignmentCenter;
//            timeL.backgroundColor = [UIColor clearColor];
//            timeL.text = @"距离年审还有       天";
//            
//            NSTimeInterval timeInterval = [[car.yxqz convertToDateWithFormat:@"yyyy-MM-dd"] timeIntervalSinceDate:[NSDate date]];
//            int days = timeInterval/60/60/24;
//            
//            UILabel *numL = [[UILabel alloc] initWithFrame:CGRectMake(carNumL.left+100, carNumL.bottom+5, 30, 20)];
//            numL.backgroundColor = [UIColor clearColor];
//            numL.text = @"--";
//            numL.textColor = [UIColor orangeColor];
//            numL.font = [UIFont systemFontOfSize:16];
//            numL.textAlignment = NSTextAlignmentCenter;
//            if (days >= 0) {
//                numL.text = [NSString stringWithFormat:@"%d",days];
//            }
//            
//            if (i==0) {
//                
//                [imgV1 addSubview:carNumL];
//                [imgV1 addSubview:statusL];
//                [imgV1 addSubview:timeL];
//                [imgV1 addSubview:numL];
//                
//            } else {
//                
//                [imgV2 addSubview:carNumL];
//                [imgV2 addSubview:statusL];
//                [imgV2 addSubview:timeL];
//                [imgV2 addSubview:numL];
//            }
//            
//        }
//        
//        
//    }
//    
//}
//



//- (void)tap1Action
//{
//    
//    if (self.cars.count == 0) {
//        
//        CarBindViewController *carBindVC = [[CarBindViewController alloc] init];
//        [self.navigationController pushViewController:carBindVC animated:YES];
//        
//    } else {
//        CarInfo *carInfo = self.cars[0];
//        CarInfoViewController *carInfoVC = [[CarInfoViewController alloc] initWithHphm:carInfo.hphm];
//        [self.navigationController pushViewController:carInfoVC animated:YES];
//    }
//    
//}
//
//- (void)tap2Action
//{
//    if (self.cars.count == 2) {
//        
//        CarInfo *carInfo = self.cars[1];
//        CarInfoViewController *carInfoVC = [[CarInfoViewController alloc] initWithHphm:carInfo.hphm];
//        [self.navigationController pushViewController:carInfoVC animated:YES];
//        
//    } else {
//        
//        CarBindViewController *carBindVC = [[CarBindViewController alloc] init];
//        [self.navigationController pushViewController:carBindVC animated:YES];
//        
//    }
//}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self.view];
//
//    CarInfo *carInfo = nil;
//
//    if (point.y<50 || point.y>270) {
//        return;
//    }
//
//    if (self.cars.count == 0) {
//        if (point.y < 270 && point.y >50) {
//            CarBindViewController *carBindVC = [[CarBindViewController alloc] init];
//            [self.navigationController pushViewController:carBindVC animated:YES];
//        }
//    } else if(self.cars.count == 1){
//        if (point.y < 160 && point.y >50) {
//            carInfo = [self.cars lastObject];
//            CarInfoViewController *carInfoVC = [[CarInfoViewController alloc] initWithHphm:carInfo.hphm];
//            [self.navigationController pushViewController:carInfoVC animated:YES];
//
//        }else if (point.y<270 && point.y >170){
//            CarBindViewController *carBindVC = [[CarBindViewController alloc] init];
//            [self.navigationController pushViewController:carBindVC animated:YES];
//        }
//    } else {
//        if (point.y < 170 && point.y >50) {
//            carInfo = self.cars[0];
//        }else if (point.y<270 && point.y >170){
//            carInfo = self.cars[1];
//        }
//        CarInfoViewController *carInfoVC = [[CarInfoViewController alloc] initWithHphm:carInfo.hphm];
//        [self.navigationController pushViewController:carInfoVC animated:YES];
//    }
//}





/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
