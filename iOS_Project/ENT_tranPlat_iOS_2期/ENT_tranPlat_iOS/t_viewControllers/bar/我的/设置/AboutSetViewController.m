//
//  AboutSetViewController.m
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-10-17.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "AboutSetViewController.h"

@interface AboutSetViewController ()

@end

@implementation AboutSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    CGFloat viewHeight = self.view.frame.size.height;    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((APP_WIDTH - 60)/2, APP_VIEW_Y+30, 60, 60)];
    imageView.image = [UIImage imageNamed:@"Icon@2x.png"];
    [self.view addSubview:imageView];
    
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(20, imageView.bottom + 10, APP_WIDTH-40, 30)];
    lable1.text = @"开车邦";
    lable1.backgroundColor = [UIColor clearColor];
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.font = [UIFont boldSystemFontOfSize:17];
    [self.view addSubview:lable1];
    

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *str = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    _versionLable = [[UILabel alloc]initWithFrame:CGRectMake(lable1.left, lable1.bottom, lable1.width, 21)];
    _versionLable.textAlignment = NSTextAlignmentCenter;
    _versionLable.text = [NSString stringWithFormat:@"版本：%@",str];
    _versionLable.font = [UIFont systemFontOfSize:16];
    _versionLable.backgroundColor = [UIColor clearColor];
    _versionLable.textColor = [UIColor lightGrayColor];
    [self.view addSubview:_versionLable];
    
    NSArray *array1 = [NSArray arrayWithObjects:@"官网：www.956122.com",@"服务热线：4000-956122",@"微信号：w956122", nil];
    for (int i = 0 ; i < 3 ; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake((APP_WIDTH-190)/2, viewHeight-190+21*i, 190, 21)];
        lable.text = [array1 objectAtIndex:i];
        
        lable.textAlignment = NSTextAlignmentLeft;
        lable.font = [UIFont systemFontOfSize:16];
        lable.backgroundColor = [UIColor clearColor];
        [self.view addSubview:lable];
    }
    
    NSArray *array2 = [NSArray arrayWithObjects:@"北京易恩通智能科技有限公司 版权所有",@"Copyright© 2014 All Rights RESERVED. ", nil];
    for (int i = 0 ; i < 2 ; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight-87+21*i, APP_WIDTH, 21)];
        lable.text = [array2 objectAtIndex:i];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.backgroundColor = [UIColor clearColor];
        lable.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:lable];
    }

    
    // Do any additional setup after loading the view.
}
- (UIColor *)color {
    
    UIColor *color = [UIColor colorWithRed:arc4random()*48%255/255.0 green:arc4random()*148%255/255.0 blue:arc4random()*178%255/255.0 alpha:1];
    return color;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"关于"];
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
