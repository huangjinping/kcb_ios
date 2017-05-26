//
//  ChatAddFriendViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-12.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "ChatAddFriendViewController.h"

@interface ChatAddFriendViewController ()

@end

@implementation ChatAddFriendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma tableview delegate and datasource
#define ROW_HEIGHT 52
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_searchResultChatUsers count]) {
        return [_searchResultChatUsers count];
    }else{
        return [_recommendResultChatUsers count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ROW_HEIGHT;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"chatUserCell";
    ChatUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChatUserCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.actionButton addTarget:self action:@selector(addFriend:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    ChatUser *chatUser = nil;
    if ([_searchResultChatUsers count]) {
        chatUser = [_searchResultChatUsers objectAtIndex:indexPath.row];
    }else{
        chatUser = [_recommendResultChatUsers objectAtIndex:indexPath.row];
    }
    
    [cell.photoImgView setImageWithURL:[NSURL URLWithString:chatUser.photo] placeholderImage:[UIImage imageNamed:@"chat_portrait_photo.png"]];
    cell.nameLabel.text = chatUser.username;
    cell.actionButton.tag = indexPath.row;
        
    return cell;
}

#pragma mark- textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)loadView_{
    
    UIImageView *headBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_X + 10, APP_VIEW_Y + 15, APP_WIDTH - 20, 40)];
    headBgImgView.backgroundColor = [UIColor whiteColor];
    headBgImgView.userInteractionEnabled = YES;
    [self.view addSubview:headBgImgView];
    
    CGFloat searchButtonWidth = 40;
    CGFloat space = 10;
    CGFloat tfWidth = headBgImgView.width - space*2 - searchButtonWidth;
    _searchTF = [[UITextField alloc] initWithFrame:CGRectMake(space, 5, tfWidth, 30)];
    [_searchTF setDelegate:self];
    _searchTF.borderStyle = UITextBorderStyleNone;
    _searchTF.placeholder = @"用户名";
    [headBgImgView addSubview:_searchTF];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setFrame:CGRectMake(_searchTF.right + 5, 0, searchButtonWidth, searchButtonWidth)];
    [searchButton setImage:[UIImage imageNamed:@"btn_search_blue.png"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchChatUser) forControlEvents:UIControlEventTouchUpInside];
    [headBgImgView addSubview:searchButton];
    
    
    UIImageView *rootTabelViewBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_X + 10, headBgImgView.bottom + space, APP_WIDTH - 20, APP_HEIGHT - (headBgImgView.bottom) - space)];
    rootTabelViewBgImgView.userInteractionEnabled = YES;
    [rootTabelViewBgImgView setImage:[UIImage imageNamed:@"bg_white.png"]];
    [self.view addSubview:rootTabelViewBgImgView];
    
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, rootTabelViewBgImgView.width, rootTabelViewBgImgView.height) style:UITableViewStylePlain];
    [_rootTableView setDelegate:self];
    [_rootTableView setDataSource:self];
    _rootTableView.showsVerticalScrollIndicator = NO;
    _rootTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //_rootTableView.bounces = NO;
    if ([_rootTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_rootTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    //[_rootTableView setBackgroundColor:COLOR_VIEW_CONTROLLER_BG];
    [rootTabelViewBgImgView addSubview:_rootTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.tabBarController hiddenCustomTabBar:YES];
    
    [self loadView_];
    _searchResultChatUsers = [[NSMutableArray alloc] initWithCapacity:0];
    _recommendResultChatUsers = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self netReccommendFriend];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"添加好友"];
}


#pragma mark- button action
- (void)searchChatUser{
    [_searchTF resignFirstResponder];
    
    if (_searchTF.text && ![_searchTF.text isEqualToString:@""]) {
        [self netSearchChatUser:_searchTF.text];
    }else{
        [UIAlertView alertTitle:@"提示信息" msg:@"搜索用户名不能为空"];
    }
    
    
}

- (void)addFriend:(UIButton*)button{
    
    ChatUser *chatUser = nil;
    if([_searchResultChatUsers count]){//所搜有值
        chatUser = [_searchResultChatUsers objectAtIndex:button.tag];
    }else{
        if (button.tag + 1 <= [_recommendResultChatUsers count]) {
            chatUser = [_recommendResultChatUsers objectAtIndex:button.tag];
        }
    }
    
    [self netAddFriendByFuid:chatUser.fuid];
    
    
    
}

