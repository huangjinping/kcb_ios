//
//  PayRecordViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-12.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "PayRecordViewController.h"
#import "FiltViewController.h"

@interface PayRecordViewController ()<
EGORefreshTableHeaderDelegate,
UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate,
FiltViewControllerDelegate
>
{
    EGORefreshTableHeaderView   *_refreshHeader;
    BOOL                        _isloading;
    
    UITableView                 *_rootTableView;
    
    NSMutableArray              *_datasourceArr;
    NSMutableArray              *_filtedDatasourceArr;
    NSMutableArray              *_datasourceHphmArr;

}

@property (nonatomic, retain)   NSArray     *filtHphmArr;
@property (nonatomic, retain)   NSString     *filtDateStr;

@end

@implementation PayRecordViewController

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
    
    
    [self getPayRecord];
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
    _filtDateStr = nil;
    _filtHphmArr = nil;
    
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(APP_X, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    [_rootTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_rootTableView setBackgroundColor:COLOR_VIEW_CONTROLLER_BG];
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
    
    
    UIButton *filtButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [filtButton setBackgroundColor:[UIColor clearColor]];
    [filtButton setBackgroundImage:[UIImage imageNamed:@"filt_button"] forState:UIControlStateNormal];
    [filtButton setFrame:YYRectMake(_navigationImgView.w - 100, (_navigationImgView.h - 30)/2, 40, 40)];
    [filtButton addTarget:self action:@selector(filtButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_navigationImgView addSubview:filtButton];
    
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
    [self gobackPage];
}


#pragma mark- UITableViewDelegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_filtedDatasourceArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 158;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"payRecordCell";
    PayRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PayRecordCell" owner:self options:nil] lastObject];
        [cell.bgView setFrame:CGRectMake(0, 10, APP_WIDTH, cell.bgView.height)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dataDict = [_filtedDatasourceArr objectAtIndex:indexPath.row];
    cell.cellNumL.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    
    cell.payNumL.text = [dataDict analysisStrValueByKey:@"ordid"];
    cell.payStatusL.text = @"确认成功";//[dataDict objectForKey:@""];
    cell.payTimeL.text = [dataDict analysisStrValueByKey:@"transtime"];
    cell.costL.text = [dataDict analysisStrValueByKey:@"transamt"];
    
    return cell;
}



#pragma mark- 网络请求

- (void)getPayRecord{
    /*
     
     {
     "count":2,
     "orders":[
     {
     "hphm":"云AE355E",
     "hpzl":"02",
     "ordid":"20130814000554",
     "jdsbhs":"530100150005979,",
     "transamt":66.5,
     "transtime":"2013-08-14 14:48:53"
     },
     {
     "hphm":"琼C99699",
     "hpzl":"02",
     "ordid":"2013922400000401",
     "jdsbhs":"469800100006964,469800100006965,",
     "transamt":80,
     "transtime":"2013-07-04 23:17:39"
     }
     ]
     }
     */
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"listorder" forKey:@"action"];
    [dict setObject:APP_DELEGATE.userName forKey:@"username"];
    _isloading = YES;
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSArray *orders = [resDict objectForKey:@"orders"];
            
            [_datasourceArr removeAllObjects];
            for (NSDictionary *dict in orders) {
                [_datasourceArr addObject:dict];
            }
            [_datasourceHphmArr removeAllObjects];
            for (NSDictionary *dict in _datasourceArr) {
                for (NSString *hphm in _datasourceHphmArr) {
                    if (![[dict objectForKey:@"hphm"] isEqualToString:hphm]) {
                        [_datasourceHphmArr addObject:[dict objectForKey:@"hphm"]];
                    }
                }
                if ([_datasourceHphmArr count] == 0) {
                    [_datasourceHphmArr addObject:[dict objectForKey:@"hphm"]];
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
