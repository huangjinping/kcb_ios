//
//  OrderInfoViewController.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/9/10.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "OrderInfoViewController.h"
#import "MyOrderController.h"
#import "ZKButton.h"
#import "dateCell.h"
@interface OrderInfoViewController ()<UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UITextField     *_ZSXMTF;//真是姓名
    UITextField     *_LXSJTF;//联系手机
    UILabel         *_BYRQTF;//保养日期
    UILabel         *_DDSJL;//到点时间
    UIView          *_datePickerBgview;
    UIView          *_choesTimeView;
   

}
@property (nonatomic, strong) UIScrollView  *rootScrollView;
@property (nonatomic, strong) UIImageView   *perfectCarinfoFormBgView;
@property (nonatomic, strong) UICollectionView *dateCV;
@property (nonatomic, copy) NSMutableArray  *dateArr;
@property (nonatomic, copy) NSArray  *timeArr;
@property (nonatomic, copy) NSMutableArray *datas;
@property (nonatomic ,copy) UIButton *button;
@property (nonatomic ,copy) UIButton *timeButton;
@property (nonatomic ,copy) NSString *timeLabel;
@property (nonatomic,strong)UIView *timeView;

@property(nonatomic,assign)NSInteger indexPathRow_date;                  //记录日期点中的位置
@property(nonatomic,assign)NSInteger indexPathRow_time;                  //记录时间点中的位置
@end

@implementation OrderInfoViewController
#define TAG_TF_ZSXM     100
#define TAG_TF_LXSJ     101
#define TAG_TF_BYRQ     102
#define TAG_TF_DDSJ     103

#define TAG_TF_SELETED_DATE     110
#define TAG_TF_SELETED_TIME     111

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    //创建UI
    [self creatUI];
}

