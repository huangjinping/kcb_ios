//
//  DriveLicensePeccancyRecordViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-31.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "DriveLicensePeccancyRecordViewController.h"
#import "PingzhengViewController.h"

@interface DriveLicensePeccancyRecordViewController ()

@end

@implementation DriveLicensePeccancyRecordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#define TAG_LEFTSEG_BUT     200
#define TAG_RIGHTSEG_BUT    201
- (void)_loadView{
    
    _rootTableView = [[UITableView alloc] init];
    [_rootTableView setFrame:CGRectMake(APP_X, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT )];
    _rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    [self.view addSubview:_rootTableView];
    
    _egoView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(APP_X, -_rootTableView.frame.size.height, _rootTableView.frame.size.width, _rootTableView.frame.size.height)];
    _egoView.delegate = self;
    [_rootTableView addSubview:_egoView];
    
}


- (void)_loadData{
    NSArray *driveLPRs = [[DataBase sharedDataBase] selectDriveLicensePeccancyRecordByUserId:APP_DELEGATE.userId];
    self.driveLPeccancyRecord = [driveLPRs lastObject];
    
    [self.driveMsgs_pay removeAllObjects];
    NSArray *arr = [Helper drivePeccancyMsgAnalysis:self.driveLPeccancyRecord.jszwf_detail];
    [self.driveMsgs_pay addObjectsFromArray:arr];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
    self.driveMsgs_pay = arr;
    
    [self _loadView];
    
    [self _loadData];
    
    _isFinishedRefresh = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"驾驶证违法记录"];
    
   
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
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"非常抱歉！" message:@"由于财政缴费接口限制，手机应用暂不提供支付功能。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    alert.tag = TAG_ALERT_CAN_FINISHED_PAY_ACTION;
//    [alert show];
//    return;
    
    
    //判断数据是否超时
    NSDate *updateDate = [self.driveLPeccancyRecord.jszwf_gxsj date];
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
    DriveLicensePeccancyMsg *driveMsg = [_driveMsgs_pay objectAtIndex:((UIButton*)sender).tag];
    
    PayViewController *payVC = [[PayViewController alloc] initWithFkje:driveMsg.fkje znj:driveMsg.znj hphm:@"" jdsbh:driveMsg.jdsbh username:APP_DELEGATE.userName fxjg:driveMsg.fxjg cljg:@"" cljgmc:@"" wsjyw:@""];
    [self.navigationController pushViewController:payVC animated:YES];
    

}

#pragma mark - uiwebviewDelegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    ENTLog(@"%@", error);
    [MBProgressHUD hideAllHUDsForView:webView animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideAllHUDsForView:webView animated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:webView animated:YES];
}


