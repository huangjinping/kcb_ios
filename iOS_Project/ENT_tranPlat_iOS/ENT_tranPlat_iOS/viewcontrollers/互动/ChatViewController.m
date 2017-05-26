//
//  CYQViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-10.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "ChatViewController.h"
#import "communityItem.h"
#import "HuodongViewController.h"
#import "ChatNetwork.h"
#import "ChatFriendsListViewController.h"
#import "APPIllustrateViewController.h"


#define TAG_CHAT_BUTTON_JIAOLIU      111
#define TAG_CHAT_BUTTON_HUODONG      222
#define TAG_CHAT_BUTTON_SHOUCE       333
#define TAG_CHAT_BUTTON_MENU         444


@interface ChatViewController ()<
UIScrollViewDelegate,
//SegmentButtonViewDelegate,
//D_CellCellTableViewDelegate,
//D_CellCellTableViewDataSource,
UITextViewDelegate,
//ChatImageDelegate,
UIAlertViewDelegate,
//UITableViewDelegate,
//UITableViewDataSource,
MenuViewDelegate
>
{
    //SegmentButtonView               *_segButtonView;
    UIScrollView                    *_rootScrollView;
    //UIScrollView                    *_communityScrollView;
    //    UITableView                    *_communityView;
    // UITableView                     *_blogTableView;
//    D_CellCellTableView                 *_friendsCellTableView;
    MenuView                            *_menuView;
    //EGORefreshTableHeaderView       *_refreshHeader;
    //EGORefreshTableFooterView       *_loadMoreFooter;
    
    ChatBriefBlogViewController         *_chatBriefBlogVC;
  //  MovieListViewController           *_movieLVC;
    UITextView                      *_pinglunTextView;
    UIImageView                     *_pinglunBgImgView;
    NSMutableArray                  *_titleMenuArray;
    NSMutableArray                  *_bsortMenuArray;
//    UIImageView                     *_userPortraitImgView;
    
    //FaceToolBar             *_bar;
    
    //NSMutableArray          *_friends;
    NSMutableArray          *_blogs;
    NSMutableArray          *_comments;
    //    NSMutableArray          *_communitys;
    //NSMutableArray          *_movieLists;
    
    //BOOL                    _backFromAddFriend;
    BOOL                     _backFromAddBlog;
    BOOL                    _netGetClassifyViewSucc;
    //BOOL                    _netGetFriendsSucc;
    
    NSInteger               _navSegmentButtonIndex;
   // UIActivityIndicatorView         *_testActivityIndicator;
    
    
    UIButton *_jiaoliuButton;
    UIButton *_huodongButton;
    UIButton *_shouceButton;
    
    HuodongViewController       *_huodongVC;
    APPIllustrateViewController *_appIllustrateVC;
}


@end
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


