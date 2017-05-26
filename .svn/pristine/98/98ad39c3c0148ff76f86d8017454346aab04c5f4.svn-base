//
//  MainViewController.m
//  kxmovie
//
//  Created by Kolyvan on 18.10.12.
//  Copyright (c) 2012 Konstantin Boukreev . All rights reserved.
//
//  https://github.com/kolyvan/kxmovie
//  this file is part of KxMovie
//  KxMovie is licenced under the LGPL v3, see lgpl-3.0.txt

#import "MoviePlayerViewController.h"
#import "KxMovieViewController.h"
#import "MovieDetailTableViewCell.h"
#import "ChatComment.h"


@interface MoviePlayerViewController () {
    
    KxMovieViewController                   *_KxMovieVC;
    UITableView                             *_commentTableView;
    //NSArray *_localMovies;
    //NSArray *_remoteMovies;
    YFInputBar                              *_movieTextView;
    NSMutableArray                          *_movieCellHeight;
    SegmentButtonView                       *_movieSegmentView;
    NSInteger                               _segButtonIndex;
    UIScrollView                            *_movieSrollView;
    EGORefreshTableHeaderView               *_refreshHeader;
    EGORefreshTableFooterView               *_loadMoreFooter;
    BOOL                                    _isloadingComment;


    
}
@end

