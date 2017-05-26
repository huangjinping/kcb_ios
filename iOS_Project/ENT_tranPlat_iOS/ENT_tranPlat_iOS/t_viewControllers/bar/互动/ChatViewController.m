//
//  CYQViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-10.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "ChatViewController.h"
#import "communityItem.h"
#import "ChatImageView.h"
#import "ChatNetwork.h"

@implementation ChatViewController


//#pragma mark- EMOJI KEYBOARD DELEGATE
//- (void)faceToolBar:(FaceToolBar *)bar textViewBecomeFirstResponder:(UIExpandingTextView *)textView{
//    [_rootScrollView setScrollEnabled:NO];
//}
//- (void)faceToolBar:(FaceToolBar *)bar sendTextAction:(NSString *)inputText{
//    [_rootScrollView setScrollEnabled:YES];
//    
//    [bar dismissKeyBoard];
//}


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


#pragma mark- 消息列表 Delegate and DataSource

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [_movieLists count];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return CELL_HEIGHT_CHAT;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    static NSString *cellName = @"movieListCell";
//    UITableViewCell *movieCell = [tableView dequeueReusableCellWithIdentifier:cellName];
//    if (movieCell == nil) {
//        movieCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
//        
//    }
//    MovieInfo *userMovie = [_movieLists objectAtIndex:indexPath.row];
//    movieCell.imageView.image = [UIImage imageNamed:userMovie.movieImageURL];
//    movieCell.textLabel.text = userMovie.movieTitle;
//    movieCell.detailTextLabel.numberOfLines = 0;
//    movieCell.detailTextLabel.text = userMovie.movieDescribe;
//    movieCell.selectionStyle = UITableViewCellSelectionStyleNone;
//    movieCell.imageView.backgroundColor = [UIColor cyanColor];
//    return movieCell;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MoviePlayerViewController *mpVC = [[MoviePlayerViewController alloc] init];
//    MovieInfo *userMovie = [_movieLists objectAtIndex:indexPath.row];
//    mpVC.movieDescribe = userMovie.movieDescribe;
//    mpVC.movieTitle = userMovie.movieTitle;
//    mpVC.movieURL = userMovie.movieURL;
//    [self.navigationController pushViewController:mpVC animated:YES];
//
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //顶部蓝色button底线的动态切换
    NSInteger index = scrollView.contentOffset.x/APP_WIDTH;
    if (index < 0 || index > 2) {
        return;
    }
    [_segButtonView setSelectedIndex:index];
    
    //刷新界面
    if (scrollView.contentOffset.x == 0) {//blog
        
    }else if (scrollView.contentOffset.x == APP_WIDTH){//friends
        
        if (APP_DELEGATE.shouldRefreshFriendsList) {
            [self netGetFriends];
        }
    }else if (scrollView.contentOffset.x == 2*APP_WIDTH){//qunzu
    }
}

#pragma mark- alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //删除好友
        if (buttonIndex == alertView.cancelButtonIndex) {
            
        }else{
            [self netRemoveFriend:[NSString stringWithFormat:@"%d", alertView.tag]];
        }
}

#pragma mark- seg button ac
- (void)segmentButtonView:(SegmentButtonView *)segmentButtonView showView:(NSInteger)index{
    
    [_rootScrollView scrollRectToVisible:CGRectMake(APP_WIDTH * index, 0, _rootScrollView.width, _rootScrollView.height) animated:NO];
    
    if (index == 1){//好友列表
        if (APP_DELEGATE.shouldRefreshFriendsList){
            [self netGetFriends];
        }
    }
    
//    if (_rootScrollView.contentOffset.x == 0) {
//        _communityScrollView.hidden = NO;
//    }
    
    
}

#pragma mark- text view delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
}

- (void)textViewDidChange:(UITextView *)textView{

}