//#pragma mark- 好友列表 Delegate and DataSource
//
//#define ROW_HEIGHT  100//(APP_HEIGHT - APP_NAV_HEIGHT - APP_TAB_HEIGHT - APP_NAV_HEIGHT)/3
//#define CELLS_COUNT_PER_ROW 3
//- (NSInteger)D_CellCellTableView:(D_CellCellTableView *)cellcellTableView numberOfCellsInRow:(NSInteger)rowIndex{
//    
//    NSInteger sumCount = [_friends count] + 1;
//    
//    if (sumCount >= (rowIndex + 1)*3) {
//        return 3;
//    }else{
//        return sumCount - (rowIndex * 3);
//    }
//}
//
//- (NSInteger)numberOfRows{
//    
//    NSInteger sumCount = [_friends count] + 1;
//    
//    NSInteger rows = sumCount/CELLS_COUNT_PER_ROW;
//    if (sumCount%CELLS_COUNT_PER_ROW) {
//        rows ++;
//    }
//    
//    return rows;
//}
//
//- (CGFloat)D_CellCellTableView:(D_CellCellTableView *)cellcellTableView heightForRow:(NSInteger)rowIndex{
//    return ROW_HEIGHT;
//}
//
//- (D_CellCell*)D_CellCellTableView:(D_CellCellTableView *)cellcellTableView cellForRow:(NSInteger)rowIndex indexForCell:(NSInteger)cellIndex{
//    static NSString *cellId = @"friendsCell";
//    
//    D_CellCell *cell = [cellcellTableView dequeueReusableD_CellWithIdentifier:cellId];
//    if (cell == nil) {
//        cell = [[D_CellCell alloc] initWithIdentifier:cellId];
//        
//        
//        
//    }
//    
//    NSInteger index = rowIndex*CELLS_COUNT_PER_ROW + cellIndex;
//    if (index == 0) {
//        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, ROW_HEIGHT - 20*2, ROW_HEIGHT - 20*2)];
//        [imgV setImage:[UIImage imageNamed:@"chat_add_friend.png"]];
//        [imgV setUserInteractionEnabled:YES];
//        [cell.contentView addSubview:imgV];
//        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imgV.left, imgV.bottom + 8, imgV.width, 20)];
//        label.backgroundColor = [UIColor clearColor];
//        label.text = @"添加好友";
//        label.font = [UIFont systemFontOfSize:14];
//        label.textAlignment = UITextAlignmentCenter;
//        [cell.contentView addSubview:label];
//        
//        
//    }else{
//        ChatUser *chatUser = [_friends objectAtIndex:index-1];
//        
//        [cell.imgView setImageWithURL:[NSURL URLWithString:chatUser.photo] placeholderImage:[UIImage imageNamed:@"chat_portrait_photo.png"]];
//        [cell.titleLabel setText:chatUser.username];
//        
//        cell.friendId = chatUser.feiendid;
//        
//        //        CGSize size = [@"试内容测试内容测试内容测试试内容测试内容测试内容测试测试测试内容测试内容测试内容测试内容测试内容内容" sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:CGSizeMake(cell.subTitleLabel.width, ROW_HEIGHT - cell.titleLabel.bottom) lineBreakMode:NSLineBreakByCharWrapping];
//        //        [cell.subTitleLabel setText:@"试内容测试内容测试内容测试试内容测试内容测试内容测试测试测试内容测试内容测试内容测试内容测试内容内容"];
//        //        [cell.subTitleLabel setFrame:CGRectMake(cell.subTitleLabel.frame.origin.x, cell.subTitleLabel.frame.origin.y, size.width, size.height)];
//    }
//    
//    
//    return cell;
//}
//
//- (void)D_CellCellTableView:(D_CellCellTableView *)cellcellTableView didTapedCell:(D_CellCell *)cell{
//    
//    if ([cell.contentView.subviews count]) {
//        [self addFriend];
//        return;
//    }
//    ChatBlogsViewController *chatBlogsVC = [[ChatBlogsViewController alloc] init];
//    chatBlogsVC.friendName = cell.titleLabel.text;
//    [self.navigationController pushViewController:chatBlogsVC animated:YES];
//}
//
//- (void)D_CellCellTableView:(D_CellCellTableView *)cellcellTableView removeFriend:(NSString *)friendName onCell:(D_CellCell *)cell{
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:[NSString stringWithFormat:@"确认删除好友：%@?",friendName] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//    alert.tag = [cell.friendId integerValue];
//    [alert show];
//}


//#pragma mark- 消息列表 Delegate and DataSource

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