@implementation MoviePlayerViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma -mark TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([_commentsArray count] > 0) {
        return [_commentsArray count];

    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHei;
    if ([_movieCellHeight count] > 0) {
        cellHei = [[_movieCellHeight objectAtIndex:indexPath.row] floatValue];
        return cellHei;
    }
    else{
        return 80;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellName = @"cellName";
    MovieDetailTableViewCell *movieCell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (movieCell == nil) {
        movieCell = [[MovieDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    if ([_movieCellHeight count] > 0) {
        CGFloat pingHeight = [[_movieCellHeight objectAtIndex:indexPath.row] floatValue]-40;
        movieCell.moviePingLable.frame = CGRectMake(50, 31, APP_WIDTH-55, pingHeight);
//        movieCell.moviePingLable.backgroundColor = [UIColor redColor];
    }
    if ([[[UIDevice currentDevice]systemVersion]floatValue] > 7.0 ) {
        movieCell.moviePingLable.lineBreakMode = NSLineBreakByCharWrapping;
    }
    movieCell.contentView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    movieCell.moviePingLable.lineBreakMode = NSLineBreakByCharWrapping;
    movieCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([_commentsArray count] > 0) {
        ChatComment *subComment = [_commentsArray objectAtIndex:indexPath.row];
        [movieCell.photo setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"chat_portrait_photo.png"]];
        movieCell.moviePingLable.text = subComment.content;
        movieCell.userNameLable.text = subComment.commentuser_username;
        movieCell.addTimeLable.text = subComment.addtime;
        movieCell.userNameLable.frame = CGRectMake(50, 7, [self getStringHeight:subComment.commentuser_username].width, 21);
        
        movieCell.addTimeLable.frame = CGRectMake(movieCell.userNameLable.frame.origin.x+movieCell.userNameLable.frame.size.width, 7, [self getStringHeight:subComment.addtime].width, 21);
    }
    return movieCell;
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark- Lable自适应 博文内容字体
- (CGSize)getStringHeight:(NSString *)aString {
    
    CGSize size;
   
        UIFont *nameFont = [UIFont systemFontOfSize:15];
        size=[aString sizeWithFont:nameFont constrainedToSize:CGSizeMake(APP_WIDTH-30, 1000) lineBreakMode:NSLineBreakByCharWrapping];
    
    return size;
}

#pragma -mark cell高度
- (NSMutableArray *)cellHeightWithMovieContentArray:(NSArray *)contentArray{
    
    for (ChatComment *subComment in contentArray) {
        CGFloat cellHeight = [self getStringHeight:subComment.content].height +45;
        [_movieCellHeight addObject:[NSString stringWithFormat:@"%f",cellHeight]];
    }
    return _movieCellHeight;
}

#pragma -mark view System
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    
    _segButtonIndex = 0;
    _isloadingComment = NO;
    _commentsArray = [NSMutableArray arrayWithCapacity:0];
    _movieCellHeight = [NSMutableArray arrayWithCapacity:0];
//    _movieCellHeight = [self cellHeightWithMovieContentArray:_commentsArray];
//  请求评论列表
    [self creatMovieContent];
    [self netMovieCommentsWithBlogID:_blogID indexid:nil ismore:NO];

}

- (void)creatMovieContent{
 
    //视频播放
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *path = _movieURL;
    // increase buffering for .wmv, it solves problem with delaying audio frames
    if ([path.pathExtension isEqualToString:@"wmv"])
        parameters[KxMovieParameterMinBufferedDuration] = @(5.0);
    // disable deinterlacing for iPhone, because it's complex operation can cause stuttering
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        parameters[KxMovieParameterDisableDeinterlacing] = @(YES);
    // disable buffering
    //parameters[KxMovieParameterMinBufferedDuration] = @(0.0f);
    //parameters[KxMovieParameterMaxBufferedDuration] = @(0.0f);
    _KxMovieVC = [KxMovieViewController movieViewControllerWithContentPath:path
                                                                parameters:parameters];
    
    
    _movieSegmentView = [[SegmentButtonView alloc]initWithFrame:CGRectMake(0, _KxMovieVC.view.bottom, APP_WIDTH, 28) backgroundColor:[UIColor whiteColor] andLineColor:COLOR_BUTTON_BLUE];
    NSArray *titleArrays = [NSArray arrayWithObjects:@"简介",@"评论", nil];
    [_movieSegmentView setTitles:titleArrays withTitleNorColor:[UIColor grayColor] andTitleSelColor:COLOR_BUTTON_BLUE];
    //[_movieSegmentView setBackgroundColor:[UIColor colorWithRed:225/255.0 green:230/255.0 blue:233/255.0 alpha:1.0]];//COLOR_FONT_NOMAL];
    [_movieSegmentView setDelegate:self];
    [self.view addSubview:_movieSegmentView];
    
    _movieSegmentView.selectedIndex = _segButtonIndex;

    _movieSrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _movieSegmentView.bottom, APP_WIDTH, self.view.height-208-APP_Y)];
    _movieSrollView.showsHorizontalScrollIndicator = NO;
    _movieSrollView.showsVerticalScrollIndicator = NO;
    _movieSrollView.contentSize = CGSizeMake(APP_WIDTH*2, self.view.height-208-APP_Y);
    _movieSrollView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    _movieSrollView.pagingEnabled = YES;
    _movieSrollView.delegate = self;
    [self.view addSubview:_movieSrollView];
    
    UIScrollView *headView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, APP_WIDTH, _movieSrollView.height)];
    UILabel *contentLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, APP_WIDTH-20, headView.height-10)];
    contentLable.text = [NSString stringWithFormat:@"    %@",_movieContent];
    contentLable.backgroundColor = [UIColor clearColor];
    contentLable.textAlignment = NSTextAlignmentLeft;
    contentLable.numberOfLines = 0;
    contentLable.textColor = COLOR_FONT_NOMAL;
    contentLable.font = [UIFont systemFontOfSize:15];
    [contentLable fitSpace:4];
    [headView addSubview:contentLable];
    headView.showsHorizontalScrollIndicator = NO;
    headView.contentSize = CGSizeMake(0, contentLable.height+10);
    [_movieSrollView addSubview:headView];
    _commentTableView = [[UITableView alloc]initWithFrame:CGRectMake(APP_WIDTH, 0, APP_WIDTH, _movieSrollView.height) style:UITableViewStylePlain];
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.showsVerticalScrollIndicator = NO;
    _commentTableView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    if ([_commentTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_commentTableView setSeparatorInset:UIEdgeInsetsZero];
    }
//    _commentTableView.bounces = NO;
    _refreshHeader = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, - _commentTableView.height, _commentTableView.width, _commentTableView.height)];
    _refreshHeader.delegate = self;
    [_commentTableView addSubview:_refreshHeader];
    //加载更多
    _loadMoreFooter = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0, _commentTableView.height, _commentTableView.width, _commentTableView.height)];
    _loadMoreFooter.delegate = self;
    [_commentTableView addSubview:_loadMoreFooter];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_WIDTH, 35.5)];
    headerView.userInteractionEnabled = YES;
    headerView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    UILabel *myBtnLable = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, APP_WIDTH-10, 25)];
    myBtnLable.text = @"我也来说两句...";
    myBtnLable.textAlignment = NSTextAlignmentLeft;
    myBtnLable.backgroundColor = [UIColor whiteColor];
    myBtnLable.textColor = [UIColor grayColor];
    myBtnLable.font = [UIFont systemFontOfSize:15];
    myBtnLable.userInteractionEnabled = YES;
    [headerView addSubview:myBtnLable];
    
    UIButton *tableHeadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tableHeadBtn.frame = CGRectMake(5, 5, APP_WIDTH-10, 25);
    tableHeadBtn.backgroundColor = [UIColor clearColor];
    [tableHeadBtn addTarget:self action:@selector(headerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:tableHeadBtn];
    
    UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 35, APP_WIDTH, 0.5)];
    lineImageView.image = [UIImage imageNamed:@"line02.png"];
    [headerView addSubview:lineImageView];
    _commentTableView.tableHeaderView = headerView;
    [_movieSrollView addSubview:_commentTableView];
    
    [self.view addSubview:_KxMovieVC.view];
    [_KxMovieVC viewDidAppear:YES];
}

