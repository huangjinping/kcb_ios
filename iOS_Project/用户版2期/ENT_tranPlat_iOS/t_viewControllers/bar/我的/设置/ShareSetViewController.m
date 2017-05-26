//
//  ShareSetViewController.m
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-10-20.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "ShareSetViewController.h"

@interface ShareSetViewController ()

@end

@implementation ShareSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareCallback:) name:NOTIFICATION_WX_CALL_BACK object:nil];
    
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, APP_VIEW_Y+10, APP_WIDTH-20, 210)];
    bgImageView.image = [UIImage imageNamed:@"bg_white.png"];
    [self.view addSubview:bgImageView];
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, APP_VIEW_Y+10, APP_WIDTH-20, 210)];
    _textView.text = @"我正在使用<开车邦>，随时随地进行违法处理和缴款，更多功能，详情见官网http://www.956122.com。";
    _textView.textColor = [UIColor lightGrayColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.font = [UIFont systemFontOfSize:17];
    _textView.editable = NO;
    _textView.delegate = self;
    [self.view addSubview:_textView];
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(10, _textView.frame.origin.y+_textView.frame.size.height+10, APP_WIDTH-20, 47);
    [sendBtn setTitle:@"分享" forState:UIControlStateNormal];
    sendBtn.titleLabel.textColor = [UIColor whiteColor];
    sendBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    sendBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [sendBtn setBackgroundColor:COLOR_BUTTON_BLUE];
    [sendBtn addTarget:self action:@selector(sendBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    CGFloat heightY = CGRectGetMaxY(sendBtn.frame);
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, heightY+10+17, 90, 21)];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.text = @"分享到：";
    lable.textColor = COLOR_FONT_NOMAL;
    lable.backgroundColor = [UIColor clearColor];
    lable.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:lable];
    
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"share_wechat_logo.png"]];
    
    imgView.frame = CGRectMake(100, heightY+10, 55, 55);
    [self.view addSubview:imgView];

    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_textView addGestureRecognizer:tap];
    
    _tableDatasource = [NSMutableArray arrayWithObjects:@"分享到微信好友",@"分享到微信朋友圈", nil];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(APP_X, APP_HEIGHT + APP_VIEW_Y, APP_WIDTH, TABLE_ROW_HEIGHT*_tableDatasource.count) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.userInteractionEnabled = YES;
    [self.view addSubview:_tableView];
    
    _textView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_white.png"]];
    
    
}

- (void)tap{
    [UIView animateWithDuration:.35 animations:^{
        [_tableView setFrame:CGRectMake(APP_X, APP_HEIGHT + APP_Y, _tableView.frame.size.width, _tableView.frame.size.height)];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"分享给好友"];
    
}

- (void)sendBtnClicked:(UIButton *)btn {
    
    //判断是否安装微信客户端
    if (![WXApi isWXAppInstalled]) {
        [UIAlertView alertTitle:@"提示信息" msg:@"当前设备没有安装微信客户端"];
        return;
    }
    if (![WXApi isWXAppSupportApi]) {
        [UIAlertView alertTitle:@"提示信息" msg:@"当前设备当前安装微信App版本不支持分享功能"];
        return;
    }
    [UIView animateWithDuration:.35 animations:^{
        _tableView.frame = CGRectMake(APP_X, self.view.height - TABLE_ROW_HEIGHT*_tableDatasource.count, APP_WIDTH, TABLE_ROW_HEIGHT*_tableDatasource.count);
    }];
    
}

- (void)shareCallback:(NSNotification*)notify{
    
    [_tableView setFrame:CGRectMake(APP_X, APP_HEIGHT + APP_Y, _tableView.frame.size.width, _tableView.frame.size.height)];
    
    int errCode = [[notify.userInfo objectForKey:@"errCode"] integerValue];
    if (errCode == 0) {
        [UIAlertView alertTitle:@"提示信息" msg:@"分享成功!"];
    }
}





#pragma mark TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableDatasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;

        CGFloat imgvHeight = 50;
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, (TABLE_ROW_HEIGHT - imgvHeight)/2, imgvHeight, imgvHeight)];
        [cell.contentView addSubview:imageV];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageV.right + 10, 0, 200, TABLE_ROW_HEIGHT)];
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = COLOR_BUTTON_BLUE;
        label.text = _tableDatasource[indexPath.row];
        [cell.contentView addSubview:label];
        
        
    }
    
    UIImageView *imgv = [cell.contentView.subviews objectAtIndex:0];
    switch (indexPath.row) {
        case 0:
            [imgv setImage:[UIImage imageNamed:@"logo_wechat_chat.png"]];
            break;
            
        default:
            [imgv setImage:[UIImage imageNamed:@"logo_wechat_friends.png"]];
            
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.text = _textView.text;
    req.bText = YES;
    
    if (index == 0) {//分享到好友
        req.scene = WXSceneSession;
        
    } else if (index == 1){//分享到朋友圈
        req.scene = WXSceneTimeline;
        
    }
    
    [WXApi sendReq:req];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TABLE_ROW_HEIGHT;
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