- (void)textViewDidEndEditing:(UITextView *)textView{
//    [_pinglunTextView resignFirstResponder];
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if ([text isEqualToString:@"\n"]) {
//        [_pinglunTextView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}

#pragma mark- keyboard notification
- (void)keyboardDidChangeFrame:(NSNotification*)notify{
    CGRect rect = [[notify.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [_pinglunBgImgView setFrame:CGRectMake(_pinglunBgImgView.frame.origin.x, (APP_VIEW_Y + APP_HEIGHT) - (_pinglunBgImgView.height + rect.size.height), _pinglunBgImgView.width, _pinglunBgImgView.height)];
}

#pragma mark-
#pragma mark-   system



- (void)loadView_{
    
    _testActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _testActivityIndicator.center = CGPointMake(100.0f, 100.0f);//只能设置中心，不能设置大小
    [self.view addSubview:_testActivityIndicator];
//    _testActivityIndicator.color = [UIColor redColor]; // 改变圈圈的颜色为红色； iOS5引入
    [_testActivityIndicator startAnimating]; // 开始旋转
    CGRect contentFrame = CGRectMake(APP_X, APP_VIEW_Y+34, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT- APP_TAB_HEIGHT-34);
    _rootScrollView = [[UIScrollView alloc] initWithFrame:contentFrame];
    [_rootScrollView setPagingEnabled:YES];
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    [_rootScrollView setContentSize:CGSizeMake(APP_WIDTH * 3, 1)];
    [_rootScrollView setDelegate:self];
    _rootScrollView.bounces = NO;
    [self.view addSubview:_rootScrollView];
    
////博文分类横向展示
//    _communityNewScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, APP_WIDTH, 55)];
//    _communityNewScrollView.delegate = self;
//    _communityNewScrollView.showsHorizontalScrollIndicator = YES ;
//    _communityNewScrollView.showsVerticalScrollIndicator = NO ;
//    _communityNewScrollView.bounces = NO;
//    _communityNewScrollView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
////    [_rootScrollView addSubview:_communityNewScrollView];
//    UILabel *newLable = [[UILabel alloc]initWithFrame:CGRectMake((APP_WIDTH-200)/2, _communityNewScrollView.bottom + 5, 200, 15 - 5)];
//    newLable.text = @"- - - - - -最 新 内 容- - - - - -";
//    newLable.textAlignment = NSTextAlignmentCenter;
//    newLable.font = [UIFont systemFontOfSize:11];
//    newLable.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:75/255.0 alpha:1];
//    newLable.backgroundColor = [UIColor clearColor];
////    [_rootScrollView addSubview:newLable];
    
    
    //博文分类展示
    _chatBriefBlogVC = [[ChatBriefBlogViewController alloc] init];
    [_chatBriefBlogVC.view setFrame:CGRectMake(0, 0, APP_WIDTH, _rootScrollView.height)];
    [_rootScrollView addSubview:_chatBriefBlogVC.view];
    //[self addChildViewController:_chatBriefBlogVC];
    
    //好友列表
    UIImageView *userInfoBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH + 10, 5, _rootScrollView.width - 20, 55)];
    userInfoBgImgView.userInteractionEnabled = YES;
    [userInfoBgImgView setImage:[UIImage imageNamed:@"bg_white.png"]];
    [_rootScrollView addSubview:userInfoBgImgView];
    
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
    
    UIImageView *friendsCellTableViewBgView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH + 10, userInfoBgImgView.bottom + 5, _rootScrollView.width - 20, _rootScrollView.height - userInfoBgImgView.height - 5*2)];
    friendsCellTableViewBgView.userInteractionEnabled = YES;
    [friendsCellTableViewBgView setImage:[UIImage imageNamed:@"bg_white.png"]];
    [_rootScrollView addSubview:friendsCellTableViewBgView];
    UITapGestureRecognizer *ftap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(friendViewBlankBeTaped)];
    [friendsCellTableViewBgView addGestureRecognizer:ftap];
    
    _friendsCellTableView = [[D_CellCellTableView alloc] initWithFrame:CGRectMake(0, 0, friendsCellTableViewBgView.width, friendsCellTableViewBgView.height)];
    _friendsCellTableView.dataSource_ = self;
    _friendsCellTableView.delegate_ = self;
    [friendsCellTableViewBgView addSubview:_friendsCellTableView];
    
    //群组
    CGRect frame = CGRectMake(APP_WIDTH * 2, 0, APP_WIDTH, _rootScrollView.height);
    _movieLVC = [[MovieListViewController alloc] init];
    [_movieLVC.view setFrame:frame];
    [_rootScrollView addSubview:_movieLVC.view];
    
}


