//
//  PeccancyRecordViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-17.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "PeccancyRecordViewController.h"

@interface PeccancyRecordViewController ()

@end

@implementation PeccancyRecordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithHphm:(NSString*)hphm{
    if (self = [super init]) {
        CarInfo *car = [[[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId andHphm:hphm] lastObject];
        _car_ = [[CarInfo alloc] initWithHpzl:car.hpzl hpzlname:car.hpzlname hphm:car.hphm clsbdh:car.clsbdh clpp1:car.clpp1 vehicletypename:car.vehicletypename vehiclepic:car.vehiclepic vehiclestatus:car.vehiclestatus yxqz:car.yxqz bxzzrq:car.bxzzrq ccdjrq:car.ccdjrq vehiclegxsj:car.vehiclegxsj isupdate:car.isupdate zt:car.zt sfzmhm:car.sfzmhm syr:car.syr andUseId:car.userId];
    }
    return self;
}

#define TAG_LEFTSEG_BUT     200
#define TAG_RIGHTSEG_BUT    201
- (void)_loadView{
    CGFloat segHeight = 30;
    CGFloat segWidth = 210;
    
    UIImageView *topBgView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_X, APP_VIEW_Y, APP_WIDTH, segHeight)];
    [topBgView setImage:[UIImage imageNamed:@"bg_white_top.png"]];
    [self.view addSubview:topBgView];
    
    UILabel *leftHphmLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_X + 5, APP_VIEW_Y + 3, segWidth, segHeight - 3)];
    leftHphmLabel.text = [_car_.hphm uppercaseString];
    leftHphmLabel.backgroundColor = [UIColor clearColor];
    leftHphmLabel.font = [UIFont italicSystemFontOfSize:18];
    [self.view addSubview:leftHphmLabel];
    
    _rootTableView = [[UITableView alloc] init];
    [_rootTableView setFrame:CGRectMake(APP_X, APP_VIEW_Y + segHeight, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - segHeight)];
    _rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rootTableView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    [_rootTableView setContentSize:CGSizeMake(_rootTableView.width, _rootTableView.height)];
    [self.view addSubview:_rootTableView];
    
    _leftSegButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftSegButton setFrame:CGRectMake(APP_WIDTH - segWidth, APP_VIEW_Y + 2, segWidth/2, segHeight - 4)];
    [_leftSegButton setTitle:@"待处罚" forState:UIControlStateNormal];
    [_leftSegButton setTitleColor:COLOR_BUTTON_BLUE forState:UIControlStateNormal];
    _leftSegButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_leftSegButton addTarget:self action:@selector(segClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_leftSegButton setTag:TAG_LEFTSEG_BUT];
    [self.view addSubview:_leftSegButton];
    
    _rightSegButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightSegButton setFrame:CGRectMake(APP_WIDTH - segWidth/2, APP_VIEW_Y + 2, segWidth/2, segHeight - 4)];
    [_rightSegButton setTitle:@"待缴款" forState:UIControlStateNormal];
    [_rightSegButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _rightSegButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_rightSegButton addTarget:self action:@selector(segClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_rightSegButton setTag:TAG_RIGHTSEG_BUT];
    [self.view addSubview:_rightSegButton];
    
    _segSelectedImgView = [[UIImageView alloc] initWithFrame:CGRectMake(_leftSegButton.left, _leftSegButton.bottom, _leftSegButton.width, 1)];
    _segSelectedImgView.backgroundColor = COLOR_BUTTON_BLUE;
    [self.view addSubview:_segSelectedImgView];
    
    _egoView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(APP_X, -_rootTableView.frame.size.height, _rootTableView.frame.size.width, _rootTableView.frame.size.height)];
    _egoView.delegate = self;
    [_rootTableView addSubview:_egoView];
    
}

- (void)filtrateMsg:(NSArray*)array{
    
    
    [self.carMsgs_pay removeAllObjects];
    [self.carMsgs_dealing removeAllObjects];
    NSDictionary *dict = [Helper filtrateCarPeccancyRecordMessages:array withHpzl:_car_.hpzl andHphm:_car_.hphm];
    [self.carMsgs_pay addObjectsFromArray:[dict objectForKey:KEY_FILTRATE_CAR_PECCANCY_MSGS_RESULT_PAY_MSG]];
    [self.carMsgs_dealing addObjectsFromArray:[dict objectForKey:KEY_FILTRATE_CAR_PECCANCY_MSGS_RESULT_DEAL_MSG]];
}

