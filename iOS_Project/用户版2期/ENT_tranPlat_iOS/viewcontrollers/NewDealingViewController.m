//
//  NewDealingViewController.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 16/2/15.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "NewDealingViewController.h"
#import "FiltViewController.h"
#import "serOderCell.h"

#define TAG_TABLEVIEW_MAIN_ORDER        0
#define TAG_TABLEVIEW_OTHER_ORDER       1
#define ROW_HEIGHT_L        182
#define ROW_HEIGHT_S        157

@interface NewDealingViewController ()<
EGORefreshTableHeaderDelegate,
SegmentButtonViewDelegate,
UITableViewDataSource,
UITableViewDelegate,
FiltViewControllerDelegate
>
{
    SegmentButtonView           *_seg;
    
    EGORefreshTableHeaderView   *_refreshHeader;
    UITableView                 *_rootTableView;
  
    
    UIView                      *_otherOrdersDetailView;
    BOOL                        _isloading;
    NSInteger                   _indexLoadDetail;
    BOOL                     _showDetail;
    
    //违章缴款订单
    NSMutableArray              *_datasourceArr;
    NSMutableArray              *_filtedDatasourceArr;
    NSMutableArray              *_datasourceHphmArr;
    //违章明细订单
    NSMutableArray              *_otherDatasourceArr;
    NSMutableArray              *_otherFiltedDatasourceArr;
    NSMutableArray              *_otherDatasourceHphmArr;
     NSMutableArray                  *_tableviewDatasourceArr;
    
}


@end