- (void)viewDidLoad{
    [super viewDidLoad];

    _friends = [[NSMutableArray alloc] initWithCapacity:0];
    _blogs = [[NSMutableArray alloc] initWithCapacity:0];
    _comments = [[NSMutableArray alloc] initWithCapacity:0];
    _netGetClassifyViewSucc = NO;
    _segButtonIndex = 0;
    
    [self loadView_];
    if([self.tabBarController respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]){
        self.tabBarController.automaticallyAdjustsScrollViewInsets = NO;
    }
}
#if 1
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (_backFromAddBlog) {
        _chatBriefBlogVC.backFromAddBlog = YES;
    }

    [_chatBriefBlogVC viewWillAppear:YES];
    
    UserInfo *user = [[[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName] lastObject];
    [_userPortraitImgView setImageWithURL:[NSURL URLWithString:[user photoServerPath]] placeholderImage:[UIImage imageNamed:@"chat_portrait_photo.png"]];
    
    //tabbar view
    [self setCustomNavigationTitle:@"车友互动"];
    
    [self setBackButtonHidden:YES];
    if (!_segButtonView) {
        _segButtonView = [[SegmentButtonView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, 34) backgroundColor:[UIColor whiteColor] andLineColor:COLOR_NAV];
        //[_segButtonView setBackgroundColor:COLOR_NAV];//[UIColor blackColor]];
        NSArray *titles = [NSArray arrayWithObjects:@"论坛", @"关注", @"视频", nil];
        [_segButtonView setTitles:titles withTitleNorColor:COLOR_NAV andTitleSelColor:COLOR_NAV];
        [_segButtonView setDelegate:self];
        [self.view addSubview:_segButtonView];
        
        _segButtonView.selectedIndex = _segButtonIndex;
    }
    //发布博文按钮
    UIButton *writeBlogButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [writeBlogButton setFrame:CGRectMake(APP_WIDTH - 50, (_navigationImgView.height - 30)/2, 30, 30)];
    [writeBlogButton setImage:[UIImage imageNamed:@"chat_write_blog_logo"] forState:UIControlStateNormal];
    [writeBlogButton addTarget:self action:@selector(writeBlog:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationImgView addSubview:writeBlogButton];
    
    UIButton *sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sortButton setFrame:CGRectMake(20, (_navigationImgView.height - 30)/2-5, 30, 30)];
    [sortButton setTitle:@"..." forState:UIControlStateNormal];
    [sortButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sortButton.selected = NO;
    sortButton.titleLabel.font = [UIFont systemFontOfSize:30];
    [sortButton addTarget:self action:@selector(sortClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationImgView addSubview:sortButton];


    //判断刷新好友列表
    if(_rootScrollView.contentOffset.x == APP_WIDTH){
        
        if (APP_DELEGATE.shouldRefreshFriendsList) {
            [self netGetFriends];
        }
    }
    //判断获取类别图片
    if (!_netGetClassifyViewSucc) {
        [self communityView];
    }
}
- (void)menuView:(MenuView*)menuView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
        ChatBlogsViewController *chatBlogsVC = [[ChatBlogsViewController alloc] init];
        communityItem *item = [_communitys objectAtIndex:indexPath.row];
        chatBlogsVC.titleName = item.dname;
        chatBlogsVC.bsort = [NSString stringWithFormat:@"%d", item.id];
        [self.navigationController pushViewController:chatBlogsVC animated:YES];
    
        [UIView animateWithDuration:0.5 animations:^{
            NSInteger count = [_communitys count];
            _communityMenuView.frame = CGRectMake(0, -40*count, 140, 40*count);
    
        }];

}


#endif
- (void)writeBlog:(UIButton*)button{
    
    _backFromAddBlog = YES;
    CYHDSendTopicViewController *writeBlogVC = [[CYHDSendTopicViewController alloc] init];
    writeBlogVC.isHu = YES;
    writeBlogVC.bsortArray = _bsortMenuArray;
    writeBlogVC.titleArray = _titleMenuArray;
    if (self.bsort) {
//        writeBlogVC.bsort = self.bsort;
    }else{
        writeBlogVC.bsort = @"0";
    }
    
    [self.navigationController pushViewController:writeBlogVC animated:YES];
}
- (void)sortClicked:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if (btn.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            NSInteger count = [_communitys count];
            _communityMenuView.frame = CGRectMake(0, APP_VIEW_Y, 140, 40*count);
            
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            NSInteger count = [_communitys count];
            _communityMenuView.frame = CGRectMake(0, -40*count, 140, 40*count);
            
        }];

    }

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_chatBriefBlogVC viewDidAppear:YES];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    
    //nav remove
    _segButtonIndex = _segButtonView.selectedIndex;