#pragma mark - EGORefreshTableHeaderDelegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self getDriveLicensePeccancyRecord];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _isFinishedRefresh;
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
    return [_driveMsgs_pay count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DriveLicensePeccancyMsg *msg = [_driveMsgs_pay objectAtIndex:indexPath.row];
    NSString *fxjg = [msg fxjgmc];
    CGFloat height = [self heightForStr:fxjg] + [self heightForStr:[msg wfdz]] + [self heightForStr:[msg wfnr]] + SIGLE_TEXT_LINE_HEIGHT*2 + BUTTON_HEIGHT + BUTTON_SPACE;
    
    return height + SPACE*4;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cell_id = CELL_ID_PEECANCY_RECORD;
    PeccancyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PeccancyRecordCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.checkPingzhengButton.hidden = YES;
        cell.checkPhotoButton.hidden = YES;
        cell.dealPeccancyButton.hidden = YES;
        [cell.lineVertical setHidden:YES];

        cell.payButton.hidden = NO;
        [cell.payButton addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
        cell.payButton.backgroundColor = [UIColor whiteColor];
        
    }
    cell.payButton.tag = indexPath.row;
    
    cell.sNumL.text = [NSString stringWithFormat:@"%d", (int)indexPath.row + 1];

    DriveLicensePeccancyMsg *msg = [_driveMsgs_pay objectAtIndex:indexPath.row];
    cell.cjjgL.text = [msg fxjgmc];
    cell.wfsjL.text = [msg wfsj];
    cell.wfddL.text = [msg wfdz];
    cell.wfxwL.text = [msg wfnr];
    //cell.cfbzL.text = [NSString stringWithFormat:@"罚款%@元 记%@分",msg.fkje, msg.wfjfs];
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:@"罚款"];
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:15],
                           NSForegroundColorAttributeName : COLOR_BUTTON_YELLOW};
    [aString appendAttributedString:[[NSAttributedString alloc] initWithString:msg.fkje attributes:dict]];
    [aString appendAttributedString:[[NSAttributedString alloc] initWithString:@"元 记"]];
    [aString appendAttributedString:[[NSAttributedString alloc] initWithString:msg.wfjfs attributes:dict]];
    [aString appendAttributedString:[[NSAttributedString alloc] initWithString:@"分"]];
    
    [cell.cfbzL setAttributedText:aString];
    

    if ([msg.jkbj isEqualToString:@"1"]) {//已缴款
        [cell.payButton setTitle:@"已缴款" forState:UIControlStateNormal];
        cell.payButton.userInteractionEnabled = NO;
        [cell.payButton setTitleColor:COLOR_FONT_INFO_SHOW forState:UIControlStateNormal];

    }else{
        [cell.payButton setTitle:@"立即缴款" forState:UIControlStateNormal];
        cell.payButton.userInteractionEnabled = YES;
        [cell.payButton setTitleColor:COLOR_LINK forState:UIControlStateNormal];

    }
    
    //set frame
    CGFloat space = 10;
    CGFloat labellabelWidth = 75;
    CGFloat bgheight = [self heightForStr:cell.cjjgL.text] + [self heightForStr:cell.wfddL.text] + [self heightForStr:cell.wfxwL.text] + SIGLE_TEXT_LINE_HEIGHT*2 + BUTTON_HEIGHT + BUTTON_SPACE + space*2;
    [cell.bgView setFrame:CGRectMake(0, 0, APP_WIDTH, bgheight)];
    [cell.line1 setFrame:CGRectMake(0, cell.bgView.top, cell.bgView.width, 1)];

    [cell.cjjgLabelLabel setFrame:CGRectMake(space*2, space*2, labellabelWidth, SIGLE_TEXT_LINE_HEIGHT)];
    [cell.cjjgL setFrame:CGRectMake(cell.cjjgLabelLabel.right, cell.cjjgLabelLabel.top, APP_WIDTH - cell.cjjgLabelLabel.right - space*2, [self heightForStr:cell.cjjgL.text])];
    [cell.wfsjLabelLabel setFrame:CGRectMake(cell.cjjgLabelLabel.left, cell.cjjgL.bottom, labellabelWidth, SIGLE_TEXT_LINE_HEIGHT)];
    [cell.wfsjL setFrame:CGRectMake(cell.wfsjLabelLabel.right, cell.wfsjLabelLabel.top, APP_WIDTH - cell.wfsjLabelLabel.right - space*2, SIGLE_TEXT_LINE_HEIGHT)];
    [cell.wfddLabelLabel setFrame:CGRectMake(cell.cjjgLabelLabel.left, cell.wfsjL.bottom, labellabelWidth, SIGLE_TEXT_LINE_HEIGHT)];
    [cell.wfddL setFrame:CGRectMake(cell.wfddLabelLabel.right, cell.wfddLabelLabel.top, APP_WIDTH - cell.wfddLabelLabel.right - space*2, [self heightForStr:cell.wfddL.text])];
    [cell.wfxwLabelLabel setFrame:CGRectMake(cell.cjjgLabelLabel.left, cell.wfddL.bottom, labellabelWidth, SIGLE_TEXT_LINE_HEIGHT)];
    [cell.wfxwL setFrame:CGRectMake(cell.wfxwLabelLabel.right, cell.wfxwLabelLabel.top, APP_WIDTH - cell.wfxwLabelLabel.right - space*2, [self heightForStr:cell.wfxwL.text])];
    [cell.cfbzLabelLabel setFrame:CGRectMake(cell.cjjgLabelLabel.left, cell.wfxwL.bottom, labellabelWidth, SIGLE_TEXT_LINE_HEIGHT)];
    [cell.cfbzL setFrame:CGRectMake(cell.cfbzLabelLabel.right, cell.cfbzLabelLabel.top, APP_WIDTH - cell.cfbzLabelLabel.right - space*2, SIGLE_TEXT_LINE_HEIGHT)];
    
    
    
    CGFloat buttonY = bgheight - BUTTON_HEIGHT;
    //CGFloat buttonWidth = (cell.bgView.width)/2;
    //CGFloat buttonSpace = 0;
    
    [cell.payButton setFrame:CGRectMake(0, buttonY, cell.bgView.width, BUTTON_HEIGHT)];
    [cell.line2 setFrame:CGRectMake(0, cell.payButton.top - 1, cell.bgView.width, 1)];
    [cell.line3 setFrame:CGRectMake(0, cell.payButton.bottom, cell.bgView.width, 1)];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



#pragma mark-  网络请求
- (void)getDriveLicensePeccancyRecord{

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"listbyjszh" forKey:@"action"];
    [dict setObject:self.driver.driversfzmhm forKey:@"jszh"];
    [dict setObject:self.driver.dabh forKey:@"dabh"];
    
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSArray *violationhis = [resDict objectForKey:@"violationhis"];
            if (![violationhis count]) {//无违章
                //清空数据库该车的违章记录
                [[DataBase sharedDataBase] deleteDriveLicensePeccancyRecordByUserId:APP_DELEGATE.userId];
            }else{
                SBJsonWriter *writer = [[SBJsonWriter alloc] init];
                NSString *jsonStr = [writer stringWithObject:requestObj];
                DriveLicensePeccancyRecord *driveLPR = [[DriveLicensePeccancyRecord alloc] initWithDriversfzmhm:self.driver.driversfzmhm jszwf_detail:jsonStr jszwf_gxsj:[[NSDate date]string] andUseId:APP_DELEGATE.userId];
                //ok写入数据库
                [driveLPR update];
            }
            
            //更新界面显示
            [self _loadData];
            [_rootTableView reloadData];
            
            [_egoView egoRefreshScrollViewDataSourceDidFinishedLoading:_rootTableView];
            
        }else{//解析错误
            
            [_egoView egoRefreshScrollViewDataSourceDidFinishedLoading:_rootTableView];
            [UIAlertView alertTitle:@"驾驶证违章信息刷新失败" msg:(NSString*)requestObj];
        }

    } onError:^(NSString *errorStr) {
        [_egoView egoRefreshScrollViewDataSourceDidFinishedLoading:_rootTableView];
        [UIAlertView alertTitle:@"驾驶证违章信息刷新失败" msg:errorStr];
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