//#pragma mark- seg button ac
//- (void)segmentButtonView:(SegmentButtonView *)segmentButtonView showView:(NSInteger)index{
//
//    [_rootScrollView scrollRectToVisible:CGRectMake(APP_WIDTH * index, 0, _rootScrollView.width, _rootScrollView.height) animated:NO];
//
//    if (index == 1){//好友列表
//        if (APP_DELEGATE.shouldRefreshFriendsList){
//            [self netGetFriends];
//        }
//    }
//
////    if (_rootScrollView.contentOffset.x == 0) {
////        _communityScrollView.hidden = NO;
////    }
//
//
//}

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
NSInteger count = 3;
- (void)loadView_{
    
//    _testActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    _testActivityIndicator.center = CGPointMake(100.0f, 100.0f);//只能设置中心，不能设置大小
//    [self.view addSubview:_testActivityIndicator];
//    //    _testActivityIndicator.color = [UIColor redColor]; // 改变圈圈的颜色为红色； iOS5引入
//    [_testActivityIndicator startAnimating]; // 开始旋转
    CGRect contentFrame = CGRectMake(APP_X, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT- APP_TAB_HEIGHT);
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
    
    _huodongVC = [[HuodongViewController alloc] init];
    [_huodongVC.view setFrame:CGRectMake(APP_WIDTH, 0, APP_WIDTH, _rootScrollView.height)];
    [_rootScrollView addSubview:_huodongVC.view];
    
    
    _appIllustrateVC = [[APPIllustrateViewController alloc] init];
    [_appIllustrateVC.view setFrame:CGRectMake(APP_WIDTH*2, 0, APP_WIDTH, _rootScrollView.height)];
    [_rootScrollView addSubview:_appIllustrateVC.view];
    
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenu)];
//    [_rootScrollView addGestureRecognizer:tap];
    
    NSDictionary *titlesAndLogos = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"chat_btn_write.png", @"chat_btn_guanzhu.png", @"chat_btn_mine.png", nil], KEY_MENU_VIEW_LOGOS, [NSArray arrayWithObjects:@"发布博文", @"关注好友", @"我的博文", nil], KEY_MENU_VIEW_TITLES, nil];
    _menuView = [[MenuView alloc]initWithFrame:CGRectMake(APP_WIDTH - 140, -40*count, 140, 40*count) titlesAndLogos:titlesAndLogos height:@"40"];
    _menuView._delegate = self;
    [self.view addSubview:_menuView];
    
    
    
//        //好友列表
//        UIImageView *userInfoBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH + 10, 5, _rootScrollView.width - 20, 55)];
//        userInfoBgImgView.userInteractionEnabled = YES;
//        [userInfoBgImgView setImage:[UIImage imageNamed:@"bg_white.png"]];
//        [_rootScrollView addSubview:userInfoBgImgView];
//    
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoUserBlogs)];
//        [userInfoBgImgView addGestureRecognizer:tap];
//    
//        _userPortraitImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (userInfoBgImgView.height - 40)/2, 40, 40)];
//        [userInfoBgImgView addSubview:_userPortraitImgView];
//    
//        UILabel *userNameL = [[UILabel alloc] initWithFrame:CGRectMake(_userPortraitImgView.right + 10, (userInfoBgImgView.height - 20)/2, 100, 20)];
//        userNameL.text = APP_DELEGATE.userName;
//        [userInfoBgImgView addSubview:userNameL];
//    
//        UIButton *userDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [userDetailButton setImage:[UIImage imageNamed:@"arrow_right.png"] forState:UIControlStateNormal];
//        [userDetailButton setFrame:CGRectMake(userInfoBgImgView.width - 40, (userInfoBgImgView.height - 16)/2, 18, 16)];
//        [userDetailButton addTarget:self action:@selector(gotoUserBlogs) forControlEvents:UIControlEventTouchUpInside];
//        [userInfoBgImgView addSubview:userDetailButton];
//    
//        UIImageView *friendsCellTableViewBgView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH + 10, userInfoBgImgView.bottom + 5, _rootScrollView.width - 20, _rootScrollView.height - userInfoBgImgView.height - 5*2)];
//        friendsCellTableViewBgView.userInteractionEnabled = YES;
//        [friendsCellTableViewBgView setImage:[UIImage imageNamed:@"bg_white.png"]];
//        [_rootScrollView addSubview:friendsCellTableViewBgView];
//        UITapGestureRecognizer *ftap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(friendViewBlankBeTaped)];
//        [friendsCellTableViewBgView addGestureRecognizer:ftap];
//    
//        _friendsCellTableView = [[D_CellCellTableView alloc] initWithFrame:CGRectMake(0, 0, friendsCellTableViewBgView.width, friendsCellTableViewBgView.height)];
//        _friendsCellTableView.dataSource_ = self;
//        _friendsCellTableView.delegate_ = self;
//        [friendsCellTableViewBgView addSubview:_friendsCellTableView];
    //
    //    //群组
    //    CGRect frame = CGRectMake(APP_WIDTH * 2, 0, APP_WIDTH, _rootScrollView.height);
    //    _movieLVC = [[MovieListViewController alloc] init];
    //    [_movieLVC.view setFrame:frame];
    //    [_rootScrollView addSubview:_movieLVC.view];
    
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
//    _friends = [[NSMutableArray alloc] initWithCapacity:0];
    _blogs = [[NSMutableArray alloc] initWithCapacity:0];
    _comments = [[NSMutableArray alloc] initWithCapacity:0];
    _netGetClassifyViewSucc = NO;
    _navSegmentButtonIndex = 0;
    
    [self loadView_];
    if([self.tabBarController respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]){
        self.tabBarController.automaticallyAdjustsScrollViewInsets = NO;
    }
}


