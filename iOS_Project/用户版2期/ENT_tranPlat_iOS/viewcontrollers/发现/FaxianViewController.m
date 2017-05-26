

#import "FaxianViewController.h"
#import "UserCarViewController.h"
#import "ScrollItemView.h"
#import "RenzhengViewController.h"
#import "MaintenanceController.h"
#import "CarDisplacementController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface FaxianViewController ()<UIScrollViewDelegate,UITableViewDataSource,MenuViewDelegate,UITextFieldDelegate>
{
    NSMutableDictionary             *_carNetStatusDict;
    NSMutableDictionary             *_ucarNetStatusDict;
    UIScrollView * _scroll;      //创建ScrollView
    UIButton * _tempBtn;         //记录上一个点击的按钮
    UIScrollView            *_rootScrollView1;
    UIScrollView            *_rootScrollView2;
    UIScrollView            *_rootScrollView3;
    NSArray * _arr_btn;
    UIView * _btnView;
    MenuView                            *_menuView;
    
    
    
    
    UILabel                 *_carWeichuliL;
    UILabel                 *_carFakuanL;
    UILabel                 *_carKoufenL;
    UILabel                 *_carfirst;
    UILabel                 *_carfirsts;
    UILabel                 *_carsecond;
    UILabel                 *_carseconds;
    UILabel                 *_carthird;
    UILabel                 *_carthirds;
    UILabel                 *_carfirst2;
    UILabel                 *_carfirsts2;
    UILabel                 *_carsecond2;
    UILabel                 *_carseconds2;
    UILabel                 *_carthird2;
    UILabel                 *_carthirds2;
    UILabel                 *_carWeichuliL2;
    UILabel                 *_carFakuanL2;
    UILabel                 *_carKoufenL2;
    
    
    UILabel                 *_drifirst;
    UILabel                 *_drifirsts;
    UILabel                 *_drisecond;
    UILabel                 *_driseconds;
    UILabel                 *_drithird;
    UILabel                 *_drithirds;
    UILabel                 *_driWeichuliL;
    UILabel                 *_driFakuanL;
    UILabel                 *_driKoufenL;
    UILabel                 *_yellowLabel1;
    
 
    UITextField     *_xxlcTF;
    LoadingPeccancyRecordStatus       _netStatus;
    BOOL  _ifTwocar;
 

}
@property(nonatomic,strong)NSMutableArray *cars;
@property(nonatomic,strong)NSMutableArray *drivers;
@property(nonatomic)NSInteger number;
@property(nonatomic)NSInteger numberDriver;
@property(nonatomic)BOOL ifDriver;
@property (nonatomic, retain)   NSMutableDictionary     *carPeccancyRecordDict;//车辆违章记录字典
@property(nonatomic,strong)UILabel  *weathercar1;
@property(nonatomic,strong)UILabel  *cc_titlecar1;
@property(nonatomic,strong)UILabel  *weathercar2;
@property(nonatomic,strong)UILabel  *cc_titlecar2;
@property(nonatomic,copy)NSString                *hphmPrefix;//车牌前缀


@end

@implementation FaxianViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _netStatus = loadingPeccancyRecordSucc;
    _carNetStatusDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [self creatUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(creatNextUI) name:@"zhuanshu" object:nil];

    
    
    
    
}


#pragma mark- MENU DELEGATE
- (void)menuView:(MenuView*)menuView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
    NSArray *drivers = [[DataBase sharedDataBase] selectDriverByUserId:APP_DELEGATE.userId];
    NSArray *array = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId];
    self.cars = [[NSMutableArray alloc] initWithArray:array];
    _number =_cars.count;
    
    if (![drivers count]){
        if (_number == 1) {
            CarInfo *car1  = [self.cars objectAtIndex:0];
            if (indexPath.row == 0) {
                
                CarInfoViewController *carInfoVC = [[CarInfoViewController alloc] initWithHphm:car1.hphm];
                [self.navigationController pushViewController:carInfoVC animated:YES];
                
            }else if (indexPath.row == 1){
                CarBindViewController *carBindVC = [[CarBindViewController alloc] init];
                [self.navigationController pushViewController:carBindVC animated:YES];
                
            }else if(indexPath.row ==2){
                DriverBindViewController *dbvc = [[DriverBindViewController alloc] init];
                [self.navigationController pushViewController:dbvc animated:YES];
                
            }
            
        }else if(_number >= 2){
            CarInfo *car1  = [self.cars objectAtIndex:0];
            CarInfo *car2  = [self.cars objectAtIndex:1];
            if (indexPath.row == 0) {
                CarInfoViewController *carInfoVC = [[CarInfoViewController alloc] initWithHphm:car1.hphm];
                [self.navigationController pushViewController:carInfoVC animated:YES];
                
            }else if (indexPath.row == 1){
                CarInfoViewController *carInfoVC = [[CarInfoViewController alloc] initWithHphm:car2.hphm];
                [self.navigationController pushViewController:carInfoVC animated:YES];
                
            }else if (indexPath.row == 2){
                DriverBindViewController *dbvc = [[DriverBindViewController alloc] init];
                [self.navigationController pushViewController:dbvc animated:YES];
            }
            
        }
    }else{
        if (_number == 0) {
            if (indexPath.row == 0) {
                CarBindViewController *carBindVC = [[CarBindViewController alloc] init];
                [self.navigationController pushViewController:carBindVC animated:YES];
                
            }else if (indexPath.row == 1){
                DriveLicenseManageViewController *driveLMVC = [[DriveLicenseManageViewController alloc] init];
                [self.navigationController pushViewController:driveLMVC animated:YES];
                
            }
            
            
        }else if(_number == 1){
            
            CarInfo *car1  = [self.cars objectAtIndex:0];
            
            if (indexPath.row == 0) {
                CarInfoViewController *carInfoVC = [[CarInfoViewController alloc] initWithHphm:car1.hphm];
                [self.navigationController pushViewController:carInfoVC animated:YES];
            }else if (indexPath.row == 1){
                CarBindViewController *carInfoVC = [[CarBindViewController alloc] init];
                [self.navigationController pushViewController:carInfoVC animated:YES];
            }else if (indexPath.row == 2){
                DriveLicenseManageViewController *driveLMVC = [[DriveLicenseManageViewController alloc] init];
                [self.navigationController pushViewController:driveLMVC animated:YES];
            }
            
            
        }else if(_number >= 2){
            CarInfo *car1  = [self.cars objectAtIndex:0];
            CarInfo *car2  = [self.cars objectAtIndex:1];
            if (indexPath.row == 0) {
                CarInfoViewController *carInfoVC = [[CarInfoViewController alloc] initWithHphm:car1.hphm];
                [self.navigationController pushViewController:carInfoVC animated:YES];
            }else if (indexPath.row == 1){
                CarInfoViewController *carInfoVC = [[CarInfoViewController alloc] initWithHphm:car2.hphm];
                [self.navigationController pushViewController:carInfoVC animated:YES];
            }else if (indexPath.row == 2){
                DriveLicenseManageViewController *driveLMVC = [[DriveLicenseManageViewController alloc] init];
                [self.navigationController pushViewController:driveLMVC animated:YES];
            }
            
            
            
        }
    }
    

}
- (void)labelTap{
    NSInteger count ;
    if(_number ==0){
        count =2;
        
    }else {
        count =3;
    }
    if(_menuView.bottom==APP_VIEW_Y+40*count){
 
        [UIView animateWithDuration:0.5 animations:^{
            _menuView.frame = CGRectMake(APP_WIDTH - 140, -40*count, 140, 40*count);
            
        }];
}


}
#pragma mark- +button
- (void)navButtonClicked:(UIButton*)button{
    NSInteger count ;
    if(_number ==0){
        count =2;
        
    }else {
        count =3;
    }
    
    if(_menuView.bottom==APP_VIEW_Y+40*count){
        
        [UIView animateWithDuration:0.5 animations:^{
            _menuView.frame = CGRectMake(APP_WIDTH - 140, -40*count, 140, 40*count);
            
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _menuView.frame = CGRectMake(APP_WIDTH - 140, APP_VIEW_Y, 140, 40*count);
            
        }];
    
    }

    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setBackButtonHidden:YES];
    
    [self setCustomNavigationTitle:@"专属服务"];
    
    
    NSArray *drivers = [[DataBase sharedDataBase] selectDriverByUserId:APP_DELEGATE.userId];
    NSArray *cars = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId];
    
    if (![drivers count]&&![cars count]){
        [self renZhengUI];
    }
     //[self creatNextUI];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH - 40, (_navigationImgView.height - 20)/2, 23, 20)];
    [imgV setUserInteractionEnabled:YES];
    [imgV setImage:[UIImage imageNamed:@"right"]];
    [_navigationImgView addSubview:imgV];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(APP_WIDTH - 50, 0, 50, 50)];
    [button setBackgroundColor:[UIColor clearColor]];
    [button addTarget:self action:@selector(navButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationImgView addSubview:button];
    _menuView.frame = CGRectMake(APP_WIDTH - 140, -120, 140, 120);
    [self reloadWeifaCount];
    [self reloadPeccancyInfoView];
    [self reloadWeahther];
   


    
}
-(void)renZhengUI{
    
    
    UIScrollView* rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT )];
    [rootScrollView setBackgroundColor:COLOR_VIEW_CONTROLLER_BG];
    rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:rootScrollView];
    
    
    
    
    
    
    ZKButton *carButton=[ZKButton blockButtonWithFrame:BBRectMake(0, 20, 1080, 700) type:UIButtonTypeCustom title:@"" backgroundImage:@"" andBlock:^(ZKButton *button) {
        CarBindViewController *carBindVC = [[CarBindViewController alloc] init];
        [self.navigationController pushViewController:carBindVC animated:YES];
        
    }];
    carButton.backgroundColor=[UIColor clearColor];
    
    [carButton setBackgroundImage:[UIImage imageNamed:@"mac01"] forState:UIControlStateNormal];
    
    [rootScrollView addSubview:carButton];
    
    //*********************************违章处理*********************************
    
    ZKButton *diverButton=[ZKButton blockButtonWithFrame:BBRectMake(0,20+20+700, 1080, 700) type:UIButtonTypeCustom title:@"" backgroundImage:@"" andBlock:^(ZKButton *button) {
        DriverBindViewController *dbvc = [[DriverBindViewController alloc] init];
        [self.navigationController pushViewController:dbvc animated:YES];
        
    }];
    
    diverButton.backgroundColor=[UIColor clearColor];
    [diverButton setBackgroundImage:[UIImage imageNamed:@"mac02"] forState:UIControlStateNormal];
    
    [rootScrollView addSubview:diverButton];



}
-(void)creatNextUI{
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIView class]]) {
            [(UIView *)obj removeFromSuperview];
        }
    }];
    
    [self creatUI];
}

//车辆排序
-(NSArray *)byCarArray:(NSArray* )array{
    NSMutableArray *date1=[[NSMutableArray alloc]init];
    
    for (CarInfo *car in array) {
        NSString *_fixsting= [car.hphm substringToIndex:1];
        if ([_fixsting isEqualToString:@"云"]||[_fixsting isEqualToString:@"青"]||[_fixsting isEqualToString:@"渝"]||[_fixsting isEqualToString:@"琼"]||[_fixsting isEqualToString:@"鲁"]){
            [date1 addObject:car];
        }
        
        
    }
    for (CarInfo *car in array) {
        NSString *_fixsting= [car.hphm substringToIndex:1];
        if ([_fixsting isEqualToString:@"云"]||[_fixsting isEqualToString:@"青"]||[_fixsting isEqualToString:@"渝"]||[_fixsting isEqualToString:@"琼"]||[_fixsting isEqualToString:@"鲁"]){
            
        }else{
            [date1 addObject:car];
        }
        
    }
    
    
    return date1;
    
}