- (void)headerBtnClicked:(UIButton *)myBtn{
    
    _movieTextView = [[YFInputBar alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY([UIScreen mainScreen].bounds)-APP_VIEW_Y, APP_WIDTH, 44)];
    _movieTextView.isMovie = YES;
    _movieTextView.isCarH = NO;
    _movieTextView.delegate = self;
    _movieTextView.clearInputWhenSend = YES;
    _movieTextView.resignFirstResponderWhenSend = YES;
    [_movieTextView.textView becomeFirstResponder];
    [self.view.superview addSubview:_movieTextView];
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:YES];
//    _movieCellHeight = [self cellHeightWithMovieContentArray:_commentsArray];

}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = YES;
    [self netPostNewBrowseOfMovieWithID:_blogID];


}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    self.navigationController.navigationBarHidden = NO;
    _segButtonIndex = _movieSegmentView.selectedIndex;

}

#pragma mark- 消息刷新与加载更多 Delegate
- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView *)view{
    if (_isloadingComment) {
        return;
    }
    ChatComment *oneComment = [_commentsArray lastObject];
    [self netMovieCommentsWithBlogID:_blogID  indexid: oneComment.id_ ismore:YES];
}

- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView *)view{
    return NO;
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view{
    if (_isloadingComment) {
        return;
    }
    [self netMovieCommentsWithBlogID:_blogID  indexid:nil ismore:NO];

}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view{
    return NO;
}

#pragma mark- scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentSize.height > _commentTableView.height) {
        [_loadMoreFooter setFrame:CGRectMake(0, scrollView.contentSize.height, _commentTableView.width, _commentTableView.height)];
    }else{
        [_loadMoreFooter setFrame:CGRectMake(0, scrollView.height, _commentTableView.width, _commentTableView.height)];
    }
    if (scrollView.contentOffset.y > 0) {
        [_loadMoreFooter egoRefreshScrollViewDidScroll:scrollView];
    }else{
        [_refreshHeader egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y > 0) {
        [_loadMoreFooter egoRefreshScrollViewDidEndDragging:scrollView];
        
    }else{
        [_refreshHeader egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark- seg button ac
- (void)segmentButtonView:(SegmentButtonView *)segmentButtonView showView:(NSInteger)index{
    
    [_movieSrollView scrollRectToVisible:CGRectMake(APP_WIDTH * index, 0, _movieSrollView.width, _movieSrollView.height) animated:NO];
    
    
    //    if (_rootScrollView.contentOffset.x == 0) {
    //        _communityScrollView.hidden = NO;
    //    }
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (![scrollView isKindOfClass:[_commentTableView class]]) {
        //顶部蓝色button底线的动态切换
        NSInteger index = scrollView.contentOffset.x/APP_WIDTH;
        if (index < 0 || index > 2) {
            return;
        }
        [_movieSegmentView setSelectedIndex:index];

    }

}

#pragma -mark 发表评论接口
//发表评论
-(void)inputBar:(YFInputBar *)inputBar  withInputString:(NSString *)str
{
    [self netMoviePingByUsername:APP_DELEGATE.userName andBlogId:_blogID andContent:str];
    _movieTextView.isMovie = NO;
    
}

#pragma -mark 上传视频浏览量
- (void)netPostNewBrowseOfMovieWithID:(NSString *)movieBlogsID{

    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDict setObject:movieBlogsID forKey:@"blogid"];
    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"checkBlog.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj){
        if (result == postSucc) {
//            NSDictionary *movieDict = (NSDictionary*)requestObj;
//            NSString *contents_ = [movieDict objectForKey:@"contents"];
//            NSInteger statusCode = [[movieDict objectForKey:@"status"] integerValue];
//            [self.view showAlertText:@"上传成功"];
        }
        else{
            
        }
    
    
    } onError:^(NSString *errorStr){
        
        
        
    }];    
}

