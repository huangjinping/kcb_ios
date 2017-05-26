//
//  BasicViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-14.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "BasicViewController.h"


@interface BasicViewController ()

@end

@implementation BasicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init{
    if (self = [super init]) {
        self.navigationItem.hidesBackButton =YES;
        self.navigationItem.backBarButtonItem.image = nil;
    }
    return self;
}


- (void)setCustomNavigationTitle:(NSString *)title{
    
    [_titleLabel setText:title];
}

- (void)gobackPage{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setCustomNavigationHidden:(BOOL)hidden{
    [_navigationImgView setHidden:hidden];
}

- (void)setBackButtonHidden:(BOOL)hidden{
    _backButton.hidden = hidden;
}

- (void)reloadNavigationBarWithBackHomeButton:(BOOL)addBackHomeButton{
    
    [self removeNavigationBar];
    //navigation view
    CGRect frame = CGRectMake(APP_X, 0, APP_WIDTH, APP_NAV_HEIGHT);
    _navigationImgView = [[UIImageView alloc] init];
    [_navigationImgView setFrame:frame];
    [_navigationImgView setBackgroundColor:COLOR_NAV];
    _navigationImgView.userInteractionEnabled = YES;
    [self.navigationController.navigationBar addSubview:_navigationImgView];
    
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setFrame:CGRectMake(8, 8, 30, 30)];
    [_backButton setImage:[UIImage imageNamed:@"go_back.png"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(gobackPage) forControlEvents:UIControlEventTouchUpInside];
    [_navigationImgView addSubview:_backButton];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_X, 5, APP_WIDTH, APP_NAV_HEIGHT - 10)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = SYS_FONT_SIZE(40);//[UIFont fontWithName:@"RTWSYueGoTrial-Regular" size:17];
    _titleLabel.textColor = [UIColor whiteColor];
    [_navigationImgView addSubview:_titleLabel];
    
    
    if (addBackHomeButton) {
        UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [homeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [homeButton setBackgroundColor:[UIColor clearColor]];
        [homeButton.titleLabel setFont:FONT_NOMAL];
        [homeButton setImage:[UIImage imageNamed:@"btn_top_home.png"] forState:UIControlStateNormal];//60*74
        [homeButton setFrame:CGRectMake(_navigationImgView.width - 100*PX_X_SCALE, (_navigationImgView.height - 37*PX_X_SCALE)/2, 33*PX_X_SCALE, 37*PX_X_SCALE)];
        [homeButton addTarget:self action:@selector(homeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [_navigationImgView addSubview:homeButton];
    }
}
- (void)removeNavigationBar{
    if (_navigationImgView) {
        [_navigationImgView removeFromSuperview];
    }
  

}

- (void)homeButtonClicked{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[TabBarViewController class]]){
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

    self.navigationItem.hidesBackButton =YES;
    self.navigationItem.backBarButtonItem.image = nil;
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

    [self reloadNavigationBarWithBackHomeButton:NO];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [self removeNavigationBar];
}




- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    if (iOS6) {
        if (USE_COUNTLY) {
            
            if (_titleLabel.text) {
                [[Countly sharedInstance] recordEvent:_titleLabel.text count:1];
            }
        }
    }
    
}


//- (void)tapLocation:(UITapGestureRecognizer*)tap{
//
//}
//- (void)isHomePage{
//
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
