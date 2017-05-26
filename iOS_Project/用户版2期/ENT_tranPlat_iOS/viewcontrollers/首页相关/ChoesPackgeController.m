//
//  ChoesPackgeController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/9/7.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "ChoesPackgeController.h"
#import "MyAFNetWorkingRequest.h"
#import "packgesCell.h"
#import "OrderInfoViewController.h"
@interface ChoesPackgeController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView    *_rootScrollView;
    
    CGFloat         _pxy;
    CGFloat         _scrollOffsetY;
    UILabel         *_xzCountLabel;
    UIView          *_bgView;
    int                     _typeId;
    float               _selectedAllPrice;
}

@property (nonatomic, strong) MyAFNetWorkingRequest *request;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic,strong)NSMutableArray *seviDatas;
@property (nonatomic, strong) NSMutableArray *smallPackegArr;
@property (nonatomic, strong) NSMutableArray *bigPackegArr;
@property (nonatomic, strong) NSMutableArray *deepPackegArr;
@property (nonatomic, strong) UITableView *tabView;

//记录默认显示第一行数据
@property (nonatomic, assign) BOOL isFirstLoad;
//记录switch打开的switch们
@property (nonatomic,strong) NSMutableArray * selectedSwitchs;

@property (nonatomic,strong)  NSMutableArray * selectedSevArr;//选中的小服务项目数组
@property (nonatomic,strong)  NSMutableArray * selectedPackgeArr;//选中的大服务项目数组

@end

@implementation ChoesPackgeController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //请求数据
    _isFirstLoad = YES;
    //初始化数组
    _datas = [NSMutableArray array];
    _selectedSwitchs = [NSMutableArray array];
    
    //观察者:计算小表中单选框选中的价格
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CalculationPrice) name:@"CalculationPriceNOTI" object:nil];
    
    _typeId = 17;
    [self downloadData];
    
    //创建表
    _tabView = [[UITableView alloc]initWithFrame:CGRectMake(0,APP_VIEW_Y+100*PX_Y_SCALE+5, APP_WIDTH, APP_HEIGHT-64-100*PX_Y_SCALE-100*PX_Y_SCALE-10) style:UITableViewStylePlain];
    _tabView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tabView];
