//
//  TabBarViewController.m
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-9-1.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "TabBarViewController.h"
#import "BarItem.h"


@interface TabBarViewController ()
{
    NSInteger               _lastSelectedIndex;
    
    
    //UIButton                *_msgButton;
    //UILabel                 *_newMsgCouLabel;
    
    //UIImageView             *_newMsgImgView;

}
@end

@implementation TabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

#define LINE_HEIGHT     1.5
- (void)_initTabBar
{
    CGFloat y ;
    
    if (([[[UIDevice currentDevice] systemVersion] versionStringConvertToInt] >= 700)){
        y = (self.view.bounds.size.height - APP_TAB_HEIGHT);
    }else{
        y = self.view.bounds.size.height - APP_TAB_HEIGHT - APP_STATUS_BAR_HEIGHT - APP_NAV_HEIGHT;
    }
    
    _tabBarView = [[UIView alloc]initWithFrame:CGRectMake(APP_X, y + LINE_HEIGHT, APP_WIDTH, APP_TAB_HEIGHT - LINE_HEIGHT)];
    _tabBarView.backgroundColor = kWhiteColor;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(APP_X, _tabBarView.top - LINE_HEIGHT/2, APP_WIDTH, LINE_HEIGHT/3)];
    [line setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:line];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(APP_X, _tabBarView.top - LINE_HEIGHT, APP_WIDTH, LINE_HEIGHT/2)];
    [line setBackgroundColor:[UIHelper getColor:@"#a1a1a1"]];
    [self.view addSubview:line];
    
    
    CGFloat count = 4;//60*74
    float itemHeight = 150*x_6_plus*2/3;//*PX_X_SCALE;
    float itemWidth = 168*x_6_plus*2/3;//*PX_X_SCALE;//APP_WIDTH/titles.count;
    float space = (APP_WIDTH - count*itemWidth)/(count + 1);
    float yspace = (APP_TAB_HEIGHT - itemHeight)/2;
    
    CGRect frame = CGRectMake(space + (0 * (itemWidth +space)), yspace, itemWidth, itemHeight);
    BarItem *barLogoButton = [[BarItem alloc]initWithFrame:frame];
    [barLogoButton setFrame:frame];
    [barLogoButton setBackgroundImage:[UIImage imageNamed:@"首页-交互"] forState:UIControlStateNormal];
    [barLogoButton addTarget:self action:@selector(barButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    barLogoButton.tag = TAG_BUTTON_SHOUYE;
    [_tabBarView addSubview:barLogoButton];
    _lastSelectedIndex = TAG_BUTTON_SHOUYE;
    
    frame = CGRectMake(space + (1 * (itemWidth +space)), yspace, itemWidth, itemHeight);
    barLogoButton = [[BarItem alloc]initWithFrame:frame];
    [barLogoButton setFrame:frame];
    [barLogoButton setBackgroundImage:[UIImage imageNamed:@"专属服务-默认"] forState:UIControlStateNormal];
    [barLogoButton addTarget:self action:@selector(barButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    barLogoButton.tag = TAG_BUTTON_HUDONG;
    [_tabBarView addSubview:barLogoButton];
    
    frame = CGRectMake(space + (2 * (itemWidth +space)), yspace, itemWidth, itemHeight);
    barLogoButton = [[BarItem alloc]initWithFrame:frame];
    [barLogoButton setFrame:frame];
    [barLogoButton setBackgroundImage:[UIImage imageNamed:@"邦邦车友-默认"] forState:UIControlStateNormal];
    [barLogoButton addTarget:self action:@selector(barButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    barLogoButton.tag = TAG_BUTTON_FAXIAN;
    [_tabBarView addSubview:barLogoButton];
    
    
//    CGFloat width = 22;//48/2;
//    CGFloat height = 22;//48/2;
    
//    _newMsgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_msgButton.width - (width - 5), 0, width, height)];
//    [_newMsgImgView setImage:[UIImage imageNamed:@"red_round_bg"]];
//    [_msgButton addSubview:_newMsgImgView];
//    
//    _newMsgCouLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _newMsgImgView.width, _newMsgImgView.height)];
//    _newMsgCouLabel.backgroundColor = [UIColor clearColor];
//    _newMsgCouLabel.textColor = [UIColor whiteColor];
//    _newMsgCouLabel.font = [UIFont systemFontOfSize:15];
//    _newMsgCouLabel.textAlignment = NSTextAlignmentCenter;
//    [_newMsgImgView addSubview:_newMsgCouLabel];
    
    frame = CGRectMake(space + (3 * (itemWidth +space)), yspace, itemWidth, itemHeight);
    barLogoButton = [[BarItem alloc]initWithFrame:frame];
    [barLogoButton setFrame:frame];
    [barLogoButton setBackgroundImage:[UIImage imageNamed:@"个人中心-默认"] forState:UIControlStateNormal];
    [barLogoButton addTarget:self action:@selector(barButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    barLogoButton.tag = TAG_BUTTON_MINE;
    [_tabBarView addSubview:barLogoButton];
    
    
    
    
    
    
    
    [self.view addSubview:_tabBarView];
    
    //[self refreshShowMsgCount];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _initTabBar];
    
    self.navigationItem.hidesBackButton =YES;
    self.navigationItem.backBarButtonItem.image = nil;
    
    self.tabBar.hidden = YES;
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    NSArray *users = [[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName];
    if ([users count]) {//用户
        //判断用户上次登录时间是否为10分钟内
        UserInfo *user = [users lastObject];
        NSTimeInterval timeinteval = [[NSDate date] timeIntervalSinceDate:[user.loadTime date]];
        //for testing 10.0f * 60
        if (timeinteval < 10.0f * 60) {//10分钟内，不请求登录接口
            homeVC.doLoginNetWork = NO;
            APP_DELEGATE.loginSuss = YES;

        }else{//超过10分钟，请求登录接口
            homeVC.doLoginNetWork = YES;
        }
    }else{//游客
        homeVC.doLoginNetWork = NO;
    }
    
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    FaxianViewController *fxVC = [[FaxianViewController alloc] init];
    MineViewController *mVC = [[MineViewController alloc] init];
    NSArray *viewVC = @[homeVC, fxVC, chatVC, mVC];
    self.viewControllers = viewVC;
    
}
//15510680686

- (void)barButtonClicked:(UIButton*)button{
    
    if (!APP_DELEGATE.loginSuss) {
        if (button.tag == TAG_BUTTON_HUDONG) {
            [self goToLoginPage];
            return;
        }

    }
    
    if (_lastSelectedIndex == button.tag) {
        return;
    }
    
    if (button.tag == TAG_BUTTON_SHOUYE) {
        [button setImage:[UIImage imageNamed:@"首页-交互"] forState:UIControlStateNormal];
    }else if (button.tag == TAG_BUTTON_HUDONG) {
        [button setImage:[UIImage imageNamed:@"专属服务-交互"] forState:UIControlStateNormal];
    }
    else if (button.tag == TAG_BUTTON_FAXIAN) {
        [button setImage:[UIImage imageNamed:@"邦邦车友-交互"] forState:UIControlStateNormal];
        
        }
    else if (button.tag == TAG_BUTTON_MINE) {
        [button setImage:[UIImage imageNamed:@"个人中心-交互"] forState:UIControlStateNormal];
    }
    
    for (id obj in _tabBarView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)obj;
            if (button.tag == _lastSelectedIndex) {
                switch (button.tag - TAG_BUTTON_BASIC) {
                    case 0:
                        [button setImage:[UIImage imageNamed:@"首页-默认"] forState:UIControlStateNormal];
                        break;
                    case 1:
                        [button setImage:[UIImage imageNamed:@"专属服务-默认"] forState:UIControlStateNormal];
                        break;
                    case 2:
                        [button setImage:[UIImage imageNamed:@"邦邦车友-默认"] forState:UIControlStateNormal];
                        break;
                    case 3:
                        [button setImage:[UIImage imageNamed:@"个人中心-默认"] forState:UIControlStateNormal];
                        break;
                    default:
                        break;
                }
            }
        }
    }
    
    _lastSelectedIndex = button.tag;
    
    self.selectedIndex = button.tag - TAG_BUTTON_BASIC;
}

//- (void)refreshShowMsgCount{
//    NSArray *arr = [[DataBase sharedDataBase] selectMsgByUser:APP_DELEGATE.userName status:MSG_STATUS_READ_NO];
//    if ([arr count]) {
//        _newMsgImgView.hidden = NO;
//        NSString *count = [NSString stringWithFormat:@"%d", [arr count]];
//        [_newMsgCouLabel setText:count];
//    }else{
//        _newMsgImgView.hidden = YES;
//
//    }
//}
//
//- (void)updateMsgStatus{
//    NSArray *arr = [[DataBase sharedDataBase] selectMsgByUser:APP_DELEGATE.userName status:MSG_STATUS_READ_NO];
//    for (Msg *msg in arr) {
//        msg.msg_read_status = MSG_STATUS_READ_ALREADY;
//        [msg updateToDB];
//    }
//    
//    [self refreshShowMsgCount];
//}


//- (void)didReceiveNewMessage:(NSNotification*)notify{
//    NSString *resMark = [notify.userInfo objectForKey:@"responseMark"];
//    if ([resMark isEqualToString:NOTIFICATION_FETCH_MESSAGES_FINISHED]) {
//        
//        [self refreshShowMsgCount];
//        
//        
//    }
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
