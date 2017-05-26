//
//  MoviePlayerViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-12-1.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieInfo.h"
#import "MovieTableViewCell.h"
#import "ChatBlog.h"
#import "MovieContent.h"

@interface MovieListViewController ()
{
//  视频访问量
    NSMutableString        *movieCount;
}


@end


@implementation MovieListViewController

- (id)init{
    self  = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadTable{
    
    _movieTable = [[UITableView alloc]initWithFrame:CGRectMake(APP_X, 0, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - APP_TAB_HEIGHT-34) style:UITableViewStylePlain];
    _movieTable.delegate = self;
    _movieTable.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    _movieTable.dataSource = self;
    _movieTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_movieTable];
    
    _refreshHeader = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, - _movieTable.height, _movieTable.width, _movieTable.height)];
    _refreshHeader.delegate = self;
    [_movieTable addSubview:_refreshHeader];
    //加载更多
    _loadMoreFooter = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0, _movieTable.height, _movieTable.width, _movieTable.height)];
    _loadMoreFooter.delegate = self;
    [_movieTable addSubview:_loadMoreFooter];

}

#pragma mark- 消息刷新与加载更多 Delegate
- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView *)view{
    if (_isloadingBlogs) {
        return;
    }
    MovieInfo *myInf = [_movieLists lastObject];
    [self netGetAllMovieListsWithIndexid:myInf.id_ loadNew:NO bsort:@"10"];
}

- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView *)view{
    return NO;
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view{
    if (_isloadingBlogs) {
        return;
    }
    [self netGetAllMovieListsWithIndexid:nil loadNew:YES bsort:@"10"];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view{
    return NO;
}

#pragma mark- scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentSize.height > _movieTable.height) {
        [_loadMoreFooter setFrame:CGRectMake(0, scrollView.contentSize.height, _movieTable.width, _movieTable.height)];
    }else{
        [_loadMoreFooter setFrame:CGRectMake(0, scrollView.height, _movieTable.width, _movieTable.height)];
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

- (void)viewDidLoad{
    
    [super viewDidLoad];
    _movieLists = [[NSMutableArray alloc] initWithCapacity:0];
    _isloadingBlogs = NO;

    [self loadTable];
    [self netGetAllMovieListsWithIndexid:nil loadNew:YES bsort:@"10"];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [_movieTable setDelegate:self];
//    [self netGetAllMovieListsWithIndexid:nil loadNew:YES bsort:@"10"];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   // [_movieTable setDelegate:nil];

}
#pragma mark- 消息列表 Delegate and DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_movieLists count];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return CELL_HEIGHT_CHAT;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellName = @"movieListCell";
    MovieTableViewCell *movieCell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (movieCell == nil) {
        movieCell = [[MovieTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        
    }
    MovieInfo *userMovie = [_movieLists objectAtIndex:indexPath.row];
    movieCell.contentView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    movieCell.movieTitleLable.text = userMovie.movieContent.videoTitle;
    [movieCell.movieImageView setImageWithURL:[NSURL URLWithString:userMovie.movieContent.imgurl] placeholderImage:[UIImage imageNamed:@""]];
    movieCell.MPpc.contentURL = [NSURL URLWithString:userMovie.movieContent.videourl];
    movieCell.movieCountLable.text = userMovie.movieContent.checkcount;
    movieCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return movieCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    for (UIView *view = self.view.superview; view; view = [view superview]) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            MovieInfo *userMovie = [_movieLists objectAtIndex:indexPath.row];
            MoviePlayerViewController *mvc = [[MoviePlayerViewController alloc] init];
            mvc.movieURL = userMovie.movieContent.videourl;
            mvc.movieID = userMovie.movieContent.id_;
            mvc.blogID = userMovie.id_;
            mvc.movieTitle = userMovie.movieContent.videoTitle;
            mvc.movieContent = userMovie.movieContent.content;
            [((UIViewController*)nextResponder).navigationController pushViewController:mvc animated:YES];
            break;
        }
    }
}

#pragma-mark 网路请求
- (void)netGetAllMovieListsWithIndexid:(NSString *)indexId loadNew:(BOOL)loadNew bsort:(NSString*)bsort{
    
    _isloadingBlogs = YES;

    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDict setObject:APP_DELEGATE.userName forKey:@"uname"];
    
//    [bodyDict setObject:@"0" forKey:@"isall"];
    //[bodyDict setObject:@"10" forKey:@"countsum"];//默认
    if (bsort) {
        [bodyDict setObject:bsort forKey:@"bsort"];
    }
    if (indexId) {
        [bodyDict setObject:indexId forKey:@"indexid"];
    }
    NSString *isRefresh = @"1";
    if (loadNew) {
        [bodyDict setObject:@"1" forKey:@"isnew"];//加载最新
    }else{
        [bodyDict setObject:@"0" forKey:@"isnew"];
        isRefresh = @"0";
    }
    if (loadNew) {
        [_movieLists removeAllObjects];
    }
    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"findBlogs.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if (result == postSucc) {
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSDictionary *contents = [resDict objectForKey:@"contents"];
            NSArray *blogs = [contents analysisArrValueByKey:@"blogs"];
            
            for (NSDictionary *blogDict in blogs) {
                MovieInfo *myInfo = [[MovieInfo alloc]init];
                myInfo.addtime = [blogDict analysisStrValueByKey:@"addtime"];
                NSDictionary *movieContentDict = [blogDict analysisDictValueByKey:@"blogcontent"];
                myInfo.movieContent.checkcount = [movieContentDict analysisStrValueByKey:@"checkcount"];
                
                myInfo.movieContent.content = [movieContentDict analysisStrValueByKey:@"content"];
                myInfo.movieContent.videoTitle = [movieContentDict analysisStrValueByKey:@"videotitle"];
                
                myInfo.movieContent.id_ = [movieContentDict analysisStrValueByKey:@"id"];
                myInfo.movieContent.imgurl = [movieContentDict analysisStrValueByKey:@"imgurl"];
                
                myInfo.movieContent.model = [movieContentDict analysisStrValueByKey:@"model"];
                myInfo.movieContent.reservedcount = [movieContentDict analysisStrValueByKey:@"reservedcount"];
                myInfo.movieContent.videourl = [movieContentDict analysisStrValueByKey:@"videourl"];
                myInfo.bsort = [blogDict analysisStrValueByKey:@"bsort"];
                myInfo.btype = [blogDict analysisStrValueByKey:@"btype"];
                myInfo.id_ = [blogDict analysisStrValueByKey:@"id"];
                myInfo.praiseusername = [blogDict analysisStrValueByKey:@"praiseusername"];
                myInfo.title = [blogDict analysisStrValueByKey:@"title"];
                myInfo.isreport = [blogDict analysisStrValueByKey:@"isreport"];
                myInfo.user.fuid = [blogDict analysisStrValueByKey:@"id"];
                myInfo.user.photo = [blogDict analysisStrValueByKey:@"photo"];
                myInfo.user.regtime= [blogDict analysisStrValueByKey:@"regtime"];
                myInfo.user.username = [blogDict analysisStrValueByKey:@"username"];
                myInfo.user.utype = [blogDict analysisStrValueByKey:@"utype"];
                myInfo.user.ucity = [blogDict analysisStrValueByKey:@"cityname"];
                
                [_movieLists addObject:myInfo];
            }
            [_movieTable reloadData];

        }else{
            [self.view showAlertText:[@"获取视频列表," stringByAppendingString:(NSString*)requestObj]];
        }
        
        
        _isloadingBlogs = NO;
        [_refreshHeader egoRefreshScrollViewDataSourceDidFinishedLoading:_movieTable];
        [_loadMoreFooter egoRefreshScrollViewDataSourceDidFinishedLoading:_movieTable];
        
    } onError:^(NSString *errorStr) {
        _isloadingBlogs = NO;
        [_refreshHeader egoRefreshScrollViewDataSourceDidFinishedLoading:_movieTable];
        [_loadMoreFooter egoRefreshScrollViewDataSourceDidFinishedLoading:_movieTable];
        [self.view showAlertText:[@"获取视频列表," stringByAppendingString:(NSString*)errorStr]];

    }];


    
}



@end