- (void)creatUI{
    
    CGFloat buttonBgHeight = 60 + 20 + 20;
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - buttonBgHeight*PX_Y_SCALE)];
    _rootScrollView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    
    
    _rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_rootScrollView];
    _rootScrollView.backgroundColor=COLOR_FRAME_LINE;
    
    CGFloat singleLineHeightPX = 30*3;
    _perfectCarinfoFormBgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y: 0 width:APP_PX_WIDTH height:singleLineHeightPX*5];
    [_rootScrollView addSubview:_perfectCarinfoFormBgView];
    //*********************************横线*********************************
    UILabel *lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(0, singleLineHeightPX - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH )*PX_X_SCALE, lineLabel.height+10)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 2 - 1+10)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 3 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(30, singleLineHeightPX * 4 - 1)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH - 60)*PX_X_SCALE, lineLabel.height)];
    [_perfectCarinfoFormBgView addSubview:lineLabel];
    
    
    //*********************************预约车辆*********************************
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"预约车辆："];
    [_perfectCarinfoFormBgView addSubview:label];
    
    UILabel *carLabel = [[UILabel alloc] initWithFrame:QGRectMake(APP_WIDTH-180,30, 180, 40)];
    [carLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_LINK textAlignment:NSTextAlignmentLeft];
    [carLabel setText:_baoyang.hphm];
    [_perfectCarinfoFormBgView  addSubview:carLabel];
    //*********************************真实姓名*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX + 45, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"真实姓名："];
    [_perfectCarinfoFormBgView addSubview:label];
    
    _ZSXMTF = [[UITextField alloc] initWithFrame:LGRectMake(280, singleLineHeightPX + 45, _perfectCarinfoFormBgView.w - 30*2, 40)];
    _ZSXMTF.delegate = self;
    _ZSXMTF.tag = TAG_TF_ZSXM;
    [_ZSXMTF setFont:FONT_NOMAL];
    [_ZSXMTF setBorderStyle:UITextBorderStyleNone];
    [_ZSXMTF setPlaceholder:@"请填写真实姓名"];
    [_ZSXMTF limitCHTextLength:7];
    [_perfectCarinfoFormBgView addSubview:_ZSXMTF];
    
    //*********************************联系手机*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*2 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"联系手机："];
    [_perfectCarinfoFormBgView addSubview:label];
    
    _LXSJTF = [[UITextField alloc] initWithFrame:LGRectMake(280, singleLineHeightPX*2 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    _LXSJTF.delegate = self;
    _LXSJTF.tag = TAG_TF_LXSJ;
    [_LXSJTF setFont:FONT_NOMAL];
    [_LXSJTF setBorderStyle:UITextBorderStyleNone];
    [_LXSJTF setPlaceholder:@"请填写联系手机"];
    [_LXSJTF limitCHTextLength:11];
    [_LXSJTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_perfectCarinfoFormBgView addSubview:_LXSJTF];
    
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*3 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"保养日期："];
    [_perfectCarinfoFormBgView addSubview:label];
    
    _BYRQTF = [[UILabel alloc] initWithFrame:LGRectMake(280, singleLineHeightPX*3 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [_BYRQTF convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_LINK textAlignment:NSTextAlignmentLeft];
    [_BYRQTF setText:@"保养日期"];
    [_perfectCarinfoFormBgView addSubview:_BYRQTF];
    [_BYRQTF setUserInteractionEnabled:YES];
    _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_timeButton setFrame:_BYRQTF.bounds];
    [_timeButton setBackgroundColor:[UIColor clearColor]];
    [_timeButton addTarget:self action:@selector(setDateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _timeButton.tag = 100;
    [_BYRQTF addSubview:_timeButton];
    
    //*********************************到店时间*********************************
    label = [[UILabel alloc] initWithFrame:LGRectMake(30, singleLineHeightPX*4 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [label setText:@"到店时间："];
    [_perfectCarinfoFormBgView addSubview:label];
    
    _DDSJL = [[UILabel alloc] initWithFrame:LGRectMake(280, singleLineHeightPX*4 + 30, _perfectCarinfoFormBgView.w - 30*2, 40)];
    [_DDSJL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_LINK textAlignment:NSTextAlignmentLeft];
    [_DDSJL setText:@"到店时间"];
    [_perfectCarinfoFormBgView addSubview:_DDSJL];
    [_DDSJL setUserInteractionEnabled:YES];
    _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_timeButton setFrame:_DDSJL.bounds];
    [_timeButton setBackgroundColor:[UIColor clearColor]];
    [_timeButton addTarget:self action:@selector(setDateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _timeButton.tag = 101;
    [_DDSJL addSubview:_timeButton];
    //_________________
    
    _timeView =[[UIView alloc]initWithFrame:LGRectMake(0, self.view.h, self.view.w, self.view.h+100)];
    _timeView.backgroundColor=[UIColor colorWithWhite:0.0 alpha:0.8];
    _timeView.userInteractionEnabled = YES;
   // [self.view addSubview:_timeView];
    
    
    ///------------------
    if (iPhone4){
     _datePickerBgview = [[UIView alloc] initWithFrame:LGRectMake(0,  self.view.h-400, APP_PX_WIDTH, 400)];
    
    }else {
    _datePickerBgview = [[UIView alloc] initWithFrame:LGRectMake(0,  self.view.h-340, APP_PX_WIDTH, 400)];
    
    }
    _datePickerBgview.backgroundColor=[UIColor whiteColor];
    _datePickerBgview.userInteractionEnabled = YES;

    [_timeView addSubview:_datePickerBgview];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:LGRectMake(_datePickerBgview.w - 100, 10, 100, 50)];
    [_button setTitle:@"取消" forState:UIControlStateNormal];
    [_button setTitleColor:COLOR_FONT_NOMAL forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(datePickerDone) forControlEvents:UIControlEventTouchUpInside];
    [_datePickerBgview addSubview:_button];
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setFrame:LGRectMake(0, 10, 150, 50)];
    [button2 setTitle:@"选择时间" forState:UIControlStateNormal];
    [button2 setTitleColor:COLOR_FONT_NOMAL forState:UIControlStateNormal];
    [_datePickerBgview addSubview:button2];
    /*_______________________下一步____________________________________________*/
    
    UIView *buttonBgView = [[UIView alloc] initWithFrame:BGRectMake(0, _rootScrollView.b, APP_PX_WIDTH, buttonBgHeight)];
    buttonBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonBgView];
    lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(0, 0)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH)*PX_X_SCALE, lineLabel.height)];
    [buttonBgView addSubview:lineLabel];
     [self.view addSubview:_timeView];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = LGRectMake(30, 15, buttonBgView.w - 30*2, buttonBgView.h - 15*2);
    [_button setTitle:@"下一步" forState:UIControlStateNormal];
    _button.titleLabel.font = FONT_NOMAL;
    [_button addTarget:self action:@selector(nextStepButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
    [_button.titleLabel setTextColor:[UIColor whiteColor]];
    [buttonBgView addSubview:_button];
    /*____________________________picker________________________________*/
    _dateArr=[[NSMutableArray alloc]init];
    _datas=[[NSMutableArray alloc]init];;
    for (int i =1; i<9; i++) {
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSDate *nexdate = [NSDate dateWithTimeInterval:60 * 60 * 24 *i sinceDate:currentDate];
        NSString *dateString = [dateFormatter stringFromDate:nexdate];
        //NSLog(@"%@",dateString);
        
        NSInteger week;
        NSString *weekStr=nil;
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        comps = [calendar components:unitFlags fromDate:nexdate];
        week = [comps weekday];
        if(week==1)
        {
            weekStr=@"星期天";
        }else if(week==2){
            weekStr=@"星期一";
            
        }else if(week==3){
            weekStr=@"星期二";
            
        }else if(week==4){
            weekStr=@"星期三";
            
        }else if(week==5){
            weekStr=@"星期四";
            
        }else if(week==6){
            weekStr=@"星期五";
            
        }else if(week==7){
            weekStr=@"星期六";
            
        }
        else {
            NSLog(@"error!");
        }
        NSString *daystring=[NSString stringWithFormat:@"%@ \n%@",dateString,weekStr];
        [_dateArr addObject:daystring];
        
    }
    _timeArr = @[@"9:00~10:00",@"10:00~11:00",@"11:00~12:00",@"12:00~13:00",@"13:00~14:00",@"15:00~16:00",@"16:00~17:00",@"17:00~18:00"];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //横向滚动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _dateCV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(button2.frame)+10, APP_WIDTH, (APP_WIDTH)/2) collectionViewLayout:layout];
    _dateCV.delegate = self;
    _dateCV.dataSource = self;
    
    _dateCV.backgroundColor = [UIColor whiteColor];
    [_dateCV registerClass:[dateCell class] forCellWithReuseIdentifier:@"datecell"];
    [_datePickerBgview addSubview:_dateCV];
    
    
}
- (void)nextStepButtonClicked{

    
    if (!_LXSJTF.text || ![_LXSJTF.text isValidPhoneNum]) {
        [UIAlertView alertTitle:@"被保人信息" msg:@"手机号码填写有误，请检查并修改后重新提交！"];
        
    }else if ([_ZSXMTF.text isEqualToString:@""] ||[_ZSXMTF.text isEqualToString:@"请填写真实姓名"] ){
       [UIAlertView alertTitle:@"被保人信息" msg:@"真实姓名填写有误，请检查并修改后重新提交！"];
    
    }else if([_DDSJL.text isEqualToString:@"到店时间"]||[_BYRQTF.text isEqualToString:@"保养日期"])
    {
        
        [UIAlertView alertTitle:@"被保人信息" msg:@"请填写预约时间！"];
    }
    else{
        
        MyOrderController *ordVC=[[MyOrderController alloc]init];
        ordVC.car = self.car;
        ordVC.baoyang = self.baoyang;
        ordVC.baoyang.peopleName = _ZSXMTF.text;
        ordVC.baoyang.peoplePhone = _LXSJTF.text;
        ordVC.baoyang.peopleDate = _BYRQTF.text;
        ordVC.baoyang.peopleTime = _DDSJL.text;
        //    NSLog(@"ordVC.baoyang%@",ordVC.baoyang);
        [self.navigationController pushViewController:ordVC animated:YES];
    }
    
    
}
- (void)datePickerCancel{
    
    [UIView animateWithDuration:0.5 animations:^{
        [_timeView setFrame:LGRectMake(0, self.view.h ,self.view.w, self.view.h+100)];
    }];
}
- (void)datePickerDone{
    [_dateCV reloadData];
    
    [UIView animateWithDuration:0.5 animations:^{
        [_timeView setFrame:LGRectMake(0, self.view.h, self.view.w, self.view.h+100)];
    }];
    
}

- (void)setDateButtonClicked:(UIButton*)button{
    
    if (button.tag == 100)
    {
        _datas = [NSMutableArray arrayWithArray:self.dateArr];
        _dateCV.tag = TAG_TF_SELETED_DATE;
        
    }else if(button.tag == 101)
    {
        _datas = [NSMutableArray arrayWithArray:self.timeArr];
        _dateCV.tag = TAG_TF_SELETED_TIME;
        
    }
    [_dateCV reloadData];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [_timeView setFrame:LGRectMake(0, 0, self.view.w, self.view.h+200)];
        
        
    }];
    
    
}