- (void)_loadData{
    
    NSArray *carPRS = [[DataBase sharedDataBase] selectCarPeccancyRecordByUserId:APP_DELEGATE.userId andHphm:_car_.hphm];
    if ([carPRS count]) {
        self.carPeccancyRecord = [carPRS lastObject];
        NSArray *arr = [Helper carPeccancyMsgAnalysis:self.carPeccancyRecord.jdcwf_detail withHphm:_car_.hphm];
        [self filtrateMsg:arr];
    }
    
    
    
}

- (void)loadPhotos{
    
    NSString *key = [NSString stringWithFormat:@"%@%@", self.xh, _car_.hphm];
    NSArray *alreadyArr = [[[NSUserDefaults standardUserDefaults] objectForKey:KEY_PHOTO_DICT_IN_USERDEFAULT] objectForKey:key];
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    for (NSString *photoPath in alreadyArr) {
        MWPhoto *photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:photoPath]];
        photo.caption = @"违章照片";
        [photos addObject:photo];
    }
    self.photos = photos;
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    //browser.wantsFullScreenLayout = NO;
    //[browser setInitialPageIndex:2];
    [self.navigationController pushViewController:browser animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
    self.carMsgs_pay = arr;
    NSMutableArray *arr1 = [[NSMutableArray alloc] initWithCapacity:0];
    self.carMsgs_dealing = arr1;
    
    [self _loadView];
    
    _isDealingRecord = YES;
    [self _loadData];
    
    if ([self.carMsgs_dealing count] == 0 && [self.carMsgs_pay count] > 0) {
        [self segClicked:_rightSegButton];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self setCustomNavigationTitle:@"车辆违法记录"];
    
    
    
//    [self _loadData];
//    [_rootTableView reloadData];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //更新界面显示--每次进入页面，刷新状态
    [_rootTableView setContentOffset:CGPointMake(_rootTableView.left, - 80) animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark- clicks!!
- (void)pay:(id)sender{
    
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"非常抱歉！" message:@"由于财政缴费接口限制，手机应用暂不提供支付功能。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        alert.tag = TAG_ALERT_CAN_FINISHED_PAY_ACTION;
//        [alert show];
//        return;
    
    
    //判断数据是否超时
    NSDate *updateDate = [self.carPeccancyRecord.jdcwf_gxsj date];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:updateDate];
    if (timeInterval > 10*60.0f) {
        [UIAlertView alertTitle:@"" msg:@"以上为历史数据，此条违法无法缴款"];
        return;
    }
    
    //当天晚上23：45-第二天00：05期间无法缴款
    NSString *dangtianYMD = [[NSDate date] stringWithFormat:@"yy-MM-dd"];
    NSString *dangtianW = [dangtianYMD stringByAppendingString:@" 23:45:00"];
    NSString *dangtianZ = [dangtianYMD stringByAppendingString:@" 00:05:00"];

    NSDate *limitDateW = [dangtianW convertToDateWithFormat:@"yy-MM-dd HH:mm:SS"];
    NSDate *limitDateZ = [dangtianZ convertToDateWithFormat:@"yy-MM-dd HH:mm:SS"];

    NSDate *nowDate = [NSDate date];
    NSTimeInterval t = [nowDate timeIntervalSinceDate:limitDateW];
    if (t > 0 || t == 0) {
        [UIAlertView alertTitle:@"" msg:@"该时间段（23：45 - 00：05）内无法缴款"];
        return;
    }
    
    t = [nowDate timeIntervalSinceDate:limitDateZ];
    if (t < 0 || t == 0) {
        [UIAlertView alertTitle:@"" msg:@"该时间段（23：45 - 00：05）内无法缴款"];
        return;
    }
    
    
    //支付
    CarPeccancyMsg *carMsg = [_carMsgs_pay objectAtIndex:((UIButton*)sender).tag];
    
    PayViewController *payVC = [[PayViewController alloc] initWithFkje:carMsg.fkje znj:carMsg.znj hphm:_car_.hphm jdsbh:carMsg.jdsbh username:APP_DELEGATE.userName fxjg:carMsg.fxjg cljg:carMsg.cljg cljgmc:carMsg.cljgmc wsjyw:carMsg.wsjyw];
    [self.navigationController pushViewController:payVC animated:YES];
    
}

- (void)dealPeccancyWithCarPeccancyMsg:(CarPeccancyMsg*)msg isyun:(BOOL)isyun{
    
    DealingViewController *dealVC = [[DealingViewController alloc] init];
    
    dealVC.car = _car_;
    dealVC.carPeccancyMsg = msg;
    dealVC.isYunnan = isyun;
    [self.navigationController pushViewController:dealVC animated:YES];
}

- (void)dealPeccancy:(id)sender{
    
    //判断数据是否超时
    NSDate *updateDate = [self.carPeccancyRecord.jdcwf_gxsj date];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:updateDate];
    if (timeInterval > 10*60.0f) {
        [self.view showAlertText:@"以上为历史数据，此条违法无法缴款"];
        return;
    }
    
    _dealingMsg = [_carMsgs_dealing objectAtIndex:((UIButton*)sender).tag];
    if([_dealingMsg.cfd isEqualToString:@"未知"]){
        [self.view showAlertText:@"此条违法无法处理"];
        return;
    }
    
    //判断是否可处理标记
    if ([_dealingMsg.hphm_head isEqualToString:@"0"] && [_dealingMsg.qrbj isEqualToString:@"1"]) {
        
        NSString *markAddr = @"";
        if ([_dealingMsg.cfd isEqualToString:@"海南"] || [_dealingMsg.cfd isEqualToString:@"云南"] || [_dealingMsg.cfd isEqualToString:@"青海"] || [_dealingMsg.cfd isEqualToString:@"重庆"]) {
            
            if([_dealingMsg.cfd isEqualToString:@"海南"]){
                markAddr = @"琼";
            }else if ([_dealingMsg.cfd isEqualToString:@"云南"]){
                markAddr = @"云";
            }else if ([_dealingMsg.cfd isEqualToString:@"青海"]){
                markAddr = @"青";
            }else if ([_dealingMsg.cfd isEqualToString:@"重庆"]){
                markAddr = @"渝";
            }
            
        }else{
            markAddr = _car_.hphm;
            
            if (![markAddr hasPrefix:@"琼"] && ![markAddr hasPrefix:@"云"] && ![markAddr hasPrefix:@"青"] && ![markAddr hasPrefix:@"渝"]) {
                
                [self.view showAlertText:@"此条违法无法处理"];
                return;
                
            }
        }
        
        
//        //原来  如果是琼，并且扣分了，无法处理。
//        if ([markAddr hasPrefix:@"琼"] && [_dealingMsg.wfjfs integerValue] > 0) {
//            [self.view showAlertText:@"此条违法无法处理"];
//            return;
//        }
        
        //现在  只要不是云，凡是扣分了，都无法处理
        if (![markAddr hasPrefix:@"云"]) {
            if ([_dealingMsg.wfjfs integerValue] > 0) {
                [UIAlertView alertTitle:@"违法处理" msg:@"当前违法记录有扣分，无法处理"];
                return;
            }
        }

        //现在  所有地区车辆，罚款超过200元，不能处理
        if ([_dealingMsg.fkje integerValue] > 200) {
            [UIAlertView alertTitle:@"违法处理" msg:@"当前违法记录罚款金额超过200元，无法处理"];
            return;
        }
        
        
        //判断车牌不是云南，检查是否绑定驾照，如果没有绑定提示绑定
        if (![markAddr hasPrefix:@"云"]) {
            
            DriverInfo *driver = [[[DataBase sharedDataBase] selectDriverByUserId:APP_DELEGATE.userId] lastObject];
            NSRange range = [driver.driverstatus rangeOfString:@"成功"];
            if (driver && range.location != NSNotFound) {
                //转到处理页面
                [self dealPeccancyWithCarPeccancyMsg:_dealingMsg isyun:NO];
            }else{
                //提示绑定驾照
                //弹出框，输入 ：车主姓名，身份证号码
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"请先绑定驾照" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                alert.tag = TAG_ALERT_BAND_DRIVER_LICENSE;
                [alert show];
            }
            
        }else{
            
            BOOL chuliguo = [[NSUserDefaults standardUserDefaults] boolForKey:KEY_YUN_NAN_CHU_LI];
            if (chuliguo) {
                [self dealPeccancyWithCarPeccancyMsg:_dealingMsg isyun:YES];

            }else{
                //弹出框，输入 ：车主姓名，身份证号码
                AlertTextFieldView *alertTFV = [[AlertTextFieldView alloc] initWithTarget:self selector:@selector(alertTFVFinishedEntry:) placehoders:[NSArray arrayWithObjects:@"车主姓名", @"请输入车主身份证号码", nil]];
                [alertTFV show];

            }
        }
        
    }else{
        [self.view showAlertText:@"此条违法无法处理"];
    }
}


