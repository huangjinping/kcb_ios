//
//  ServiceViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-10-20.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "ServiceViewController.h"

@interface ServiceViewController ()

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CGFloat width = 100;//120
    CGFloat height = 80*105/120;//105
    CGFloat startX = 5;
    CGFloat space = (APP_WIDTH - 2*startX - 3*width)/2;
    CGFloat startY = APP_VIEW_Y + 20;
    for (int i = 0; i < 7; i ++) {
        UIView *cellBgView = [[UIView alloc] initWithFrame:CGRectMake(startX + (i%3)*(width+space), startY + (i/3)*(height+space), width, height)];
        [self.view addSubview:cellBgView];
        
        CGFloat logoWidth = 50;
        CGFloat logoHeight = 50*105/120;
        UIImageView *logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake((width - logoWidth)/2, 0, logoWidth, logoHeight)];
        [logoImgView setUserInteractionEnabled:YES];
        [cellBgView addSubview:logoImgView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, height - 20, width, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        [cellBgView addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setFrame:cellBgView.bounds];
        button.tag = i;
        [button addTarget:self action:@selector(cellBetaped:) forControlEvents:UIControlEventTouchUpInside];
        [cellBgView addSubview:button];
        
        switch (i) {
            case 0:
                [logoImgView setImage:[UIImage imageNamed:@"service_chexian_jsq.png"]];
                [label setText:@"车检计算器"];
                break;
            case 1:
                [logoImgView setImage:[UIImage imageNamed:@"service_cheliang_zhaohui_sucha.png"]];
                [label setText:@"车辆召回速查"];
                break;
            case 2:
                [logoImgView setImage:[UIImage imageNamed:@"service_chepai_yaohao_sucha.png"]];
                [label setText:@"车牌摇号速查"];
                break;
            case 3:
                [logoImgView setImage:[UIImage imageNamed:@"service_chexian_bijia.png"]];
                [label setText:@"车险比价"];
                break;
            case 4:
                [logoImgView setImage:[UIImage imageNamed:@"service_yunnan_bangban.png"]];
                [label setText:@"云南帮办"];
                break;
            case 5:
                [logoImgView setImage:[UIImage imageNamed:@"service_add.png"]];
                [label setText:@"决定书编号查询"];
                break;
            case 6:
                [logoImgView setImage:[UIImage imageNamed:@"service_add.png"]];
                [label setText:@"添加服务"];
                break;
            default:
                break;
        }
    }
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setCustomNavigationTitle:@"服务"];
    [self setBackButtonHidden:YES];
}

- (void)cellBetaped:(UIButton*)btn{

    if (btn.tag == 0) {//车检计算器
        CheXian_JSQ_ViewController *cxjsqVC = [[CheXian_JSQ_ViewController alloc] init];
        [self.navigationController pushViewController:cxjsqVC animated:YES];
    }else if (btn.tag == 1){//车辆召回速查
        CheLiang_ZHViewController *clzhVC = [[CheLiang_ZHViewController alloc] init];
        [self.navigationController pushViewController:clzhVC animated:YES];
    }else if (btn.tag == 2){//车牌摇号速查
        [self.view showAlertText:@"开发中...敬请期待"];
    }else if (btn.tag == 3){//车险比价
        [self.view showAlertText:@"开发中...敬请期待"];
    }else if (btn.tag == 4){//云南帮办
        YunNan_BBViewController *yunnanbbVC = [[YunNan_BBViewController alloc] init];
        [self.navigationController pushViewController:yunnanbbVC animated:YES];
    }else if (btn.tag == 5){//决定书编号
        JDSBHSearchPayViewController *jdsbhSPVC = [[JDSBHSearchPayViewController alloc] init];
        [self.navigationController pushViewController:jdsbhSPVC animated:YES];
    }else if (btn.tag == 6){//添加服务
        [self.view showAlertText:@"暂无更多服务"];
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