- (void)reloadNavSegmentButtons{
    if (_navSegmentButtonIndex == 0) {
        [_jiaoliuButton setBackgroundImage:[UIImage imageNamed:@"chat_nav_btn_left_selected"] forState:UIControlStateNormal];
        [_huodongButton setBackgroundImage:[UIImage imageNamed:@"chat_nav_btn_center_unselected"] forState:UIControlStateNormal];
        [_shouceButton setBackgroundImage:[UIImage imageNamed:@"chat_nav_btn_right_unselected"] forState:UIControlStateNormal];

    }else if (_navSegmentButtonIndex == 1) {
        [_jiaoliuButton setBackgroundImage:[UIImage imageNamed:@"chat_nav_btn_left_unselected"] forState:UIControlStateNormal];
        [_huodongButton setBackgroundImage:[UIImage imageNamed:@"chat_nav_btn_center_selected"] forState:UIControlStateNormal];
        [_shouceButton setBackgroundImage:[UIImage imageNamed:@"chat_nav_btn_right_unselected"] forState:UIControlStateNormal];
        
    }else if (_navSegmentButtonIndex == 2) {
        [_jiaoliuButton setBackgroundImage:[UIImage imageNamed:@"chat_nav_btn_left_unselected"] forState:UIControlStateNormal];
        [_huodongButton setBackgroundImage:[UIImage imageNamed:@"chat_nav_btn_center_unselected"] forState:UIControlStateNormal];
        [_shouceButton setBackgroundImage:[UIImage imageNamed:@"chat_nav_btn_right_selected"] forState:UIControlStateNormal];
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_backFromAddBlog) {
        _chatBriefBlogVC.backFromAddBlog = YES;
    }
    
    [_chatBriefBlogVC viewWillAppear:animated];
    [_huodongVC viewWillAppear:animated];
    [_appIllustrateVC viewWillAppear:animated];
    
//    UserInfo *user = [[[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName] lastObject];
//    [_userPortraitImgView setImageWithURL:[NSURL URLWithString:[user photoServerPath]] placeholderImage:[UIImage imageNamed:@"chat_portrait_photo.png"]];
    
    
    
    
    [self setBackButtonHidden:YES];
    CGFloat width = 1/5.0*APP_WIDTH;
    _jiaoliuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_jiaoliuButton setFrame:CGRectMake(width, 5, width, _navigationImgView.height - 5*2)];
    
    [_jiaoliuButton setTitle:@"交流" forState:UIControlStateNormal];
    [_jiaoliuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_jiaoliuButton.titleLabel setFont:FONT_NOMAL];
    _jiaoliuButton.tag = TAG_CHAT_BUTTON_JIAOLIU;
    [_jiaoliuButton addTarget:self action:@selector(navButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationImgView addSubview:_jiaoliuButton];
    _huodongButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_huodongButton setFrame:CGRectMake(width*2, 5, width, _navigationImgView.height - 5*2)];
    [_huodongButton setTitle:@"活动" forState:UIControlStateNormal];
    [_huodongButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_huodongButton.titleLabel setFont:FONT_NOMAL];
    _huodongButton.tag = TAG_CHAT_BUTTON_HUODONG;
    [_huodongButton addTarget:self action:@selector(navButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationImgView addSubview:_huodongButton];
    _shouceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shouceButton setFrame:CGRectMake(width*3, 5, width, _navigationImgView.height - 5*2)];
    
    [_shouceButton setTitle:@"手册" forState:UIControlStateNormal];
    [_shouceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_shouceButton.titleLabel setFont:FONT_NOMAL];
    _shouceButton.tag = TAG_CHAT_BUTTON_SHOUCE;
    [_shouceButton addTarget:self action:@selector(navButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationImgView addSubview:_shouceButton];
    [self reloadNavSegmentButtons];
    
    //    if (!_segButtonView) {
    //        _segButtonView = [[SegmentButtonView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, 34) backgroundColor:[UIColor whiteColor] andLineColor:COLOR_NAV];
    //        //[_segButtonView setBackgroundColor:COLOR_NAV];//[UIColor blackColor]];
    //        NSArray *titles = [NSArray arrayWithObjects:@"论坛", @"关注", @"视频", nil];
    //        [_segButtonView setTitles:titles withTitleNorColor:COLOR_NAV andTitleSelColor:COLOR_NAV];
    //        [_segButtonView setDelegate:self];
    //        [self.view addSubview:_segButtonView];
    //
    //        _segButtonView.selectedIndex = _navSegmentButtonIndex;
    //    }
    //+按钮
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH - 40, (_navigationImgView.height - 20)/2, 20, 20)];
    [imgV setUserInteractionEnabled:YES];
    [imgV setImage:[UIImage imageNamed:@"chat_nav_add.png"]];
    [_navigationImgView addSubview:imgV];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(APP_WIDTH - 50, 0, 50, 50)];
    //[button setImage:[UIImage imageNamed:@"chat_nav_add.png"] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];
    [button addTarget:self action:@selector(navButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = TAG_CHAT_BUTTON_MENU;
    [_navigationImgView addSubview:button];
    //    UIButton *writeBlogButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [writeBlogButton setFrame:CGRectMake(APP_WIDTH - 50, (_navigationImgView.height - 30)/2, 30, 30)];
    //    [writeBlogButton setImage:[UIImage imageNamed:@"chat_write_blog_logo"] forState:UIControlStateNormal];
    //    [writeBlogButton addTarget:self action:@selector(writeBlog:) forControlEvents:UIControlEventTouchUpInside];
    //    [_navigationImgView addSubview:writeBlogButton];
    
    //    UIButton *sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [sortButton setFrame:CGRectMake(20, (_navigationImgView.height - 30)/2-5, 30, 30)];
    //    [sortButton setTitle:@"..." forState:UIControlStateNormal];
    //    [sortButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    sortButton.selected = NO;
    //    sortButton.titleLabel.font = [UIFont systemFontOfSize:30];
    //    [sortButton addTarget:self action:@selector(sortClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    [_navigationImgView addSubview:sortButton];
    
    
    //判断刷新好友列表
//    if(_rootScrollView.contentOffset.x == APP_WIDTH){
//        
//        if (APP_DELEGATE.shouldRefreshFriendsList) {
//            [self netGetFriends];
//        }
//    }
    //判断获取类别图片
    //    if (!_netGetClassifyViewSucc) {
    //        [self communityView];
    //    }
}




- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_chatBriefBlogVC viewDidAppear:animated];
    [_huodongVC viewDidAppear:animated];
    [_appIllustrateVC viewDidAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    
    //nav remove
    // _navSegmentButtonIndex = _segButtonView.selectedIndex;
    //    [_segButtonView removeFromSuperview];
    //    _segButtonView = nil;
    
}
- (void)viewDidDisappear:(BOOL)animated{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        _menuView.frame = CGRectMake(APP_WIDTH - 140, -40*count, 140, 40*count);
        
    }];
    
    
}
#pragma mark- button action