-(void)creatUI{
    
    _ifTwocar=NO;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    NSArray *drivers = [[DataBase sharedDataBase] selectDriverByUserId:APP_DELEGATE.userId];
    self.driver = [drivers lastObject];
    //_drivers=[[NSMutableArray alloc] initWithArray:arrayDriver];
    _numberDriver =_drivers.count;
    if(![drivers count]){
        _ifDriver=NO;
    }else{
        _ifDriver=YES;
    }
    
    NSArray *array = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId];

    self.cars = [[NSMutableArray alloc] initWithArray:[self byCarArray:array]];
    
    _number =_cars.count;
    
    
    //判断滑动模块
    if (![drivers count]){
        
        if (_number == 1) {
            
            CarInfo *car1  = [self.cars objectAtIndex:0];
            NSDictionary *titlesAndLogos = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"liscar", @"listncar", @"nodrvier",nil], KEY_MENU_VIEW_LOGOS, [NSArray arrayWithObjects:car1.hphm, @"认证车辆",@"认证驾驶证",nil], KEY_MENU_VIEW_TITLES, nil];
            
            _menuView = [[MenuView alloc]initWithFrame:CGRectMake(APP_WIDTH - 140, -40*3, 140, 40*3) titlesAndLogos:titlesAndLogos height:@"40"];
            
            [self createOnlyScrollView];
            
        }else if(_number >= 2){
            CarInfo *car1  = [self.cars objectAtIndex:0];
            CarInfo *car2  = [self.cars objectAtIndex:1];
            
            NSDictionary *titlesAndLogos = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"liscar", @"liscar", @"nodrvier",nil], KEY_MENU_VIEW_LOGOS, [NSArray arrayWithObjects:car1.hphm, car2.hphm,@"认证驾驶证",nil], KEY_MENU_VIEW_TITLES, nil];
            
            _menuView = [[MenuView alloc]initWithFrame:CGRectMake(APP_WIDTH - 140, -40*3, 140, 40*3) titlesAndLogos:titlesAndLogos height:@"40"];
            
            _arr_btn = @[car1.hphm,car2.hphm];
            
            [self createTopBtn];
            [self createTwoScrollView];
            
        }
    }else{
        if (_number == 0) {
            
            NSDictionary *titlesAndLogos = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"listncar", @"listdrvier", nil], KEY_MENU_VIEW_LOGOS, [NSArray arrayWithObjects: @"认证车辆",@"我的驾驶证",nil], KEY_MENU_VIEW_TITLES, nil];
            
            _menuView = [[MenuView alloc]initWithFrame:CGRectMake(APP_WIDTH - 140, -40*2, 140, 40*2) titlesAndLogos:titlesAndLogos height:@"40"];
            
            [self createOnlyScrollView];
            
        }else if(_number == 1){
            
            CarInfo *car1  = [self.cars objectAtIndex:0];
            _arr_btn = @[car1.hphm,@"驾驶证"];
            
            NSDictionary *titlesAndLogos = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"liscar", @"listncar", @"listdrvier",nil], KEY_MENU_VIEW_LOGOS, [NSArray arrayWithObjects:car1.hphm, @"认证车辆",@"我的驾驶证",nil], KEY_MENU_VIEW_TITLES, nil];
            
            _menuView = [[MenuView alloc]initWithFrame:CGRectMake(APP_WIDTH - 140, -40*3, 140, 40*3) titlesAndLogos:titlesAndLogos height:@"40"];
            
            
            
            [self createTopBtn];
            [self createTwoScrollView];
            
            
        }else if(_number >= 2){
            CarInfo *car1  = [self.cars objectAtIndex:0];
            CarInfo *car2  = [self.cars objectAtIndex:1];
            
            _arr_btn = @[car1.hphm,car2.hphm,@"驾驶证"];
            
            NSDictionary *titlesAndLogos = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"liscar", @"liscar", @"listdrvier",nil], KEY_MENU_VIEW_LOGOS, [NSArray arrayWithObjects:car1.hphm, car2.hphm,@"我的驾驶证",nil], KEY_MENU_VIEW_TITLES, nil];
            
            _menuView = [[MenuView alloc]initWithFrame:CGRectMake(APP_WIDTH - 140, -40*3, 140, 40*3) titlesAndLogos:titlesAndLogos height:@"40"];
            
            [self createTopBtn];
            [self createScrollView];
            
            
        }
    }
    _menuView._delegate = self;
    [self.view addSubview:_menuView];
    _rootScrollView1=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64-35)];
    _rootScrollView2=[[UIScrollView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT-64-35)];
    _rootScrollView3=[[UIScrollView alloc]initWithFrame:CGRectMake(2*WIDTH, 0, WIDTH, HEIGHT-64-35)];
    
    if (![drivers count]){
        
        if (_number == 1) {
            CarInfo *car1  = [self.cars objectAtIndex:0];
            [self carInfoAndCreateView:_rootScrollView1 andCarInfo:car1];
            
        }else if(_number >= 2){
            CarInfo *car1  = [self.cars objectAtIndex:0];
            CarInfo *car2  = [self.cars objectAtIndex:1];
            [self carInfoAndCreateView:_rootScrollView1 andCarInfo:car1];
            [self carInfoAndCreateView:_rootScrollView2 andCarInfo:car2];
        }
    }else{
        if (_number == 0) {
            
            [self DriverInfoAndCreateView:_rootScrollView1 andDriver:_driver];
            
        }else if(_number == 1){
            
            CarInfo *car1  = [self.cars objectAtIndex:0];
            [self carInfoAndCreateView:_rootScrollView1 andCarInfo:car1];
            [self DriverInfoAndCreateView:_rootScrollView2 andDriver:_driver];
            
            
            
        }else if(_number >= 2){
            CarInfo *car1  = [self.cars objectAtIndex:0];
            CarInfo *car2  = [self.cars objectAtIndex:1];
            [self carInfoAndCreateView:_rootScrollView1 andCarInfo:car1];
            [self carInfoAndCreateView:_rootScrollView2 andCarInfo:car2];
            [self DriverInfoAndCreateView:_rootScrollView3 andDriver:_driver];
            
            
        }
    }
    _rootScrollView1.userInteractionEnabled=YES;
    [_rootScrollView1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)]];
    _rootScrollView2.userInteractionEnabled=YES;
    [_rootScrollView2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)]];
    _rootScrollView3.userInteractionEnabled=YES;
    [_rootScrollView3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)]];
}

#pragma mark _滚动三个视图

-(void)createTopBtn
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 35)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    if(_arr_btn.count==2){
        _yellowLabel1=[[UILabel alloc]initWithFrame:CGRectMake(0,34, WIDTH/2, 1)];
    
    }else if (_arr_btn.count==3){
        _yellowLabel1=[[UILabel alloc]initWithFrame:CGRectMake(0,34, WIDTH/3, 1)];
  
    }
    
    _yellowLabel1.backgroundColor=COLOR_NAV;
    
    for (int i=0; i<_arr_btn.count; i++){
      
       
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i+10;
        if (i==0){
            btn.selected  = YES;
            _tempBtn = btn;
           
        }
        if(_arr_btn.count ==3){
            
            btn.frame = CGRectMake((WIDTH/3+1)*i, 1, WIDTH/3, 35);

        }else if(_arr_btn.count ==2){
            btn.frame = CGRectMake((WIDTH/2+1)*i, 1, WIDTH/2, 35);
          
        }
        [btn setTitle:[_arr_btn objectAtIndex:i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_NAV forState:UIControlStateSelected];

        
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0,34, WIDTH, 1)];
        view1.backgroundColor=COLOR_FRAME_LINE;
         [view addSubview:view1];
        //[btn addSubview:_yellowLabel1];
         [view addSubview:_yellowLabel1];
        
    }
}
-(void)createScrollView
{
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 35+64, WIDTH, HEIGHT-64-35)];
    _scroll.delegate = self;
    _scroll.pagingEnabled = YES;
    _scroll.bounces = NO;
    _scroll.scrollEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.contentOffset = CGPointMake(0, 0);
    _scroll.contentSize = CGSizeMake(WIDTH*3, HEIGHT-64-35);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:_scroll];
}
-(void)createTwoScrollView
{
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 35+64, WIDTH,HEIGHT-64-35)];
    _scroll.delegate = self;
    _scroll.pagingEnabled = YES;
    _scroll.bounces = NO;
    _scroll.scrollEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.contentOffset = CGPointMake(0, 0);
    _scroll.contentSize = CGSizeMake(WIDTH*2, HEIGHT-64-35);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:_scroll];
}

-(void)createOnlyScrollView
{
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    _scroll.delegate = self;
    _scroll.pagingEnabled = YES;
    _scroll.bounces = NO;
    _scroll.scrollEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.contentOffset = CGPointMake(0, 0);
    _scroll.contentSize = CGSizeMake(WIDTH, HEIGHT-64);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:_scroll];
}

#pragma mark _DriverInfo
-(void)DriverInfoAndCreateView:(UIScrollView *)rootScrollView andDriver:(DriverInfo *)driver{
    

    UIImageView *perfectCarinfoFormBgView = [[UIImageView alloc] initWithFrame:BBRectMake(0, 0, APP_WY_WIDTH, 2000)];
    [perfectCarinfoFormBgView setBackgroundColor:[UIColor whiteColor]];
    [perfectCarinfoFormBgView setUserInteractionEnabled:YES];
    rootScrollView.backgroundColor=COLOR_FRAME_LINE;
    [rootScrollView addSubview:perfectCarinfoFormBgView];
    [_scroll addSubview:rootScrollView];
    rootScrollView.contentSize = CGSizeMake(screenSize.width,1625*y_6_plus+35);
    //*********************************横线*********************************
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:BBRectMake(0, 0, APP_WY_WIDTH, 1)];
    [lineLabel setBackgroundColor:COLOR_FRAME_LINE];
    [lineLabel setSize:CGSizeMake((APP_WY_WIDTH)*x_6_SCALE, lineLabel.height+1)];
   // [perfectCarinfoFormBgView addSubview:lineLabel];
    
    lineLabel = [[UILabel alloc] initWithFrame:BBRectMake(0, 512, APP_WY_WIDTH, 20)];
    [lineLabel setBackgroundColor:COLOR_FRAME_LINE];
    [perfectCarinfoFormBgView addSubview:lineLabel];
    
    lineLabel = [[UILabel alloc] initWithFrame:BBRectMake(0, 512+20+260, APP_WY_WIDTH, 20)];
    [lineLabel setBackgroundColor:COLOR_FRAME_LINE];
    [perfectCarinfoFormBgView addSubview:lineLabel];
    
    lineLabel = [[UILabel alloc] initWithFrame:BBRectMake(0,512+20+260+260+20, APP_WY_WIDTH, 20)];
    [lineLabel setBackgroundColor:COLOR_FRAME_LINE];
    [perfectCarinfoFormBgView addSubview:lineLabel];
    
    lineLabel = [[UILabel alloc] initWithFrame:BBRectMake(0, 512+20+260+260+20+20+305, APP_WY_WIDTH, 20)];
    [lineLabel setBackgroundColor:COLOR_FRAME_LINE];
    [perfectCarinfoFormBgView addSubview:lineLabel];
    
    
    //*********************************姓名*********************************
    UILabel *label = [[UILabel alloc] initWithFrame:BBRectMake(40, 100,300, 80)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(72)) textColor:COLOR_NAV textAlignment:NSTextAlignmentLeft];
    [label setText:driver.xm];
    [label sizeToFit];
    label.centerX=perfectCarinfoFormBgView.centerX;
    [perfectCarinfoFormBgView addSubview:label];
    ZKButton *XCButton=[ZKButton blockButtonWithFrame:BBRectMake(40,0,APP_WY_WIDTH-80 , 250)  type:UIButtonTypeCustom title:@""backgroundImage:nil andBlock:^(ZKButton *button) {
        DriveLicenseManageViewController *carInfoVC = [[DriveLicenseManageViewController alloc] init];
        
        
        [self.navigationController pushViewController:carInfoVC animated:YES];
        
    }];
    [perfectCarinfoFormBgView addSubview:XCButton];
    UIImageView *Image =[[UIImageView alloc]initWithFrame:BBRectMake(474, 210, 135, 40)];