//    [_segButtonView removeFromSuperview];
//    _segButtonView = nil;
    
}
- (void)viewDidDisappear:(BOOL)animated{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        NSInteger count = [_communitys count];
        _communityMenuView.frame = CGRectMake(0, -40*count, 140, 40*count);
        
    }];

    
}
#pragma mark- button action
- (void)btnSortClicked:(UIButton *)myBtn{
    if ([myBtn.titleLabel.text isEqualToString:@"视频曝光"]) {
        [self.view showAlertText:@"开发中..."];
        return;
    }
    ChatBlogsViewController *chatBlogsVC = [[ChatBlogsViewController alloc] init];
    chatBlogsVC.titleName = myBtn.titleLabel.text;
    chatBlogsVC.bsort = [NSString stringWithFormat:@"%d", myBtn.tag-1000];
    //    chatBlogsVC.myFriends = _friends;
    [self.navigationController pushViewController:chatBlogsVC animated:YES];

    
    
}
- (void)addFriend{
    //_backFromAddFriend = YES;
    ChatAddFriendViewController *chatAddFriendVC = [[ChatAddFriendViewController alloc] init];
    [self.navigationController pushViewController:chatAddFriendVC animated:YES];
}

- (void)gotoUserBlogs{
    ChatBlogsViewController *chatBlogsVC = [[ChatBlogsViewController alloc] init];
    chatBlogsVC.friendName = APP_DELEGATE.userName;
    [self.navigationController pushViewController:chatBlogsVC animated:YES];
}

- (void)friendViewBlankBeTaped{
    [_friendsCellTableView reloadData_];
}



- (void)gotoMovieList{
    MovieListViewController *mpVC = [[MovieListViewController alloc] init];
    [self.navigationController pushViewController:mpVC animated:YES];
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

- (void)communityView
{
    [[ChatNetwork sharedChatNetwork] chatPostBody:nil onUrl:@"findBlogsort.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj){
        if (result == postSucc) {
            
            _netGetClassifyViewSucc = YES;
            _communitys = [NSMutableArray array];
            NSDictionary *commuDict = (NSDictionary *)requestObj;
            _titleMenuArray = [NSMutableArray arrayWithCapacity:0];
            _bsortMenuArray = [NSMutableArray arrayWithCapacity:0];
            if (commuDict) {
                NSArray *contents = [commuDict objectForKey:@"contents"];
                if ([contents count]>0) {
                    for (NSDictionary *subDict in contents) {
                        communityItem *item = [[communityItem alloc]init];
                        item.dimgurl = [subDict analysisStrValueByKey:@"dimgurl"];
                        item.dname = [subDict analysisStrValueByKey:@"dname"];
                        item.dtype = [subDict objectForKey:@"dtype"];
                        item.id = [[subDict objectForKey:@"id"] integerValue];
                        item.special = [subDict objectForKey:@"special"];
                        [_communitys addObject:item];
                        [_titleMenuArray addObject:item.dname];
                        [_bsortMenuArray addObject:[NSString stringWithFormat:@"%d",item.id]];
                    }
                }
            }
            NSInteger count = [_communitys count];
            NSDictionary *menuDict = [[NSDictionary alloc]initWithObjectsAndKeys:_titleMenuArray,@"title", nil];
            
            _communityMenuView = [[MenuView alloc]initWithFrame:CGRectMake(0, -40*count, 140, 40*count) titlesAndLogos:menuDict height:@"40"];
            _communityMenuView._delegate = self;
            [self.view addSubview:_communityMenuView];
            
            [_testActivityIndicator stopAnimating]; // 结束旋转
            [_testActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏

        }else{
            [self performSelector:@selector(communityView) withObject:nil afterDelay:10.0];
        }
    } onError:^(NSString *errorStr){
        [self performSelector:@selector(communityView) withObject:nil afterDelay:10.0];
        [self.view showAlertText:[@"网络请求失败!" stringByAppendingString:errorStr]];
    }];
}

@end