- (void)navButtonClicked:(UIButton*)button{
    if (button.tag == TAG_CHAT_BUTTON_JIAOLIU) {
        _navSegmentButtonIndex = 0;
        [_rootScrollView scrollRectToVisible:CGRectMake(APP_WIDTH * 0, 0, _rootScrollView.width, _rootScrollView.height) animated:NO];
    }else if (button.tag == TAG_CHAT_BUTTON_HUODONG){
        _navSegmentButtonIndex = 1;
        [_rootScrollView scrollRectToVisible:CGRectMake(APP_WIDTH * 1, 0, _rootScrollView.width, _rootScrollView.height) animated:NO];
    }else if (button.tag == TAG_CHAT_BUTTON_SHOUCE){
        _navSegmentButtonIndex = 2;
        [_rootScrollView scrollRectToVisible:CGRectMake(APP_WIDTH * 2, 0, _rootScrollView.width, _rootScrollView.height) animated:NO];
    }else if (button.tag == TAG_CHAT_BUTTON_MENU){
        button.selected = !button.selected;
        if (button.selected) {
            [UIView animateWithDuration:0.5 animations:^{
                _menuView.frame = CGRectMake(APP_WIDTH - 140, APP_VIEW_Y, 140, 40*count);
                
            }];
        }
        else{
            [UIView animateWithDuration:0.5 animations:^{
                _menuView.frame = CGRectMake(APP_WIDTH - 140, -40*count, 140, 40*count);
                
            }];
            
        }
    }
    [self reloadNavSegmentButtons];
}