//
    if([driver.driverstatus isEqualToString:@"验证成功"]){
     
         Image.image=[UIImage imageNamed:@"renzheng"];
   
        
    }else{
   
        
         Image.image=[UIImage imageNamed:@"未认证"];
    }
    [perfectCarinfoFormBgView addSubview:Image];
    
  
    
    label= [[UILabel alloc] initWithFrame:BBRectMake(430, Image.bottom/y_6_plus+40,500, 40)];
    [label convertNewLabelWithFont:WY_FONT_SIZE(36) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    label.centerX=Image.centerX;
   
    NSString *str1 = [driver.driversfzmhm substringToIndex:3];
    NSString *str2 = @"";
    if (driver.driversfzmhm.length == 15) {
        str2 = [driver.driversfzmhm substringFromIndex:11];
    } else {
        str2 = [driver.driversfzmhm substringFromIndex:14];
    }
    label.text = [NSString stringWithFormat:@"证件号码 : %@***********%@",str1,str2];
     [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    
    
    label= [[UILabel alloc] initWithFrame:BBRectMake(label.left/x_6_plus,label.bottom/y_6_plus+10, 500, 40)];
    [label convertNewLabelWithFont:WY_FONT_SIZE(36) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    str1 = driver.dabh.length > 3? [driver.dabh substringToIndex:3] : driver.dabh;
    str2 = driver.dabh.length > 5? [driver.dabh substringFromIndex:driver.dabh.length-2] : @"";
    label.text = [NSString stringWithFormat:@"档案编号 : %@*******%@",str1,str2];
    [label sizeToFit];
    //label.centerX=perfectCarinfoFormBgView.centerX;

    [perfectCarinfoFormBgView addSubview:label];
    
    
    label= [[UILabel alloc] initWithFrame:BBRectMake(label.left/x_6_plus, label.bottom/y_6_plus+10,500, 40)];
    [label convertNewLabelWithFont:WY_FONT_SIZE(36) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    str1 = driver.zxbh.length > 3? [driver.zxbh substringToIndex:3] : driver.zxbh;
    str2 = driver.zxbh.length > 5? [driver.zxbh substringFromIndex:driver.zxbh.length-2] : @"";
    label.text = [NSString stringWithFormat:@"证芯编号 : %@*************%@",str1,str2];
    [label sizeToFit];
    //label.centerX=perfectCarinfoFormBgView.centerX;
    [perfectCarinfoFormBgView addSubview:label];
//
    
    //*********************************违章处理*********************************
    
    Image=[[UIImageView alloc]initWithFrame:BBRectMake(940, 526+20+82, 34, 59)];
    Image.image=[UIImage imageNamed:@"形状"];
    Image.centerY=(532+130)*y_6_plus;
    [perfectCarinfoFormBgView addSubview:Image];

    Image=[[UIImageView alloc]initWithFrame:BBRectMake(120, 532+82, 88, 92)];
    Image.image=[UIImage imageNamed:@"违章图标"];
    [perfectCarinfoFormBgView addSubview:Image];
    
//    label= [[UILabel alloc] initWithFrame:BBRectMake(420,532+82, perfectCarinfoFormBgView.w - 30*2, 60)];
//    [label convertNewLabelWithFont:WY_FONT_SIZE(48) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
//    [label setText:@"新违章       条"];
//    [perfectCarinfoFormBgView addSubview:label];
    _drifirst= [[UILabel alloc] initWithFrame:BBRectMake(250, 512+82+20, perfectCarinfoFormBgView.w - 30*2, 60)];
    [_drifirst setText:@"新违章"];
    [_drifirst convertNewLabelWithFont:(WY_FONT_SIZE(48)) textColor:COLOR_BK_SHOW textAlignment:NSTextAlignmentLeft];
    _drifirst.font = [UIFont boldSystemFontOfSize:(48/2-3)*X_X_SCALE];
    [_drifirst sizeToFit];
    [perfectCarinfoFormBgView addSubview:_drifirst];
    _driWeichuliL= [[UILabel alloc] initWithFrame:BBRectMake(_drifirst.right/x_6_plus+5, _drifirst.top/y_6_plus, 300, 60)];
    [_driWeichuliL convertNewLabelWithFont:WY_FONT_SIZE(48) textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    _driWeichuliL.text=@"--";
    [_driWeichuliL sizeToFit];
    [perfectCarinfoFormBgView addSubview:_driWeichuliL];
    _drifirsts= [[UILabel alloc] initWithFrame:BBRectMake(_driWeichuliL.right/x_6_plus+5, _drifirst.top/y_6_plus, 300, 60)];
    [_drifirsts setText:@"条"];
    [_drifirsts convertNewLabelWithFont:(WY_FONT_SIZE(48)) textColor:COLOR_BK_SHOW textAlignment:NSTextAlignmentLeft];
    _drifirsts.font = [UIFont boldSystemFontOfSize:(48/2-3)*X_X_SCALE];
    [_drifirsts sizeToFit];
    [perfectCarinfoFormBgView addSubview:_drifirsts];
    _drisecond= [[UILabel alloc] initWithFrame:BBRectMake(250, _drifirst.bottom/y_6_plus+18, 300, 60)];
    [_drisecond setText:@"罚款"];
    [_drisecond convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_drisecond sizeToFit];
    [perfectCarinfoFormBgView addSubview:_drisecond];
    _driFakuanL= [[UILabel alloc] initWithFrame: BBRectMake(_drisecond.right/x_6_plus+5, _drisecond.top/y_6_plus,300, 40)];
    [_driFakuanL convertNewLabelWithFont:WY_FONT_SIZE(36) textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    _driFakuanL.text=@"--";
    [_driFakuanL sizeToFit];
    [perfectCarinfoFormBgView addSubview:_driFakuanL];
    _driseconds= [[UILabel alloc] initWithFrame:BBRectMake(_driFakuanL.right/x_6_plus+5,_drisecond.top/y_6_plus, 300, 40)];
    [_driseconds convertNewLabelWithFont:WY_FONT_SIZE(36) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_driseconds setText:@"元"];
    [_driseconds sizeToFit];
    [perfectCarinfoFormBgView addSubview:_driseconds];

    _drithird= [[UILabel alloc] initWithFrame:BBRectMake(_driseconds.right/x_6_plus+20, _driseconds.top/y_6_plus, 300, 40)];
    [_drithird convertNewLabelWithFont:WY_FONT_SIZE(36) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_drithird setText:@"扣分"];
     [_drithird sizeToFit];
    [perfectCarinfoFormBgView addSubview:_drithird];

    _driKoufenL= [[UILabel alloc] initWithFrame:BBRectMake(_drithird.right/x_6_plus+5, _driseconds.top/y_6_plus, perfectCarinfoFormBgView.w - 30*2, 40)];
    [_driKoufenL convertNewLabelWithFont:WY_FONT_SIZE(36) textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    _driKoufenL.text=@"--";
     [_driKoufenL sizeToFit];
    [perfectCarinfoFormBgView addSubview:_driKoufenL];
    _drithirds= [[UILabel alloc] initWithFrame:BBRectMake(_driKoufenL.right/x_6_plus+5, _driseconds.top/y_6_plus, 300, 40)];
    [_drithirds convertNewLabelWithFont:WY_FONT_SIZE(36) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_drithirds setText:@"分"];
    [perfectCarinfoFormBgView addSubview:_drithirds];

    ZKButton *DriverButton=[ZKButton blockButtonWithFrame:BBRectMake(0,512+20 ,1080 , 260)  type:UIButtonTypeCustom title:nil backgroundImage:nil andBlock:^(ZKButton *button) {
        
        DriveLicensePeccancyRecord *record = [[[DataBase sharedDataBase] selectDriveLicensePeccancyRecordByUserId:APP_DELEGATE.userId] lastObject];
        if (![driver.driverstatus isEqualToString:@"验证成功"]){
          //  NSLog(@"驾驶证未绑定成功 无法查询");
            
        }else{
            if (record) {//显示记录数
                DriveLicensePeccancyRecordViewController *dvc = [[DriveLicensePeccancyRecordViewController alloc] init];
                
                dvc.driver = driver;
                
                [self.navigationController pushViewController:dvc animated:YES];
                
            }else{
            [UITools alertWithMsg:@"驾驶证未认证"];
            }
            
            
        }
        
        
    }];
    [perfectCarinfoFormBgView addSubview:DriverButton];
    
    
    //********************************年审代办*********************************

    Image=[[UIImageView alloc]initWithFrame:BBRectMake(120,  512+260+20*2+82, 88, 62)];
    Image.image=[UIImage imageNamed:@"年审图标"];
    [perfectCarinfoFormBgView addSubview:Image];
    label = [[UILabel alloc] initWithFrame:BBRectMake(250, 512+260+20*2+82, perfectCarinfoFormBgView.w - 30*2, 60)];
    
    [label setText:@"驾驶证年审"];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(48)) textColor:COLOR_BK_SHOW textAlignment:NSTextAlignmentLeft];
    label.font = [UIFont boldSystemFontOfSize:(48/2-3)*X_X_SCALE];
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    
    
    label= [[UILabel alloc] initWithFrame:BBRectMake(250, label.bottom/y_6_plus+18, perfectCarinfoFormBgView.w, 40)];
    label.text=@"您的驾驶证年审日期为";
    [label convertNewLabelWithFont:WY_FONT_SIZE(36) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    label= [[UILabel alloc] initWithFrame:BBRectMake(label.right/x_6_plus+5, label.top/y_6_plus, perfectCarinfoFormBgView.w, 40)];
    [label convertNewLabelWithFont:WY_FONT_SIZE(36) textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    NSDate *d = [driver.yxqz convertToDateWithFormat:@"yyyy-MM-dd"];
    NSString *yxqzStr = [d stringWithFormat:@"yyyy年MM月dd日"];
    if(yxqzStr){
     label.text = [NSString stringWithFormat:@"%@",yxqzStr];
    
    }else{
     label.text = [NSString stringWithFormat:@"--年--月--日 "];
    }

    [perfectCarinfoFormBgView addSubview:label];
    
    ZKButton * NJButton=[ZKButton blockButtonWithFrame:BBRectMake(0,512+260+20*2 ,1080,260)  type:UIButtonTypeCustom title:nil backgroundImage:nil andBlock:^(ZKButton *button) {
         [UITools alertWithMsg:@"该地区暂不支持服务"];
      
        
    }];

    [perfectCarinfoFormBgView addSubview:NJButton];
    
    //*********************************其他信息*********************************

    
    label= [[UILabel alloc] initWithFrame:BBRectMake(250, 512+20+260+260+20+20+70, perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:WY_FONT_SIZE(36) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    NSNumber * num =0;

    if (![driver.driverstatus isEqualToString:@"验证成功"]){
     //   NSLog(@"驾驶证未绑定成功 无法查询");
        
    }else{
         DriveLicensePeccancyRecord *record3 = [[[DataBase sharedDataBase] selectDriveLicensePeccancyRecordByUserId:APP_DELEGATE.userId] lastObject];
        if (record3) {
            DriveLicensePeccancyRecord *record3 = [[[DataBase sharedDataBase] selectDriveLicensePeccancyRecordByUserId:APP_DELEGATE.userId] lastObject];
             //   NSLog(@"%@",record3);
            NSArray *array=[Helper drivePeccancyMsgAnalysis:record3.jszwf_detail];
            for (NSDictionary *dic in array) {
                NSNumber *wf=[dic valueForKey:@"jkbj"];
                num = [NSNumber numberWithFloat:[num floatValue] + [wf floatValue]];
            }
        }

        
    }
    
    label.text = [NSString stringWithFormat:@"您当前周期有"];
     [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    label= [[UILabel alloc] initWithFrame:BBRectMake(label.right/x_6_plus+10, label.top/y_6_plus,30*2, 40)];
    [label convertNewLabelWithFont:WY_FONT_SIZE(36) textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
  
    label.text=[NSString stringWithFormat:@"%d",[num intValue]];
    [label sizeToFit];

    [perfectCarinfoFormBgView addSubview:label];
    label= [[UILabel alloc] initWithFrame:BBRectMake(label.right/x_6_plus+10, label.top/y_6_plus,30*2, 40)];
    [label convertNewLabelWithFont:WY_FONT_SIZE(36) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    
    label.text=@"分累计扣分";
    
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    
    label= [[UILabel alloc] initWithFrame:BBRectMake(250, label.bottom/y_6_plus+10, perfectCarinfoFormBgView.w , 40)];
    [label convertNewLabelWithFont:WY_FONT_SIZE(36) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
   
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    //获取当前时间
    NSDate * nowDate = [NSDate date];
    //获取时间差
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:d];
    if (timeInterval >=0) {
        label.text = [NSString stringWithFormat:@"本记分周期: %@",d];
        // label.text = [NSString stringWithFormat:@"本纪周期: %@",nowDate];
        NSString *zq= [nowDate stringWithFormat:@"yyyy-MM-dd"];
        
        NSString *next= [d stringWithFormat:@"yyyy-MM-dd"];
        label.text = [NSString stringWithFormat:@"本记分周期: %@到%@",next,zq];
        
    }else{
        
        NSString *zq= [nowDate stringWithFormat:@"yyyy-MM-dd"];
        
        NSString *next= [nowDate stringWithFormat:@"yyyy"];
        NSInteger year =[next integerValue];
        NSInteger nextyear=year -1;
        NSString *nextdate=[NSString stringWithFormat:@"%ld-%@",(long)nextyear,[nowDate stringWithFormat:@"MM-dd"]];
        label.text = [NSString stringWithFormat:@"本记分周期: %@到%@",nextdate,zq];
        
        
    }
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    label= [[UILabel alloc] initWithFrame:BBRectMake(250, label.bottom/y_6_plus+10, perfectCarinfoFormBgView.w - 30*2, 40)];
    
    [label convertNewLabelWithFont:WY_FONT_SIZE(36) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    label.text=@"驾驶证违法状态 :";
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    label= [[UILabel alloc] initWithFrame:BBRectMake(label.right/x_6_plus+5, label.top/y_6_plus, perfectCarinfoFormBgView.w - 30*2, 40)];
    
    [label convertNewLabelWithFont:WY_FONT_SIZE(36) textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];

    if([driver.driverstatus isEqualToString:@"验证成功"]){
        
    label.text = [NSString stringWithFormat:@"%@",driver.driverzt];
    }else{
     label.text = [NSString stringWithFormat:@"--"];
    
    }
    [perfectCarinfoFormBgView addSubview:label];
    
//    rootScrollView.contentSize = CGSizeMake(screenSize.width,35/PX_Y_SCALE*y_6_SCALE+(perfectCarinfoFormBgView.h-10)*PX_Y_SCALE);
      rootScrollView.contentSize = CGSizeMake(screenSize.width,(512+20+260+260+20+20+305+20)*y_6_plus+35);
}

#pragma mark _CarInfo
-(void)carInfoAndCreateView:(UIScrollView *)rootScrollView andCarInfo:(CarInfo *)car{
    UIImageView *perfectCarinfoFormBgView = [[UIImageView alloc] initWithFrame:BBRectMake(0, 0, 1080, 2503)];
    [perfectCarinfoFormBgView setBackgroundColor:[UIColor whiteColor]];
    [perfectCarinfoFormBgView setUserInteractionEnabled:YES];
    [rootScrollView addSubview:perfectCarinfoFormBgView];
    rootScrollView.backgroundColor=COLOR_FRAME_LINE;
    [_scroll addSubview:rootScrollView];
    
    //*********************************横线*********************************
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:BBRectMake(0, 0, APP_WY_WIDTH, 1)];
    [lineLabel setBackgroundColor:COLOR_FRAME_LINE];
    [lineLabel setSize:CGSizeMake((APP_WY_WIDTH )*x_6_plus, lineLabel.height+1)];
    //[perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [[UILabel alloc] initWithFrame:BBRectMake(0, 526, APP_WY_WIDTH, 20)];
    [lineLabel setBackgroundColor:COLOR_FRAME_LINE];
    [perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [[UILabel alloc] initWithFrame:BBRectMake(0, 526+20+260, APP_WY_WIDTH, 20)];
    [lineLabel setBackgroundColor:COLOR_FRAME_LINE];
    [perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [[UILabel alloc] initWithFrame:BBRectMake(0, 526+260+304+20*2, APP_WY_WIDTH, 20)];
    [lineLabel setBackgroundColor:COLOR_FRAME_LINE];
    [perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [[UILabel alloc] initWithFrame:BBRectMake(0, 526+260+304*2+20*3, APP_WY_WIDTH, 20)];
    [lineLabel setBackgroundColor:COLOR_FRAME_LINE];
    [perfectCarinfoFormBgView addSubview:lineLabel];

    lineLabel = [[UILabel alloc] initWithFrame:BBRectMake(0,526+260*2+304*2+20*4, APP_WY_WIDTH, 20)];
    [lineLabel setBackgroundColor:COLOR_FRAME_LINE];
    [perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [[UILabel alloc] initWithFrame:BBRectMake(0, 526+260*2+304*3+20*5, APP_WY_WIDTH, 20)];
    [lineLabel setBackgroundColor:COLOR_FRAME_LINE];
    [perfectCarinfoFormBgView addSubview:lineLabel];
 
//    
//    //*********************************车型*********************************
    UILabel *label = [[UILabel alloc] initWithFrame:BBRectMake(360, 100, 440, 80)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(72)) textColor:COLOR_NAV textAlignment:NSTextAlignmentLeft];
    [label setText:car.hphm];
    label.centerX=perfectCarinfoFormBgView.centerX;
    [perfectCarinfoFormBgView addSubview:label];
    //车辆信息
    ZKButton *XCButton=[ZKButton blockButtonWithFrame:BBRectMake(40,0,APP_WY_WIDTH-80 , 250)  type:UIButtonTypeCustom title:@""backgroundImage:nil andBlock:^(ZKButton *button) {
        CarInfoViewController *carInfoVC = [[CarInfoViewController alloc] initWithHphm:car.hphm];
    
        
        [self.navigationController pushViewController:carInfoVC animated:YES];
        
    }];
    [perfectCarinfoFormBgView addSubview:XCButton];
//
    //认证
     _hphmPrefix = [car.hphm substringToIndex:1];
    UIImageView *Image =[[UIImageView alloc]initWithFrame:BBRectMake(474, 200, 135, 40)];
    Image.centerX=perfectCarinfoFormBgView.centerX;
    if ([_hphmPrefix isEqualToString:@"云"]||[_hphmPrefix isEqualToString:@"青"]||[_hphmPrefix isEqualToString:@"渝"]||[_hphmPrefix isEqualToString:@"琼"]||[_hphmPrefix isEqualToString:@"鲁"]){
        
        NSRange range = [car.vehiclestatus rangeOfString:@"成功"];
        
        if (range.location != NSNotFound) {
           
            Image.image=[UIImage imageNamed:@"renzheng"];
           
            
        }else{
            Image.image=[UIImage imageNamed:@"未认证"];
//
            }
            }else{
        
        Image.image=[UIImage imageNamed:@"未认证"];
        }

    [perfectCarinfoFormBgView addSubview:Image];
    UIImageView *carImage =[[UIImageView alloc]initWithFrame:BBRectMake(225, 300-15, 100, 50+30)];
    NSString *urlstr = [NSString stringWithFormat:@"http://idc.pic-01.956122.com/allPic/CarLogo/%@.jpg", [[car.clsbdh substringToIndex:3] uppercaseString]];
    
    [carImage setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageNamed:@"home_car_brand_default"]];
    [perfectCarinfoFormBgView addSubview:carImage];
//
//
    label = [[UILabel alloc] initWithFrame:BBRectMake(355,300,150, 80)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    [label setText:car.clpp1];
    [label sizeToFit];
    label.centerX=perfectCarinfoFormBgView.centerX;
    label.centerY=carImage.centerY;
    [perfectCarinfoFormBgView addSubview:label];

 if(_ifTwocar==NO){
     _weathercar1 = [[UILabel alloc] initWithFrame:BBRectMake(225,370,0 ,80)];
   
    [_weathercar1 convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
     [perfectCarinfoFormBgView addSubview:_weathercar1];
     _cc_titlecar1 = [[UILabel alloc] initWithFrame:BBRectMake(_weathercar1.right/x_6_plus+10,370,0 ,80)];
     [_cc_titlecar1 convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_NAV textAlignment:NSTextAlignmentLeft];
     [perfectCarinfoFormBgView addSubview:_cc_titlecar1];
    }else if(_ifTwocar==YES){
        _weathercar2 = [[UILabel alloc] initWithFrame:BBRectMake(225,370,400 ,80)];
        [_weathercar2 convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];

        [perfectCarinfoFormBgView addSubview:_weathercar2];
        _cc_titlecar2 = [[UILabel alloc] initWithFrame:BBRectMake(725,370,400 ,80)];
        [_cc_titlecar2 convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_NAV textAlignment:NSTextAlignmentLeft];
        [perfectCarinfoFormBgView addSubview:_cc_titlecar2];
 }

//    //*********************************违章处理*********************************
    //
    Image=[[UIImageView alloc]initWithFrame:BBRectMake(120, 526+20+82, 88, 92)];
    Image.image=[UIImage imageNamed:@"违章图标"];
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:Image];
 
    Image=[[UIImageView alloc]initWithFrame:BBRectMake(940, 526+20+82, 34, 59)];
    Image.image=[UIImage imageNamed:@"形状"];
    Image.centerY=(526+20+130)*y_6_plus;
    [perfectCarinfoFormBgView addSubview:Image];
    if(_ifTwocar==NO){
    _carfirst= [[UILabel alloc] initWithFrame:BBRectMake(250, 526+82+20, perfectCarinfoFormBgView.w - 30*2, 60)];
    [_carfirst setText:@"新违章"];
    [_carfirst convertNewLabelWithFont:(WY_FONT_SIZE(48)) textColor:COLOR_BK_SHOW textAlignment:NSTextAlignmentLeft];
    _carfirst.font = [UIFont boldSystemFontOfSize:(48/2-3)*X_X_SCALE];
    [_carfirst sizeToFit];
    _carWeichuliL= [[UILabel alloc] initWithFrame:BBRectMake(_carfirst.right/x_6_plus+5, 526+82+20, 50, 60)];
    [_carWeichuliL convertNewLabelWithFont:(WY_FONT_SIZE(48)) textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    _carWeichuliL.text = @"--";
    [_carWeichuliL sizeToFit];
    _carfirsts= [[UILabel alloc] initWithFrame:BBRectMake(_carWeichuliL.right/x_6_plus+5, 526+82+20, perfectCarinfoFormBgView.w - 30*2, 60)];
    [_carfirsts setText:@"条"];
    [_carfirsts sizeToFit];
    [_carfirsts convertNewLabelWithFont:(WY_FONT_SIZE(48)) textColor:COLOR_BK_SHOW textAlignment:NSTextAlignmentLeft];
    _carfirsts.font = [UIFont boldSystemFontOfSize:(48/2-3)*X_X_SCALE];
        
    _carsecond= [[UILabel alloc] initWithFrame:BBRectMake(250, _carfirsts.bottom/y_6_plus+18, 300, 40)];
    [_carsecond convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_carsecond setText:@"共罚款"];
    [_carsecond sizeToFit];
        
    _carFakuanL= [[UILabel alloc] initWithFrame: BBRectMake(_carsecond.right/x_6_plus+5, _carsecond.top/y_6_plus, 80, 40)];
    [_carFakuanL convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    _carFakuanL.text = @"--";
    [_carFakuanL sizeToFit];
    _carseconds= [[UILabel alloc] initWithFrame:BBRectMake(_carFakuanL.right/x_6_plus+5, _carsecond.top/y_6_plus, 300, 40)];
    [_carseconds convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_carseconds setText:@"元"];
        [_carseconds sizeToFit];
    _carthird= [[UILabel alloc] initWithFrame:BBRectMake(_carseconds.right/x_6_plus+20, _carsecond.top/y_6_plus, 300, 40)];
    [_carthird convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_carthird setText:@"扣分"];
    [_carthird sizeToFit];
        
    _carKoufenL= [[UILabel alloc] initWithFrame:BBRectMake(_carthird.right/x_6_plus+5,_carsecond.top/y_6_plus, 80, 40)];
    [_carKoufenL convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    _carKoufenL.text = @"--";
    [_carKoufenL sizeToFit];
    _carthirds= [[UILabel alloc] initWithFrame:BBRectMake(_carKoufenL.right/x_6_plus+5, _carsecond.top/y_6_plus, 300, 40)];
    [_carthirds convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [_carthirds setText:@"元"];
        
    [perfectCarinfoFormBgView addSubview:_carfirst];
    [perfectCarinfoFormBgView addSubview:_carWeichuliL];
    [perfectCarinfoFormBgView addSubview:_carfirsts];
        
    [perfectCarinfoFormBgView addSubview:_carsecond];
    [perfectCarinfoFormBgView addSubview:_carFakuanL];
    [perfectCarinfoFormBgView addSubview:_carseconds];
    [perfectCarinfoFormBgView addSubview:_carthird];
    [perfectCarinfoFormBgView addSubview:_carthirds];
    [perfectCarinfoFormBgView addSubview:_carKoufenL];
    _ifTwocar=YES;
    
    }else if(_ifTwocar==YES)
    {
        _carfirst2= [[UILabel alloc] initWithFrame:BBRectMake(250, 526+82+20, perfectCarinfoFormBgView.w - 30*2, 60)];
        [_carfirst2 setText:@"新违章"];
        [_carfirst2 convertNewLabelWithFont:(WY_FONT_SIZE(48)) textColor:COLOR_BK_SHOW textAlignment:NSTextAlignmentLeft];
        _carfirst2.font = [UIFont boldSystemFontOfSize:(48/2-3)*X_X_SCALE];
        [_carfirst2 sizeToFit];
        _carWeichuliL2= [[UILabel alloc] initWithFrame:BBRectMake(_carfirst2.right/x_6_plus+5, 526+82+20, 50, 60)];
        [_carWeichuliL2 convertNewLabelWithFont:(WY_FONT_SIZE(48)) textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
        _carWeichuliL2.text = @"--";
        [_carWeichuliL2 sizeToFit];
        _carfirsts2= [[UILabel alloc] initWithFrame:BBRectMake(_carWeichuliL2.right/x_6_plus+5, 526+82+20, 300, 60)];
        [_carfirsts2 setText:@"条"];
        [_carfirsts2 convertNewLabelWithFont:(WY_FONT_SIZE(48)) textColor:COLOR_BK_SHOW textAlignment:NSTextAlignmentLeft];
        _carfirsts2.font = [UIFont boldSystemFontOfSize:(48/2-3)*X_X_SCALE];
        _carsecond2= [[UILabel alloc] initWithFrame:BBRectMake(250, _carWeichuliL2.bottom/y_6_plus+18, 300, 40)];
        [_carsecond2 convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        [_carsecond2 setText:@"共罚款"];
        [_carsecond2 sizeToFit];
        
        _carFakuanL2= [[UILabel alloc] initWithFrame: BBRectMake(_carsecond2.right/x_6_plus+5, _carsecond2.top/y_6_plus, 80, 40)];
        [_carFakuanL2 convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
        _carFakuanL2.text = @"--";
        [_carFakuanL2 sizeToFit];
        _carseconds2= [[UILabel alloc] initWithFrame:BBRectMake(_carFakuanL2.right/x_6_plus+5, _carsecond2.top/y_6_plus, 300, 40)];
        [_carseconds2 convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        [_carseconds2 setText:@"元"];
        [_carseconds2 sizeToFit];
        _carthird2= [[UILabel alloc] initWithFrame:BBRectMake(_carseconds2.right/x_6_plus+10, _carsecond2.top/y_6_plus, 300, 40)];
        [_carthird2 convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        [_carthird2 setText:@"扣分"];
        [_carthird2 sizeToFit];
        
        _carKoufenL2= [[UILabel alloc] initWithFrame:BBRectMake(_carthird2.right/x_6_plus+10,_carsecond2.top/y_6_plus, 80, 40)];
        [_carKoufenL2 convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
        _carKoufenL2.text = @"--";
        [_carKoufenL2 sizeToFit];
        _carthirds2= [[UILabel alloc] initWithFrame:BBRectMake(_carKoufenL2.right/x_6_plus+5, _carsecond2.top/y_6_plus, 300, 40)];
        [_carthirds2 convertNewLabelWithFont:(WY_FONT_SIZE(36)) textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
        [_carthirds2 setText:@"元"];
        
        [perfectCarinfoFormBgView addSubview:_carfirst2];
        [perfectCarinfoFormBgView addSubview:_carWeichuliL2];
        [perfectCarinfoFormBgView addSubview:_carfirsts2];
        
        [perfectCarinfoFormBgView addSubview:_carsecond2];
        [perfectCarinfoFormBgView addSubview:_carFakuanL2];
        [perfectCarinfoFormBgView addSubview:_carseconds2];
        [perfectCarinfoFormBgView addSubview:_carthird2];
        [perfectCarinfoFormBgView addSubview:_carthirds2];
        [perfectCarinfoFormBgView addSubview:_carKoufenL2];
    
    
    }
 
    //判断常用车辆
    if ([_hphmPrefix isEqualToString:@"云"]||[_hphmPrefix isEqualToString:@"青"]||[_hphmPrefix isEqualToString:@"渝"]||[_hphmPrefix isEqualToString:@"琼"]||[_hphmPrefix isEqualToString:@"鲁"]){
        
        ZKButton * weiFaButton=[ZKButton blockButtonWithFrame:BBRectMake(0 ,526+20,1080, 260)  type:UIButtonTypeCustom title:nil backgroundImage:nil andBlock:^(ZKButton *button) {
            
            
            PeccancyRecordViewController *prvc = [[PeccancyRecordViewController alloc] initWithHphm:car.hphm];
            [self.navigationController pushViewController:prvc animated:YES];
            
            
        }];
    //    weiFaButton.layer.cornerRadius = 5*y_6_plus;
//        weiFaButton.layer.masksToBounds = YES;
//        [weiFaButton setTitleColor:COLOR_NAV];
//        weiFaButton.layer.borderColor = COLOR_NAV.CGColor;
//        weiFaButton.layer.borderWidth=1;
//        weiFaButton.titleLabel.font=(WY_FONT_SIZE(36));
        [perfectCarinfoFormBgView addSubview:weiFaButton];
    }else{
        ZKButton * weiFaButton=[ZKButton blockButtonWithFrame:BBRectMake(0 ,526+20,1080, 260)  type:UIButtonTypeSystem title:nil backgroundImage:nil andBlock:^(ZKButton *button) {
            UpeccancyViewController *prvc = [[UpeccancyViewController alloc] initWithHphm:car.hphm];
            [self.navigationController pushViewController:prvc animated:YES];
            
        }];
 
//        weiFaButton.layer.cornerRadius = 5*y_6_plus;
//        weiFaButton.layer.masksToBounds = YES;
//        [weiFaButton setTitleColor:COLOR_NAV];
//        weiFaButton.layer.borderColor = COLOR_NAV.CGColor;
//        weiFaButton.layer.borderWidth=1;
//        weiFaButton.titleLabel.font=(WY_FONT_SIZE(36));
        [perfectCarinfoFormBgView addSubview:weiFaButton];
    
    }

//    //*********************************车辆年检*********************************
    
    Image=[[UIImageView alloc]initWithFrame:BBRectMake(120,  526+20+260+20+82, 91, 90)];
    Image.image=[UIImage imageNamed:@"车辆年检图标"];
    [perfectCarinfoFormBgView addSubview:Image];
    label = [[UILabel alloc] initWithFrame:BBRectMake(250, 526+20+260+20+82, perfectCarinfoFormBgView.w - 30*2, 60)];
    [label setText:@"车辆年检"];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(48)) textColor:COLOR_BK_SHOW textAlignment:NSTextAlignmentLeft];
    label.font = [UIFont boldSystemFontOfSize:(48/2-3)*X_X_SCALE];

    [perfectCarinfoFormBgView addSubview:label];
    

    label= [[UILabel alloc] initWithFrame:BBRectMake(250,label.bottom/y_6_plus+18, perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(36))  textColor:COLOR_BK_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"六年免检车辆"];
    [perfectCarinfoFormBgView addSubview:label];
    
    label= [[UILabel alloc] initWithFrame:BBRectMake(250, label.bottom/y_6_plus+10, 0, 40)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(36))  textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    [label setText:@"您的车辆年检到期日"];
    //    label.numberOfLines=0;
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    
    label= [[UILabel alloc] initWithFrame:BBRectMake(label.right/x_6_plus+5, label.top/y_6_plus, perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(36))   textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    if ([[car.yxqz convertToDateWithFormat:@"yyyy-MM-dd"] stringWithFormat:@"yyyy年MM月dd日"]) {
        label.text=[[car.yxqz convertToDateWithFormat:@"yyyy-MM-dd"] stringWithFormat:@"yyyy年MM月dd日"];
    }else {
        label.text=@"--";
    }
    [perfectCarinfoFormBgView addSubview:label];
    Image=[[UIImageView alloc]initWithFrame:BBRectMake(940, 526+20+82, 34, 59)];
    Image.image=[UIImage imageNamed:@"形状"];
    Image.centerY=(526+20+260+20+152)*y_6_plus;
    [perfectCarinfoFormBgView addSubview:Image];
    XCButton=[ZKButton blockButtonWithFrame:BBRectMake(0,526+20+260+20 ,1080 , 304)  type:UIButtonTypeCustom title:nil backgroundImage:nil andBlock:^(ZKButton *button) {
        
      //  [UITools alertWithMsg:@"是否拨打客服电话 4000956122" viewCon
        [UITools alertWithMsg:@"该地区暂不支持服务"];
        
    }];
//    XCButton.layer.borderWidth=1;
//    XCButton.titleLabel.font=(WY_FONT_SIZE(36));
//    XCButton.layer.cornerRadius = 5*y_6_plus;
//    XCButton.layer.masksToBounds = YES;
//    [XCButton setTitleColor:COLOR_NAV];
//    XCButton.layer.borderColor = COLOR_NAV.CGColor;
    [perfectCarinfoFormBgView addSubview:XCButton];

//    //*********************************车辆保险*********************************
    Image=[[UIImageView alloc]initWithFrame:BBRectMake(120,  526+304+260+20*3+82, 88, 117)];
    Image.image=[UIImage imageNamed:@"车辆保险图标"];
    [perfectCarinfoFormBgView addSubview:Image];

    label = [[UILabel alloc] initWithFrame:BBRectMake(250,  Image.top/y_6_plus, perfectCarinfoFormBgView.w - 30*2, 40)];
    [label setText:@"车辆保险"];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(48)) textColor:COLOR_BK_SHOW textAlignment:NSTextAlignmentLeft];
    label.font = [UIFont boldSystemFontOfSize:(48/2-3)*X_X_SCALE];
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    Image=[[UIImageView alloc]initWithFrame:BBRectMake(940, 526+20+82, 34, 59)];
    Image.image=[UIImage imageNamed:@"形状"];
    Image.centerY=(526+20+260+20+20+304+152)*y_6_plus;
    [perfectCarinfoFormBgView addSubview:Image];

    label= [[UILabel alloc] initWithFrame:BBRectMake(250,label.bottom/y_6_plus+18, perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(36))   textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    label.text= [NSString stringWithFormat:@"商业险到期日为"];
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
  
    label= [[UILabel alloc] initWithFrame:BBRectMake(label.right/x_6_plus+5,label.top/y_6_plus, perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(36))   textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    
    if([car.bxzzrq convertToDateWithFormat:@"yyyy-MM-dd"]){
        label.text =[[car.bxzzrq convertToDateWithFormat:@"yyyy-MM-dd"] stringWithFormat:@"MM月dd日"];
    }else{
        label.text =@"-月-日";
        
    }
    
    
    [perfectCarinfoFormBgView addSubview:label];
    label= [[UILabel alloc] initWithFrame:BBRectMake(250,  label.bottom/y_6_plus+10, perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(36))   textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    label.text= [NSString stringWithFormat:@"交强险到期日为"];
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    label= [[UILabel alloc] initWithFrame:BBRectMake(label.right/x_6_plus+5, label.top/y_6_plus, perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(36))   textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    if([car.bxzzrq convertToDateWithFormat:@"yyyy-MM-dd"]){
        label.text =[[car.bxzzrq convertToDateWithFormat:@"yyyy-MM-dd"] stringWithFormat:@"MM月dd日"];
    }else{
        label.text =@"-月-日";
        
    }
    [perfectCarinfoFormBgView addSubview:label];
    XCButton=[ZKButton blockButtonWithFrame:BBRectMake(0,526+20+260+20+304+20,1080 , 304)  type:UIButtonTypeSystem title:nil backgroundImage:nil andBlock:^(ZKButton *button) {
        
        
        
        BXPerfectCarinfoViewController *bxpciVC = [[BXPerfectCarinfoViewController alloc] init];
        bxpciVC.car = car;
        [self.navigationController pushViewController:bxpciVC animated:YES];
        
        
    }];
//    XCButton.layer.borderWidth=1;
//    
//    XCButton.layer.cornerRadius = 5*y_6_plus;
//    XCButton.layer.masksToBounds = YES;
//    [XCButton setTitleColor:COLOR_NAV];
//    XCButton.titleLabel.font=(WY_FONT_SIZE(36));
//    XCButton.layer.borderColor = COLOR_NAV.CGColor;
    [perfectCarinfoFormBgView addSubview:XCButton];
//    //*********************************常规保养********************************
    Image=[[UIImageView alloc]initWithFrame:BBRectMake(120,   526+304*2+260+20*4+82, 72, 102)];
    Image.image=[UIImage imageNamed:@"保养图标"];
    [perfectCarinfoFormBgView addSubview:Image];
    label = [[UILabel alloc] initWithFrame:BBRectMake(250,  Image.top/y_6_plus, perfectCarinfoFormBgView.w - 30*2, 40)];
    [label setText:@"常规保养"];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(48)) textColor:COLOR_BK_SHOW textAlignment:NSTextAlignmentLeft];
    label.font = [UIFont boldSystemFontOfSize:(48/2-3)*X_X_SCALE];
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    Image=[[UIImageView alloc]initWithFrame:BBRectMake(940, 526+20+82, 34, 59)];
    Image.image=[UIImage imageNamed:@"形状"];
    Image.centerY=(526+20+260+20+20+304+304+20+130)*y_6_plus;
    [perfectCarinfoFormBgView addSubview:Image];
    label= [[UILabel alloc] initWithFrame:BBRectMake(250, label.bottom/y_6_plus+18, perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(36))   textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    [label setText:@"车辆行驶里程为"];
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    label= [[UILabel alloc] initWithFrame:BBRectMake(label.right/x_6_plus+5, label.top/y_6_plus, perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(36))   textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"--"];
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    label= [[UILabel alloc] initWithFrame:BBRectMake(label.right/x_6_plus+5, label.top/y_6_plus, perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(36))   textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    [label setText:@"万公里"];
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    
//    _xxlcTF = [[UITextField alloc] initWithFrame:BBRectMake(640+10+10+13, 1940+146+10+2,110, 40)];
//    _xxlcTF.delegate = self;
//  
//    [_xxlcTF setFont:(WY_FONT_SIZE(36))  ];
//    [_xxlcTF setBorderStyle:UITextBorderStyleNone];
//    [_xxlcTF setPlaceholder:@""];
//    [_xxlcTF limitCHTextLength:5];
//    _xxlcTF.textColor=COLOR_BUTTON_YELLOW;
//    [_xxlcTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
//    
//    [perfectCarinfoFormBgView addSubview:_xxlcTF];

    
    XCButton=[ZKButton blockButtonWithFrame:BBRectMake(0,526+304*2+260+20*4,1080 , 260)  type:UIButtonTypeSystem title:nil backgroundImage:nil andBlock:^(ZKButton *button) {
        CarInfo *c = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId andHphm:car.hphm][0];
        if ([c.carId isLegal] && ![car.carId isEqualToString:@"(null)"]) {
            MaintenanceController *mvc = [[MaintenanceController alloc] init];
            [self.navigationController pushViewController:mvc animated:YES];
        }else{
            if (![c.clpp1 isLegal]) {
                [UITools alertWithMsg:@"请选择认证成功的车辆"];
            }else{
                [UITools alertWithMsg:[NSString stringWithFormat:@"您的“%@”需要完善车型信息",car.clpp1] viewController:self action:^{
                    CarDisplacementController *mvc = [[CarDisplacementController alloc] init];
                    mvc.car = car;
                    mvc.needHome = YES;
                    [self.navigationController pushViewController:mvc animated:YES];
                }];
            }
        }
        
    }];
//    XCButton.layer.cornerRadius = 5*y_6_plus;
//    XCButton.layer.masksToBounds = YES;
//    [XCButton setTitleColor:COLOR_NAV];
//    XCButton.layer.borderColor = COLOR_NAV.CGColor;
//    XCButton.layer.borderWidth=1;
//     XCButton.titleLabel.font=(WY_FONT_SIZE(36));
    [perfectCarinfoFormBgView addSubview:XCButton];

//    //*********************************车辆估价********************************
    Image=[[UIImageView alloc]initWithFrame:BBRectMake(120,  526+304*2+260*2+20*5+82, 97, 62)];
    Image.image=[UIImage imageNamed:@"车辆估价图标"];
    [perfectCarinfoFormBgView addSubview:Image];
    label = [[UILabel alloc] initWithFrame:BBRectMake(250,  526+304*2+260*2+20*5+82, perfectCarinfoFormBgView.w - 30*2, 50)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(48)) textColor:COLOR_BK_SHOW textAlignment:NSTextAlignmentLeft];
    label.font = [UIFont boldSystemFontOfSize:(48/2-3)*X_X_SCALE];
    [label setText:@"车辆估价"];
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    Image=[[UIImageView alloc]initWithFrame:BBRectMake(940, 526+20+82, 34, 59)];
    Image.image=[UIImage imageNamed:@"形状"];
    Image.centerY=(526+20+260+20+20+304+304+20+260+20+152)*y_6_plus;
    [perfectCarinfoFormBgView addSubview:Image];
    label = [[UILabel alloc] initWithFrame:BBRectMake(250, label.bottom/y_6_plus+18, perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(36))   textColor:COLOR_BK_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:car.clpp1];
    [perfectCarinfoFormBgView addSubview:label];
    
    label= [[UILabel alloc] initWithFrame:BBRectMake(250,  label.bottom/y_6_plus+10, perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(36))   textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    
    label.text =@"行驶时间";
    [label sizeToFit];
     [perfectCarinfoFormBgView addSubview:label];
    
    
    label= [[UILabel alloc] initWithFrame:BBRectMake(label.right/x_6_plus+5,label.top/y_6_plus, 0, 40)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(36))  textColor: COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
   
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate * lastDate = [formatter dateFromString:car.ccdjrq];
    //获取当前时间
    if(lastDate){
        NSDate * nowDate = [NSDate date];
        //获取时间差
        NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:lastDate];
        if (timeInterval >= 0 && timeInterval <365*24*3600) {
            // int mm = (int)timeInterval / (24*3600);
            label.text=@" 1 ";
        }else if (timeInterval >= 365*24*3600){
            int nn = (int)timeInterval / (365*24*3600);
            label.text=[NSString stringWithFormat:@" %d ",nn];
            
        }
    }else{
        
        label.text=[NSString stringWithFormat:@" -- "];
        
    }
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    label= [[UILabel alloc] initWithFrame:BBRectMake(label.right/x_6_plus+5, label.top/y_6_plus, 200, 40)];
    [label convertNewLabelWithFont:(WY_FONT_SIZE(36))   textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    
    label.text =@"年";
    [label sizeToFit];
    [perfectCarinfoFormBgView addSubview:label];
    
    XCButton=[ZKButton blockButtonWithFrame:BBRectMake(0, 526+304*2+260*2+20*5 ,1080 , 304)  type:UIButtonTypeSystem title:nil backgroundImage:nil andBlock:^(ZKButton *button) {
        
        UserCarViewController *cwVC = [[UserCarViewController alloc] init];
        [self.navigationController pushViewController:cwVC animated:YES];
        
    }];
//    XCButton.layer.borderWidth=1;
//    XCButton.layer.cornerRadius = 5*y_6_plus;
//    XCButton.layer.masksToBounds = YES;
//    [XCButton setTitleColor:COLOR_NAV];
//    XCButton.layer.borderColor = COLOR_NAV.CGColor;
//       XCButton.titleLabel.font=(WY_FONT_SIZE(36));
    [perfectCarinfoFormBgView addSubview:XCButton];

    rootScrollView.contentSize = CGSizeMake(screenSize.width,(526+304*3+260*2+20*5+64)*y_6_plus+35);
//    //车辆信息违法请求
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLabel) name:@"weifa" object:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
        //    define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789.\n"] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
        
        NSString *upperCaseString1 = [filtered uppercaseString];
        BOOL canChange = [string isEqualToString:upperCaseString1];
        
        return canChange;
 
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)changeLabel{
       _number =_cars.count;
    if (_number == 1) {
       CarInfo *car1  = [self.cars objectAtIndex:0];
        CarPeccancyRecord *carPeccancyRecord = [[[DataBase sharedDataBase] selectCarPeccancyRecordByUserId:APP_DELEGATE.userId andHphm:car1.hphm] lastObject];
        if (!carPeccancyRecord) {
            
            _carWeichuliL.text = @"--";
            _carFakuanL.text = @"--";
            _carKoufenL.text = @"--";
        }else{
            
            NSArray *pmsArr = [Helper carPeccancyMsgAnalysis:carPeccancyRecord.jdcwf_detail withHphm:car1.hphm];
            NSDictionary *peccancyRDict = [Helper filtrateCarPeccancyRecordMessages:pmsArr withHpzl:car1.hpzl andHphm:car1.hphm];
            NSArray *payArr = [peccancyRDict objectForKey:KEY_FILTRATE_CAR_PECCANCY_MSGS_RESULT_PAY_MSG];
            NSArray *dealArr = [peccancyRDict objectForKey:KEY_FILTRATE_CAR_PECCANCY_MSGS_RESULT_DEAL_MSG];
            _carWeichuliL.text = [NSString stringWithFormat:@"%d", (int)[payArr count] + (int)[dealArr count]];
            
            NSInteger fkje = 0;
            NSInteger koufen = 0;
            for (CarPeccancyMsg *msg in payArr) {
                fkje = fkje + [msg.fkje integerValue];
                koufen = koufen + [msg.wfjfs integerValue];
            }
            for (CarPeccancyMsg *msg in dealArr) {
                fkje = fkje + [msg.fkje integerValue];
                koufen = koufen + [msg.wfjfs integerValue];
            }
            _carFakuanL.text = [NSString stringWithFormat:@"%d",(int)fkje];
            _carKoufenL.text = [NSString stringWithFormat:@"%d",(int)koufen];
            
           
            _carFakuanL.text = [NSString stringWithFormat:@"%d",(int)fkje];
            _carKoufenL.text = [NSString stringWithFormat:@"%d",(int)koufen];
            _carWeichuliL.frame= BBRectMake(_carfirst.right/x_6_plus+5, 526+82+20, 50, 60);
            [_carWeichuliL sizeToFit];
            _carfirsts.frame= BBRectMake(_carWeichuliL.right/x_6_plus+5, 526+82+20, 500, 60);
            [_carfirsts sizeToFit];
            _carsecond.frame= BBRectMake(250, _carfirsts.bottom/y_6_plus+18, 300, 40);
            [_carsecond sizeToFit];
            _carFakuanL.frame=  BBRectMake(_carsecond.right/x_6_plus+5, _carsecond.top/y_6_plus, 300, 40);
            [_carFakuanL sizeToFit];
            _carseconds.frame= BBRectMake(_carFakuanL.right/x_6_plus+5, _carsecond.top/y_6_plus, 300, 40);
            [_carseconds sizeToFit];
            _carthird.frame=BBRectMake(_carseconds.right/x_6_plus+20, _carsecond.top/y_6_plus, 300, 40);
            [_carthird sizeToFit];
            _carKoufenL.frame= BBRectMake(_carthird.right/x_6_plus+5,_carsecond.top/y_6_plus, 80, 40);
            [_carKoufenL sizeToFit];
            _carthirds.frame= BBRectMake(_carKoufenL.right/x_6_plus+5, _carsecond.top/y_6_plus, 300, 40);
            
        }
    }else{
        CarInfo *car1  = [self.cars objectAtIndex:0];
        CarInfo *car2  = [self.cars objectAtIndex:1];
        CarPeccancyRecord *carPeccancyRecord = [[[DataBase sharedDataBase] selectCarPeccancyRecordByUserId:APP_DELEGATE.userId andHphm:car1.hphm] lastObject];
        if (!carPeccancyRecord) {
            
            _carWeichuliL.text = @"--";
            _carFakuanL.text = @"--";
            _carKoufenL.text = @"--";
        }else{
            
            NSArray *pmsArr = [Helper carPeccancyMsgAnalysis:carPeccancyRecord.jdcwf_detail withHphm:car1.hphm];
            NSDictionary *peccancyRDict = [Helper filtrateCarPeccancyRecordMessages:pmsArr withHpzl:car1.hpzl andHphm:car1.hphm];
            NSArray *payArr = [peccancyRDict objectForKey:KEY_FILTRATE_CAR_PECCANCY_MSGS_RESULT_PAY_MSG];
            NSArray *dealArr = [peccancyRDict objectForKey:KEY_FILTRATE_CAR_PECCANCY_MSGS_RESULT_DEAL_MSG];
            _carWeichuliL.text = [NSString stringWithFormat:@"%d", (int)[payArr count] + (int)[dealArr count]];
            
            NSInteger fkje = 0;
            NSInteger koufen = 0;
            for (CarPeccancyMsg *msg in payArr) {
                fkje = fkje + [msg.fkje integerValue];
                koufen = koufen + [msg.wfjfs integerValue];
            }
            for (CarPeccancyMsg *msg in dealArr) {
                fkje = fkje + [msg.fkje integerValue];
                koufen = koufen + [msg.wfjfs integerValue];
            }
            
            _carFakuanL.text = [NSString stringWithFormat:@"%d",(int)fkje];
            _carKoufenL.text = [NSString stringWithFormat:@"%d",(int)koufen];
            _carWeichuliL.frame= BBRectMake(_carfirst.right/x_6_plus+5, 526+82+20, 50, 60);
            [_carWeichuliL sizeToFit];
            _carfirsts.frame= BBRectMake(_carWeichuliL.right/x_6_plus+5, 526+82+20, 500, 60);
            [_carfirsts sizeToFit];
            _carsecond.frame= BBRectMake(250, _carfirsts.bottom/y_6_plus+18, 300, 40);
           [_carsecond sizeToFit];
            _carFakuanL.frame=  BBRectMake(_carsecond.right/x_6_plus+5, _carsecond.top/y_6_plus, 300, 40);
            [_carFakuanL sizeToFit];
            _carseconds.frame= BBRectMake(_carFakuanL.right/x_6_plus+5, _carsecond.top/y_6_plus, 300, 40);
             [_carseconds sizeToFit];
            _carthird.frame=BBRectMake(_carseconds.right/x_6_plus+10, _carsecond.top/y_6_plus, 300, 40);
            [_carthird sizeToFit];
            _carKoufenL.frame= BBRectMake(_carthird.right/x_6_plus+10,_carsecond.top/y_6_plus, 80, 40);
            [_carKoufenL sizeToFit];
            _carthirds.frame= BBRectMake(_carKoufenL.right/x_6_plus+5, _carsecond.top/y_6_plus, 300, 40);
        }
        
            CarPeccancyRecord *carPeccancyRecord2 = [[[DataBase sharedDataBase] selectCarPeccancyRecordByUserId:APP_DELEGATE.userId andHphm:car2.hphm] lastObject];
            if (!carPeccancyRecord2) {
                
                _carWeichuliL2.text = @"--";
                _carFakuanL2.text = @"--";
                _carKoufenL2.text = @"--";
            }else{
                
                NSArray *pmsArr = [Helper carPeccancyMsgAnalysis:carPeccancyRecord2.jdcwf_detail withHphm:car2.hphm];
                NSDictionary *peccancyRDict = [Helper filtrateCarPeccancyRecordMessages:pmsArr withHpzl:car2.hpzl andHphm:car2.hphm];
                NSArray *payArr = [peccancyRDict objectForKey:KEY_FILTRATE_CAR_PECCANCY_MSGS_RESULT_PAY_MSG];
                NSArray *dealArr = [peccancyRDict objectForKey:KEY_FILTRATE_CAR_PECCANCY_MSGS_RESULT_DEAL_MSG];
                _carWeichuliL2.text = [NSString stringWithFormat:@"%d", (int)[payArr count] + (int)[dealArr count]];
                
                NSInteger fkje = 0;
                NSInteger koufen = 0;
                for (CarPeccancyMsg *msg in payArr) {
                    fkje = fkje + [msg.fkje integerValue];
                    koufen = koufen + [msg.wfjfs integerValue];
                }
                for (CarPeccancyMsg *msg in dealArr) {
                    fkje = fkje + [msg.fkje integerValue];
                    koufen = koufen + [msg.wfjfs integerValue];
                }
                _carFakuanL2.text = [NSString stringWithFormat:@"%d",(int)fkje];
                _carKoufenL2.text = [NSString stringWithFormat:@"%d",(int)koufen];
                _carFakuanL2.text = [NSString stringWithFormat:@"%d",(int)fkje];
                _carKoufenL2.text = [NSString stringWithFormat:@"%d",(int)koufen];
                _carWeichuliL2.frame= BBRectMake(_carfirst2.right/x_6_plus+5, 526+82+20, 50 , 60);
                [_carWeichuliL2 sizeToFit];
                _carfirsts2.frame= BBRectMake(_carWeichuliL2.right/x_6_plus+5, 526+82+20, 500, 80);
                _carfirsts2.text=@"条";
                [_carfirsts2 sizeToFit];
                _carsecond2.frame= BBRectMake(_carfirst.left/x_6_plus, _carWeichuliL2.bottom/y_6_plus+18, 300, 40);
                [_carsecond2 sizeToFit];
                _carFakuanL2.frame=  BBRectMake(_carsecond2.right/x_6_plus+5, _carsecond2.top/y_6_plus, 300, 40);
                [_carFakuanL2 sizeToFit];
                _carseconds2.frame= BBRectMake(_carFakuanL2.right/x_6_plus+5, _carsecond2.top/y_6_plus, 300, 40);
                [_carseconds2 sizeToFit];
                _carthird2.frame=BBRectMake(_carseconds2.right/x_6_plus+10, _carsecond2.top/y_6_plus, 300, 40);
                [_carthird2 sizeToFit];
                _carKoufenL2.frame= BBRectMake(_carthird2.right/x_6_plus+10,_carsecond2.top/y_6_plus, 80, 40);
                [_carKoufenL2 sizeToFit];
                _carthirds2.frame= BBRectMake(_carKoufenL2.right/x_6_plus+5, _carsecond2.top/y_6_plus, 300, 40);
    
    
            }
    
        }

}

#pragma mark -驾驶证违章请求
- (void)getDriveLicensePeccancyRecordWithDriver:(DriverInfo*)driver{
    _netStatus = isloadingPeccancyRecord;
    [self reloadWeifaCount];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"listbyjszh" forKey:@"action"];
    [dict setObject:driver.driversfzmhm forKey:@"jszh"];
    [dict setObject:driver.dabh forKey:@"dabh"];

    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:NO callBackWithObj:driver onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if (result == postSucc) {
            _netStatus = loadingPeccancyRecordSucc;
            
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            NSString *jsonStr = [writer stringWithObject:requestObj];
            DriveLicensePeccancyRecord *driveLPR = [[DriveLicensePeccancyRecord alloc] initWithDriversfzmhm:((DriverInfo*)callBackObj).driversfzmhm jszwf_detail:jsonStr jszwf_gxsj:[[NSDate date]string] andUseId:APP_DELEGATE.userId];
            //ok写入数据库
            [driveLPR update];
        }else{//解析错误
            _netStatus = loadingPeccancyRecordFailed;
            
            [self.view showAlertText:[NSString stringWithFormat:@"驾驶证违章信息获取失败,%@", requestObj]];
        }
        
        //更新界面显示
        [self reloadWeifaCount];
        
    } onError:^(NSString *errorStr) {
        
        _netStatus = loadingPeccancyRecordFailed;
        [self.view showAlertText:errorStr];
        //更新页面显示
        [self reloadWeifaCount];
    }];
    
}
- (void)reloadWeifaCount{
    //违法记录数显示
   
    NSRange range = [self.driver.driverstatus rangeOfString:@"成功"];
    DriveLicensePeccancyRecord *record = [[[DataBase sharedDataBase] selectDriveLicensePeccancyRecordByUserId:APP_DELEGATE.userId] lastObject];
    
    if (range.location != NSNotFound) {
        //网络是否加载
        if(_netStatus == loadingPeccancyRecordSucc){
            BOOL needLoad_net = NO;
            if (record) {//有记录判断是否超时
                CGFloat timeinterval = [[NSDate date] timeIntervalSinceDate:[record.jszwf_gxsj date]];
                if (timeinterval > 10*60.0f) {
                    needLoad_net = YES;
                }
            }else{//无记录
                needLoad_net = YES;
            }
            //以上判断数据需要网络加载，以下判断是否已经加载失败
            if (_netStatus == loadingPeccancyRecordFailed) {
                needLoad_net = NO;
            }
            if (needLoad_net) {
                if(self.driver && ([self.driver.driverstatus rangeOfString:@"成功"].location != NSNotFound)){
                    [self getDriveLicensePeccancyRecordWithDriver:self.driver];
                }
            }
        }

        //界面如何显示
        for (UIView *v in _driWeichuliL.subviews) {
            [v removeFromSuperview];
        }
        
        if (_netStatus == loadingPeccancyRecordFailed) {
            _driWeichuliL.text = @"--";//显示--
            _driFakuanL.text = @"--";
            _driKoufenL.text = @"--";
        }else if (_netStatus == loadingPeccancyRecordSucc){
            if (record) {//显示记录数
                
                NSArray *array=[Helper drivePeccancyMsgAnalysis:record.jszwf_detail];
                NSInteger count = 0;
                NSInteger fkje = 0;
                NSInteger koufen = 0;
                for (NSDictionary *dic in array) {
                    if (![[dic valueForKey:@"jkbj"]isEqualToString:@"1"]) {
                        count++;
                        fkje = fkje + [[dic valueForKey:@"fkje"] integerValue];
                        koufen = koufen + [[dic valueForKey:@"wfjfs"] integerValue];
                        
                    }
                    _driWeichuliL.text = [NSString stringWithFormat:@"%d", (int)count];
                    _driFakuanL.text = [NSString stringWithFormat:@"%d", (int)fkje];
                    _driKoufenL.text = [NSString stringWithFormat:@"%d", (int)koufen];
                    _driWeichuliL.frame= BBRectMake(_drifirst.right/x_6_plus+5, _drifirst.top/y_6_plus, 50, 60);
                    [_driWeichuliL sizeToFit];
                    _drifirsts.frame= BBRectMake(_driWeichuliL.right/x_6_plus+5, _drifirst.top/y_6_plus, 500, 60);
                    [_drifirsts sizeToFit];
                    _drisecond.frame= BBRectMake(250, _drifirsts.bottom/y_6_plus+18, 300, 40);
                    [_drisecond sizeToFit];
                    _driFakuanL.frame=  BBRectMake(_drisecond.right/x_6_plus+5, _drisecond.top/y_6_plus, 300, 40);
                    [_driFakuanL sizeToFit];
                    _driseconds.frame= BBRectMake(_driFakuanL.right/x_6_plus+5, _drisecond.top/y_6_plus, 300, 40);
                    [_driseconds sizeToFit];
                    _drithird.frame=BBRectMake(_driseconds.right/x_6_plus+10, _drisecond.top/y_6_plus, 300, 40);
                    [_drithird sizeToFit];
                    _driKoufenL.frame= BBRectMake(_drithird.right/x_6_plus+10,_drisecond.top/y_6_plus, 80, 40);
                    [_driKoufenL sizeToFit];
                    _drithirds.frame= BBRectMake(_driKoufenL.right/x_6_plus+5, _drisecond.top/y_6_plus, 300, 40);
//                    if (count == 0){
//                        
//                        
//                        _driWeichuliL.text = [NSString stringWithFormat:@"%d", (int)count];
//                        _driFakuanL.text = [NSString stringWithFormat:@"%d", (int)count];
//                        _driKoufenL.text = [NSString stringWithFormat:@"%d", (int)count];
//                    }
                    
                }
                
                
            }
        }else if (_netStatus == isloadingPeccancyRecord){
            
         
            _driWeichuliL.text = @"-";//显示--
            _driFakuanL.text = @"-";
            _driKoufenL.text = @"-";
            
        }
        
    }else{
        _driWeichuliL.text = @"--";
        _driFakuanL.text = @"--";
        _driKoufenL.text = @"--";
        
    }
    
}


#pragma mark -车辆违章请求

- (void)netGetPeccancyRecord:(CarInfo*)car{
     _hphmPrefix = [car.hphm substringToIndex:1];
    [_carNetStatusDict removeObjectForKey:car.hphm];
if ([_hphmPrefix isEqualToString:@"云"]||[_hphmPrefix isEqualToString:@"青"]||[_hphmPrefix isEqualToString:@"渝"]||[_hphmPrefix isEqualToString:@"琼"]||[_hphmPrefix isEqualToString:@"鲁"]){
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"list" forKey:@"action"];
    [dict setObject:car.hpzl forKey:@"hpzl"];
    [dict setObject:car.hphm forKey:@"hphm"];
    
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:NO  callBackWithObj:car onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            NSString *jsonStr = [writer stringWithObject:requestObj];
            CarPeccancyRecord *carpr = [[CarPeccancyRecord alloc] initWithHpzl:((CarInfo*)callBackObj).hpzl hphm:((CarInfo*)callBackObj).hphm jdcwf_detail:jsonStr jdcwf_gxsj:[[NSDate date]string] andUserId:APP_DELEGATE.userId];
            //ok写入数据库
            [carpr update];
            
            [_carNetStatusDict setObject:PECCANCY_NET_STATUS_SUCC forKey:car.hphm];
        }else{
            [_carNetStatusDict setObject:PECCANCY_NET_STATUS_FAILED forKey:car.hphm];
            
            [self.view showAlertText:[NSString stringWithFormat:@"车辆违章信息查询失败,%@", requestObj]];
        }
        //更新界面显示
        [self reloadPeccancyInfoView];
    } onError:^(NSString *errorStr) {
        [self.view showAlertText:errorStr];
        
        [_carNetStatusDict setObject:PECCANCY_NET_STATUS_FAILED forKey:car.hphm];
        //更新界面显示
        [self reloadPeccancyInfoView];
     
    }];
    }else{
     
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dict setObject:@"listbycxy" forKey:@"action"];
        [dict setObject:car.hpzl forKey:@"hpzl"];
        [dict setObject:car.hphm forKey:@"hphm"];
        [dict setObject:car.clsbdh forKey:@"clsbdh"];
        [dict setObject:car.fdjh forKey:@"fdjh"];
        
        [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:NO  callBackWithObj:car onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
            NSLog(@"%@",requestObj);
            
            id dicUcar=  requestObj;
            
            if ([dicUcar isKindOfClass:[NSDictionary class]]){
                if([[dicUcar valueForKey:@"ErrorCode"]isEqualToString:@"0"]){
                    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
                    NSString *jsonStr = [writer stringWithObject:requestObj];
                    //     NSLog(@"%@",jsonStr);
                    CarPeccancyRecord *carpr = [[CarPeccancyRecord alloc] initWithHpzl:((CarInfo*)callBackObj).hpzl hphm:((CarInfo*)callBackObj).hphm jdcwf_detail:jsonStr jdcwf_gxsj:[[NSDate date]string] andUserId:APP_DELEGATE.userId];
                    
                    //ok写入数据库
                    [carpr update];
                    
                   [_carNetStatusDict setObject:PECCANCY_NET_STATUS_SUCC forKey:car.hphm];
                    
                    
                }else{
                    [_carNetStatusDict setObject:PECCANCY_NET_STATUS_FAILED forKey:car.hphm];
                    [self.view showAlertText:[NSString stringWithFormat:@"常用车辆查询失败"]];
                   // [self.view showAlertText:[NSString stringWithFormat:@"常用车辆查询失败,%@", requestObj]];
                //更新界面显示
                    [self reloadPeccancyInfoView];

                    
                }
                
                
                
            }else{
                
                [_carNetStatusDict setObject:PECCANCY_NET_STATUS_FAILED forKey:car.hphm];
                //更新界面显示
                [self reloadPeccancyInfoView];
              
            }
            
            
        } onError:^(NSString *errorStr) {
            
            
            
        }];
        
        [_carNetStatusDict setObject:PECCANCY_NET_STATUS_FAILED forKey:car.hphm];
        //更新界面显示
        [self reloadPeccancyInfoView];
     
     
     }
    
}
- (void)reloadPeccancyInfoView{//从DB直接load数据。（数据一定在其他位置改动了DB，故不需重新从网络请求）。网络请求的判断基于：超时自动加载与无数据加载
       // CarInfo *car1  = [self.cars objectAtIndex:0];
  
    //违章信息
    self.carPeccancyRecordDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (CarInfo *car in self.cars) {
        //获取车辆违章记录
        NSArray *carPeccancyRecors = [[DataBase sharedDataBase] selectCarPeccancyRecordByUserId:APP_DELEGATE.userId andHphm:car.hphm];
        if ([carPeccancyRecors count]) {
            CarPeccancyRecord *record = [carPeccancyRecors lastObject];
            [self.carPeccancyRecordDict setObject:record forKey:car.hphm];
        }
    }
    
    //刷新显示违章记录
    //--刷新显示车辆违章记录
    for (CarInfo *car in self.cars) {
        CarPeccancyRecord *record = [self.carPeccancyRecordDict objectForKey:car.hphm];
        BOOL needLoad_net = NO;
        if (record) {//超时加载
            CGFloat timeinterval = [[NSDate date] timeIntervalSinceDate:[record.jdcwf_gxsj date]];
            if (timeinterval > 10*60.0f) {
                needLoad_net = YES;
            }
        }else{//无数据加载
            needLoad_net = YES;
        }
        //以上判断数据需要网络加载，以下判断是否已经加载失败
        NSString *carNetStatus = [_carNetStatusDict objectForKey:car.hphm];
        if (needLoad_net) {
            if ([carNetStatus isEqualToString:PECCANCY_NET_STATUS_FAILED]) {
                needLoad_net = NO;
            }
        }
        
        if (needLoad_net) {
            //车辆绑定成功 可查询违法记录
            if (car && (([car.vehiclestatus rangeOfString:@"成功"].location != NSNotFound)|| ([car.vehiclestatus rangeOfString:@"成功"].location != NSNotFound))) {
                [self netGetPeccancyRecord:car];
            }
        }else{
         
            NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
            [center postNotificationName:@"weifa" object:self userInfo:nil];
            
        }
        
    }
   
}
#pragma mark -天气请求
-(void)reloadWeahther{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *cityname=[[NSUserDefaults standardUserDefaults]valueForKey:@"zhuanshu"];
    if ([cityname rangeOfString:@"市"].location != NSNotFound && [cityname rangeOfString:@"市"].location == cityname.length-1) {
        cityname = [cityname substringToIndex:cityname.length-1];
    }
    [dict setObject:cityname forKey:@"cityname"];
    [[NetworkEngine sharedNetwork] postBody:dict apiPath:kWeatherURL hasHeader:YES finish:^(ResultState state, id resObj) {
        if (state == StateSucceed) {
            
            NSDictionary *dic = [resObj valueForKey:@"body"];
            NSDictionary *weatherdic = [dic valueForKey:@"weather"];
            
            // NSString *syLabel= [[[weatherdic valueForKey:@"times"] convertToDateWithFormat:@"YYYY-MM-dd"] stringWithFormat:@"YYYY年MM月dd日"];
            NSString *syLabel1=[[weatherdic valueForKey:@"times"]substringFromIndex:5];
            NSString *syLabel= [[syLabel1 convertToDateWithFormat:@"MM-dd"] stringWithFormat:@"MM月dd日"];
            
            NSString * weather=[NSString stringWithFormat:@"%@ %@/%@℃ %@",syLabel,[weatherdic valueForKey:@"min_w"],[weatherdic valueForKey:@"max_w"],[weatherdic valueForKey:@"sc"]];
            NSString * cc_title =[NSString stringWithFormat:@"%@洗车",[weatherdic valueForKey:@"cc_title"]];
            _weathercar1.text=weather;
            _cc_titlecar1.text=cc_title;
            _weathercar2.text=weather;
            _cc_titlecar2.text=cc_title;
            [_weathercar1 sizeToFit];
            [_weathercar2 sizeToFit];
//            
            _cc_titlecar1.frame=BBRectMake(_weathercar1.right/x_6_plus+10,370,0 ,80);
            [_cc_titlecar1 sizeToFit];
            _cc_titlecar2.frame=BBRectMake(_weathercar2.right/x_6_plus+10,370,0 ,80);
            [_cc_titlecar2 sizeToFit];


     
        }else{
          
            if ([resObj[@"head"][@"rspCode"] isEqualToString:@"-1"]) {
 
            }
        }
        
    } failed:^(NSError *error) {

        
    }];
    
}

#pragma mark - TopBtnClicked
-(void)pressBtn:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    [self changeViewPositionAndColorOfBtn:btn];
    if (btn != _tempBtn){
        _tempBtn.selected = NO;

        _tempBtn = sender;
    }
}

#pragma mark - change Btn Title Color
-(void)changeViewPositionAndColorOfBtn:(UIButton *)btn
{
    btn.selected = YES;
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];

    
    [UIView animateWithDuration:0.15 animations:^{
         _yellowLabel1.centerX=btn.centerX;
        _scroll.contentOffset = CGPointMake((btn.tag-10)*WIDTH, 0);
    }];
    
    
}

#pragma mark - scroll delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger num = _scroll.contentOffset.x/WIDTH;
    UIButton * btn = (UIButton *)[self.view viewWithTag:num+10];
    NSLog(@"%ld",(long)btn.tag);
    [self pressBtn:btn];
    NSInteger count ;
    if(_number ==0){
        count =2;
        
    }else {
        count =3;
    }
    if(_menuView.bottom==APP_VIEW_Y+40*count){
        
        [UIView animateWithDuration:0.5 animations:^{
            _menuView.frame = CGRectMake(APP_WIDTH - 140, -40*count, 140, 40*count);
            
        }];
    }
}

//-(UILabel*)createUIlabel:(NSString *)title andFont:(CGFloat)font andColor:(UIColor*)color {
//    UILabel * label =[[UILabel alloc]init];
//    label.text = title;
//    label.textColor = color;
//    UIFont *fnt = [UIFont fontWithName:@"HelveticaNeue" size:font];CGSize size = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
//    // 名字的H
//    CGFloat nameH = size.height;
//    // 名字的W
//    CGFloat nameW = size.width;
//    label.frame =CGRectMake(0, 0, nameW, nameH);
//    label.font = Font(font);
//    return label;
//}

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
