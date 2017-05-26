//
//  ChatFriendsListViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/8/20.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "ChatFriendsListViewController.h"


@interface ChatFriendsListViewController ()<
UIAlertViewDelegate,
D_CellCellTableViewDataSource,
D_CellCellTableViewDelegate
>


{
    D_CellCellTableView                 *_friendsCellTableView;
    UIImageView                         *_userPortraitImgView;
    NSMutableArray                      *_friends;
    
    

}

@end
@implementation ChatFriendsListViewController


#pragma mark- 好友列表 Delegate and DataSource

#define ROW_HEIGHT  100//(APP_HEIGHT - APP_NAV_HEIGHT - APP_TAB_HEIGHT - APP_NAV_HEIGHT)/3
#define CELLS_COUNT_PER_ROW 3
- (NSInteger)D_CellCellTableView:(D_CellCellTableView *)cellcellTableView numberOfCellsInRow:(NSInteger)rowIndex{
    
    NSInteger sumCount = [_friends count] + 1;
    
    if (sumCount >= (rowIndex + 1)*3) {
        return 3;
    }else{
        return sumCount - (rowIndex * 3);
    }
}

- (NSInteger)numberOfRows{
    
    NSInteger sumCount = [_friends count] + 1;
    
    NSInteger rows = sumCount/CELLS_COUNT_PER_ROW;
    if (sumCount%CELLS_COUNT_PER_ROW) {
        rows ++;
    }
    
    return rows;
}

- (CGFloat)D_CellCellTableView:(D_CellCellTableView *)cellcellTableView heightForRow:(NSInteger)rowIndex{
    return ROW_HEIGHT;
}

- (D_CellCell*)D_CellCellTableView:(D_CellCellTableView *)cellcellTableView cellForRow:(NSInteger)rowIndex indexForCell:(NSInteger)cellIndex{
    static NSString *cellId = @"friendsCell";
    
    D_CellCell *cell = [cellcellTableView dequeueReusableD_CellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[D_CellCell alloc] initWithIdentifier:cellId];
        
        
        
    }
    
    NSInteger index = rowIndex*CELLS_COUNT_PER_ROW + cellIndex;
    if (index == 0) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, ROW_HEIGHT - 20*2, ROW_HEIGHT - 20*2)];
        [imgV setImage:[UIImage imageNamed:@"chat_add_friend.png"]];
        [imgV setUserInteractionEnabled:YES];
        [cell.contentView addSubview:imgV];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imgV.left, imgV.bottom + 8, imgV.width, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"添加好友";
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = UITextAlignmentCenter;
        [cell.contentView addSubview:label];
        
        
    }else{
        ChatUser *chatUser = [_friends objectAtIndex:index-1];
        
        [cell.imgView setImageWithURL:[NSURL URLWithString:chatUser.photo] placeholderImage:[UIImage imageNamed:@"chat_portrait_photo.png"]];
        [cell.titleLabel setText:chatUser.username];
        
        cell.friendId = chatUser.feiendid;
        
        //        CGSize size = [@"试内容测试内容测试内容测试试内容测试内容测试内容测试测试测试内容测试内容测试内容测试内容测试内容内容" sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:CGSizeMake(cell.subTitleLabel.width, ROW_HEIGHT - cell.titleLabel.bottom) lineBreakMode:NSLineBreakByCharWrapping];
        //        [cell.subTitleLabel setText:@"试内容测试内容测试内容测试试内容测试内容测试内容测试测试测试内容测试内容测试内容测试内容测试内容内容"];
        //        [cell.subTitleLabel setFrame:CGRectMake(cell.subTitleLabel.frame.origin.x, cell.subTitleLabel.frame.origin.y, size.width, size.height)];
    }
    
    
    return cell;
}

- (void)D_CellCellTableView:(D_CellCellTableView *)cellcellTableView didTapedCell:(D_CellCell *)cell{
    
    if ([cell.contentView.subviews count]) {
        [self addFriend];
        return;
    }
    ChatBlogsViewController *chatBlogsVC = [[ChatBlogsViewController alloc] init];
    chatBlogsVC.friendName = cell.titleLabel.text;
    [self.navigationController pushViewController:chatBlogsVC animated:YES];
}

- (void)D_CellCellTableView:(D_CellCellTableView *)cellcellTableView removeFriend:(NSString *)friendName onCell:(D_CellCell *)cell{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:[NSString stringWithFormat:@"确认删除好友：%@?",friendName] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag = [cell.friendId integerValue];
    [alert show];
}



