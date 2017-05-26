//
//  PayRecordViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-12.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "PayRecordViewController.h"
#import "FiltViewController.h"
#import "BXPayRecordCell.h"
#import "serOderCell.h"
#import "OderViewController.h"
#import "MyAFNetWorkingRequest.h"
#import "BYViewController.h"
#import "InfoModel.h"

#define TAG_TABLEVIEW_MAIN_ORDER        0
#define TAG_TABLEVIEW_OTHER_ORDER       1

@interface PayRecordViewController ()<
EGORefreshTableHeaderDelegate,
UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate,
FiltViewControllerDelegate,
SegmentButtonViewDelegate
>
{
    SegmentButtonView           *_seg;
    
    EGORefreshTableHeaderView   *_refreshHeader;
    UITableView                 *_rootTableView;
    UIButton                    *_filtButton;
    
    UIView                      *_otherOrdersDetailView;
    BOOL                        _isloading;
    NSInteger                   _indexLoadDetail;
    BOOL                     _showDetail;
    
    //违章缴款订单
    NSMutableArray              *_datasourceArr;
    NSMutableArray              *_filtedDatasourceArr;
    NSMutableArray              *_datasourceHphmArr;
    //其他订单
    NSMutableArray              *_otherOrderDataArr;
    NSMutableArray              *_otherBYArr;
    NSMutableArray              *_otherBXArr;
    
}

@property (nonatomic, retain)   NSArray     *filtHphmArr;
@property (nonatomic, retain)   NSString     *filtDateStr;
@property (nonatomic, strong)   MyAFNetWorkingRequest     *reponse;
@property (nonatomic,weak) id obj1;
@property (nonatomic,weak) id obj2;
@property (nonatomic,strong) NSArray *PXArray;

@end

@implementation PayRecordViewController
CGFloat contentLineHeight = 50;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark- 消息刷新与加载更多 Delegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view{
    if (_isloading) {
        return;
    }
    if (_rootTableView.tag == TAG_TABLEVIEW_MAIN_ORDER) {
        [self getPayRecord];
    }else if(_rootTableView.tag == TAG_TABLEVIEW_OTHER_ORDER){
        [self getOtherPayRecord];
    }
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view{
    return NO;
}

#pragma mark- scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > 0) {
        
    }else{
        [_refreshHeader egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y > 0) {
        
    }else{
        [_refreshHeader egoRefreshScrollViewDidEndDragging:scrollView];
    }
}


