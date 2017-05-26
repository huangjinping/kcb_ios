//
//  InformationCenterListViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-13.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "InformationCenterListViewController.h"

@interface InformationCenterListViewController ()<
EGORefreshTableHeaderDelegate,
UITableViewDataSource,
UITableViewDelegate
>
{
    EGORefreshTableHeaderView       *_refreshHeader;
    BOOL                            _isloading;
    
    UITableView                     *_rootTableView;
    
    NSArray                         *_notiDatasourceArr;
    //NSMutableArray                  *_infoDatasourceArr;
}
@end

@implementation InformationCenterListViewController

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
    [self getNotifycations];
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


- (void)loadDataFromDB{
    NSArray *arr = [[DataBase sharedDataBase] selectAllMsgByUser:APP_DELEGATE.userName];
    _notiDatasourceArr = [[NSArray alloc] initWithArray:arr];
}

- (void)didReceiveNewMessage:(NSNotification*)notify{
    NSString *mark = [notify.userInfo objectForKey:@"responseMark"];
    if ([mark isEqualToString:NOTIFICATION_FETCH_MESSAGES_FINISHED]) {//succ
        [self loadDataFromDB];
    }else{
        [self.view showAlertText:mark];
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _notiDatasourceArr = [[NSArray alloc] init];

    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    _rootTableView.dataSource = self;
    _rootTableView.delegate  = self;
    if ([_rootTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_rootTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    [self.view addSubview:_rootTableView];
    
    _isloading = NO;
    _refreshHeader = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, - _rootTableView.height, _rootTableView.width, _rootTableView.height)];
    _refreshHeader.delegate = self;
    [_rootTableView addSubview:_refreshHeader];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNewMessage:) name:NOTIFICATION_FETCH_MESSAGES_FINISHED object:nil];
    [self loadDataFromDB];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"开车邦"];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateMsgStatus];
}
- (void)updateMsgStatus{
    NSArray *arr = [[DataBase sharedDataBase] selectMsgByUser:APP_DELEGATE.userName status:MSG_STATUS_READ_NO];
    for (Msg *msg in arr) {
        msg.msg_read_status = MSG_STATUS_READ_ALREADY;
        [msg updateToDB];
    }
}

#define SPACE                   10
#define TIME_LINE_HEIGHT        20
#define INFORMATIOIN_CENTER_LIST_FONT       [UIFont systemFontOfSize:15]