- (void)writeBlog{
    
    _backFromAddBlog = YES;
    CYHDSendTopicViewController *writeBlogVC = [[CYHDSendTopicViewController alloc] init];
    writeBlogVC.isHu = NO;
    writeBlogVC.bsortArray = _bsortMenuArray;
    writeBlogVC.titleArray = _titleMenuArray;
    writeBlogVC.navTitleStr = @"发送交流内容";
    if (self.bsort) {
        //        writeBlogVC.bsort = self.bsort;
    }else{
        writeBlogVC.bsort = @"0";
    }
    
    [self.navigationController pushViewController:writeBlogVC animated:YES];
}

//- (void)btnSortClicked:(UIButton *)myBtn{
//    if ([myBtn.titleLabel.text isEqualToString:@"视频曝光"]) {
//        [self.view showAlertText:@"开发中..."];
//        return;
//    }
//    ChatBlogsViewController *chatBlogsVC = [[ChatBlogsViewController alloc] init];
//    chatBlogsVC.titleName = myBtn.titleLabel.text;
//    chatBlogsVC.bsort = [NSString stringWithFormat:@"%d", (int)myBtn.tag-1000];
//    //    chatBlogsVC.myFriends = _friends;
//    [self.navigationController pushViewController:chatBlogsVC animated:YES];
//    
//    
//    
//}
//- (void)addFriend{
//    //_backFromAddFriend = YES;
//    ChatAddFriendViewController *chatAddFriendVC = [[ChatAddFriendViewController alloc] init];
//    [self.navigationController pushViewController:chatAddFriendVC animated:YES];
//}

- (void)gotoUserBlogs{
    ChatBlogsViewController *chatBlogsVC = [[ChatBlogsViewController alloc] init];
    chatBlogsVC.friendName = APP_DELEGATE.userName;
    [self.navigationController pushViewController:chatBlogsVC animated:YES];
}

//- (void)friendViewBlankBeTaped{
//    [_friendsCellTableView reloadData_];
//}

