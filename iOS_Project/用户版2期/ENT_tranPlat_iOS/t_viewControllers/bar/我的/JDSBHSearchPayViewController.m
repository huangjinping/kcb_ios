//
//  JDSBHSearchPayViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-1.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "JDSBHSearchPayViewController.h"

@interface JDSBHSearchPayViewController ()<
UITextFieldDelegate
>
{
    UITextField         *_JDSBHTextField;
    UIScrollView        *_rootScrollView;
    UIView              *_contentBgView;
    //IBOutlet  UITableView   *_tableView;
}

@property (nonatomic, retain)   NSMutableArray     *peccancyArr;

@end

@implementation JDSBHSearchPayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView_{
    
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    [self.view addSubview:_rootScrollView];
    
    //float bi = APP_WIDTH/320;
    UIImageView *searchBgImgView = [[UIImageView alloc] initWithFrame:YYRectMake(0, 0, APP_PX_WIDTH, 30*3)];
    [searchBgImgView setBackgroundColor:COLOR_NAV];
    [searchBgImgView setUserInteractionEnabled:YES];
    [_rootScrollView addSubview:searchBgImgView];
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:YYRectMake(APP_PX_WIDTH - 30 - 40, (90 - 40)/2, 40, 40)];
    [searchButton addTarget:self action:@selector(startSearch:) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setImage:[UIImage imageNamed:@"btn_search.png"] forState:UIControlStateNormal];
    [searchBgImgView addSubview:searchButton];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:YYRectMake(30, 20, APP_PX_WIDTH - 30*2 - 40 - 20, 50)];
    [imgView setImage:[UIImage imageNamed:@"bg_white"]];
    [imgView setUserInteractionEnabled: YES];
    [searchBgImgView addSubview:imgView];

    _JDSBHTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 3, imgView.bounds.size.width - 60, imgView.bounds.size.height)];
    _JDSBHTextField.borderStyle = UITextBorderStyleNone;
    _JDSBHTextField.delegate = self;
    _JDSBHTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [imgView addSubview:_JDSBHTextField];
    
    UILabel *l = [[UILabel alloc] initWithFrame:YYRectMake(30, searchBgImgView.b + 20, APP_PX_WIDTH - 30*2, 60)];
    l.numberOfLines = 0;
    [l convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_FONT_NOTICE textAlignment:NSTextAlignmentLeft];
    [l setText:@"输入违法处罚决定书上的编号查询并缴费，处罚决定书编号为16位，查询时请输入完整决定书编号。"];
    [l setSize:[l.text sizeWithFont:l.font constrainedToSize:CGSizeMake(l.width, 1000)]];
    [_rootScrollView addSubview:l];
    
    _contentBgView = [[UIView alloc] initWithFrame:YYRectMake(0, l.b + 20, APP_PX_WIDTH, 0)];
    [_contentBgView setBackgroundColor:[UIColor whiteColor]];
    [_rootScrollView addSubview:_contentBgView];
}