- (void)checkPhoto:(UIButton*)button{
    
    CarPeccancyMsg *msg = [_carMsgs_dealing objectAtIndex:button.tag];
    self.xh = ((CarPeccancyMsg*)[_carMsgs_dealing objectAtIndex:button.tag]).xh;

    if ([msg.photostatus isEqualToString:@"1"]) {
        //判断本地是否有数据
        NSString *key = [NSString stringWithFormat:@"%@%@", self.xh, _car_.hphm];
        NSArray *alreadyArr = [[[NSUserDefaults standardUserDefaults] objectForKey:KEY_PHOTO_DICT_IN_USERDEFAULT] objectForKey:key];
        if (![alreadyArr count]) {
            [self getPhotoDatas];
        }else{
            [self loadPhotos];
        }
    }else if([msg.photostatus isEqualToString:@"2"] || [msg.photostatus isEqualToString:@"5"]) {
        [self netApplyCheckPhoto];
    }
}


- (void)segClicked:(UIButton*)button{
    
    //button.titleLabel.font = [UIFont systemFontOfSize:17];
    
    
    if (button.tag == TAG_LEFTSEG_BUT) {
        _isDealingRecord = YES;
        [_leftSegButton setTitleColor:COLOR_BUTTON_BLUE forState:UIControlStateNormal];
        [_rightSegButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.25f animations:^{
            [_segSelectedImgView setFrame:CGRectMake(_leftSegButton.left, _leftSegButton.bottom, _leftSegButton.width, 1)];
            
        }];
        
    }else if (button.tag == TAG_RIGHTSEG_BUT){
        _isDealingRecord = NO;
        [_rightSegButton setTitleColor:COLOR_BUTTON_BLUE forState:UIControlStateNormal];
        [_leftSegButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        //_leftSegButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [UIView animateWithDuration:0.25f animations:^{
            [_segSelectedImgView setFrame:CGRectMake(_rightSegButton.left, _rightSegButton.bottom, _rightSegButton.width, 1)];
            
        }];
        
    }
    [_rootTableView reloadData];
}