// 视频评论
- (void)netMoviePingByUsername:(NSString*)username andBlogId:(NSString*)blogId andContent:(NSString *)contents{
    
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDict setObject:username forKey:@"username"];
    [bodyDict setObject:blogId forKey:@"blogid"];
    [bodyDict setObject:contents forKey:@"content"];
    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"addComment.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:contents onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            
            NSDictionary *resDict = (NSDictionary*)requestObj;
            
            NSArray *contentsArr = [resDict analysisArrValueByKey:@"contents"];
            for (NSDictionary *subDict in contentsArr) {
                ChatComment *twoComment = [[ChatComment alloc]init];
                twoComment.addtime = [subDict analysisStrValueByKey:@"addtime"];
                twoComment.content = [subDict analysisStrValueByKey:@"content"];
                twoComment.id_ = [subDict analysisStrValueByKey:@"id"];
                NSDictionary *commUser = [subDict analysisDictValueByKey:@"commentuser"];
                twoComment.commentuser_username = [commUser analysisStrValueByKey:@"username"];
            }
            [_movieCellHeight removeAllObjects];
            _movieCellHeight = [self cellHeightWithMovieContentArray:_commentsArray];
            
            [_commentTableView reloadData];
            [self.view showAlertText:@"发表评论成功!上拉查看最新。"];
        }else{
            [self.view showAlertText:[@"发表评论失败!" stringByAppendingString:(NSString *)requestObj]];
        }
        
        
    }onError:^(NSString *errorStr) {
        [self.view showAlertText:[@"发表评论失败!" stringByAppendingString:errorStr]];
        
        
    }];
}

//视频评论列表
- (void)netMovieCommentsWithBlogID:(NSString *)blog_id  indexid:(NSString *)indexid ismore:(BOOL)ismore{
    
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDict setObject:blog_id forKey:@"blogid"];
    [bodyDict setObject:@"10" forKey:@"countsum"];
    if (indexid) {
        [bodyDict setObject:indexid forKey:@"indexid"];
    }
    [bodyDict setObject:[NSString stringWithFormat:@"%d",ismore] forKey:@"isnew"];
    _isloadingComment = YES;
    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"findComments.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:_commentTableView callBackWithObj:[NSString stringWithFormat:@"%d",ismore] onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj){
        if (result == postSucc) {
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSArray *contentsArr = [resDict analysisArrValueByKey:@"contents"];
            NSString *isnewStr = (NSString*)callBackObj;
            if ([isnewStr isEqualToString:@"0"]) {
                [_commentsArray removeAllObjects];
            }
            for (NSDictionary *dict in contentsArr) {
                ChatComment *oneComment = [[ChatComment alloc]init];
                oneComment.addtime = [dict analysisStrValueByKey:@"addtime"];
                oneComment.content = [dict analysisStrValueByKey:@"content"];
                oneComment.id_ = [dict analysisStrValueByKey:@"id"];
                NSDictionary *commentDict = [dict analysisDictValueByKey:@"commentuser"];
                oneComment.commentuser_username = [commentDict analysisStrValueByKey:@"username"];
                [_commentsArray addObject:oneComment];
            }
            if ([_movieCellHeight count] > 0) {
                [_movieCellHeight removeAllObjects];
            }
            _movieCellHeight = [self cellHeightWithMovieContentArray:_commentsArray];
            [_commentTableView reloadData];
        }
        else{
            [self.view showAlertText:[@"获取评论列表," stringByAppendingString:(NSString*)requestObj]];

        }
        _isloadingComment = NO;
        [_refreshHeader egoRefreshScrollViewDataSourceDidFinishedLoading:_commentTableView];
        [_loadMoreFooter egoRefreshScrollViewDataSourceDidFinishedLoading:_commentTableView];
    
    } onError:^(NSString *errorStr){}];
    
    _isloadingComment = NO;
    [_refreshHeader egoRefreshScrollViewDataSourceDidFinishedLoading:_commentTableView];
    [_loadMoreFooter egoRefreshScrollViewDataSourceDidFinishedLoading:_commentTableView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