- (void)reloadView{
    for (UIView *v in _contentBgView.subviews) {
        [v removeFromSuperview];
    }
    
    if ([_peccancyArr count] == 0) {
        return;
    }
    
    PeccancyMsg *msg = [_peccancyArr lastObject];
    
    UILabel *label = [[UILabel alloc] initWithFrame:YYRectMake(30, 30, 0, 30)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"车牌号码：";
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(1000, label.height)];
    [label setSize:size];
    [_contentBgView addSubview:label];
    UILabel *hphmL = [[UILabel alloc] initWithFrame:YYRectMake(label.r + 15, label.t, 400, size.height/PX_X_SCALE)];
    [hphmL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [hphmL setText:msg.hphm];
    [_contentBgView addSubview:hphmL];
    
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, label.b + 20, size.width/PX_X_SCALE, size.height/PX_X_SCALE)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"违法时间：";
    [_contentBgView addSubview:label];
    UILabel *timeL = [[UILabel alloc] initWithFrame:YYRectMake(label.r + 15, label.t, APP_PX_WIDTH - label.r - 15 - 30, size.height/PX_X_SCALE)];
    [timeL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [timeL setText:msg.wfsj];
    [_contentBgView addSubview:timeL];
    
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, label.b + 20, size.width/PX_X_SCALE, size.height/PX_X_SCALE)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"当事人：";
    [_contentBgView addSubview:label];
    UILabel *dsrL = [[UILabel alloc] initWithFrame:YYRectMake(label.r + 15, label.t, APP_PX_WIDTH - label.r - 15 - 30, size.height/PX_X_SCALE)];
    [dsrL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [dsrL setText:msg.dsr];
    [_contentBgView addSubview:dsrL];

    
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, label.b + 20, size.width/PX_X_SCALE, size.height/PX_X_SCALE)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"违法地点：";
    [_contentBgView addSubview:label];
    UILabel *wfddL = [[UILabel alloc] initWithFrame:YYRectMake(label.r + 15, label.t, APP_PX_WIDTH - label.r - 15 - 30, size.height/PX_X_SCALE)];
    [wfddL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [wfddL setText:msg.wfdz];
    [wfddL setSize:[wfddL.text sizeWithFont:wfddL.font constrainedToSize:CGSizeMake(wfddL.width, 1000)]];
    wfddL.numberOfLines = 0;
    [_contentBgView addSubview:wfddL];
    
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, wfddL.b + 20, size.width/PX_X_SCALE, size.height/PX_X_SCALE)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"发现机关：";
    [_contentBgView addSubview:label];
    UILabel *fxjgL = [[UILabel alloc] initWithFrame:YYRectMake(label.r + 15, label.t, APP_PX_WIDTH - label.r - 15 - 30, size.height/PX_X_SCALE)];
    [fxjgL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [fxjgL setText:msg.fxjgmc];
    [fxjgL setSize:[fxjgL.text sizeWithFont:fxjgL.font constrainedToSize:CGSizeMake(fxjgL.width, 1000)]];
    fxjgL.numberOfLines = 0;
    [_contentBgView addSubview:fxjgL];
    
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, fxjgL.b + 20, size.width/PX_X_SCALE, size.height/PX_X_SCALE)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"违法行为：";
    [_contentBgView addSubview:label];
    UILabel *wfxwL = [[UILabel alloc] initWithFrame:YYRectMake(label.r + 15, label.t, APP_PX_WIDTH - label.r - 15 - 30, size.height/PX_X_SCALE)];
    [wfxwL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [wfxwL setText:msg.wfms];
    [wfxwL setSize:[wfxwL.text sizeWithFont:wfxwL.font constrainedToSize:CGSizeMake(wfxwL.width, 1000)]];
    wfxwL.numberOfLines = 0;
    [_contentBgView addSubview:wfxwL];
    
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, label.b + 20, size.width/PX_X_SCALE, size.height/PX_X_SCALE)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"违法内容：";
    [_contentBgView addSubview:label];
    UILabel *wfnrL = [[UILabel alloc] initWithFrame:YYRectMake(label.r + 15, label.t, APP_PX_WIDTH - label.r - 15 - 30, size.height/PX_X_SCALE)];
    [wfnrL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [wfnrL setText:msg.wfnr];
    [wfnrL setSize:[wfnrL.text sizeWithFont:wfnrL.font constrainedToSize:CGSizeMake(wfnrL.width, 1000)]];
    wfnrL.numberOfLines = 0;
    [_contentBgView addSubview:wfnrL];
    
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, wfnrL.b + 20, size.width/PX_X_SCALE, size.height/PX_X_SCALE)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"缴纳罚金：";
    [_contentBgView addSubview:label];
    UILabel *jnfjL = [[UILabel alloc] initWithFrame:YYRectMake(label.r + 15, label.t, APP_PX_WIDTH - label.r - 15 - 30, size.height/PX_X_SCALE)];
    [jnfjL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    [jnfjL setText:msg.fkje];
    [jnfjL setSize:[jnfjL.text sizeWithFont:jnfjL.font constrainedToSize:CGSizeMake(jnfjL.width, 1000)]];
    [_contentBgView addSubview:jnfjL];
    UILabel *l = [[UILabel alloc] initWithFrame:YYRectMake(jnfjL.r + 5, jnfjL.t, 100, jnfjL.h)];
    [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    l.text = @"元";
    [_contentBgView addSubview:l];
    
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, label.b + 20, size.width/PX_X_SCALE, size.height/PX_X_SCALE)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"滞纳金：";
    [_contentBgView addSubview:label];
    UILabel *znjL = [[UILabel alloc] initWithFrame:YYRectMake(label.r + 15, label.t, APP_PX_WIDTH - label.r - 15 - 30, size.height/PX_X_SCALE)];
    [znjL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    [znjL setText:msg.znj];
    [znjL setSize:[znjL.text sizeWithFont:znjL.font constrainedToSize:CGSizeMake(znjL.width, 1000)]];
    [_contentBgView addSubview:znjL];
    l = [[UILabel alloc] initWithFrame:YYRectMake(znjL.r + 5, znjL.t, 100, znjL.h)];
    [l convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    l.text = @"元";
    [_contentBgView addSubview:l];
    
    label = [[UILabel alloc] initWithFrame:YYRectMake(30, label.b + 20, size.width/PX_X_SCALE, size.height/PX_X_SCALE)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    label.text = @"缴款状态：";
    [_contentBgView addSubview:label];
    UILabel *jkztL = [[UILabel alloc] initWithFrame:YYRectMake(label.r + 15, label.t, APP_PX_WIDTH - label.r - 15 - 30, size.height/PX_X_SCALE)];
    [jkztL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    //jkbj  0未交款  1已缴款
    if ([msg.jkbj isEqualToString:@"0"]) {
        [jkztL setText:@"未缴款"];
    }else{
        [jkztL setText:@"已缴款"];
    }
    [_contentBgView addSubview:jkztL];
    
    
    
    if ([msg.jkbj isEqualToString:@"0"]) {
        [jkztL setText:@"未缴款"];
        
        UIButton *payButton = [UIButton mainButtonWithPXY:jkztL.b + 30 title:@"立即缴款" target:self action:@selector(payButtonClicked:)];
        [_contentBgView addSubview:payButton];
        
        [_contentBgView setSize:CGSizeMake(_contentBgView.width, payButton.bottom + 30)];
    }else{
        [_contentBgView setSize:CGSizeMake(_contentBgView.width, jkztL.bottom + 30)];
    }
    
    [_rootScrollView setContentSize:CGSizeMake(_rootScrollView.width, _contentBgView.bottom)];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadView_];
    
    self.peccancyArr = [[NSMutableArray alloc] initWithCapacity:0];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"决定书编号查询"];

}

- (void)startSearch:(id)sender{
    [_JDSBHTextField resignFirstResponder];
    if (_JDSBHTextField.text && ![_JDSBHTextField.text isEqualToString:@""]) {
        [self getRecordByJDSBH];
    }else{
        [self.view showAlertText:@"请填写正确的决定书编号"];
    }
}

- (void)payButtonClicked:(UIButton*)btn{
    PeccancyMsg *p = [self.peccancyArr objectAtIndex:btn.tag];
    
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

    PayViewController *payVC = [[PayViewController alloc] initWithFkje:p.fkje znj:p.znj hphm:p.hphm jdsbh:p.jdsbh username:APP_DELEGATE.userName fxjg:p.fxjg cljg:p.cljg cljgmc:p.cljgmc wsjyw:p.wsjyw];
    [self.navigationController pushViewController:payVC animated:YES];
}

#pragma mark- 网络请求
- (void)getRecordByJDSBH{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"listbyjdsbh" forKey:@"action"];
    [dict setObject:_JDSBHTextField.text forKey:@"jdsbh"];
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if (result == postSucc) {
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSArray *array = [resDict objectForKey:@"violation"];
            if (array) {
                //解析
                NSArray *peccancyArr = [Helper jdsbhSearchPeccancyMsgAnalysis:array];
                [self.peccancyArr removeAllObjects];
                [self.peccancyArr addObjectsFromArray:peccancyArr];
                [self reloadView];
                //[_tableView reloadData];
            }else{
                NSString *mess = [resDict objectForKey:@"message"];
                [UIAlertView alertTitle:@"提示信息" msg:mess];
            }
        }else{
            [UIAlertView alertTitle:@"查询失败" msg:(NSString*)requestObj];
        }
        
    } onError:^(NSString *errorStr) {
        [UIAlertView alertTitle:@"查询失败" msg:errorStr];
    }];
}