#pragma mark - EGORefreshTableHeaderDelegate


- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self getPeccancyRecord:_car_];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_egoView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_egoView egoRefreshScrollViewDidEndDragging:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [_egoView egoRefreshScrollViewDidEndDragging:scrollView];
}


#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}



#pragma mark- uialertview DELEGATE

- (void)alertTFVFinishedEntry:(AlertTextFieldView*)alertTFV{
    NSString *name = [alertTFV textAtIndex:0];
    NSString *idnum = [alertTFV textAtIndex:1];
    if ([_car_.syr isEqualToString:name] && [_car_.sfzmhm isEqualToString:idnum]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KEY_YUN_NAN_CHU_LI];
        //转到处理页面
        [self dealPeccancyWithCarPeccancyMsg:_dealingMsg isyun:YES];
        
    } else {
        [self.view showAlertText:@"所有人验证失败"];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    
    if (alertView.tag == TAG_ALERT_BAND_DRIVER_LICENSE){
        //跳转绑定驾照界面
        DriverBindViewController *dBindVC = [[DriverBindViewController alloc] init];
        
        DriverInfo *driver = [[[DataBase sharedDataBase] selectDriverByUserId:APP_DELEGATE.userId] lastObject];
        if (driver) {
            dBindVC.reBindDriver = driver;
        }
        
        [self.navigationController pushViewController:dBindVC animated:YES];
    }
}

