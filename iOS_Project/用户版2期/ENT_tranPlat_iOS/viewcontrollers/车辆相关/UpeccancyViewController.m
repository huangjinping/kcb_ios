//
//  UpeccancyViewController.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 16/1/18.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "UpeccancyViewController.h"

@interface UpeccancyViewController ()

@end

@implementation UpeccancyViewController

- (id)initWithHphm:(NSString*)hphm{
    if (self = [super init]) {
        CarInfo *car = [[[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId andHphm:hphm] lastObject];
        _car = [[CarInfo alloc] initWithHpzl:car.hpzl hpzlname:car.hpzlname hphm:car.hphm clsbdh:car.clsbdh clpp1:car.clpp1 vehicletypename:car.vehicletypename vehiclepic:car.vehiclepic vehiclestatus:car.vehiclestatus yxqz:car.yxqz bxzzrq:car.bxzzrq ccdjrq:car.ccdjrq vehiclegxsj:car.vehiclegxsj isupdate:car.isupdate createTime:car.createTime zt:car.zt sfzmhm:car.sfzmhm syr:car.syr fdjh:car.fdjh andUseId:car.userId];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor =[UIColor lightGrayColor];
    _rootTableView = [[UITableView alloc] init];
    [_rootTableView setFrame:CGRectMake(0, 64,self.view.width, APP_HEIGHT - APP_NAV_HEIGHT )];
    _rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rootTableView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    [_rootTableView setContentSize:CGSizeMake(_rootTableView.width, _rootTableView.height)];
    [self.view addSubview:_rootTableView];
    [_rootTableView registerNib:[UINib nibWithNibName:@"UcarpenccanCell" bundle:nil] forCellReuseIdentifier:@"Ucar"];
    CarPeccancyRecord *carPeccancyRecord = [[[DataBase sharedDataBase] selectCarPeccancyRecordByUserId:APP_DELEGATE.userId andHphm:_car.hphm] lastObject];
    
    
    NSDictionary *dic =[Instance_ENT dictionaryWithJsonString:carPeccancyRecord.jdcwf_detail];
    
    
    _datas =[dic valueForKey:@"vehicles"];
    
    
    _egoView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(APP_X, -_rootTableView.frame.size.height, _rootTableView.frame.size.width, _rootTableView.frame.size.height)];
    _egoView.delegate = self;
    [_rootTableView addSubview:_egoView];
    
}
#pragma mark- tableview DELEGATE and DATASOURCE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return 190;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ident = @"Ucar";
    UcarpenccanCell *cell=[tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    
    //   UcarWFModel *model = _datas[indexPath.row];
    //cell.bgView.frame=CGRectMake(0, 10,cell.frame.size.height, cell.frame.size.height-10);
    cell.wfsjL.text =[_datas[indexPath.row]valueForKey: @"wfsj"];

    cell.wfddL.text =[_datas[indexPath.row]valueForKey: @"wfdz"];
    cell.wfddL.numberOfLines=0;
    cell.wfxwL.text =[_datas[indexPath.row]valueForKey: @"wfnr"];
    cell.wfddL.numberOfLines=0;

    cell.wfsjL.font = WY_FONT_SIZE(38);;
    cell.wfddL.font = WY_FONT_SIZE(38);;
    cell.wfxwL.font = WY_FONT_SIZE(38);;
    cell.cfbzL.font = WY_FONT_SIZE(38);;
    cell.wfsjLabelLabel.font = WY_FONT_SIZE(38);;
    cell.wfddLabelLabel.font = WY_FONT_SIZE(38);;
    cell.wfxwLabelLabel.font = WY_FONT_SIZE(38);;
    cell.wfxwLabelLabel.font = WY_FONT_SIZE(38);;
    cell.wfsjL.textColor=[UIColor colorWithHex:0x666666];
    cell.wfddL.textColor=[UIColor colorWithHex:0x666666];
    cell.wfxwL.textColor=[UIColor colorWithHex:0x666666];
    cell.cfbzL.textColor=[UIColor colorWithHex:0x666666];
    cell.wfsjLabelLabel.textColor=[UIColor colorWithHex:0x666666];
    cell.wfddLabelLabel.textColor=[UIColor colorWithHex:0x666666];
    cell.wfxwLabelLabel.textColor=[UIColor colorWithHex:0x666666];
    cell.wfxwLabelLabel.textColor=[UIColor colorWithHex:0x666666];
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:@"罚款"];
    
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:15],
                           NSForegroundColorAttributeName : COLOR_BUTTON_YELLOW};
    
    [aString appendAttributedString:[[NSAttributedString alloc] initWithString:[_datas[indexPath.row]valueForKey: @"fkje"] attributes:dict]];
    [aString appendAttributedString:[[NSAttributedString alloc] initWithString:@"元 记"]];
    [aString appendAttributedString:[[NSAttributedString alloc] initWithString:[_datas[indexPath.row]valueForKey: @"wfjfs"]  attributes:dict]];
    [aString appendAttributedString:[[NSAttributedString alloc] initWithString:@"分"]];
    
    [cell.cfbzL setAttributedText:aString];
    cell.cfbzL.numberOfLines=0;
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    //    NSString *string=[NSString stringWithFormat:@"罚款%@元 记%@分",model.fkje,model.wfjfs];
    // cell.cfbzL.text =string;
    
    //    @interface UcarpenccanCell : UITableViewCell
    //    @property(nonatomic, retain) IBOutlet UILabel       *wfsjL;//时间
    //    @property(nonatomic, retain) IBOutlet UILabel       *wfddL;//地点
    //    @property(nonatomic, retain) IBOutlet UILabel       *wfxwL;//行为
    //    @property(nonatomic, retain) IBOutlet UILabel       *cfbzL;//处罚标准
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (void)getPeccancyRecord:(CarInfo*)car{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"listbycxy" forKey:@"action"];
    [dict setObject:car.hpzl forKey:@"hpzl"];
    [dict setObject:car.hphm forKey:@"hphm"];
    [dict setObject:car.clsbdh forKey:@"clsbdh"];
    [dict setObject:car.fdjh forKey:@"fdjh"];
    
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:NO  callBackWithObj:car onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        id dicUcar=  requestObj;
        
        if ([dicUcar isKindOfClass:[NSDictionary class]]){
            if([[dicUcar valueForKey:@"ErrorCode"]isEqualToString:@"0"]){
                SBJsonWriter *writer = [[SBJsonWriter alloc] init];
                NSString *jsonStr = [writer stringWithObject:requestObj];
                
                CarPeccancyRecord *carpr = [[CarPeccancyRecord alloc] initWithHpzl:((CarInfo*)callBackObj).hpzl hphm:((CarInfo*)callBackObj).hphm jdcwf_detail:jsonStr jdcwf_gxsj:[[NSDate date]string] andUserId:APP_DELEGATE.userId];
                
                
                [carpr update];
                 _datas=[[NSMutableArray alloc]init];
                CarPeccancyRecord *carPeccancyRecord = [[[DataBase sharedDataBase] selectCarPeccancyRecordByUserId:APP_DELEGATE.userId andHphm:car.hphm] lastObject];
                NSDictionary *dic =[Instance_ENT dictionaryWithJsonString:carPeccancyRecord.jdcwf_detail];
                
                
                _datas =[dic valueForKey:@"vehicles"];
                
                [_rootTableView reloadData];
                
            }
            
           // _datas=[[NSMutableArray alloc]init];
            
        }else{
            
             [_datas removeAllObjects];
            if ([dicUcar isKindOfClass:[NSString class]]) {
                
            }
        }
        
        
    } onError:^(NSString *errorStr) {
      //  _datas=[[NSMutableArray alloc]init];
        
           [_datas removeAllObjects];
        
    }];
}
#pragma mark - EGORefreshTableHeaderDelegate


- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self getPeccancyRecord:_car];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self setCustomNavigationTitle:_car.hphm];
    
    [_rootTableView reloadData];
    if(!_datas.count){
    
        [UIAlertView alertTitle:@"信息提示" msg:@"无违章罚款记录"];
       
    }
    
    //    [self _loadData];
    //    [_rootTableView reloadData];
    
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