- (void)reloadView{
    [_filtedDatasourceArr removeAllObjects];
    
    
    
    if ([_filtHphmArr count] == 0) {
        [_filtedDatasourceArr addObjectsFromArray:_datasourceArr];
    }else{
        for (int i = 0; i < _datasourceArr.count; i++) {
            NSDictionary *dict = [_datasourceArr objectAtIndex:i];
            NSString *hphm = [dict objectForKey:@"hphm"];
            for (NSString *conditionhphm in self.filtHphmArr){
                if ([conditionhphm isEqualToString:hphm]) {
                    [_filtedDatasourceArr addObject:dict];
                    break;
                }
            }
        }
    }
    if (_filtDateStr && ![_filtDateStr isEqualToString:@""]) {
        NSDate *filtDate = nil;
        if ([_filtDateStr isEqualToString:@"30天以内"]) {
            filtDate = [[NSDate date] dateByAddingTimeInterval:-(30*24*60*60)];
        }else if ([_filtDateStr isEqualToString:@"三个月以内"]){
            filtDate = [[NSDate date] dateByAddingTimeInterval:-(3*30*24*60*60)];
        }else if ([_filtDateStr isEqualToString:@"三个月之前"]){
            
        }
        
        for (int i = 0; i < _filtedDatasourceArr.count; i++) {
            NSDictionary *dict = [_filtedDatasourceArr objectAtIndex:i];
            NSString *time = [dict objectForKey:@"transtime"];
            NSDate *date = [time convertToDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
            if (filtDate == nil) {
                NSTimeInterval inte = [date timeIntervalSinceDate:[[NSDate date] dateByAddingTimeInterval:-(3*30*24*60*60)]];
                if (inte > 0) {
                    [_filtedDatasourceArr removeObjectAtIndex:i];
                    i -- ;
                }
            }else{
                if ([date timeIntervalSinceDate:filtDate] < 0) {
                    [_filtedDatasourceArr removeObjectAtIndex:i];
                    i -- ;
                }
            }
        }
    }
    
    [_rootTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _datasourceArr = [[NSMutableArray alloc] initWithCapacity:0];
    _filtedDatasourceArr = [[NSMutableArray alloc] initWithCapacity:0];
    _datasourceHphmArr = [[NSMutableArray alloc] initWithCapacity:0];
    _otherOrderDataArr = [[NSMutableArray alloc] initWithCapacity:0];
    _filtDateStr = nil;
    _filtHphmArr = nil;
    _otherOrdersDetailView = nil;
    _indexLoadDetail = 0;
    _showDetail = NO;
    
    _seg = [[SegmentButtonView alloc] initWithFrame:LGRectMake(APP_X, APP_VIEW_Y/PX_Y_SCALE, APP_PX_WIDTH, 34*2) backgroundColor:[UIColor whiteColor] andLineColor:COLOR_NAV];
    [_seg setTitles:[NSArray arrayWithObjects:@"违章缴款订单", @"服务订单", nil] withTitleNorColor:COLOR_FONT_NOMAL andTitleSelColor:COLOR_NAV];
    [_seg setDelegate:self];
    [_seg setSelectedIndex:0];
    [self segmentButtonView:_seg showView:0];
    [self.view addSubview:_seg];
    
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(APP_X, _seg.bottom+10, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - _seg.height)];
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    [_rootTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_rootTableView setBackgroundColor:COLOR_VIEW_CONTROLLER_BG];
    [_rootTableView registerNib:[UINib nibWithNibName:@"serOderCell" bundle:nil] forCellReuseIdentifier:@"serOder"];
    _rootTableView.tag = _seg.selectedIndex;
    [self.view addSubview:_rootTableView];
    
    
    
    
    //刷新
    _isloading = NO;
    _refreshHeader = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, - _rootTableView.height, _rootTableView.width, _rootTableView.height)];
    _refreshHeader.delegate = self;
    [_rootTableView addSubview:_refreshHeader];
    
    [self getPayRecord];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"我的缴款单"];
    
    
    _filtButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_filtButton setBackgroundColor:[UIColor clearColor]];
    [_filtButton setBackgroundImage:[UIImage imageNamed:@"filt_button"] forState:UIControlStateNormal];
    [_filtButton setFrame:LGRectMake(_navigationImgView.w - 100, (_navigationImgView.h - 30)/2, 40, 40)];
    [_filtButton addTarget:self action:@selector(filtButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_navigationImgView addSubview:_filtButton];
    
    [self reloadView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)filtButtonClicked{
    FiltViewController *fvc = [[FiltViewController alloc] initWithChosenHphm:_filtHphmArr chosenDate:_filtDateStr andHphmDatasource:_datasourceHphmArr];
    fvc.delegate_ = self;
    [self.navigationController pushViewController:fvc animated:YES];
}

- (void)filtViewController:(FiltViewController *)vc chooseHphm:(NSArray *)hphms andDate:(NSString *)date{
    
    self.filtHphmArr = [NSArray arrayWithArray:hphms];
    self.filtDateStr = [NSString stringWithString:date];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //[self gobackPage];
}


#pragma mark- SegmentButtonViewDelegate
- (void)segmentButtonView:(SegmentButtonView *)segmentButtonView showView:(NSInteger)index{
    if (segmentButtonView.selectedIndex == TAG_TABLEVIEW_MAIN_ORDER) {
        _filtButton.hidden = NO;
    }else{
        _filtButton.hidden = YES;
        if ([_otherOrderDataArr count] == 0) {
            [self getOtherPayRecord];
        }
        
    }
    
    _rootTableView.tag = segmentButtonView.selectedIndex;
    [_rootTableView reloadData];
    
}


#pragma mark- UITableViewDelegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == TAG_TABLEVIEW_MAIN_ORDER) {
        return [_filtedDatasourceArr count];
    }else{
        
        return _otherOrderDataArr.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == TAG_TABLEVIEW_MAIN_ORDER) {
        return 158;
    }else{
        
        
        return 120;
    }
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView.tag == TAG_TABLEVIEW_MAIN_ORDER) {
        
        static NSString *cellId = @"payRecordCell";
        
        PayRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PayRecordCell" owner:self options:nil] lastObject];
            [cell.bgView setFrame:CGRectMake(0, 10, APP_WIDTH, cell.bgView.height)];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.line0L setSize:CGSizeMake(APP_PX_WIDTH, cell.line0L.height)];
            [cell.line1L setSize:CGSizeMake(APP_PX_WIDTH, cell.line1L.height)];
            
        }
        
        
        
        NSDictionary *dataDict = [_filtedDatasourceArr objectAtIndex:indexPath.row];
       // cell.cellNumL.text = [NSString stringWithFormat:@"%d", (int)indexPath.row + 1];
        cell.payNumL.text = [dataDict analysisStrValueByKey:@"ordid"];
        cell.payStatusL.text = @"确认成功";//[dataDict objectForKey:@""];
        cell.payTimeL.text = [dataDict analysisStrValueByKey:@"transtime"];
        cell.costL.text = [dataDict analysisStrValueByKey:@"transamt"];
     //   cell.cellNumL.font = WY_FONT_SIZE(38);
        cell.payNumL.font = WY_FONT_SIZE(38);;
        cell.payStatusL.font = WY_FONT_SIZE(38);;
        cell.payTimeL.font = WY_FONT_SIZE(38);;
        cell.costL.font = WY_FONT_SIZE(38);;
        
        
        return cell;
    }else{
        
        
        serOderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"serOder" forIndexPath:indexPath];
        
        
        NSDictionary *dict = [_otherOrderDataArr objectAtIndex:indexPath.row];
        
        if([dict objectForKey:@"hphm"]){
            
            cell.carInfo.text = [NSString stringWithFormat:@"车牌号码 :   %@",[dict objectForKey:@"hphm"]];
            cell.timeLab.text = [NSString stringWithFormat:@"订单时间 :   %@",[dict objectForKey:@"hbtime"]];
            cell.oderLab.text =@"订单类型 :   车辆保险订单";
          
            if ([[dict valueForKey:@"status"]isEqualToString:@"3"]) {
                cell.stpyLab.text=@"订单状态 :   订单支付成功";
                 cell.stpyLab.textColor=COLOR_BUTTON_BLUE;
                
            }else{
                
                cell.stpyLab.text=@"订单状态 :   订单未支付";
                cell.stpyLab.textColor=[UIColor blackColor];
            }
            return cell;
        }else{
            
            NSDictionary *dic = [[dict objectForKey:@"orderInfo"]objectForKey:@"vehicleInfo"];
            cell.carInfo.text = [NSString stringWithFormat:@"车牌号码 :   %@",[dic objectForKey:@"hphm"]];
            cell.timeLab.text = [NSString stringWithFormat:@"订单时间 :   %@",[dict objectForKey:@"createtime"]];
            cell.oderLab.text =@"订单类型 :   车辆保养订单";
         
            if ([[dict valueForKey:@"status"]isEqualToString:@"3"]) {
                cell.stpyLab.text=@"订单状态 :   订单支付成功";
              
                cell.stpyLab.textColor=COLOR_BUTTON_BLUE;
            }else{
                
                cell.stpyLab.text=@"订单状态 :   订单未支付";
                cell.stpyLab.textColor=[UIColor blackColor];
            }
            return cell;
            
        }
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == TAG_TABLEVIEW_OTHER_ORDER) {
        NSDictionary *dict = [_otherOrderDataArr objectAtIndex:indexPath.row];
        if ([dict objectForKey:@"hphm"]) {
            
            OderViewController *oderVC=[[OderViewController alloc]init];
            
            Baoxian *model = _otherBXArr[indexPath.row];
            
            oderVC.baoxian=model;
            [self.navigationController pushViewController:oderVC animated:YES];
            
        }else{
            // OderViewController *oderVC=[[OderViewController alloc]init];
            BYViewController *byVC=[[BYViewController alloc]init];
            
            InfoModel *model=_otherBYArr[indexPath.row];
            
            
            byVC.model=model;
            
            [self.navigationController pushViewController:byVC animated:YES];
        }
        
    }
}