#define SPACE                           10
#define SIGLE_TEXT_LINE_HEIGHT          25
#define BUTTON_HEIGHT                   40
#define BUTTON_SPACE                    20
- (CGFloat)heightForStr:(NSString*)str{
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(APP_WIDTH - 95 - SPACE*2,2000) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height + 5;
}
#pragma mark- tableview DELEGATE and DATASOURCE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isDealingRecord) {
        return [_carMsgs_dealing count];
    }else{
        return [_carMsgs_pay count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CarPeccancyMsg *msg;
    if (_isDealingRecord) {
        msg = [_carMsgs_dealing objectAtIndex:indexPath.row];
        
    }else{
        msg = [_carMsgs_pay objectAtIndex:indexPath.row];
    }
    NSString *jg = [msg cljgmc];
    if ([jg isEqualToString:@""]) {
        jg = [msg cjjgmc];
    }
    
    CGFloat height = [self heightForStr:jg] + [self heightForStr:[msg wfdz]] + [self heightForStr:[msg wfnr]] + SIGLE_TEXT_LINE_HEIGHT*2 + BUTTON_HEIGHT + BUTTON_SPACE;

    
    return height + SPACE*2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell_id = CELL_ID_PEECANCY_RECORD;
    PeccancyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PeccancyRecordCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.payButton addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
        [cell.checkPhotoButton addTarget:self action:@selector(checkPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [cell.dealPeccancyButton addTarget:self action:@selector(dealPeccancy:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    //show mes
    cell.payButton.tag = indexPath.row;
    cell.checkPhotoButton.tag = indexPath.row;
    cell.dealPeccancyButton.tag = indexPath.row;
    
    cell.sNumL.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    
    CarPeccancyMsg *msg;
    if (_isDealingRecord) {
        msg = [_carMsgs_dealing objectAtIndex:indexPath.row];
        
    }else{
        msg = [_carMsgs_pay objectAtIndex:indexPath.row];
    }
    NSString *jg = [msg cljgmc];
    cell.cjjgLabelLabel.text = @"处理机关：";
    if ([jg isEqualToString:@""]) {
        jg = [msg cjjgmc];
        cell.cjjgLabelLabel.text = @"采集机关：";
    }
    cell.cjjgL.text = jg;
    cell.wfsjL.text = [msg wfsj];
    cell.wfddL.text = [msg wfdz];
    cell.wfxwL.text = [msg wfnr];
    
    //cell.cfbzL.text = [NSString stringWithFormat:@"罚款%@元 记%@分",msg.fkje, msg.wfjfs];
    //******************************
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:@"罚款"];
    
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:15],
                           NSForegroundColorAttributeName : COLOR_BUTTON_YELLOW};
    
    [aString appendAttributedString:[[NSAttributedString alloc] initWithString:msg.fkje attributes:dict]];
    [aString appendAttributedString:[[NSAttributedString alloc] initWithString:@"元 记"]];
     [aString appendAttributedString:[[NSAttributedString alloc] initWithString:msg.wfjfs attributes:dict]];
    [aString appendAttributedString:[[NSAttributedString alloc] initWithString:@"分"]];

    [cell.cfbzL setAttributedText:aString];

    
    
    
    if (_isDealingRecord) {
        cell.payButton.hidden = YES;
        cell.lineVertical.hidden = NO;
        cell.checkPhotoButton.hidden = NO;
        cell.dealPeccancyButton.hidden = NO;

        cell.dealPeccancyButton.userInteractionEnabled = YES;
        cell.dealPeccancyButton.backgroundColor = [UIColor whiteColor];
        //cell.dealPeccancyButton.titleLabel.textColor = COLOR_LINK;
        [cell.dealPeccancyButton setTitleColor:COLOR_LINK forState:UIControlStateNormal];

        /*
         未确认,确认成功,确认失败,有异议,确认中
         */
        if ([msg.wzzt isEqualToString:@"未确认"]){//此时可以提交处理
            [cell.dealPeccancyButton setTitle:@"立即处理" forState:UIControlStateNormal];
            
        }else if ([msg.wzzt isEqualToString:@"确认失败"]){
            [cell.dealPeccancyButton setTitle:@"失败 重新处理" forState:UIControlStateNormal];
            
        }else if ([msg.wzzt isEqualToString:@"确认成功"]){
            [cell.dealPeccancyButton setTitle:@"处理成功" forState:UIControlStateNormal];

            cell.dealPeccancyButton.userInteractionEnabled = NO;
            //cell.dealPeccancyButton.backgroundColor = [UIColor clearColor];
            //cell.dealPeccancyButton.titleLabel.textColor = COLOR_FONT_NOTICE;
            [cell.dealPeccancyButton setTitleColor:COLOR_FONT_NOTICE forState:UIControlStateNormal];

        }else{
            [cell.dealPeccancyButton setTitle:msg.wzzt forState:UIControlStateNormal];
            cell.dealPeccancyButton.userInteractionEnabled = NO;
            //cell.dealPeccancyButton.backgroundColor = [UIColor clearColor];
            //cell.dealPeccancyButton.titleLabel.textColor = COLOR_FONT_NOTICE;
            [cell.dealPeccancyButton setTitleColor:COLOR_FONT_NOTICE forState:UIControlStateNormal];

        }
        
        
        
        /*
         listall返回的非现场结果增加photostatus字段：
         1:有照片可查看－－－查看
         2:无照片未申请－－－申请
         3:无照片申请中－－－等待
         4:无照片申请成功－－－无法查看
         5:无照片申请过期－－－重新申请
         */
        cell.checkPhotoButton.userInteractionEnabled = YES;
        cell.checkPhotoButton.backgroundColor = [UIColor whiteColor];
        [cell.checkPhotoButton setTitleColor:COLOR_LINK forState:UIControlStateNormal];

        if ([msg.photostatus isEqualToString:@"1"]) {
            [cell.checkPhotoButton setTitle:@"立即查看照片" forState:UIControlStateNormal];
            
        }else if([msg.photostatus isEqualToString:@"2"]) {
            [cell.checkPhotoButton setTitle:@"申请查看照片" forState:UIControlStateNormal];
            
        }else if([msg.photostatus isEqualToString:@"5"]) {
            [cell.checkPhotoButton setTitle:@"过期 重新申请" forState:UIControlStateNormal];
            
        }else if([msg.photostatus isEqualToString:@"3"]) {
            cell.checkPhotoButton.userInteractionEnabled = NO;
            [cell.checkPhotoButton setTitle:@"照片申请中..." forState:UIControlStateNormal];
            //cell.checkPhotoButton.backgroundColor = [UIColor clearColor];
            //cell.checkPhotoButton.titleLabel.textColor = COLOR_FONT_NOTICE;
            [cell.checkPhotoButton setTitleColor:COLOR_FONT_NOTICE forState:UIControlStateNormal];

        }else if([msg.photostatus isEqualToString:@"4"]) {
            cell.checkPhotoButton.userInteractionEnabled = NO;
            [cell.checkPhotoButton setTitle:@"无法查看照片" forState:UIControlStateNormal];
            //cell.checkPhotoButton.backgroundColor = [UIColor clearColor];
            //cell.checkPhotoButton.titleLabel.textColor = COLOR_FONT_NOTICE;
            [cell.checkPhotoButton setTitleColor:COLOR_FONT_NOTICE forState:UIControlStateNormal];

        }
        
    }else{
        cell.lineVertical.hidden = YES;
        cell.payButton.hidden = NO;
        cell.payButton.backgroundColor = [UIColor whiteColor];
        cell.payButton.titleLabel.textColor = COLOR_LINK;

        cell.checkPhotoButton.hidden = YES;
        cell.dealPeccancyButton.hidden = YES;
    }
    
    
    //set frame
    CGFloat space = 10;
    CGFloat labellabelWidth = 75;
    CGFloat bgheight = [self heightForStr:cell.cjjgL.text] + [self heightForStr:cell.wfddL.text] + [self heightForStr:cell.wfxwL.text] + SIGLE_TEXT_LINE_HEIGHT*2 + BUTTON_HEIGHT + BUTTON_SPACE;
    [cell.bgView setFrame:CGRectMake(0, 20, APP_WIDTH, bgheight)];
    [cell.line1 setFrame:CGRectMake(0, cell.bgView.top, cell.bgView.width, 1)];
    
    [cell.cjjgLabelLabel setFrame:CGRectMake(space*2, space*3, labellabelWidth, SIGLE_TEXT_LINE_HEIGHT)];
    [cell.cjjgL setFrame:CGRectMake(cell.cjjgLabelLabel.right, cell.cjjgLabelLabel.top + 1, APP_WIDTH - cell.cjjgLabelLabel.right - space*2, [self heightForStr:cell.cjjgL.text])];
    [cell.wfsjLabelLabel setFrame:CGRectMake(cell.cjjgLabelLabel.left, cell.cjjgL.bottom, labellabelWidth, SIGLE_TEXT_LINE_HEIGHT)];
    [cell.wfsjL setFrame:CGRectMake(cell.wfsjLabelLabel.right, cell.wfsjLabelLabel.top, APP_WIDTH - cell.wfsjLabelLabel.right - space*2, SIGLE_TEXT_LINE_HEIGHT)];
    [cell.wfddLabelLabel setFrame:CGRectMake(cell.cjjgLabelLabel.left, cell.wfsjL.bottom + 1, labellabelWidth, SIGLE_TEXT_LINE_HEIGHT)];
    [cell.wfddL setFrame:CGRectMake(cell.wfddLabelLabel.right, cell.wfddLabelLabel.top, APP_WIDTH - cell.wfddLabelLabel.right - space*2, [self heightForStr:cell.wfddL.text])];
    [cell.wfxwLabelLabel setFrame:CGRectMake(cell.cjjgLabelLabel.left, cell.wfddL.bottom, labellabelWidth, SIGLE_TEXT_LINE_HEIGHT)];
    [cell.wfxwL setFrame:CGRectMake(cell.wfxwLabelLabel.right, cell.wfxwLabelLabel.top + 1, APP_WIDTH - cell.wfxwLabelLabel.right - space*2, [self heightForStr:cell.wfxwL.text])];
    [cell.cfbzLabelLabel setFrame:CGRectMake(cell.cjjgLabelLabel.left, cell.wfxwL.bottom, labellabelWidth, SIGLE_TEXT_LINE_HEIGHT)];
    [cell.cfbzL setFrame:CGRectMake(cell.cfbzLabelLabel.right, cell.cfbzLabelLabel.top, APP_WIDTH - cell.cfbzLabelLabel.right - space*2, SIGLE_TEXT_LINE_HEIGHT)];
    
    
   
    CGFloat buttonY = cell.bgView.height + cell.bgView.top - BUTTON_HEIGHT;
    [cell.payButton setFrame:CGRectMake(0, buttonY, cell.bgView.width, BUTTON_HEIGHT)];
    CGFloat buttonWidth = (cell.bgView.width)/2;
    CGFloat buttonSpace = 0;
    [cell.checkPhotoButton setFrame:CGRectMake(buttonSpace, buttonY, buttonWidth, BUTTON_HEIGHT)];
    [cell.dealPeccancyButton setFrame:CGRectMake(buttonSpace + (buttonSpace + buttonWidth), buttonY, buttonWidth, BUTTON_HEIGHT)];
    [cell.line2 setFrame:CGRectMake(0, cell.dealPeccancyButton.top - 1, cell.bgView.width, 1)];
    [cell.line3 setFrame:CGRectMake(0, cell.dealPeccancyButton.bottom, cell.bgView.width, 1)];
    [cell.lineVertical setFrame:CGRectMake(buttonWidth, cell.line2.top, 1, BUTTON_HEIGHT)];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



#pragma mark-  网络请求

- (void)getPhotoDatas{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"viewphoto" forKey:@"action"];
    NSString *xh = @"";
    if ([self.xh rangeOfString:SERVER_BACK_WITHOUT].location == NSNotFound) {
        xh = self.xh;
    }
    [dict setObject:xh forKey:@"xh"];
    [dict setObject:_car_.hphm forKey:@"hphm"];
    
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSArray *arr = [resDict objectForKey:@"photos"];
            for (int i = 0; i < [arr count]; i ++) {
                NSDictionary *dict = [arr objectAtIndex:i];
                
                NSString *photoDataBase64String = [dict objectForKey:@"zpstr"];
                if ([photoDataBase64String isEqualToString:@""]) {
                    continue;
                }
                NSData *photoData = [NSData dataFromBase64String: photoDataBase64String];
                
                //获取Document文件夹路径
                NSURL *appUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
                //在Document下建立名为photo文件夹
                NSString *dirPath = [[appUrl path] stringByAppendingPathComponent:@"photo"];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                BOOL isDirExist = [fileManager fileExistsAtPath:dirPath];
                if (!isDirExist) {
                    BOOL createSucc = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
                    if (createSucc) {
                        isDirExist = YES;
                    }
                }
                if (isDirExist) {
                    //写图片文件，名为：datei.jpg
                    NSString *imgName = [[[NSDate date] string] stringByAppendingString:[NSString stringWithFormat:@"%d.jpg",i]];
                    NSString *imgPath = [dirPath stringByAppendingPathComponent:imgName];
                    BOOL writeJpgSucc = [photoData writeToFile:imgPath atomically:YES];
                    if (!writeJpgSucc) {
                        [self.view showAlertText:@"程序出错，写图片文件失败"];
                    }else{
                        //文件信息存入userdefualt
                        NSString *key = [NSString stringWithFormat:@"%@%@", self.xh, _car_.hphm];
                        NSArray *alreadyArr = [[[NSUserDefaults standardUserDefaults] objectForKey: KEY_PHOTO_DICT_IN_USERDEFAULT] objectForKey:key];
                        NSMutableArray *photos;
                        if ([alreadyArr count]) {
                            photos = [[NSMutableArray alloc] initWithArray:alreadyArr];
                        }else{
                            photos = [[NSMutableArray alloc] initWithCapacity:0];
                        }
                        [photos addObject:imgPath];
                        NSDictionary *alreadyDict = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_PHOTO_DICT_IN_USERDEFAULT];
                        NSMutableDictionary *photoDict;
                        if (alreadyDict) {
                            photoDict = [[NSMutableDictionary alloc] initWithDictionary:alreadyDict];
                        }else{
                            photoDict = [[NSMutableDictionary alloc] initWithCapacity:0];
                        }
                        [photoDict setObject:photos forKey:key];
                        [[NSUserDefaults standardUserDefaults] setObject:photoDict forKey:KEY_PHOTO_DICT_IN_USERDEFAULT];
                        
                    }
                }else{
                    [self.view showAlertText:@"程序出错，建立图片文件夹失败"];
                }
                
                
            }
            [self loadPhotos];
        }else{
            [self.view showAlertText:[@"获取图片信息失败" stringByAppendingString:(NSString*)requestObj]];
        }
        
    } onError:^(NSString *errorStr) {
        [UIAlertView alertTitle:@"提示信息" msg:[NSString stringWithFormat:@"%@", errorStr]];
    }];
}