#pragma  mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}
//个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _datas.count;
}
//添加内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ident = @"datecell";
    
    dateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ident forIndexPath:indexPath];
    
    NSString *string = _datas[indexPath.row];
    cell.dateLabel.text = string;
    cell.layer.borderWidth = 0.5;
    cell.layer.borderColor=COLOR_FONT_NOTICE.CGColor;
    if (_dateCV.tag == TAG_TF_SELETED_DATE)
    {
        //添加颜色
        if (indexPath.row == _indexPathRow_date)
        {
            [cell setBackgroundColor:COLOR_BUTTON_BLUE];
            cell.dateLabel.textColor=[UIColor whiteColor];
        }
        else
        {
            [cell setBackgroundColor:[UIColor whiteColor]];
            cell.dateLabel.textColor=COLOR_FONT_NOTICE;

        }
        
    }
    else if(_dateCV.tag == TAG_TF_SELETED_TIME)
    {
        //添加颜色
        if (indexPath.row == _indexPathRow_time)
        {
            [cell setBackgroundColor:COLOR_BUTTON_BLUE];
            cell.dateLabel.textColor=[UIColor whiteColor];
        }
        else
        {
            [cell setBackgroundColor:[UIColor whiteColor]];
            cell.dateLabel.textColor=COLOR_FONT_NOTICE;
        }
    }
    
    return cell;
    
    
}
//设置一个Item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //必须有中间间距10像素
    return CGSizeMake((APP_WIDTH)/4,(APP_WIDTH)/4);
}
//设置当前项与四周的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//选中当前项执行
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dateCV.tag == TAG_TF_SELETED_DATE)
    {
        _indexPathRow_date = indexPath.row;
    }
    else if(_dateCV.tag == TAG_TF_SELETED_TIME)
    {
        _indexPathRow_time = indexPath.row;
    }
    
    dateCell *cell = (dateCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [cell setBackgroundColor:COLOR_BUTTON_BLUE];
    [UIView animateWithDuration:0.5 animations:^{
        [_timeView setFrame:LGRectMake(0, self.view.h, self.view.w, self.view.h)];
        if ([_datas isEqualToArray:_dateArr])
        {
            
            NSString *string = cell.dateLabel.text;
            NSArray * array= [string componentsSeparatedByString:@"\n"];
            NSMutableString *need = [NSMutableString string];
            for (NSString *str in array) {
                
                [need appendString:str];
            }
            
            _BYRQTF.text = need;
        }else if([_datas isEqualToArray:_timeArr])
        {
            
            _DDSJL.text = cell.dateLabel.text;
            
        }
        
        
    }];
    
    [_dateCV reloadData];
    
}//列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"完善预约信息"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
