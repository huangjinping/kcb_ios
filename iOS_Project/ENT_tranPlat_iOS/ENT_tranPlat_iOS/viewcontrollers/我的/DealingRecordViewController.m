//
//  DealingRecordViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-12.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "DealingRecordViewController.h"
#import "FiltViewController.h"

@interface DealingRecordViewController ()<
EGORefreshTableHeaderDelegate,
SegmentButtonViewDelegate,
UITableViewDataSource,
UITableViewDelegate,
FiltViewControllerDelegate
>
{
    EGORefreshTableHeaderView       *_refreshHeader;
    BOOL                            _isloading;
    UITableView                     *_rootTableView;
    
    NSMutableArray                  *_datasourceArr;
    NSMutableArray                  *_filtedDatasourceArr;
    NSMutableArray                  *_tableviewDatasourceArr;
    NSMutableArray                  *_datasourceHphmArr;

    SegmentButtonView               *_segBView;
}

@property (nonatomic, retain)   NSArray     *filtHphmArr;
@property (nonatomic, retain)   NSString     *filtDateStr;
@end

@implementation DealingRecordViewController

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
    
    [self getDealRecordWithIndex:0];
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
            NSString *hphm = [dict analysisStrValueByKey:@"hphm"];
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
            NSString *time = [dict objectForKey:@"contime"];
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
    
    [_tableviewDatasourceArr removeAllObjects];
    //segbutton过滤
    if (_segBView.selectedIndex == 0) {//全部
        [_tableviewDatasourceArr addObjectsFromArray:_filtedDatasourceArr];
    }else if (_segBView.selectedIndex == 1) {//成功
        for (NSDictionary *dict in _filtedDatasourceArr) {
            NSString *status = [dict analysisStrValueByKey:@"stauts"];
            if ([status isEqualToString:@"2"]) {
                [_tableviewDatasourceArr addObject:dict];
            }
        }
        
    }else if (_segBView.selectedIndex == 2) {//失败
        for (NSDictionary *dict in _filtedDatasourceArr) {
            NSString *status = [dict analysisStrValueByKey:@"stauts"];
            if ([status isEqualToString:@"4"]) {
                [_tableviewDatasourceArr addObject:dict];
            }
        }
    }
    
    [_rootTableView reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    //data
    _datasourceArr = [[NSMutableArray alloc] initWithCapacity:0];
    _filtedDatasourceArr = [[NSMutableArray alloc] initWithCapacity:0];
    _tableviewDatasourceArr = [[NSMutableArray alloc] initWithCapacity:0];
    _datasourceHphmArr = [[NSMutableArray alloc] initWithCapacity:0];
    _filtDateStr = nil;
    _filtHphmArr = nil;
    
    
    _segBView = [[SegmentButtonView alloc] initWithFrame:LGRectMake(APP_X, APP_VIEW_Y/PX_X_SCALE, APP_PX_WIDTH, 34/PX_X_SCALE) backgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_white_top.png"]] andLineColor:COLOR_NAV];
    [_segBView setTitles:[NSArray arrayWithObjects:@"全部", @"确认成功", @"确认失败", nil] withTitleNorColor:COLOR_FONT_NOMAL andTitleSelColor:COLOR_FONT_NOMAL];
    _segBView.delegate = self;
    [self.view addSubview:_segBView];
    
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(APP_X, _segBView.bottom, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - _segBView.height)];
    _rootTableView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    [_rootTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_rootTableView];

    _isloading = NO;
    _refreshHeader = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, - _rootTableView.height, _rootTableView.width, _rootTableView.height)];
    _refreshHeader.delegate = self;
    [_rootTableView addSubview:_refreshHeader];
    
    //start
    [self getDealRecordWithIndex:0];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    [self setCustomNavigationTitle:@"违法处理明细"];
    
    
    UIButton *filtButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [filtButton setBackgroundColor:[UIColor clearColor]];
    [filtButton setBackgroundImage:[UIImage imageNamed:@"filt_button"] forState:UIControlStateNormal];
    [filtButton setFrame:LGRectMake(_navigationImgView.w - 100, (_navigationImgView.h - 30)/2, 40, 40)];
    //[filtButton addTarget:self action:@selector(filtButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    //[_navigationImgView addSubview:filtButton];
    
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