@implementation NewDealingViewController
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
         [self getDealRecordWithIndex:0];
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
    [_otherFiltedDatasourceArr removeAllObjects];
    
    [_filtedDatasourceArr addObjectsFromArray:_datasourceArr];
    [_otherFiltedDatasourceArr addObjectsFromArray:_otherDatasourceArr];
    [_rootTableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _datasourceArr = [[NSMutableArray alloc] initWithCapacity:0];
    _filtedDatasourceArr = [[NSMutableArray alloc] initWithCapacity:0];
    _datasourceHphmArr = [[NSMutableArray alloc] initWithCapacity:0];
    _otherDatasourceArr = [[NSMutableArray alloc] initWithCapacity:0];
    _otherFiltedDatasourceArr = [[NSMutableArray alloc] initWithCapacity:0];
    _otherDatasourceHphmArr = [[NSMutableArray alloc] initWithCapacity:0];
    _otherOrdersDetailView = nil;
    _indexLoadDetail = 0;
    _showDetail = NO;
    
    _seg = [[SegmentButtonView alloc] initWithFrame:LGRectMake(APP_X, APP_VIEW_Y/PX_Y_SCALE, APP_PX_WIDTH, 34*2) backgroundColor:[UIColor whiteColor] andLineColor:COLOR_NAV];
    [_seg setTitles:[NSArray arrayWithObjects:@"违章处理", @"缴款明细", nil] withTitleNorColor:COLOR_FONT_NOMAL andTitleSelColor:COLOR_NAV];
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
    
    [self reloadView];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark- SegmentButtonViewDelegate
- (void)segmentButtonView:(SegmentButtonView *)segmentButtonView showView:(NSInteger)index{
    if (segmentButtonView.selectedIndex == TAG_TABLEVIEW_MAIN_ORDER) {
      
    }else{
 
        if ([_otherFiltedDatasourceArr count] == 0) {
            [self getDealRecordWithIndex:0];
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
        
        return _otherFiltedDatasourceArr.count;
    }
    
}
#define ROW_HEIGHT_L        182
#define ROW_HEIGHT_S        157
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == TAG_TABLEVIEW_MAIN_ORDER) {
        return 158;
    }else{
         NSDictionary *dataDict = [_otherFiltedDatasourceArr objectAtIndex:indexPath.row];
        NSString *jdsbh = [dataDict analysisStrValueByKey:@"jdsbh"];
        if ([jdsbh isEqualToString:@""]) {
            return ROW_HEIGHT_S;
        }else {
            return ROW_HEIGHT_L;
        }
        
      
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
        cell.cellNumL.text = [NSString stringWithFormat:@"%d", (int)indexPath.row + 1];
        
        cell.payNumL.text = [dataDict analysisStrValueByKey:@"ordid"];
        cell.payStatusL.text = @"确认成功";//[dataDict objectForKey:@""];
        cell.payTimeL.text = [dataDict analysisStrValueByKey:@"transtime"];
        cell.costL.text = [dataDict analysisStrValueByKey:@"transamt"];
     //   cell.cellNumL.font = WY_FONT_SIZE(38);
          cell.cellNumL.hidden=YES;
        cell.payNumL.font = WY_FONT_SIZE(38);;
        cell.payStatusL.font = WY_FONT_SIZE(38);;
        cell.payTimeL.font = WY_FONT_SIZE(38);;
        cell.costL.font = WY_FONT_SIZE(38);;
        cell.Time.font = WY_FONT_SIZE(38);;
        cell.Statusl.font = WY_FONT_SIZE(38);;
        cell.Pay.font = WY_FONT_SIZE(38);;
        cell.Bianhao.font = WY_FONT_SIZE(38);;
        cell.Bianhao.textColor=[UIColor colorWithHex:0x666666];
        cell.Pay.textColor=[UIColor colorWithHex:0x666666];
        cell.Statusl.textColor=[UIColor colorWithHex:0x666666];
        cell.Time.textColor=[UIColor colorWithHex:0x666666];
        cell.payNumL.textColor=[UIColor colorWithHex:0x666666];
        cell.payTimeL.textColor=[UIColor colorWithHex:0x666666];
     
        
        return cell;
    }else{
        static NSString *cellId = @"dealingRecordCell";
        DealingRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[DealingRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        
        
        NSDictionary *dataDict = [_otherFiltedDatasourceArr objectAtIndex:indexPath.row];
        cell.cellNumL.text = [NSString stringWithFormat:@"%d", (int)indexPath.row + 1];
        cell.cellNumL.hidden=YES;
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
        cell.dealNumL.font = WY_FONT_SIZE(38);
        cell.dealTimeL.font = WY_FONT_SIZE(38);
        cell.jdsbhL.font = WY_FONT_SIZE(38);
        cell.hphmL.font = WY_FONT_SIZE(38);
        cell.hpzlL.font = WY_FONT_SIZE(38);
        cell.timeLabel.font = WY_FONT_SIZE(38);
        cell.jdsbhLabel.font = WY_FONT_SIZE(38);
        cell.statusLabel.font = WY_FONT_SIZE(38);
        cell.dealStatusL.font = WY_FONT_SIZE(38);
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    }
- (void)getPayRecord{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"listorder" forKey:@"action"];
    [dict setObject:APP_DELEGATE.userName forKey:@"username"];
    _isloading = YES;
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            NSDictionary *resDict = (NSDictionary*)requestObj;
           // NSLog(@"%@",resDict);
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
                [_otherDatasourceArr removeAllObjects];
                [_otherDatasourceHphmArr removeAllObjects];
            }
            for (NSMutableDictionary *dict in orders) {
                [dict setObject:car.hphm forKey:@"hphm"];
                [dict setObject:car.hpzlname forKey:@"hpzl"];
                [_otherDatasourceArr addObject:dict];
                
                for (int i = 0; i < [_otherDatasourceHphmArr count]; i++) {
                    NSString *oldHphm = [_otherDatasourceHphmArr objectAtIndex:i];
                    if ([car.hphm isEqualToString:oldHphm]) {
                        break;
                    }else{
                        if (i == [_otherDatasourceHphmArr count] - 1){
                            [_otherDatasourceHphmArr addObject:car.hphm];
                        }
                    }
                }
                if ([_otherDatasourceHphmArr count] == 0) {
                    [_otherDatasourceHphmArr addObject:car.hphm];
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