- (void)getPeccancyRecord:(CarInfo*)car{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"list" forKey:@"action"];
    [dict setObject:car.hpzl forKey:@"hpzl"];
    [dict setObject:car.hphm forKey:@"hphm"];
    
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:YES callBackWithObj:car onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            NSDictionary *resDict = (NSDictionary*)requestObj;
            if ([[resDict analysisStrValueByKey:@"count"] isEqualToString:@"0"]) {//无违章
                //清空数据库该车的违章记录
                [[DataBase sharedDataBase] deleteCarPeccancyRecordByUserId:APP_DELEGATE.userId andHphm:car.hphm];
            }else{
                SBJsonWriter *writer = [[SBJsonWriter alloc] init];
                NSString *jsonStr = [writer stringWithObject:requestObj];
                CarPeccancyRecord *carpr = [[CarPeccancyRecord alloc] initWithHpzl:((CarInfo*)callBackObj).hpzl hphm:((CarInfo*)callBackObj).hphm jdcwf_detail:jsonStr jdcwf_gxsj:[[NSDate date]string] andUserId:APP_DELEGATE.userId];
                //ok写入数据库
                [carpr update];
            }
            
            //更新界面显示
            [self _loadData];
            if (_segSelectedImgView.frame.origin.x == _leftSegButton.left) {
                _isDealingRecord = YES;
            }else{
                _isDealingRecord = NO;
            }
            [_rootTableView reloadData];
            
            [_egoView egoRefreshScrollViewDataSourceDidFinishedLoading:_rootTableView];
            
        }else{//解析错误
            
            [_egoView egoRefreshScrollViewDataSourceDidFinishedLoading:_rootTableView];
            [UIAlertView alertTitle:@"车辆违章信息刷新失败" msg:(NSString*)requestObj];
        }
        
        
    } onError:^(NSString *errorStr) {
        [_egoView egoRefreshScrollViewDataSourceDidFinishedLoading:_rootTableView];
        [UIAlertView alertTitle:@"车辆违章信息刷新失败" msg:errorStr];
    }];
}


- (void)netApplyCheckPhoto{
    //向服务器发送申请查看照片的请求
    //andriod.do?action=appealphoto&hpzl=??&hphm=??&xh=??
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDict setObject:@"appealphoto" forKey:@"action"];
    [bodyDict setObject:_car_.hpzl forKey:@"hpzl"];
    [bodyDict setObject:_car_.hphm forKey:@"hphm"];
    [bodyDict setObject:self.xh forKey:@"xh"];
    [[Network sharedNetwork] postBody:bodyDict isResponseJson:NO doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        //本接口返回成功后，刷新列表
        [_rootTableView setContentOffset:CGPointMake(_rootTableView.left, - 80) animated:YES];
        [UIAlertView alertTitle:@"提交申请成功" msg:@"已为您提交查看照片申请，请耐心等待"];

    } onError:^(NSString *errorStr) {
        
        [UIAlertView alertTitle:@"申请查看照片" msg:errorStr];
    }];
    
    
}


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