- (void)viewDidLoad{
    [super viewDidLoad];
    _friends = [[NSMutableArray alloc] initWithCapacity:0];

    
    //好友列表
    UIImageView *userInfoBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, APP_VIEW_Y + 5, self.view.width - 20, 55)];
    userInfoBgImgView.userInteractionEnabled = YES;
    [userInfoBgImgView setImage:[UIImage imageNamed:@"bg_white.png"]];
    [self.view addSubview:userInfoBgImgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoUserBlogs)];
    [userInfoBgImgView addGestureRecognizer:tap];
    _userPortraitImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (userInfoBgImgView.height - 40)/2, 40, 40)];
    [userInfoBgImgView addSubview:_userPortraitImgView];
    
    UILabel *userNameL = [[UILabel alloc] initWithFrame:CGRectMake(_userPortraitImgView.right + 10, (userInfoBgImgView.height - 20)/2, 100, 20)];
    userNameL.text = APP_DELEGATE.userName;
    [userInfoBgImgView addSubview:userNameL];
    
    UIButton *userDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [userDetailButton setImage:[UIImage imageNamed:@"arrow_right.png"] forState:UIControlStateNormal];
    [userDetailButton setFrame:CGRectMake(userInfoBgImgView.width - 40, (userInfoBgImgView.height - 16)/2, 18, 16)];
    [userDetailButton addTarget:self action:@selector(gotoUserBlogs) forControlEvents:UIControlEventTouchUpInside];
    [userInfoBgImgView addSubview:userDetailButton];
    
    UIImageView *friendsCellTableViewBgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, userInfoBgImgView.bottom + 5, self.view.width - 20, APP_HEIGHT - APP_NAV_HEIGHT - userInfoBgImgView.height - 5*3)];
    friendsCellTableViewBgView.userInteractionEnabled = YES;
    [friendsCellTableViewBgView setImage:[UIImage imageNamed:@"bg_white.png"]];
    [self.view addSubview:friendsCellTableViewBgView];
    UITapGestureRecognizer *ftap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(friendViewBlankBeTaped)];
    [friendsCellTableViewBgView addGestureRecognizer:ftap];
    
    _friendsCellTableView = [[D_CellCellTableView alloc] initWithFrame:CGRectMake(0, 0, friendsCellTableViewBgView.width, friendsCellTableViewBgView.height)];
    _friendsCellTableView.dataSource_ = self;
    _friendsCellTableView.delegate_ = self;
    [friendsCellTableViewBgView addSubview:_friendsCellTableView];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setCustomNavigationTitle:@"好友列表"];

    UserInfo *user = [[[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName] lastObject];
    [_userPortraitImgView setImageWithURL:[NSURL URLWithString:[user photoServerPath]] placeholderImage:[UIImage imageNamed:@"chat_portrait_photo.png"]];
    [self netGetFriends];
}

#pragma mark-   ACITONS

- (void)gotoUserBlogs{
    ChatBlogsViewController *chatBlogsVC = [[ChatBlogsViewController alloc] init];
    chatBlogsVC.friendName = APP_DELEGATE.userName;
    [self.navigationController pushViewController:chatBlogsVC animated:YES];
}

- (void)friendViewBlankBeTaped{
    [_friendsCellTableView reloadData_];
}

- (void)addFriend{
    ChatAddFriendViewController *chatAddFriendVC = [[ChatAddFriendViewController alloc] init];
    [self.navigationController pushViewController:chatAddFriendVC animated:YES];
}

#pragma mark- ALERT DELEGATE
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //删除好友
    if (buttonIndex != alertView.cancelButtonIndex) {
        [self netRemoveFriend:[NSString stringWithFormat:@"%d", (int)alertView.tag]];
    }
}

#pragma mark- 网络请求
//获取好友列表
- (void)netGetFriends{
    
    [[ChatNetwork sharedChatNetwork] chatPostBody:[NSMutableDictionary dictionaryWithObject:APP_DELEGATE.userName forKey:@"username"] onUrl:@"findFriends.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            
            APP_DELEGATE.shouldRefreshFriendsList = NO;
            
            NSDictionary *resDict = (NSDictionary*)requestObj;
            
            NSArray *contents_ = [resDict objectForKey:@"contents"];
            [_friends removeAllObjects];
            for (NSDictionary *dict in contents_) {
                
                NSString *blogcount = [dict analysisStrValueByKey:@"blogcount"];
                NSString *blogsum = [dict analysisStrValueByKey:@"blogsum"];
                NSString *feiendid = [dict analysisStrValueByKey:@"feiendid"];
                NSString *fuid = [dict analysisStrValueByKey:@"fuid"];
                NSString *photo = [dict analysisStrValueByKey:@"photo"];
                NSString *posttime = [dict analysisStrValueByKey:@"posttime"];
                NSString *regtime = [dict analysisStrValueByKey:@"regtime"];
                NSString *username = [dict analysisStrValueByKey:@"username"];
                NSString *utype = [dict analysisStrValueByKey:@"utype"];
                
                ChatUser *chatUser = [[ChatUser alloc] init];
                chatUser.blogcount = blogcount;
                chatUser.blogsum = blogsum;
                chatUser.feiendid = feiendid;
                chatUser.fuid = fuid;
                chatUser.photo = photo;
                chatUser.posttime = posttime;
                chatUser.regtime = regtime;
                chatUser.username = username;
                chatUser.utype = utype;
                
                [_friends addObject:chatUser];
                
                
            }
            
            
        }else{
            
            [_friends removeAllObjects];
            //            [self.view showAlertText:[@"获取好友列表," stringByAppendingString:(NSString*)requestObj]];
            
        }
        
        [_friendsCellTableView reloadData_];
        
    } onError:^(NSString *errorStr) {
        
        [self.view showAlertText:[@"获取好友列表失败!" stringByAppendingString:errorStr]];
    }];
}


//移除好友
- (void)netRemoveFriend:(NSString*)friendId{
    NSMutableDictionary *bodyDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:friendId, @"friendsid", nil];
    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"deleteFriend.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if (result == postSucc) {
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSString *contents = [resDict objectForKey:@"contents"];
            [self.view showAlertText:contents];
            
            [self netGetFriends];
            
        }else{
            [self.view showAlertText:[NSString stringWithFormat:@"删除好友失败!%@", requestObj]];
        }
        
        [_friendsCellTableView reloadData_];
    } onError:^(NSString *errorStr) {
        
        [self.view showAlertText:[NSString stringWithFormat:@"删除好友失败!%@", errorStr]];
        
        [_friendsCellTableView reloadData_];
    }];
}

@end