- (void)hideMenu{
    [UIView animateWithDuration:0.5 animations:^{
        _menuView.frame = CGRectMake(APP_WIDTH - 140, -40*count, 140, 40*count);
        
    }];
}


- (void)gotoMovieList{
    MovieListViewController *mpVC = [[MovieListViewController alloc] init];
    [self.navigationController pushViewController:mpVC animated:YES];
}

#pragma mark- MENU DELEGATE
- (void)menuView:(MenuView*)menuView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
    if (indexPath.row == 0) {//发博文
        [self writeBlog];
    }else if (indexPath.row == 1){//关注好友
        ChatFriendsListViewController *vc = [[ChatFriendsListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){//我的博文
        [self gotoUserBlogs];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        _menuView.frame = CGRectMake(APP_WIDTH - 140, -40*count, 140, 40*count);
        
    }];
    
}
//#pragma mark- ALERT DELEGATE
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    
//    //删除好友
//    if (buttonIndex == alertView.cancelButtonIndex) {
//        
//    }else{
//        [self netRemoveFriend:[NSString stringWithFormat:@"%d", (int)alertView.tag]];
//    }
//}


#pragma mark- SCROLLVIEW DELEGATE
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x == 0) {//blog
        
        _navSegmentButtonIndex = 0;
    }else if (scrollView.contentOffset.x == APP_WIDTH){//huodong
        
        
        _navSegmentButtonIndex = 1;
        [_huodongVC loadWebView];
        [_appIllustrateVC loadWebView];
    }else if (scrollView.contentOffset.x == 2*APP_WIDTH){//shouce
        
        
        _navSegmentButtonIndex = 2;

    }
    
    [self reloadNavSegmentButtons];
    
    //    //顶部蓝色button底线的动态切换
    //    NSInteger index = scrollView.contentOffset.x/APP_WIDTH;
    //    if (index < 0 || index > 2) {
    //        return;
    //    }
    //   // [_segButtonView setSelectedIndex:index];
    //
    //    //刷新界面
    //    if (scrollView.contentOffset.x == 0) {//blog
    //
    //    }else if (scrollView.contentOffset.x == APP_WIDTH){//friends
    //
    //        if (APP_DELEGATE.shouldRefreshFriendsList) {
    //            [self netGetFriends];
    //        }
    //    }else if (scrollView.contentOffset.x == 2*APP_WIDTH){//qunzu
    //    }
}