#pragma mark- 网络请求

- (void)getPayRecord{
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"listorder" forKey:@"action"];
    [dict setObject:APP_DELEGATE.userName forKey:@"username"];
    _isloading = YES;
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSArray *orders = [resDict analysisArrValueByKey:@"orders"];
            
            [_datasourceArr removeAllObjects];
            for (NSDictionary *dict in orders) {
                [_datasourceArr addObject:dict];
            }
            [_datasourceHphmArr removeAllObjects];
            for (NSDictionary *dict in _datasourceArr) {
                NSString *newHphm = [dict analysisStrValueByKey:@"hphm"];
                for (int i = 0; i < [_datasourceHphmArr count]; i ++) {
                    NSString *oldHphm = [_datasourceHphmArr objectAtIndex:i];
                    if ([oldHphm isEqualToString:newHphm]) {
                        break;
                    }else {
                        if (i == [_datasourceHphmArr count] - 1) {
                            [_datasourceHphmArr addObject:newHphm];
                        }
                    }
                }
                if ([_datasourceHphmArr count] == 0) {
                    [_datasourceHphmArr addObject:newHphm];
                }
            }
            
            if ([_datasourceArr count] == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"无缴费记录" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                [alert show];
            }else{
                [self reloadView];
            }
            
        }else{
            [UIAlertView alertTitle:@"提示信息" msg:[NSString stringWithFormat:@"服务器异常，获取罚款缴纳明细列表失败,服务器返回%@", requestObj]];
            
        }
        _isloading = NO;
        [_refreshHeader egoRefreshScrollViewDataSourceDidFinishedLoading:_rootTableView];
        
    } onError:^(NSString *errorStr) {
        [UIAlertView alertTitle:@"提示信息" msg:errorStr];
        
        _isloading = NO;
        [_refreshHeader egoRefreshScrollViewDataSourceDidFinishedLoading:_rootTableView];
        
    }];
    
}