- (void)segmentButtonView:(SegmentButtonView *)segmentButtonView showView:(NSInteger)index{
    [self reloadView];
}

#pragma mark- UITableViewDelegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_tableviewDatasourceArr count];
    
}

#define ROW_HEIGHT_L        182
#define ROW_HEIGHT_S        157
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dataDict = [_tableviewDatasourceArr objectAtIndex:indexPath.row];
    NSString *jdsbh = [dataDict analysisStrValueByKey:@"jdsbh"];
    if ([jdsbh isEqualToString:@""]) {
        return ROW_HEIGHT_S;
    }else {
        return ROW_HEIGHT_L;
    }


}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"dealingRecordCell";
    DealingRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[DealingRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dataDict = [_tableviewDatasourceArr objectAtIndex:indexPath.row];
    cell.cellNumL.text = [NSString stringWithFormat:@"%d", (int)indexPath.row + 1];
    cell.dealNumL.text = [dataDict analysisStrValueByKey:@"xh"];
    NSString *status = [dataDict analysisStrValueByKey:@"stauts"];
    if ([status isEqualToString:@"1"]){
        status = @"确认中";
    }else if ([status isEqualToString:@"2"]){
        status = @"确认成功";
    }
    else if ([status isEqualToString:@"3"]){
        status = @"违章异议";
    }
    else if ([status isEqualToString:@"4"]){
        status = @"确认失败";
    }
    cell.dealStatusL.text = status;

    //车牌号码大写****
    cell.hphmL.text = [[dataDict analysisStrValueByKey:@"hphm"] uppercaseString];
    cell.hpzlL.text = [dataDict analysisStrValueByKey:@"hpzl"];
    cell.dealTimeL.text = [dataDict analysisStrValueByKey:@"contime"];
    NSString *jdsbh = [dataDict analysisStrValueByKey:@"jdsbh"];
    if (![jdsbh isEqualToString:@""]) {
        cell.jdsbhL.hidden = NO;
        cell.jdsbhLabel.hidden = NO;
        [cell.bgImgView setSize:CGSizeMake(APP_WIDTH, ROW_HEIGHT_L - 15)];
        //决定书编号复位
        //[cell.jdsbhL setFrame:CGRectMake(cell.dealTimeL.left, cell.dealTimeL.bottom + 5, cell.dealTimeL.width, cell.dealTimeL.height)];
        //状态行下移
        [cell.dealStatusL setFrame:CGRectMake(cell.jdsbhL.left, cell.jdsbhL.bottom, cell.jdsbhL.width, cell.jdsbhL.height)];
        [cell.statusLabel setFrame:CGRectMake(cell.jdsbhLabel.left, cell.jdsbhLabel.bottom, cell.jdsbhLabel.width, cell.jdsbhLabel.height)];

        cell.jdsbhL.text = jdsbh;//[NSString stringWithFormat:@"%@**********%@",[jdsbh substringToIndex:3], [jdsbh substringFromIndex:(jdsbh.length - 2)]];
        
        //line
        [cell.bottomLine setFrame:LGRectMake(0, cell.bgImgView.h - 1, APP_PX_WIDTH, 1)];
    }else{
        cell.jdsbhL.hidden = YES;
        cell.jdsbhLabel.hidden = YES;
        [cell.bgImgView setSize:CGSizeMake(APP_WIDTH, ROW_HEIGHT_S - 15)];
        //状态行上移
        [cell.dealStatusL setFrame:CGRectMake(cell.dealTimeL.left, cell.dealTimeL.bottom, cell.dealTimeL.width, cell.dealTimeL.height)];
        [cell.statusLabel setFrame:CGRectMake(cell.timeLabel.left, cell.timeLabel.bottom, cell.timeLabel.width, cell.timeLabel.height)];
        //line
        [cell.bottomLine setFrame:LGRectMake(0, cell.bgImgView.h - 1, APP_PX_WIDTH, 1)];
    }
    return cell;
}

#pragma mark- 网络请求