//#pragma mark- 网络请求
////获取好友列表
//- (void)netGetFriends{
//    
//    [[ChatNetwork sharedChatNetwork] chatPostBody:[NSMutableDictionary dictionaryWithObject:APP_DELEGATE.userName forKey:@"username"] onUrl:@"findFriends.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
//        if (result == postSucc) {
//            
//            APP_DELEGATE.shouldRefreshFriendsList = NO;
//            
//            NSDictionary *resDict = (NSDictionary*)requestObj;
//            
//            NSArray *contents_ = [resDict objectForKey:@"contents"];
//            [_friends removeAllObjects];
//            for (NSDictionary *dict in contents_) {
//                
//                NSString *blogcount = [dict analysisStrValueByKey:@"blogcount"];
//                NSString *blogsum = [dict analysisStrValueByKey:@"blogsum"];
//                NSString *feiendid = [dict analysisStrValueByKey:@"feiendid"];
//                NSString *fuid = [dict analysisStrValueByKey:@"fuid"];
//                NSString *photo = [dict analysisStrValueByKey:@"photo"];
//                NSString *posttime = [dict analysisStrValueByKey:@"posttime"];
//                NSString *regtime = [dict analysisStrValueByKey:@"regtime"];
//                NSString *username = [dict analysisStrValueByKey:@"username"];
//                NSString *utype = [dict analysisStrValueByKey:@"utype"];
//                
//                ChatUser *chatUser = [[ChatUser alloc] init];
//                chatUser.blogcount = blogcount;
//                chatUser.blogsum = blogsum;
//                chatUser.feiendid = feiendid;
//                chatUser.fuid = fuid;
//                chatUser.photo = photo;
//                chatUser.posttime = posttime;
//                chatUser.regtime = regtime;
//                chatUser.username = username;
//                chatUser.utype = utype;
//                
//                [_friends addObject:chatUser];
//                
//                
//            }
//            
//            
//        }else{
//            
//            [_friends removeAllObjects];
//            //            [self.view showAlertText:[@"获取好友列表," stringByAppendingString:(NSString*)requestObj]];
//            
//        }
//        
//        [_friendsCellTableView reloadData_];
//        
//    } onError:^(NSString *errorStr) {
//        
//        [self.view showAlertText:[@"获取好友列表失败!" stringByAppendingString:errorStr]];
//    }];
//}
//
//
////移除好友
//- (void)netRemoveFriend:(NSString*)friendId{
//    NSMutableDictionary *bodyDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:friendId, @"friendsid", nil];
//    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"deleteFriend.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
//        
//        if (result == postSucc) {
//            NSDictionary *resDict = (NSDictionary*)requestObj;
//            NSString *contents = [resDict objectForKey:@"contents"];
//            [self.view showAlertText:contents];
//            
//            [self netGetFriends];
//            
//        }else{
//            [self.view showAlertText:[NSString stringWithFormat:@"删除好友失败!%@", requestObj]];
//        }
//        
//        [_friendsCellTableView reloadData_];
//    } onError:^(NSString *errorStr) {
//        
//        [self.view showAlertText:[NSString stringWithFormat:@"删除好友失败!%@", errorStr]];
//        
//        [_friendsCellTableView reloadData_];
//    }];
//}
//
//- (void)communityView
//{
//    [[ChatNetwork sharedChatNetwork] chatPostBody:nil onUrl:@"findBlogsort.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj){
//        if (result == postSucc) {
//
//            _netGetClassifyViewSucc = YES;
//            _communitys = [NSMutableArray array];
//            NSDictionary *commuDict = (NSDictionary *)requestObj;
//            _titleMenuArray = [NSMutableArray arrayWithCapacity:0];
//            _bsortMenuArray = [NSMutableArray arrayWithCapacity:0];
//            if (commuDict) {
//                NSArray *contents = [commuDict objectForKey:@"contents"];
//                if ([contents count]>0) {
//                    for (NSDictionary *subDict in contents) {
//                        communityItem *item = [[communityItem alloc]init];
//                        item.dimgurl = [subDict analysisStrValueByKey:@"dimgurl"];
//                        item.dname = [subDict analysisStrValueByKey:@"dname"];
//                        item.dtype = [subDict objectForKey:@"dtype"];
//                        item.id = (int)[[subDict objectForKey:@"id"] integerValue];
//                        item.special = [subDict objectForKey:@"special"];
//                        [_communitys addObject:item];
//                        [_titleMenuArray addObject:item.dname];
//                        [_bsortMenuArray addObject:[NSString stringWithFormat:@"%d",item.id]];
//                    }
//                }
//            }
//            NSInteger count = [_communitys count];
//            NSDictionary *menuDict = [[NSDictionary alloc]initWithObjectsAndKeys:_titleMenuArray,@"title", nil];
//
//            _communityMenuView = [[MenuView alloc]initWithFrame:CGRectMake(0, -40*count, 140, 40*count) titlesAndLogos:menuDict height:@"40"];
//            _communityMenuView._delegate = self;
//            [self.view addSubview:_communityMenuView];
//
//            [_testActivityIndicator stopAnimating]; // 结束旋转
//            [_testActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
//
//        }else{
//            [self performSelector:@selector(communityView) withObject:nil afterDelay:10.0];
//        }
//    } onError:^(NSString *errorStr){
//        [self performSelector:@selector(communityView) withObject:nil afterDelay:10.0];
//        [self.view showAlertText:[@"网络请求失败!" stringByAppendingString:errorStr]];
//    }];
//}

@end