//  _tabView.bounces = NO;
    _tabView.separatorStyle = UITableViewCellEditingStyleNone;
    _tabView.delegate = self;
    _tabView.dataSource = self;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"packegCell";
    
    packgesCell * listCell = [[packgesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    listCell.indexPath = indexPath;
    BaoYangModel *model = _datas[indexPath.row];
    
    if(model.isDefaultSelected == YES)
    {
        listCell.switchChoes.enabled = NO;//switch开着的时候,不允许关闭
        [listCell.switchChoes setOn:YES animated:NO];
    }
    if (model.isdelete == YES) {
        [_selectedSwitchs addObject:indexPath];//记录switch开状态的位置
        [listCell.switchChoes setOn:YES animated:NO];
    }
    
    //移除添加的方法
    [listCell.switchChoes removeTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    
    listCell.model = model;
    listCell.switchChoes.tag = indexPath.row;
    [listCell.switchChoes addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    //添加开关打开的位置进数组
    if (_selectedSwitchs)
    {
        if ([_selectedSwitchs containsObject:indexPath]) {
            [listCell.switchChoes setOn:YES animated:NO];
        }
    }
    
    //取消cell的点击事件(动画)
    [listCell setSelectionStyle:UITableViewCellSelectionStyleNone];

    
    //说明 你把所有的 都加载了一次了。下次在加载就是第二次了
    if (indexPath.row == _datas.count-1) {
        _isFirstLoad = NO;
    }
    
    return listCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaoYangModel *model = _datas[indexPath.row];
    NSMutableArray *mutArray = [NSMutableArray array];
    for (BaoYangServiewModel *sevModel in model.serviceItemList)
    {
        
        if (model.sczd >= 5 && model.sczd < 10)
        {
            if ([sevModel.ext1Int isEqualToString:@"23"])
            {
                [mutArray addObject:sevModel];
            }
        }
        if (model.sczd >= 10 && model.sczd <= 15)
        {
            if ([sevModel.ext1Int isEqualToString:@"24"])
            {
                [mutArray addObject:sevModel];
            }
        }
        if (model.sczd >= 16 && model.sczd <= 30)
        {
            if ([sevModel.ext1Int isEqualToString:@"25"])
            {
                [mutArray addObject:sevModel];
            }
        }
        if (model.sczd > 30)
        {
            if ([sevModel.ext1Int isEqualToString:@"26"])
            {
                [mutArray addObject:sevModel];
            }
        }

       
    }

    return 5 + 40 + 10 + mutArray.count * 40 + 10;
}
-(void)CalculationPrice
{
    _selectedAllPrice = 0.0;
    _selectedPackgeArr = [NSMutableArray array];
    _selectedSevArr = [NSMutableArray array];
    for (BaoYangModel *modelBaoyang in _datas)
    {
        if(modelBaoyang.isdelete == YES || modelBaoyang.isDefaultSelected == YES)
        {
            [_selectedPackgeArr addObject:modelBaoyang];
            
            if(modelBaoyang.serviceItemList.count > 0)
            {
                for (BaoYangServiewModel *modelSev in modelBaoyang.serviceItemList )
                {
                    if(modelSev.isdelete == YES)
                    {
                        NSInteger price = [modelSev.price integerValue];
                        _selectedAllPrice += price;
                        [_selectedSevArr addObject:modelSev];
                    }
                }
                
            }else
            {
                BaoYangServiewModel *model = [BaoYangServiewModel new];
                [_selectedSevArr addObject:model];
                
            }
            
        }
    }
    
    [self createTopView];
    //        NSLog(@"_countPriceArr __ %@",_selectedSevArr);
    //        NSLog(@"selectedAllPrice__ %@",_selectedPackgeArr);
}

-(void) formatDatas
{
    
    for (int i =0; i<_datas.count; i++) {
        
        BaoYangModel *model = _datas[i];
        
        NSMutableArray * sevDatas = [NSMutableArray array];
        
        /*******************************
         判断市场价格来区分服务项目数据的显示
         *******************************/
        for (BaoYangServiewModel *sevModel in model.serviceItemList)
        {
            
            if (model.sczd >= 5 && model.sczd < 10)
            {
                if ([sevModel.ext1Int isEqualToString:@"23"])
                {
                    [sevDatas addObject:sevModel];
                }
            }
            if (model.sczd >= 10 && model.sczd <= 15)
            {
                if ([sevModel.ext1Int isEqualToString:@"24"])
                {
                    [sevDatas addObject:sevModel];
                }
            }
            if (model.sczd >= 16 && model.sczd <= 30)
            {
                if ([sevModel.ext1Int isEqualToString:@"25"])
                {
                    [sevDatas addObject:sevModel];
                }
            }
            if (model.sczd > 30)
            {
                if ([sevModel.ext1Int isEqualToString:@"26"])
                {
                    [sevDatas addObject:sevModel];
                }
            }
            
        }
        //确保每个cell中的第一个数据是默认勾选
        if(_isFirstLoad == YES)
        {
            if (sevDatas.count >0)
            {
                BaoYangServiewModel *sevModel = sevDatas[0];
                sevModel.isdelete = YES;
            }
        }
        
        //将经过筛选的数组赋值给小表
        _seviDatas = sevDatas;
        model.serviceItemList = sevDatas;
        
    }
    
    [self CalculationPrice];
    
}



#pragma mark downloadData
-(void)downloadData
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://%@/getPackage.do?typeId=%d&shopId=%@",NET_ADDR_BUSS_956122,_typeId,self.baoyang.id];
    NSString *path = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _request = [[MyAFNetWorkingRequest alloc]initWithRequest:path andParams:nil andBlock:^(NSData *requestData) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataArr = dic[@"msg"];
        NSMutableArray *arr = [BaoYangModel arrayOfModelsFromDictionaries:dataArr];
        //倒序
        NSArray *array = [[arr reverseObjectEnumerator]allObjects];
        //小保养
        _smallPackegArr = [NSMutableArray array];
        [_smallPackegArr removeAllObjects];
        //大保养
        _bigPackegArr = [NSMutableArray array];
        [_bigPackegArr removeAllObjects];
        //深保养
        _deepPackegArr = [NSMutableArray array];
        [_deepPackegArr removeAllObjects];
        
        for (BaoYangModel *model in array)
        {
            model.xxlc = self.baoyang.xxlc;
            model.sczd = self.baoyang.sczd;
            long travelNum = model.xxlc;
            if (model.xxlc >= 10000) {
                travelNum = model.xxlc % 10000;
            }
            
            //小保养
            if ([model.extInt1 isEqualToString:@"20"])
            {
                
                [_smallPackegArr addObject:model];
                model.isDefaultSelected = YES;//使开关默认打开
                
            }
            //大保养
            if ([model.extInt1 isEqualToString:@"21"])
            {
                
                [_bigPackegArr addObject:model];
                if (travelNum >= 7500 || travelNum < 2500)
                {
                    model.isDefaultSelected = YES;
                }
            }
            //深保养
            if ([model.extInt1 isEqualToString:@"22"])
            {
                [_deepPackegArr addObject:model];
                
            }
        }
        
        [_datas addObjectsFromArray:_smallPackegArr];
        [_datas addObjectsFromArray:_bigPackegArr];
        [_datas addObjectsFromArray:_deepPackegArr];
        
        
        [_tabView reloadData];
        [self formatDatas];
        
    }];
    
    
    
    
}
#pragma mark 创建顶部视图
-(void)createTopView
{
    
    
    CGFloat buttonBgHeight = 60 + 20 + 10;
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - 100*PX_Y_SCALE)];
    
    self.view.backgroundColor = COLOR_FRAME_LINE;
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH,buttonBgHeight*PX_Y_SCALE)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
    
    //*********************************选择服务*********************************
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 300, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"预约车辆："];
    [_bgView addSubview:label];
    
    UILabel *carLabel = [[UILabel alloc] initWithFrame:QGRectMake(APP_WIDTH-90,30, 180, 40)];
    [carLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_LINK textAlignment:NSTextAlignmentLeft];
    [carLabel setText:_baoyang.hphm];
    [_bgView  addSubview:carLabel];
    
    //*********************************下一步*********************************
    UIView *buttonBgView = [[UIView alloc] initWithFrame:BGRectMake(0, _rootScrollView.b, APP_PX_WIDTH, 100)];
    buttonBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonBgView];
    
    //下一步View
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = LGRectMake(30, 15, buttonBgView.w - 30*2, buttonBgView.h - 15*2);
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_NOMAL;
    [button addTarget:self action:@selector(nextStepButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    [buttonBgView addSubview:button];
    //
    
    
    _xzCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -30, APP_WIDTH, 30)];
    [_xzCountLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
    _xzCountLabel.backgroundColor = [UIColor whiteColor];
    NSString *sevString = [NSString stringWithFormat:@"您已选择%lu项服务,总金额%.2f元",(unsigned long)_selectedPackgeArr.count,_selectedAllPrice];
    NSString *priceStr = [NSString stringWithFormat:@"%.2f",_selectedAllPrice];
    NSRange priceRange = [sevString rangeOfString:priceStr];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:sevString];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, 1)];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(12, priceRange.length)];
    [_xzCountLabel setAttributedText:attributedStr];
    [buttonBgView addSubview:_xzCountLabel];
    
    UILabel *lineL = [UILabel lineLabelWithPoint:CGPointMake(0, CGRectGetMaxY(_xzCountLabel.frame))];
    [buttonBgView addSubview:lineL];
}


-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    
    NSIndexPath * selecedIndexPath =[NSIndexPath indexPathForRow:switchButton.tag inSection:0];
    
    
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        //        showSwitchValue.text = @"是";
        [_selectedSwitchs addObject:selecedIndexPath];
        
    }else {
        //        showSwitchValue.text = @"否";
        [_selectedSwitchs removeObject:selecedIndexPath];
    }
    
    BaoYangModel * model = _datas[selecedIndexPath.row];
    model.isdelete =isButtonOn;
    
    
    [self formatDatas];
    
}

#pragma mark 下一步跳转
- (void)nextStepButtonClicked
{
    OrderInfoViewController *dateInfoVc = [[OrderInfoViewController alloc]init];
    dateInfoVc.car = self.car;
    dateInfoVc.baoyang = self.baoyang;
    dateInfoVc.baoyang.selectedAllPrice = _selectedAllPrice;
    dateInfoVc.baoyang.seletedPacegeArr = _selectedPackgeArr;
    dateInfoVc.baoyang.seletedSevArr    = _selectedSevArr;
    //    NSLog(@"dateInfoVc.baoyang:%@",dateInfoVc.baoyang);
    [self.navigationController pushViewController:dateInfoVc animated:YES];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"选择服务"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