- (void)getDealRecordWithIndex:(NSInteger)index{
    NSArray *arr = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId];
    if ([arr count] == 0) {
        [self.view showAlertText:@"您当前未绑定任何车辆,无法进行查询."];
        return;
    }
    if (index >= [arr count]) {
        return;
    }
    CarInfo *car = [arr objectAtIndex:index];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"listvss" forKey:@"action"];
    [dict setObject:car.hpzl forKey:@"hpzl"];
    [dict setObject:car.hphm forKey:@"hphm"];
    
    NSDictionary *callBackDict = [NSDictionary dictionaryWithObjectsAndKeys:car, @"car", [NSString stringWithFormat:@"%d", (int)index], @"index", nil];
    _isloading = YES;
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:YES callBackWithObj:callBackDict onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSArray *orders = [resDict objectForKey:@"vss"];
            NSDictionary *callBackDict = (NSDictionary*)callBackObj;
            CarInfo *car = [callBackDict objectForKey:@"car"];
            NSString *indexString = [callBackDict objectForKey:@"index"];
            if ([indexString isEqualToString:@"0"]) {
                [_datasourceArr removeAllObjects];
                [_datasourceHphmArr removeAllObjects];
            }
            for (NSMutableDictionary *dict in orders) {
                [dict setObject:car.hphm forKey:@"hphm"];
                [dict setObject:car.hpzlname forKey:@"hpzl"];
                [_datasourceArr addObject:dict];
                
                for (int i = 0; i < [_datasourceHphmArr count]; i++) {
                    NSString *oldHphm = [_datasourceHphmArr objectAtIndex:i];
                    if ([car.hphm isEqualToString:oldHphm]) {
                        break;
                    }else{
                        if (i == [_datasourceHphmArr count] - 1){
                            [_datasourceHphmArr addObject:car.hphm];
                        }
                    }
                }
                if ([_datasourceHphmArr count] == 0) {
                    [_datasourceHphmArr addObject:car.hphm];
                }
                
            }
            
            
            [self reloadView];
            NSArray *arr = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId];
            if ([arr count] == 2 && [indexString isEqualToString:@"0"]) {
                [self getDealRecordWithIndex:1];
            }
            if ([_datasourceArr count] == 0) {
                if ([arr count] == 1 || [indexString isEqualToString:@"1"]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"无违法处理记录" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
            
        }else{
            
            [UIAlertView alertTitle:@"提示信息" msg:[NSString stringWithFormat:@"服务器异常，获取违法处理明细列表失败,服务器返回%@", requestObj]];
            
        }
        _isloading = NO;
        [_refreshHeader egoRefreshScrollViewDataSourceDidFinishedLoading:_rootTableView];

    } onError:^(NSString *errorStr) {
        
        [UIAlertView alertTitle:@"提示信息" msg:[NSString stringWithFormat:@"获取违法处理明细列表失败,%@", errorStr]];
        _isloading = NO;
        [_refreshHeader egoRefreshScrollViewDataSourceDidFinishedLoading:_rootTableView];

        
    }];
    /*
     {
     "count":4,
     "vss":[
     {
     "xh":"5325267900084214",
     "sfzmhm":"532621196212260056",
     "contime":"2013-11-26 01:16:27",
     "dsr":"曹福生",
     "jdsbh":"532526160090383",
     "stauts":"2"
     },
     {
     "xh":"5303237900025472",
     "sfzmhm":"532621196212260056",
     "contime":"2013-11-26 01:20:21",
     "dsr":"曹福生",
     "jdsbh":"530323160047478",
     "stauts":"2"
     },
     {
     "xh":"5326307900092807",
     "sfzmhm":"532621196212260056",
     "contime":"2013-11-26 01:38:07",
     "dsr":"曹福生",
     "jdsbh":"532630160010387",
     "stauts":"2"
     },
     {
     "xh":"5326217900120153",
     "sfzmhm":"532621196212260056",
     "contime":"2013-11-26 01:47:14",
     "dsr":"曹福生",
     "jdsbh":"",
     "stauts":"4"
     }
     ]
     }
     
     
     status 1:确认中2：确认成功;3:违章异议;4:确认失败
     
     */

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