- (void)getOtherPayRecord{
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDict setObject:APP_DELEGATE.userName forKey:@"username"];//用户名e
    _otherBXArr =[[NSMutableArray alloc]init];
    _otherBYArr =[[NSMutableArray alloc]init];
    
    
    
    
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:NET_QI_YE_956122];
    MKNetworkOperation *op = [en operationWithPath:@"Insurance/cx_findOrder.action" params:bodyDict httpMethod:@"POST"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
       // [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSArray *resArr = [parser objectWithString:completedOperation.responseString];
        //NSLog(@"%@",completedOperation);
        [_otherOrderDataArr removeAllObjects];
        for (NSDictionary *resDict in resArr) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
            //车牌号
            NSString *hphm = [resDict analysisStrValueByKey:@"hphm"];
            //注册时间
            NSString *hbtime = [resDict analysisStrValueByKey:@"hbtime"];
            //备注
            NSString *bxCompanyName = [resDict analysisStrValueByKey:@"beizhu"];
            //空
            NSString *jkstatus =[resDict analysisStrValueByKey:@"jkstatus"];
            //0
            NSString *hbstatus =[resDict analysisStrValueByKey:@"hbstatus"];
            if ([bxCompanyName isEqualToString:@"2"]) {
                bxCompanyName = @"阳光保险";
            }
            [dict setObject:hphm forKey:@"hphm"];
            [dict setObject:hbtime forKey:@"hbtime"];
            [dict setObject:bxCompanyName forKey:@"beizhu"];
            [dict setObject:jkstatus forKey:@"jkstatus"];
            [dict setObject:hbstatus forKey:@"hbstatus"];
            
            NSDictionary * dic = resDict[@"orderdata"];
            
            [dict setObject:dic forKey:@"orderdata"];
            
            [_otherOrderDataArr addObject:dict];
            [_otherBXArr addObject:dict];
            
        }
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *errStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if (!errStr || [errStr isEqualToString:@""]) {
            errStr = @"服务器出错了！";
        }
        [UIAlertView alertTitle:nil msg:errStr];
    }];
    
    [en enqueueOperation:op];
    
    
    [BLMHttpTool postWithURL:@"http://buss.956122.com/getOrderMaster.do?" params:bodyDict success:^(id json) {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSArray *resArr = [json valueForKey:@"msg"];
        for (NSDictionary *resDict in resArr) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
            
            NSString *ordid= [resDict analysisStrValueByKey:@"ordid"];
            NSString *status = [resDict analysisStrValueByKey:@"status"];
            NSString *payType = [resDict analysisStrValueByKey:@"payType"];
            NSString *sumAmount =[resDict analysisStrValueByKey:@"sumAmount"];
            NSString *createtime =[resDict analysisStrValueByKey:@"createtime"];
            NSString *username =[resDict analysisStrValueByKey:@"username"];
            NSString *isdelete =[resDict analysisStrValueByKey:@"isdelete"];
            NSString *verifycode =[resDict analysisStrValueByKey:@"verifycode"];
            
            [dict setObject:ordid forKey:@"ordid"];
            [dict setObject:status forKey:@"status"];
            [dict setObject:payType forKey:@"payType"];
            [dict setObject:sumAmount forKey:@"sumAmount"];
            [dict setObject:createtime forKey:@"createtime"];
            [dict setObject:username forKey:@"username"];
            [dict setObject:isdelete forKey:@"isdelete"];
            [dict setObject:verifycode forKey:@"verifycode"];
            
            NSDictionary * dic1 = resDict[@"orderInfo"];
            
            [dict setObject:dic1 forKey:@"orderInfo"];
            [_otherBYArr addObject:dict];
            [_otherOrderDataArr addObject:dict];
            
            
            
        }
        
        NSDictionary *px=nil;
        for(int j = 0;j<_otherOrderDataArr.count -1;j++){
            for(int i = 0;i< _otherOrderDataArr.count -j-1;i++){
                NSString *key1 =nil;
                NSString *key2 =nil;
                if (_otherOrderDataArr[i][@"hbtime"]) {
                    
                    key1=@"hbtime";
                    
                }else{
                    key1 =@"createtime";
                    
                }
                if (_otherOrderDataArr[i+1][@"hbtime"]) {
                    key2=@"hbtime";
                }else{
                    key2 =@"createtime";
                }
                //转化时间
                NSDateFormatter *foomatter=[[NSDateFormatter alloc]init];
                foomatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
                NSDate *date1 =[foomatter dateFromString:[_otherOrderDataArr[i] valueForKey:key1]];
                NSDate *date2 =[foomatter dateFromString:[_otherOrderDataArr[i+1] valueForKey:key2]];
                
                
                if (date2>date1) {
                    px=_otherOrderDataArr[i];
                    _otherOrderDataArr[i]=_otherOrderDataArr[i+1];
                    _otherOrderDataArr[i+1]=px;
                }
                
            }
            
        }
        [_rootTableView reloadData];
        _isloading = NO;
        [_refreshHeader egoRefreshScrollViewDataSourceDidFinishedLoading:_rootTableView];
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
    _isloading = NO;
    [_refreshHeader egoRefreshScrollViewDataSourceDidFinishedLoading:_rootTableView];
    
    
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