//#pragma mark- tableview delegate and datasource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [self.peccancyArr count];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 259;
//}
//
//- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cell_id = @"JDSBHPeccancyRecordCell";
//    JDSBHPeccancyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
//    if (cell == nil) {
//        cell = [[JDSBHPeccancyRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        [cell.payButton addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    cell.payButton.tag = indexPath.row;
//    cell.sNumL.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
//    PeccancyMsg *p = [self.peccancyArr objectAtIndex:indexPath.row];
//    //jkbj  0未交款  1已缴款
//    if ([p.jkbj isEqualToString:@"0"]) {
//        [cell.payButton setTitle:@"立即缴款" forState:UIControlStateNormal];
//        cell.payButton.userInteractionEnabled = YES;
//        cell.payButton.backgroundColor = [UIHelper getColor:@"#ff8d1b"];
//    }else{
//        [cell.payButton setTitle:@"已缴款" forState:UIControlStateNormal];
//        cell.payButton.userInteractionEnabled = NO;
//        cell.payButton.backgroundColor = [UIColor lightGrayColor];
//    }
//    cell.jdsbhL.text = p.jdsbh;
//    cell.jgTV.text = p.cljgmc;
//    cell.sjL.text = p.wfsj;
//    cell.ddTV.text = p.wfdz;
//    NSInteger zje = [p.znj integerValue] + [p.fkje integerValue];
//    cell.jeL.text = [NSString stringWithFormat:@"%d元", zje];
//    return cell;
//}

#pragma mark- textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