- (CGFloat)heightForContentString:(NSString*)str{
    CGSize size = [str sizeWithFont:INFORMATIOIN_CENTER_LIST_FONT constrainedToSize:CGSizeMake((APP_WIDTH - SPACE - 45 - 10 - SPACE*2),2000) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height;
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_notiDatasourceArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Msg *msg = [_notiDatasourceArr objectAtIndex:indexPath.row];
    CGFloat height = ([self heightForContentString:msg.msg_content] + SPACE*4 + TIME_LINE_HEIGHT);
    if (height < 120) {
        return 120;
    }else{
        return height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *notiCellId = @"noti_cell";
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_rootTableView setBackgroundColor:COLOR_VIEW_CONTROLLER_BG];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:notiCellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:notiCellId];
        cell.contentView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat space = 10;
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(space, space, APP_WIDTH - space*2, 0)];
        [bgImgView setImage:[UIImage imageNamed:@"bg_white.png"]];
        [bgImgView setUserInteractionEnabled:YES];
        [cell.contentView addSubview:bgImgView];
        
        UILabel *numL = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 100)];
        numL.backgroundColor = [UIColor clearColor];
        numL.font = [UIFont systemFontOfSize:101];
        numL.textColor = COLOR_CELL_NUM_LEBEL_TEXT;
        numL.textAlignment = NSTextAlignmentLeft;
        [bgImgView addSubview:numL];
        
        UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(space, space, 45, 20)];
        l.backgroundColor = [UIColor clearColor];
        l.text = @"内容:";
        l.font = INFORMATIOIN_CENTER_LIST_FONT;
        l.textAlignment = NSTextAlignmentLeft;
        [bgImgView addSubview:l];
        
        UILabel *contentL = [[UILabel alloc] initWithFrame:CGRectMake(l.right, l.top, bgImgView.width - l.right - space, 0)];
        contentL.font = INFORMATIOIN_CENTER_LIST_FONT;
        contentL.backgroundColor = [UIColor clearColor];
        contentL.numberOfLines = 0;
        [bgImgView addSubview:contentL];
        
        l = [[UILabel alloc]initWithFrame:CGRectMake(space, 0, 45, 20)];
        l.backgroundColor = [UIColor clearColor];
        l.text = @"时间:";
        l.font = INFORMATIOIN_CENTER_LIST_FONT;
        l.textAlignment = NSTextAlignmentLeft;
        [bgImgView addSubview:l];
        
        UILabel *timeL = [[UILabel alloc] initWithFrame:CGRectMake(l.right, l.top, bgImgView.width - l.right - space, l.height)];
        timeL.font = INFORMATIOIN_CENTER_LIST_FONT;
        timeL.backgroundColor = [UIColor clearColor];
        [bgImgView addSubview:timeL];
        
        
    }
    UIImageView *bgV = [cell.contentView.subviews lastObject];
    UILabel *numL = [bgV.subviews objectAtIndex:0];
    numL.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    
    Msg *msg = [_notiDatasourceArr objectAtIndex:indexPath.row];
    UILabel *contentL = [bgV.subviews objectAtIndex:2];
    contentL.text = msg.msg_content;
    UILabel *timeL = [bgV.subviews lastObject];
    timeL.text = msg.msg_time;
    
    CGFloat bgVHeight = ([self heightForContentString:msg.msg_content] + SPACE*2 + TIME_LINE_HEIGHT);
    if (bgVHeight < 100) {
        bgVHeight = 100;
    }
    [bgV setFrame:CGRectMake(bgV.left, bgV.top, bgV.width, bgVHeight)];
    
    [contentL setFrame:CGRectMake(contentL.left, contentL.top, contentL.width, [self heightForContentString:contentL.text])];
    UILabel *timeLabelLable = [bgV.subviews objectAtIndex:3];
    [timeLabelLable setFrame:CGRectMake(timeLabelLable.left, contentL.bottom, timeLabelLable.width, timeLabelLable.height)];
    [timeL setFrame:CGRectMake(timeLabelLable.right, timeLabelLable.top, timeL.width, timeL.height)];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark-  网络请求
- (void)getNotifycations{
    
    /*
     {
     "listmessage":[
     {
     "message":"1，APP重构，流畅性更高，易用；
     2，开通违法处理功能；
     3，开通违法缴款功能；
     4，增加车友互动；
     5，增加车险易购。",
     "sendtime":"2014-08-08 18:00:00"
     }
     ]
     }
     
     */
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setObject:@"getmessage" forKey:@"action"];
    [dict setObject:APP_DELEGATE.userName forKey:@"username"];
    NSArray *messages = [[DataBase sharedDataBase] selectAllMsgByUser:APP_DELEGATE.userName];
    if ([messages count]) {
        Msg *msg = [messages objectAtIndex:0];
        [dict setObject:msg.msg_time forKey:@"updatetime"];
    }
    _isloading = YES;
    [[Network sharedNetwork] postBody:dict isResponseJson:YES doShowIndicator:YES callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSArray *resArr = [resDict objectForKey:@"listmessage"];
            for (NSDictionary *dict in resArr) {
                Msg *msg = [[Msg alloc] initWithMsg_ID:@"" msg_time:[dict analysisStrValueByKey:@"sendtime"] msg_title:@"" msg_content:[dict analysisStrValueByKey:@"message"] msg_read_status:MSG_STATUS_READ_NO msg_classify:@"" andMsg_user:APP_DELEGATE.userName];
                [msg addToDB];
            }
            
            [self loadDataFromDB];
        }else{
            [self.view showAlertText:@"服务器返回异常"];
        }
        _isloading = NO;
        [_refreshHeader egoRefreshScrollViewDataSourceDidFinishedLoading:_rootTableView];
    } onError:^(NSString *errorStr) {
        
        [self.view showAlertText:errorStr];
        _isloading = NO;
        [_refreshHeader egoRefreshScrollViewDataSourceDidFinishedLoading:_rootTableView];
        
    }];
    
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