#pragma mark- 网络请求

- (void)netSearchChatUser:(NSString*)userName{
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDict setObject:userName forKey:@"username"];
    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"selectUser.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if (result == postSucc) {
            
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSArray *contents_ = [resDict objectForKey:@"contents"];
            
            [_searchResultChatUsers removeAllObjects];
            for (NSDictionary *dict in contents_) {
                
                NSString *photo = [dict analysisStrValueByKey:@"photo"];
                NSString *regtime = [dict analysisStrValueByKey:@"regtime"];
                NSString *username = [dict analysisStrValueByKey:@"username"];
                NSString *utype = [dict analysisStrValueByKey:@"utype"];
                NSString *fuid = [dict analysisStrValueByKey:@"id"];
                
                ChatUser *chatUser = [[ChatUser alloc] init];
                chatUser.photo = photo;
                chatUser.regtime = regtime;
                chatUser.username = username;
                chatUser.utype = utype;
                chatUser.fuid = fuid;
                
                [_searchResultChatUsers addObject:chatUser];
                
            }
            
            [_rootTableView reloadData];
            
        }else{
            
            [UIAlertView alertTitle:@"提示信息" msg:[@"搜索用户失败," stringByAppendingString:(NSString*)requestObj]];
        }
        
    } onError:^(NSString *errorStr) {
        
        [UIAlertView alertTitle:@"提示信息" msg:[@"搜索用户失败," stringByAppendingString:errorStr]];
    }];
}


- (void)netAddFriendByFuid:(NSString*)fuid{
    
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDict setObject:APP_DELEGATE.userName forKey:@"username"];
    [bodyDict setObject:fuid forKey:@"fuid"];
    
    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"addFriend.do" withPostMethod:@"POST"isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:fuid onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if (result == postSucc) {
            
            APP_DELEGATE.shouldRefreshFriendsList = YES;
            
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSString *contents_ = [resDict objectForKey:@"contents"];
            [UIAlertView alertTitle:@"提示信息" msg:contents_];
            
            //如果添加的是推荐好友，添加成功后，从推荐列表中删除该好友
            NSString *callBackFuid = (NSString*)callBackObj;
            for (ChatUser *user in _recommendResultChatUsers) {
                if ([(NSString*)user.fuid isEqualToString:callBackFuid]) {
                    [_recommendResultChatUsers removeObject:user];
                    [_rootTableView reloadData];
                    break;
                }
            }
            
        }else{
            
            [UIAlertView alertTitle:@"提示信息" msg:[@"添加好友失败," stringByAppendingString:(NSString*)requestObj]];
            
        }
        
    } onError:^(NSString *errorStr) {
        
        [UIAlertView alertTitle:@"提示信息" msg:[@"添加好友失败," stringByAppendingString:errorStr]];
    }];
    
    
}


- (void)netReccommendFriend{
    
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDict setObject:APP_DELEGATE.userName forKey:@"username"];

    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"recommendFriend.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if (result == postSucc) {
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSArray *contents = [resDict analysisArrValueByKey:@"contents"];
            
            if (contents == nil) {//为字符串，无推荐用户
                return ;
            }
            [_recommendResultChatUsers removeAllObjects];
            for (NSDictionary *dict in contents) {
                NSString *_id = [dict analysisStrValueByKey:@"id"];
                NSString *utype = [dict analysisStrValueByKey:@"utype"];
                NSString *username = [dict analysisStrValueByKey:@"username"];
                NSString *photo = [dict analysisStrValueByKey:@"photo"];
                NSString *regtime = [dict analysisStrValueByKey:@"regtime"];
                
                ChatUser *chatUser = [[ChatUser alloc] init];
                chatUser.fuid = _id;
                chatUser.utype = utype;
                chatUser.username = username;
                chatUser.photo = photo;
                chatUser.regtime = regtime;
                [_recommendResultChatUsers addObject:chatUser];
            }
            
            
            [_rootTableView reloadData];
        }
       
        
    } onError:^(NSString *errorStr) {
        
        
        
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
