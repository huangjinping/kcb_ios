//
//  ChatBlogsViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-16.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "ChatBlogsViewController.h"



@interface ChatBlogsViewController ()

@end

@implementation ChatBlogsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark- 长按手势操作
- (void)lableLongPress{
    
    NSLog(@"长按点击");
    
}
#pragma mark- 消息列表 Delegate and DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //if ([_blogs count]) {
        //return 4;
    //}else{
        return [_blogs count];
    //}
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([_cellHeightArray count] > 0) {
        return [[_cellHeightArray objectAtIndex:indexPath.row] floatValue];
    }
    return 0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = CELL_ID_CHAT;
    _cellHeight = 0;
    float bi = APP_WIDTH/320;
    _zanLableHeight = 0;
    ChatBlogsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ChatBlogsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate_ = self;
//        cell.attention.selected = NO;
    }
    [cell.zanB setTitle:@"赞" forState:UIControlStateNormal];
    [cell.zanB setTitle:@"已赞" forState:UIControlStateSelected];
    [cell.pinglunB setTitle:@"评论" forState:UIControlStateNormal];
    [cell.pinglunB setTitle:@"评论" forState:UIControlStateSelected];

    cell.photoBtn.tag = 2000+indexPath.row;
    [cell.photoBtn addTarget:self action:@selector(photoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.attention.hidden = YES;
//    有bug
    if (cell.xianBtn.selected) {
        cell.xianBtn.selected = NO;
    }
    if ([_cellHeightArray count] > 0) {
        
        cell.cellBgImageView.frame = CGRectMake(10, 4, APP_WIDTH-20, [[_cellHeightArray objectAtIndex:indexPath.row] floatValue]-8);
    }
    [cell.zanB addTarget:self action:@selector(blogZan:) forControlEvents:UIControlEventTouchUpInside];
    [cell.pinglunB addTarget:self action:@selector(blogPinglun:) forControlEvents:UIControlEventTouchUpInside];
    cell.reportB.tag = indexPath.row;
    [cell.reportB addTarget:self action:@selector(blogReport:) forControlEvents:UIControlEventTouchUpInside];
    [cell.attention addTarget:self action:@selector(blogAttention:) forControlEvents:UIControlEventTouchUpInside];
    cell.attention.tag = indexPath.row;
    cell.xianBtn.hidden = YES;
    ChatBlog *blog = [_blogs objectAtIndex:indexPath.row];
    NSArray *imgArray = [blog.blogcontent.imgurl componentsSeparatedByString:@","];
    //发博文用户头像

    if ([blog.user.photo length] > 0 ) {
        [self photoWithImageView:cell.photo imgUrl:blog.user.photo imgArrayCount:0];
    }
    else{
        
        [cell.photo setImage:[UIImage imageNamed:@"chat_portrait_photo.png"]];
    }
    //发博文用户名
    cell.userNameLable.text = blog.user.username;
    CGFloat width = [self getStringHeight:blog.user.username isContent:YES].width;
    cell.userNameLable.frame = CGRectMake(70, 10, width, 20);
    if ([blog.user.username isEqualToString:APP_DELEGATE.userName]) {
        cell.attention.hidden = YES;
    }
    else{
        cell.attention.hidden = NO;
        for (NSString *friendStr in _myFriends) {
            if ([friendStr isEqualToString:blog.user.fuid]) {
                cell.attention.selected = YES;
                break;
            }
            else{
                cell.attention.selected = NO;
            }
        }
    }
    //发表时间
    cell.addTimeLable.text = [blog.addtime convertBlogAddDate];
    cell.cityLable.text = blog.user.ucity;

    //博文内容
    if ([blog.user.username isEqualToString:APP_DELEGATE.userName]) {
        cell.deleteBtn.hidden = NO;
        cell.deleteBtn.tag = [blog.id_ integerValue];
        [cell.deleteBtn addTarget:self action:@selector(deleteClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        cell.deleteBtn.hidden = YES;
    }
    NSString *str = [NSString stringWithString:blog.blogcontent.content];
//    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if ([[[UIDevice currentDevice]systemVersion]floatValue] > 7.0 ) {
        cell.blogsContentsLable.lineBreakMode = NSLineBreakByCharWrapping;
    }
    cell.blogsContentsLable.lineBreakMode = NSLineBreakByCharWrapping;

    
//    NSMutableString *subString = [NSMutableString string];
    CGSize size;
    if ([str length] > 150) {
        cell.xianBtn.hidden = NO;
    }
    if ([blog.blogcontent.currentShowContent length] >150) {
        cell.xianBtn.selected = YES;
    }
    size = [self getStringHeight:blog.blogcontent.currentShowContent isContent:YES];
    size = CGSizeMake(size.width, size.height + 5);
    
    cell.blogsContentsLable.frame = CGRectMake(10, 60, 280*bi, size.height);
//    blog.blogcontent.currentShowContent = [blog.blogcontent.currentShowContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    cell.blogsContentsLable.text = blog.blogcontent.currentShowContent;
    cell.blogsContentsLable.lineLableDelegate = self;
    cell.blogsContentsLable.copyableLabelDelegate = self;
    cell.blogsContentsLable.numberOfLines = 0;
    //关联博文内容与label
    cell.blogsContentsLable.blogIndex = indexPath.row;
    
    
    
    
    
    cell.blogsContentsLable.tag = 6000+indexPath.row;
//    cell.blogsContentsLable.backgroundColor = [UIColor greenColor];
    cell.blogsContentsLable.font = [UIFont systemFontOfSize:15];
    if ([str length] > 150) {
        cell.xianBtn.frame = CGRectMake(225*bi,cell.blogsContentsLable.bottom, 60, 20);
        cell.xianBtn.tag = 7000+indexPath.row;
        [cell.xianBtn addTarget:self action:@selector(xianBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

        size = CGSizeMake(size.width, size.height+20);
    }
    
    [self highlightLinksWithIndex:NSNotFound withLable:cell.blogsContentsLable andBlogIndex:indexPath.row];


//    cell.blogsContentsLable.text = str;
//    NSInteger contentsLength = [str length];
//    if (contentsLength > 150) {
//        
//        NSMutableString *str1 = [NSMutableString stringWithString:cell.blogsContentsLable.text];
//    }
//    else{
//        size = [self getStringHeight:cell.blogsContentsLable.text isContent:YES];
    
//    }
//    cell.blogsContentsLable.frame = CGRectMake(5, 60, APP_WIDTH-30, size.height);
    
    //该条博文被赞用户
    NSArray *zanArr = [blog.praiseusername componentsSeparatedByString:@","];
    NSMutableArray *array2 = [NSMutableArray arrayWithArray:zanArr];
    NSMutableString *string1 = [NSMutableString string];
    for (NSString *str in zanArr) {
        if ([str isEqualToString:@""]) {
            [array2 removeObject:str];
        }
    }
    
        if ([array2 count] > 0) {
            NSArray *array1 = [self arrayWithUserString:array2];
            NSMutableString *zanUserString = [NSMutableString string];
            if ([array1 count] <= 5) {
                zanUserString = [NSMutableString stringWithString:[array1 componentsJoinedByString:@","]];
                string1 = [NSMutableString stringWithFormat:@"%@觉得很赞", zanUserString];
            }
            else{
                NSMutableArray *stringArray1 = [NSMutableArray arrayWithCapacity:0];
                for (int i = 0 ; i < 5 ; i++) {
                    NSString *string = [array1 objectAtIndex:i];
                    [stringArray1 addObject:string];
                }
                zanUserString = [NSMutableString stringWithString:[stringArray1 componentsJoinedByString:@","]];
                string1 = [NSMutableString stringWithFormat:@"%@等觉得很赞", zanUserString];
            }
            cell.zanB.selected = YES;
        }
        else{
            string1 = [NSMutableString stringWithFormat:@"动动手赞一个吧"];
            cell.zanB.selected = NO;
        }
    cell.zanCountLable.text = string1;
    _zanLableHeight = [self getStringHeight:cell.zanCountLable.text isContent:NO].height;
    //使用设备
    cell.modelLable.text = blog.blogcontent.model;
    CGFloat modelWidth = [self getStringHeight:blog.blogcontent.model isContent:NO].width;
    //博文图片
    cell.blogsImage1.hidden = YES;
    cell.blogsImage2.hidden = YES;
    cell.blogsImage3.hidden = YES;
    if ([blog.blogcontent.content length] > 150) {
        if ([blog.blogcontent.imgurl length] != 0) {
            [self cellWithImage1:cell.blogsImage1 Image2:cell.blogsImage2 Image3:cell.blogsImage3 imgArray:imgArray height:size.height];
            cell.modelLable.frame = CGRectMake(25, cell.blogsImage1.bottom, modelWidth, 25);
            cell.modleImage.frame = CGRectMake(10, cell.blogsImage1.bottom+5, 15, 15);
            cell.cityLable.frame = CGRectMake(modelWidth+20, cell.blogsImage1.bottom, 50, 25);
        }
        else{
            cell.modelLable.frame = CGRectMake(25, cell.blogsContentsLable.bottom+20, modelWidth, 25);
            cell.modleImage.frame = CGRectMake(10, cell.blogsContentsLable.bottom+25, 15, 15);
            cell.cityLable.frame = CGRectMake(modelWidth+20, cell.blogsContentsLable.bottom+20, 50, 25);
        }
    }
    else{
        if ([blog.blogcontent.imgurl length] != 0) {
            [self cellWithImage1:cell.blogsImage1 Image2:cell.blogsImage2 Image3:cell.blogsImage3 imgArray:imgArray height:size.height];
            cell.modelLable.frame = CGRectMake(25, cell.blogsImage1.bottom, modelWidth, 25);
            cell.modleImage.frame = CGRectMake(10, cell.blogsImage1.bottom+5, 15, 15);
            cell.cityLable.frame = CGRectMake(modelWidth+20, cell.blogsImage1.bottom, 50, 25);
        }
        else{
            cell.modelLable.frame = CGRectMake(25, cell.blogsContentsLable.bottom, modelWidth, 25);
            cell.modleImage.frame = CGRectMake(10, cell.blogsContentsLable.bottom+5, 15, 15);
            cell.cityLable.frame = CGRectMake(modelWidth+20, cell.blogsContentsLable.bottom, 50, 25);
        }
    }
    cell.bgView.frame = CGRectMake(0, cell.modelLable.bottom+5, APP_WIDTH-20, 30);
    cell.reportB.frame = CGRectMake(5+(APP_WIDTH-30)/5*2, 0, (APP_WIDTH-30)/5, 30);
    cell.zanB.frame = CGRectMake(5+(APP_WIDTH-30)/5*3, 0, (APP_WIDTH-30)/5, 30);
    cell.pinglunB.frame = CGRectMake(5+(APP_WIDTH-30)/5*4, 0, (APP_WIDTH-30)/5, 30);
    cell.lineView.frame = CGRectMake(0, cell.bgView.bottom, APP_WIDTH-20, 0.5);
    cell.zanCountLable.frame = CGRectMake(25, cell.bgView.bottom+5.5, APP_WIDTH-55, _zanLableHeight);
    cell.zanCountImage.frame = CGRectMake(10, cell.bgView.bottom+5.5+(_zanLableHeight-13)/2, 13, 13);

//    [cell.zhuanImgView setImage:[UIImage imageNamed:@"zhuanfa.png"]];
    //当前用户是否已赞此博文
    
    if ([blog.praiseusername rangeOfString:APP_DELEGATE.userName].location != NSNotFound) {
        cell.zanB.selected = YES;
    }else{
        cell.zanB.selected = NO;
    }
    [self photoWithImageView:cell.zanImgView btnState:cell.zanB.selected];
    //攒button tag为此条博文的id
    cell.zanB.tag = [blog.id_ integerValue];
    cell.pinglunB.tag = [blog.id_ integerValue];
    //评论按钮显示图
    //暂时设置为 已选中图
    [cell.pingImgView setImage:[UIImage imageNamed:@"chat_pinglun_selected.png"]];
    [_myCommentArray removeAllObjects];
    
    for (ChatComment *myComment in _comments) {
        if ([myComment.bid isEqualToString:blog.id_]) {
            [_myCommentArray addObject:myComment];
        }
    }
    if ([_myCommentArray count] > 0 ) {
        cell.lineZanView.hidden = NO;
        if ([blog.blogcontent.imgurl length] != 0) {
//            cell.lineZanView.frame = CGRectMake(0, 255.5+size.height, APP_WIDTH-20, 0.5);
            cell.lineZanView.frame = CGRectMake(0, cell.zanCountLable.bottom+5, APP_WIDTH-20, 0.5);
            _cellHeight = cell.lineZanView.bottom;
        }else{
//            cell.lineZanView.frame = CGRectMake(0, 165.5+size.height, APP_WIDTH-20, 0.5);
            cell.lineZanView.frame = CGRectMake(0, cell.zanCountLable.bottom+5, APP_WIDTH-20, 0.5);
            _cellHeight = cell.lineZanView.bottom;
        }

    }
    else{
        cell.lineZanView.hidden = YES;
        if ([blog.blogcontent.imgurl length] != 0) {
            _cellHeight = cell.zanCountLable.bottom;
        }else{
            _cellHeight = cell.zanCountLable.bottom;
        }

    }
        if (cell.contentView != nil) {
            for (int i = 0 ; i < 999; i++) {
                UIView *view = [cell.contentView viewWithTag:9000+i];
                [view removeFromSuperview];
            }
        }
    
    
    for (int i = 0 ;i< [_comments count];i++) {
        ChatComment *pingComment = [_comments objectAtIndex:i];
        _pLable = [[pingLable alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _pLable.delegate = self;
        if ([[[UIDevice currentDevice]systemVersion]floatValue] > 7.0 ) {
            _pLable.lineBreakMode = NSLineBreakByCharWrapping;
        }

        _pLable.font = [UIFont systemFontOfSize:13];
//        _pLable.backgroundColor = [UIColor colorWithRed:arc4random()*39%255/255.0 green:arc4random()*79%255/255.0 blue:arc4random()*99%255/255.0 alpha:1.0];
        _pLable.blogID = pingComment.bid;
        _pLable.Peplyuid = pingComment.commentuser_id;
        _pLable.pingID = pingComment.id_;
        _pLable.tag = 9000+i;
        if ([pingComment.bid isEqualToString:blog.id_]) {
            
            NSMutableString *commentStr = [NSMutableString string];
            if ([pingComment.peplyuser_id intValue] > 0) {
                NSMutableString *str = [NSMutableString stringWithFormat:@"%@回复%@: %@",pingComment.commentuser_username,pingComment.peplyuser_username,pingComment.content];
//                commentStr = [NSMutableString stringWithString:[str stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
                commentStr = [NSMutableString stringWithString:str];
            }
            else{
    
                NSMutableString *str = [NSMutableString stringWithFormat:@"%@:%@",pingComment.commentuser_username,pingComment.content];
//                commentStr = [NSMutableString stringWithString:[str stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
                commentStr = [NSMutableString stringWithString:str];

            }
            CGSize size;
            size = [self getStringHeight:commentStr isContent:NO];
            
            
            
            _pLable.frame =  CGRectMake(5, _cellHeight+5, APP_WIDTH-30, size.height);
            NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]init];
            if ([[[UIDevice currentDevice] systemVersion]floatValue] < 6.0) {
                _pLable.text = commentStr;
            }
            else{
                attrString = [[NSMutableAttributedString alloc]initWithString:commentStr];
                [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:56/255.0 green:75/255.0 blue:125/255.0 alpha:1] range:[commentStr rangeOfString:pingComment.commentuser_username]];
                [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:56/255.0 green:75/255.0 blue:125/255.0 alpha:1] range:[commentStr rangeOfString:pingComment.peplyuser_username]];
                _pLable.attributedText = attrString;
                _pLable.lineBreakMode = UILineBreakModeCharacterWrap;
            }
            
            _cellHeight = _cellHeight+size.height+5;
            [cell.cellBgImageView addSubview:_pLable];
        }
    }

    return cell;
}


- (NSString *)stringToCopyForCopyableLabel:(CopyLineLable *)copyableLabel{
    NSString *stringToCopy = @"";
    if ([copyableLabel isKindOfClass:[CopyLineLable class]]) {
        stringToCopy = [NSString stringWithFormat:@"%@",copyableLabel.text];
    }
    return stringToCopy;
}

- (CGRect)copyMenuTargetRectInCopyableLabelCoordinates:(CopyLineLable *)copyableLabel{
    CGRect rect;
    if ([copyableLabel isKindOfClass:[CopyLineLable class]]) {
        rect = copyableLabel.bounds;
    }
    return rect;
}

- (void)label:(CopyLineLable *)label didBeginTouch:(UITouch *)touch onCharacterAtIndex:(CFIndex)charIndex withBlogIndex:(NSInteger)blogIndex{
    [self highlightLinksWithIndex:charIndex withLable:label andBlogIndex:blogIndex];
}

- (void)label:(CopyLineLable *)label didMoveTouch:(UITouch *)touch onCharacterAtIndex:(CFIndex)charIndex  withBlogIndex:(NSInteger)blogIndex{
    
    [self highlightLinksWithIndex:charIndex withLable:label andBlogIndex:blogIndex];
}

- (void)label:(CopyLineLable *)label didEndTouch:(UITouch *)touch onCharacterAtIndex:(CFIndex)charIndex  withBlogIndex:(NSInteger)blogIndex{
    
    [self highlightLinksWithIndex:NSNotFound withLable:label andBlogIndex:blogIndex];
        ChatBlog *blog = [_blogs objectAtIndex:blogIndex];

        for (LinkMessage *linkMess in blog.blogcontent.linkMessArr) {
            
            NSRange matchRange = [linkMess range];
            
            if ([self isIndex:charIndex inRange:matchRange]) {
                
                
                NSError *error = NULL;
                NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
                NSArray *matches = [detector matchesInString:linkMess.urlString options:0 range:NSMakeRange(0, linkMess.urlString.length)];
                if ([matches count] > 0) {
                    NSTextCheckingResult *match = [matches objectAtIndex:0];
                    CommonWebViewController *cwVC = [[CommonWebViewController alloc] init];
                    cwVC.url = match.URL;
                    [self.navigationController pushViewController:cwVC animated:YES];
                }
                
                break;
            }
        }
}

- (void)label:(CopyLineLable *)label didCancelTouch:(UITouch *)touch  withBlogIndex:(NSInteger)blogIndex{
    
    [self highlightLinksWithIndex:NSNotFound withLable:label andBlogIndex:blogIndex];
}

- (BOOL)isIndex:(CFIndex)index inRange:(NSRange)range {
    return index > range.location && index < range.location+range.length;
}

- (void)highlightLinksWithIndex:(CFIndex)index withLable:(CopyLineLable *)lineCoLable andBlogIndex:(NSInteger)blogIndex{
    
    NSMutableAttributedString* attributedString = [lineCoLable.attributedText mutableCopy];
    ChatBlog *blog = [_blogs objectAtIndex:blogIndex];
    for (LinkMessage *linkMess in blog.blogcontent.linkMessArr) {
        
        
            NSRange matchRange = [linkMess range];
            
            if ([self isIndex:index inRange:matchRange]) {
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:matchRange];
            }
            else {
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:56/255.0 green:75/255.0 blue:125/255.0 alpha:1] range:matchRange];
            }
            
            [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:matchRange];
    }
    lineCoLable.attributedText = attributedString;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    BlogsDetailsViewController *bdv = [[BlogsDetailsViewController alloc]init];
//    ChatBlog *blog = [_blogs objectAtIndex:indexPath.row];
//    bdv.myBlogs = blog;
//    bdv.myCommentsArray = _comments;
//    [self.navigationController pushViewController:bdv animated:YES];
    
}
#pragma mark- Lable自适应 博文内容字体
- (CGSize)getStringHeight:(NSString *)aString isContent:(BOOL)content{
    
    CGSize size;
        if (content) {
            UIFont *nameFont = [UIFont systemFontOfSize:15];
            size=[aString sizeWithFont:nameFont constrainedToSize:CGSizeMake(APP_WIDTH-30, 1000) lineBreakMode:NSLineBreakByCharWrapping];
        }
        else{
            UIFont *nameFont = [UIFont systemFontOfSize:13];
            size=[aString sizeWithFont:nameFont constrainedToSize:CGSizeMake(275, 400) lineBreakMode:NSLineBreakByCharWrapping];
        }

    
    
    return size;
}
- (void)photoWithImageView:(UIImageView *)myImag btnState:(BOOL)state{
    if (state) {
        [myImag setImage:[UIImage imageNamed:@"chat_zan_selected.png"]];
        
    }
    else{
        [myImag setImage:[UIImage imageNamed:@"chat_zan.png"]];
    }
}


#pragma mark- 消息刷新与加载更多 Delegate
- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView *)view{
    if (_isloadingBlogs) {
        return;
    }
    ChatBlog *blog = [_blogs lastObject];
    [self netGetAllBlogsWithIndexid:blog.id_ loadNew:NO bsort:self.bsort];
}

- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView *)view{
    return NO;
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view{
    if (_isloadingBlogs) {
        return;
    }

    [self netGetAllBlogsWithIndexid:nil loadNew:YES bsort:self.bsort];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view{
    return NO;
}

#pragma mark- scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentSize.height > _blogTableView.height) {
        [_loadMoreFooter setFrame:CGRectMake(0, scrollView.contentSize.height, _blogTableView.width, _blogTableView.height)];
    }else{
        [_loadMoreFooter setFrame:CGRectMake(0, scrollView.height, _blogTableView.width, _blogTableView.height)];
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

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (void)loadView_{
    
    //消息列表
    _blogTableView = [[UITableView alloc] initWithFrame:CGRectMake(APP_X, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    [_blogTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_blogTableView setDelegate:self];
    [_blogTableView setDataSource:self];
    _blogTableView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    [self.view addSubview:_blogTableView];
//    if ([_blogTableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [_blogTableView setSeparatorInset:UIEdgeInsetsZero];
//    }
    //刷新
    _refreshHeader = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, - _blogTableView.height, _blogTableView.width, _blogTableView.height)];
    _refreshHeader.delegate = self;
    [_blogTableView addSubview:_refreshHeader];
    //加载更多
    _loadMoreFooter = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0, _blogTableView.height, _blogTableView.width, _blogTableView.height)];
    _loadMoreFooter.delegate = self;
    [_blogTableView addSubview:_loadMoreFooter];
}

#pragma mark- system
- (void)viewDidLoad
{
    [super viewDidLoad];
    
 //   [self.tabBarController hiddenCustomTabBar:YES];
    [self loadView_];
    _comments = [[NSMutableArray alloc] initWithCapacity:0];
    _blogs = [[NSMutableArray alloc] initWithCapacity:0];
    _cellHeightArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    _myCommentArray = [NSMutableArray arrayWithCapacity:0];
    _beforeCommentsArray = [NSMutableArray arrayWithCapacity:0];
    _myFriends = [NSMutableArray arrayWithCapacity:0];
    
    _backFromAddBlog = NO;
    _isloadingBlogs = NO;
    
    //修改，去掉分类功能
    self.bsort = nil;

    [self netGetAllBlogsWithIndexid:nil loadNew:YES bsort:self.bsort];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_blogTableView setDelegate:nil];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [_blogTableView setDelegate:self];
    
    
    if (self.friendName) {
        [self setCustomNavigationTitle:self.friendName];

    }else{
        [self setCustomNavigationTitle:self.titleName];

    }
    
    //发布博文按钮
    UIButton *writeBlogButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [writeBlogButton setFrame:CGRectMake(APP_WIDTH - 50, (_navigationImgView.height - 30)/2, 30, 30)];
    [writeBlogButton setImage:[UIImage imageNamed:@"chat_write_blog_logo"] forState:UIControlStateNormal];
    [writeBlogButton addTarget:self action:@selector(writeBlog:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationImgView addSubview:writeBlogButton];
    
    if (self.bsort == nil) {
        writeBlogButton.hidden = YES;
    }
    if(_backFromAddBlog){
        _backFromAddBlog = NO;
        [self netGetAllBlogsWithIndexid:nil loadNew:YES bsort:self.bsort];
    }
}
#pragma mark- 从字符串中解出用户
- (NSMutableArray *)arrayWithUserString:(NSArray *)pUserArray{
    NSMutableArray *array1 = [NSMutableArray arrayWithCapacity:0];
    for (NSString *userString in pUserArray) {
        NSInteger lent = [userString length];
        if (lent > 2) {
            NSMutableString *string = [NSMutableString stringWithString:[userString substringWithRange:NSMakeRange(1, lent-2)]];
            [array1 addObject:string];
        }
    }
    return array1;
}


#pragma mark- 根据博文。评论数组返回cell高度数组
- (NSArray *)arrayWithChatCommentArray:(NSArray *)commentArray blog:(NSArray *)blogArray{
    NSMutableArray *heightArray = [NSMutableArray arrayWithCapacity:0];
    for (ChatBlog *blog in blogArray) {
        float testHeight = 0.0;
        _zanLableHeight = 0.0;
        NSArray *zanArr = [blog.praiseusername componentsSeparatedByString:@","];
        NSMutableString *string1 = [NSMutableString string];
        if ([zanArr count] > 0) {
            NSString *zanUserString = [[self arrayWithUserString:zanArr] componentsJoinedByString:@","];
            string1 = [NSMutableString stringWithFormat:@"%@等%d人觉得很赞", zanUserString,(int)[zanArr count]];
        }else{
            string1 = [NSMutableString stringWithFormat:@"动动手赞一个吧"];
        }
        _zanLableHeight = [self getStringHeight:string1 isContent:NO].height;
        
        if ([blog.blogcontent.content length] > 150) {
            if ([blog.blogcontent.imgurl length] != 0) {
                testHeight = 251+blog.lableHeight+_zanLableHeight;
            }else{
                testHeight = 161+blog.lableHeight+_zanLableHeight;
            }
        }
        else{
            if ([blog.blogcontent.imgurl length] != 0) {
                testHeight = 231+blog.lableHeight+_zanLableHeight;
            }else{
                testHeight = 141+blog.lableHeight+_zanLableHeight;
            }
        }
        for (ChatComment *chatComment in commentArray) {
            CGFloat height;
            if ([chatComment.bid isEqualToString:blog.id_]) {
                if (chatComment.peplyuser_id) {
                    height = [self getStringHeight:[NSString stringWithFormat:@"%@回复:%@ %@",chatComment.peplyuser_username,chatComment.commentuser_username,chatComment.content] isContent:NO].height;
                    testHeight = testHeight+height+5;
                }
                else
                {
                    height = [self getStringHeight:chatComment.content isContent:NO].height;
                    testHeight = testHeight+height+5;
                }
            }
        }
        testHeight = testHeight+5;
        [heightArray addObject:[NSString stringWithFormat:@"%f",testHeight]];
    }
    return heightArray;
}

- (void)cellWithImage1:(ChatImageView *)img1 Image2:(ChatImageView *)img2 Image3:(ChatImageView *)img3 imgArray:(NSArray *)imgArray height:(CGFloat)height{
    if ([imgArray count] == 0) {
        img1.hidden = YES;
        img2.hidden = YES;
        img3.hidden = YES;
    }
    else if ([imgArray count] == 1) {
        img1.hidden = NO;
        img1.frame = CGRectMake(5, 60+height, APP_WIDTH-20-10, 90);
        
        [self photoWithImageView:img1 imgUrl:[imgArray objectAtIndex:0] imgArrayCount:1];
        img2.hidden = YES;
        img3.hidden = YES;
    }
    else if ([imgArray count] == 2){
        img1.hidden = NO;
        img1.frame = CGRectMake(5, 60+height, (APP_WIDTH-20-10-5)/2, 90);
        [self photoWithImageView:img1 imgUrl:[imgArray objectAtIndex:0]imgArrayCount:2];
        img2.hidden = NO;
        img2.frame = CGRectMake(5+(APP_WIDTH-20-10-5)/2+5, 60+height, (APP_WIDTH-20-10-5)/2, 90);
        [self photoWithImageView:img2 imgUrl:[imgArray objectAtIndex:1]imgArrayCount:2];
        
        img3.hidden = YES;
    }
    else{
        img1.hidden = NO;
        img2.hidden = NO;
        img3.hidden = NO;
        img1.frame = CGRectMake(5, 60+height, (APP_WIDTH-20-10-10)/3, 90);
        [self photoWithImageView:img1 imgUrl:[imgArray objectAtIndex:0]imgArrayCount:3];
        
        img2.frame = CGRectMake(5+(APP_WIDTH-20-10-10)/3+5, 60+height, (APP_WIDTH-20-10-10)/3, 90);
        [self photoWithImageView:img2 imgUrl:[imgArray objectAtIndex:1]imgArrayCount:3];
        
        img3.frame = CGRectMake(5+(APP_WIDTH-20-10-10)/3*2+10, 60+height, (APP_WIDTH-20-10-10)/3, 90);
        [self photoWithImageView:img3 imgUrl:[imgArray objectAtIndex:2]imgArrayCount:3];
        
    }

}
- (void)photoWithImageView:(UIImageView *)imageView imgUrl:(NSString *)imgUrl imgArrayCount:(NSInteger)count{
    __block UIImageView *imgView = imageView;
    UIImage *placeholderImg = [[UIImage alloc]init];
    if (count == 0) {
        placeholderImg = [UIImage imageNamed:@"chat_portrait_photo.png"];
    }
    else if (count == 1) {
        placeholderImg = [UIImage imageNamed:@"bg_placeholder_img280*90.gif"];
    }
    else if (count == 2){
        placeholderImg = [UIImage imageNamed:@"bg_placeholder_img140*90.gif"];
    }
    else{
        placeholderImg = [UIImage imageNamed:@"bg_placeholder_img94*90.gif"];
    }
    
    [imageView setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:placeholderImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        [UIHelper createThumbImage:image size:imgView.frame.size percent:1 onCompletion:^(NSData *imgData) {
            
            [imgView setImage:[UIImage imageWithData:imgData]];
            
        }];
        
    }];

}
#pragma mark- alertDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if ([alertView.message isEqualToString:@"确认删除这条博文吗"]) {
        if (buttonIndex == 0) {
        }
        else{
            [self netDeleteBlogs:[NSString stringWithFormat:@"%d",(int)alertView.tag]];
        }
        [_deleteAlertView removeFromSuperview];

    }
    else if([alertView.message isEqualToString:@"是否删除这条信息"]) {
        
        if (buttonIndex == 0) {
        }
        else{
            [self netDeleteComment:[NSString stringWithFormat:@"%d",(int)alertView.tag]];
        }
        
        [_deletePingAlertView removeFromSuperview];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView.message rangeOfString:@"举报"].location != NSNotFound) {
        if (buttonIndex == alertView.cancelButtonIndex) {
            
        }else{
            ChatBlog *blog = [_blogs objectAtIndex:alertView.tag];
            [self netJUBao:blog.id_];
        }
    }
}

#pragma mark- button action

- (void)photoBtnClicked:(UIButton *)myBtn{
    
    NSInteger index = myBtn.tag-2000;
    ChatBlog *blog = [_blogs objectAtIndex:index];
    
//    NSLog(@"头像点击  row = %d",myBtn.tag-2000);
    ChatBlogsViewController *chatBlogsVC = [[ChatBlogsViewController alloc] init];
    chatBlogsVC.friendName = blog.user.username;
    [self.navigationController pushViewController:chatBlogsVC animated:YES];
}

- (void)xianBtnClicked:(UIButton *)xianBtn{
    NSInteger row = xianBtn.tag-7000;
    UILabel *myLable = (UILabel*)[self.view viewWithTag:row+6000];
    if (xianBtn.selected) {
        
        myLable.text = @"";
        ChatBlog *blog = [_blogs objectAtIndex:row];
        NSString *str = [NSString stringWithString:blog.blogcontent.content];
//        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSString *subString = [str substringToIndex:150];
        CGFloat height = [self getStringHeight:subString isContent:YES].height;
        blog.lableHeight = height;
        blog.blogcontent.currentShowContent = subString;
        myLable.frame = CGRectMake(5, 60, 290, height);
        myLable.text = subString;
    }
    else{
        UILabel *myLable = (UILabel*)[self.view viewWithTag:row+6000];
        ChatBlog *blog = [_blogs objectAtIndex:row];
        NSString *str = [NSString stringWithString:blog.blogcontent.content];
//        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        CGFloat height = [self getStringHeight:str isContent:YES].height;
        blog.lableHeight = height;
        blog.blogcontent.currentShowContent = blog.blogcontent.content;
        myLable.frame = CGRectMake(5, 60, 290, height);
        myLable.text = @"";
        myLable.text = str;
//        if ([[[UIDevice currentDevice] systemVersion]floatValue] > 7.0) {
//            xianBtn.frame = CGRectMake(225,myLable.frame.size.height+40, 60, 20);
//        }
//        else{
//            xianBtn.frame = CGRectMake(225,myLable.frame.size.height+60, 60, 20);
//        }
    }
    xianBtn.frame = CGRectMake(225,myLable.frame.size.height+60, 60, 20);
    _cellHeightArray = [NSMutableArray arrayWithArray:[self arrayWithChatCommentArray:_comments blog:_blogs]];
    xianBtn.selected = !xianBtn.selected;
    [_blogTableView reloadData];
}

- (void)blogReport:(UIButton *)button{
    //ENTLog(@"举报");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"是否确认举报该贴" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag = button.tag;
    [alert show];
}

- (void)blogZan:(UIButton*)button{
    button.selected = !button.selected;
    [self netZanByUsername:APP_DELEGATE.userName andBlogId:[NSString stringWithFormat:@"%d",(int)button.tag]];
}

- (void)deleteClicked:(UIButton *)myBtn{
    _deleteAlertView = [[UIAlertView alloc]initWithTitle:@"" message:@"确认删除这条博文吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    _deleteAlertView.frame = CGRectMake(20, 0, APP_WIDTH-40, 200);
    _deleteAlertView.tag = myBtn.tag;    
    _deleteAlertView.alertViewStyle = UIAlertActionStyleDefault;
    [_deleteAlertView show];
}

- (void)blogPinglun:(UIButton*)button{
    
    _pingTextView = [[YFInputBar alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY([UIScreen mainScreen].bounds), APP_WIDTH, 44)];
    
    _pingTextView.tagCount = (int)button.tag;
    _pingTextView.pingOrHui = YES;
    _pingTextView.isCarH = NO;
    _pingTextView.isMovie = NO;
    _pingTextView.delegate = self;
    _pingTextView.clearInputWhenSend = YES;
    _pingTextView.resignFirstResponderWhenSend = YES;
    [_pingTextView.textView becomeFirstResponder];
    [self.view addSubview:_pingTextView];

}
//关注方法
- (void)blogAttention:(UIButton *)myAttention{
    ChatBlog *blog = [_blogs objectAtIndex:myAttention.tag];
    if (myAttention.selected) {//取消关注
//        ENTLog(@"%@", blog.user.feiendid);
//        [self netRemoveFriend:blog.user.feiendid];
        return;
    }else{//关注
        [self netAddFriendByFuid:blog.user.fuid];
    }
    
    
}
- (void)writeBlog:(UIButton*)button{
    
    _backFromAddBlog = YES;
    CYHDSendTopicViewController *writeBlogVC = [[CYHDSendTopicViewController alloc] init];
    writeBlogVC.isHu = NO;
    writeBlogVC.navTitleStr = _titleName;
    if (self.bsort) {
        writeBlogVC.bsort = self.bsort;
    }else{
        writeBlogVC.bsort = @"0";
    }
    
    [self.navigationController pushViewController:writeBlogVC animated:YES];
}


- (void)chatBlogCell:(ChatBlogsCell *)cell clickedChatImage:(ChatImageView *)imgView
{
    
    NSIndexPath *indexPath = [_blogTableView indexPathForCell:cell];
    ChatBlog *blog = [_blogs objectAtIndex:indexPath.row];
    NSArray *imgArray = [blog.blogcontent.imgurl componentsSeparatedByString:@","];
    
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    for (NSString *urlString in imgArray) {
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:urlString]];
        photo.caption = @"博文图片";
        [photos addObject:photo];
    }
    
    self.photos = photos;
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    [self.navigationController pushViewController:browser animated:YES];
}




-(void)inputBar:(YFInputBar *)inputBar  withInputString:(NSString *)str
{
    if (inputBar.pingOrHui) {
        [self netPingByUsername:APP_DELEGATE.userName andBlogId:[NSString stringWithFormat:@"%d",inputBar.tagCount] andContent:str];
    }
    else{
        [self netHuiByUsername:APP_DELEGATE.userName andBlogId:[NSString stringWithFormat:@"%d",inputBar.tagCount] andPeplyuid:inputBar.peplyuid andContent:str];
    }
    
    inputBar.frame = CGRectMake(0, self.view.frame.size.height, APP_WIDTH, 44);
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [((UIView*)obj) resignFirstResponder];
    }];
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[YFInputBar class]]) {
            [view resignFirstResponder];
        }
    }
//    if ([_pLable isFirstResponder]) {
//        for (UIView *view in self.view.subviews) {
//            if ([view isKindOfClass:[UITableView class]]) {
//                [view resignFirstResponder];
//            }
//        }
//    }
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    
}
- (void)pingLableClicked:(pingLable *)myLable{
    
    NSArray *stringArray = [myLable.text componentsSeparatedByString:@":"];
    NSMutableString *userString = [NSMutableString stringWithString:[stringArray objectAtIndex:0]];
    NSInteger length = APP_DELEGATE.userName.length;
    if ([userString length] < length) {        
            _pingTextView = [[YFInputBar alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY([UIScreen mainScreen].bounds), APP_WIDTH, 44)];
            _pingTextView.tagCount = [myLable.blogID intValue];
            _pingTextView.peplyuid = myLable.Peplyuid;
            _pingTextView.pingOrHui = NO;
            _pingTextView.isCarH = NO;
            _pingTextView.isMovie = NO;
            _pingTextView.delegate = self;
            _pingTextView.clearInputWhenSend = YES;
            _pingTextView.resignFirstResponderWhenSend = YES;
            [_pingTextView.textView becomeFirstResponder];
            [self.view addSubview:_pingTextView];

    }
    else{
        NSMutableString *string = [NSMutableString stringWithString:[userString substringWithRange:NSMakeRange(0, length)]];
        if ([string rangeOfString:APP_DELEGATE.userName].location != NSNotFound) {
            _deletePingAlertView = [[UIAlertView alloc]initWithTitle:@"" message:@"是否删除这条信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            _deletePingAlertView.tag = [myLable.pingID integerValue];
            _deletePingAlertView.alertViewStyle = UIAlertActionStyleDefault;
            [_deletePingAlertView show];

        }else{
            _pingTextView = [[YFInputBar alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY([UIScreen mainScreen].bounds), APP_WIDTH, 44)];
            _pingTextView.tagCount = [myLable.blogID intValue];
            _pingTextView.peplyuid = myLable.Peplyuid;
            _pingTextView.pingOrHui = NO;
            _pingTextView.isCarH = NO;
            _pingTextView.isMovie = NO;
            _pingTextView.delegate = self;
            _pingTextView.clearInputWhenSend = YES;
            _pingTextView.resignFirstResponderWhenSend = YES;
            [_pingTextView.textView becomeFirstResponder];
            [self.view addSubview:_pingTextView];
        }
    }
}

#pragma mark- 网络请求

//获取博文列表
- (void)netGetAllBlogsWithIndexid:(NSString*)indexId loadNew:(BOOL)loadNew bsort:(NSString*)bsort{
    _isloadingBlogs = YES;
    
    [_cellHeightArray removeAllObjects];
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    if (self.friendName) {
        [bodyDict setObject:self.friendName forKey:@"username"];
    }
    


    [bodyDict setObject:APP_DELEGATE.userName forKey:@"uname"];
    [bodyDict setObject:@"0" forKey:@"isall"];
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

//    _cellTestHeight = 0;
    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"findBlogs.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:isRefresh onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if(result == postSucc){
            
            if ([_myFriends count] > 0) {
                [_myFriends removeAllObjects];
            }
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSDictionary *contents = [resDict analysisDictValueByKey:@"contents"];
            NSDictionary *contentsDict = [resDict objectForKey:@"contents"];
            NSArray *blogs = [contentsDict analysisArrValueByKey:@"blogs"];
            NSArray *friends = [contentsDict analysisArrValueByKey:@"friends"];
            for (NSDictionary *friendsDict in friends) {
                [_myFriends addObject:[[friendsDict analysisDictValueByKey:@"snsuser"] analysisStrValueByKey:@"id"]];
            }
            NSString* isRefresh = (NSString*)callBackObj;
            if ([isRefresh isEqualToString:@"1"]) {
                [_blogs removeAllObjects];
            }
            for (NSDictionary *dict in blogs) {
                ChatBlog *blog = [[ChatBlog alloc] init];
                blog.addtime = [dict analysisStrValueByKey:@"addtime"];
                blog.btype = [dict analysisStrValueByKey:@"btype"];
                blog.id_ = [dict analysisStrValueByKey:@"id"];
                blog.praiseusername = [dict analysisStrValueByKey:@"praiseusername"];
                blog.title = [dict analysisStrValueByKey:@"title"];
                NSDictionary *blogcontentDict = [dict analysisDictValueByKey:@"blogcontent"];
                blog.blogcontent.checkcount = [blogcontentDict analysisStrValueByKey:@"checkcount"];
                NSString *content = [blogcontentDict analysisStrValueByKey:@"content"];
                //过滤并解析博文内容中的博文信息

                
                NSInteger repeat = 0;

                while (1) {
                    
                    NSError *error = NULL;
                    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
                    NSArray *matches = [detector matchesInString:content options:0 range:NSMakeRange(0, content.length)];
                    
                    if ([matches count] == repeat) {
                        blog.blogcontent.content = content;
                        break;
                    }else{
                        NSTextCheckingResult *match = [matches objectAtIndex:repeat];
                         NSString *urlStr = [content substringWithRange:match.range];
                            LinkMessage *linkMess = [[LinkMessage alloc]init];
                        
                            linkMess.urlString = urlStr;

                        ENTLog(@"%@", match.URL);
                        NSString *title = [match.URL webTitle];
                        if ([title isEqualToString:@"0"]) {
                            repeat ++;
                            linkMess.title = urlStr;
                        }else{
                            linkMess.title = title;
                        }
                        
                        NSString *prestr = [content substringToIndex:match.range.location];
                        NSString *tailstr = [content substringFromIndex:match.range.location + match.range.length];
                        content = [[prestr stringByAppendingString:linkMess.title] stringByAppendingString:tailstr];
                        
                            linkMess.range = NSMakeRange(match.range.location, linkMess.title.length);
                            [blog.blogcontent.linkMessArr addObject:linkMess];
                       // }
                    }
                }
                
                
                NSString *str = [NSString stringWithString:blog.blogcontent.content];
                
                
//                str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                
                blog.blogcontent.id_ = [blogcontentDict analysisStrValueByKey:@"id"];
                blog.blogcontent.imgurl = [blogcontentDict analysisStrValueByKey:@"imgurl"];
                blog.blogcontent.reservedcount = [blogcontentDict analysisStrValueByKey:@"reservedcount"];
                blog.blogcontent.videourl = [blogcontentDict analysisStrValueByKey:@"videourl"];
                blog.blogcontent.model = [blogcontentDict analysisStrValueByKey:@"model"];
                NSMutableString *subString = [NSMutableString string];
                if ([str length] > 150) {
                    subString = [NSMutableString stringWithString:[str substringToIndex:150]];
                }
                else{
                    subString = [NSMutableString stringWithString:str];
                }
                blog.blogcontent.currentShowContent = subString;
                blog.lableHeight = [self getStringHeight:subString isContent:YES].height + 5;
                NSDictionary *userDict = [dict analysisDictValueByKey:@"user"];
                blog.user.fuid = [userDict analysisStrValueByKey:@"id"];
                blog.user.photo = [userDict analysisStrValueByKey:@"photo"];
                blog.user.regtime= [userDict analysisStrValueByKey:@"regtime"];
                blog.user.username = [userDict analysisStrValueByKey:@"username"];
                blog.user.utype = [userDict analysisStrValueByKey:@"utype"];
                blog.user.ucity = [userDict analysisStrValueByKey:@"cityname"];
                [_blogs addObject:blog];
            }
            NSArray *comments = [contents analysisArrValueByKey:@"comments"];
           
            if ([isRefresh isEqualToString:@"1"]) {
                [_comments removeAllObjects];
            }
            for (NSDictionary *dict in comments) {
                ChatComment *chatComment = [[ChatComment alloc] init];
                chatComment.addtime = [dict analysisStrValueByKey:@"addtime"];
                chatComment.bid = [dict analysisStrValueByKey:@"bid"];
                chatComment.content = [dict analysisStrValueByKey:@"content"];
                chatComment.id_ = [dict analysisStrValueByKey:@"id"];
                NSDictionary *peplyuserDict = [dict analysisDictValueByKey:@"peplyuser"];
                chatComment.peplyuser_id = [peplyuserDict analysisStrValueByKey:@"id"];
                chatComment.peplyuser_username = [peplyuserDict analysisStrValueByKey:@"username"];
                NSDictionary *commentuserDict = [dict analysisDictValueByKey:@"commentuser"];
                chatComment.commentuser_id = [commentuserDict analysisStrValueByKey:@"id"];
                chatComment.commentuser_username = [commentuserDict objectForKey:@"username"];
                [_comments addObject:chatComment];
            }
            _beforeCommentsArray = [NSMutableArray arrayWithArray:_comments];
            _cellHeightArray = [NSMutableArray arrayWithArray:[self arrayWithChatCommentArray:_comments blog:_blogs]];
            [_blogTableView reloadData];
        }else{
            [self.view showAlertText:[@"获取博文列表," stringByAppendingString:(NSString*)requestObj]];
//            if ([isRefresh isEqualToString:@"1"]) {
//                [self performSelector:@selector(gobackPage) withObject:nil afterDelay:2.0f];
//            }
//            [_blogTableView reloadData];
            _cellHeightArray = [NSMutableArray arrayWithArray:[self arrayWithChatCommentArray:_comments blog:_blogs]];
        }
        _isloadingBlogs = NO;
        [_refreshHeader egoRefreshScrollViewDataSourceDidFinishedLoading:_blogTableView];
        [_loadMoreFooter egoRefreshScrollViewDataSourceDidFinishedLoading:_blogTableView];
        
    } onError:^(NSString *errorStr) {
        _isloadingBlogs = NO;
        [self.view showAlertText:[@"获取博文列表失败!" stringByAppendingString:errorStr]];
        
        [_refreshHeader egoRefreshScrollViewDataSourceDidFinishedLoading:_blogTableView];
        [_loadMoreFooter egoRefreshScrollViewDataSourceDidFinishedLoading:_blogTableView];
    }];
}


//点赞
- (void)netZanByUsername:(NSString*)username andBlogId:(NSString*)blogId{
    
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];\
    [bodyDict setObject:username forKey:@"username"];
    [bodyDict setObject:blogId forKey:@"blogid"];
    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"complimentBlog.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:NO onView:self.view callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if (result == postSucc) {
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSString *contents_ =[resDict objectForKey:@"contents"];
            //[self.view showAlertText:[@"点赞成功!" stringByAppendingString:contents_]];
            [self.view showAlertText:contents_];
            
            for (ChatBlog *blog in _blogs) {
                if ([blog.id_ isEqualToString:blogId]) {
                    NSRange range = [blog.praiseusername rangeOfString:[NSString stringWithFormat:@"[%@]", APP_DELEGATE.userName]];
                    if (range.location != NSNotFound) {//本次操作为取消赞
                        blog.praiseusername = [blog.praiseusername substringToIndex:range.location];
                    }else{
                        blog.praiseusername = [blog.praiseusername stringByAppendingString:[NSString stringWithFormat:@",[%@]", APP_DELEGATE.userName]];
                    }
                    break;
                }
            }
            _cellHeightArray = [NSMutableArray arrayWithArray:[self arrayWithChatCommentArray:_comments blog:_blogs]];
            [_blogTableView reloadData];
            
        }else{
            //[self.view showAlertText:[@"点赞失败!" stringByAppendingString:(NSString*)requestObj]];
            [self.view showAlertText:(NSString*)requestObj];
        }
        
    } onError:^(NSString *errorStr) {
        [self.view showAlertText:[@"点赞失败!" stringByAppendingString:errorStr]];
    }];
}

// 评论
- (void)netPingByUsername:(NSString*)username andBlogId:(NSString*)blogId andContent:(NSString *)contents{
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [_cellHeightArray removeAllObjects];
    [bodyDict setObject:username forKey:@"username"];
    [bodyDict setObject:blogId forKey:@"blogid"];
    [bodyDict setObject:contents forKey:@"content"];
    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"addComment.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:contents onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSArray *contentsArr = [resDict analysisArrValueByKey:@"contents"];
            for (NSDictionary *dict in contentsArr) {
                ChatComment *chatComment = [[ChatComment alloc] init];
                chatComment.addtime = [dict analysisStrValueByKey:@"addtime"];
                chatComment.bid = [dict analysisStrValueByKey:@"bid"];
                chatComment.content = [dict analysisStrValueByKey:@"content"];
                chatComment.id_ = [dict analysisStrValueByKey:@"id"];
                NSDictionary *peplyuserDict = [dict analysisDictValueByKey:@"peplyuser"];
                chatComment.peplyuser_id = [peplyuserDict analysisStrValueByKey:@"id"];
                chatComment.peplyuser_username = [peplyuserDict analysisStrValueByKey:@"username"];
                
                NSDictionary *commentuserDict = [dict analysisDictValueByKey:@"commentuser"];
                chatComment.commentuser_id = [commentuserDict analysisStrValueByKey:@"id"];
                chatComment.commentuser_username = [commentuserDict objectForKey:@"username"];
                
                //此接口已做出修改
                [_comments addObject:chatComment];
                _beforeCommentsArray = [NSMutableArray arrayWithArray:_comments];
                _cellHeightArray = [NSMutableArray arrayWithArray:[self arrayWithChatCommentArray:_comments blog:_blogs]];

            }
            
            [_blogTableView reloadData];

        }else{
            [self.view showAlertText:[@"评论失败!" stringByAppendingString:(NSString *)requestObj]];
        }
    
    
    }onError:^(NSString *errorStr) {
        [self.view showAlertText:[@"评论失败!" stringByAppendingString:errorStr]];
                                              
        
    }];
}
// 回复
- (void)netHuiByUsername:(NSString*)username andBlogId:(NSString*)blogId andPeplyuid:(NSString *)peplyuid andContent:(NSString *)contents{
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];

    [_cellHeightArray removeAllObjects];
    [bodyDict setObject:username forKey:@"username"];
    [bodyDict setObject:blogId forKey:@"blogid"];
    [bodyDict setObject:peplyuid forKey:@"peplyuid"];
    [bodyDict setObject:contents forKey:@"content"];
    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"addPeply.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:NO onView:self.view callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            
            
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSArray *contentsArr = [resDict analysisArrValueByKey:@"contents"];
            for (NSDictionary *dict in contentsArr) {
                ChatComment *chatComment = [[ChatComment alloc] init];
                chatComment.addtime = [dict analysisStrValueByKey:@"addtime"];
                chatComment.bid = [dict analysisStrValueByKey:@"bid"];
                chatComment.content = [dict analysisStrValueByKey:@"content"];
                chatComment.id_ = [dict analysisStrValueByKey:@"id"];
                NSDictionary *peplyuserDict = [dict analysisDictValueByKey:@"peplyuser"];
                chatComment.peplyuser_id = [peplyuserDict analysisStrValueByKey:@"id"];
                chatComment.peplyuser_username = [peplyuserDict analysisStrValueByKey:@"username"];
                
                NSDictionary *commentuserDict = [dict analysisDictValueByKey:@"commentuser"];
                chatComment.commentuser_id = [commentuserDict analysisStrValueByKey:@"id"];
                chatComment.commentuser_username = [commentuserDict objectForKey:@"username"];
                
                //此接口已做出修改
                [_comments addObject:chatComment];
                _beforeCommentsArray = [NSMutableArray arrayWithArray:_comments];
                _cellHeightArray = [NSMutableArray arrayWithArray:[self arrayWithChatCommentArray:_comments blog:_blogs]];

            }

            [_blogTableView reloadData];
            
        }else{
            [self.view showAlertText:(NSString *)requestObj];
        }
        
        
    }onError:^(NSString *errorStr) {
        [self.view showAlertText:[@"回复失败!" stringByAppendingString:errorStr]];
        
    }];
}

//删除博文
- (void)netDeleteBlogs:(NSString *)blogsID{
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [_cellHeightArray removeAllObjects];
    [bodyDict setObject:blogsID forKey:@"blogid"];
    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"deleteBlog.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj){
        if (result == postSucc) {
            NSMutableArray *array1 = [NSMutableArray arrayWithArray:_blogs];
            NSMutableArray *array2 = [NSMutableArray arrayWithArray:_comments];
            
            for (ChatBlog *myBlogs in _blogs) {
                if ([myBlogs.id_ isEqualToString:blogsID]) {
                    [array1 removeObject:myBlogs];
                }
            }
            _blogs = [NSMutableArray arrayWithArray:array1];
            
            for (ChatComment *myComment in _comments) {
                if ([myComment.bid isEqualToString:blogsID]) {
                    [array2 removeObject:myComment];
                }
            }
            _comments = [NSMutableArray arrayWithArray:array2];
            
            _cellHeightArray = [NSMutableArray arrayWithArray:[self arrayWithChatCommentArray:_comments blog:_blogs]];
            [_blogTableView reloadData];
        }
        else{
            [self.view showAlertText:(NSString *)requestObj];
        }
     } onError:^(NSString *errorStr){
        [self.view showAlertText:[@"删除失败!" stringByAppendingString:errorStr]];
    }];
}

//删除评论/回复
- (void)netDeleteComment:(NSString *)commentID{
    
    
    _beforeCommentsArray = [NSMutableArray arrayWithArray:_comments];
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [_cellHeightArray removeAllObjects];
    [bodyDict setObject:commentID forKey:@"commentid"];
    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"deleteComment.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj){
        if (result == postSucc) {
            NSMutableArray *array2 = [NSMutableArray arrayWithArray:_comments];
            for (ChatComment *myComment in _comments) {
                if ([myComment.id_ isEqualToString:commentID]) {
                    [array2 removeObject:myComment];
                }
            }
            _comments = [NSMutableArray arrayWithArray:array2];
            
            
            
            _cellHeightArray = [NSMutableArray arrayWithArray:[self arrayWithChatCommentArray:_comments blog:_blogs]];
            [_blogTableView reloadData];
        }
        else{
            [self.view showAlertText:(NSString *)requestObj];
        }
        
    } onError:^(NSString *errorStr){
        [self.view showAlertText:[@"删除失败!" stringByAppendingString:errorStr]];
    }];
}


- (void)netJUBao:(NSString*)blogId
{
    [[ChatNetwork sharedChatNetwork] chatPostBody:[NSMutableDictionary dictionaryWithObjectsAndKeys:blogId, @"blogid", nil] onUrl:@"reportBlog.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:NO onView:nil callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        if (result == postSucc) {
            [self.view showAlertText:@"已收到您的举报，我们会尽快处理"];
        }else{
            NSDictionary *resDict = (NSDictionary*) requestObj;
            NSString *content =  [resDict analysisStrValueByKey:@"contents"];
            [self.view showAlertText:[NSString stringWithFormat:@"举报失败！%@", content]];
        }
    
    } onError:^(NSString *errorStr) {
        [self.view showAlertText:[NSString stringWithFormat:@"举报失败！%@", errorStr]];
        
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
            
            NSString *callbackFuid = (NSString*)callBackObj;
            [self.myFriends addObject:callbackFuid];
            [_blogTableView reloadData];

        }else{
            
            [UIAlertView alertTitle:@"提示信息" msg:[@"关注好友失败," stringByAppendingString:(NSString*)requestObj]];
            
        }
        
    } onError:^(NSString *errorStr) {
        
        [UIAlertView alertTitle:@"提示信息" msg:[@"关注好友失败," stringByAppendingString:errorStr]];
    }];
    
    
}

//移除好友
- (void)netRemoveFriend:(NSString*)friendId{
    
    NSMutableDictionary *bodyDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:friendId, @"friendsid", nil];
    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"deleteFriend.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:friendId onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if (result == postSucc) {
            
            APP_DELEGATE.shouldRefreshFriendsList = YES;
            
            NSDictionary *resDict = (NSDictionary*)requestObj;
            NSString *contents = [resDict objectForKey:@"contents"];
            [self.view showAlertText:contents];
            
            NSString *callbackFuid = (NSString*)callBackObj;
            [self.myFriends removeObject:callbackFuid];
            [_blogTableView reloadData];
            
        }else{
            [self.view showAlertText:[NSString stringWithFormat:@"取消关注失败!%@", requestObj]];
        }
        
    } onError:^(NSString *errorStr) {
        
        [self.view showAlertText:[NSString stringWithFormat:@"取消关注失败!%@", errorStr]];
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (iOS6) {
        if (USE_COUNTLY) {
            [[Countly sharedInstance] recordEvent:@"ChatBlogsVC-recieved memory waring" count:1];
        }
    }
    ENTLog(@"ChatBlogsVC-recieved memory waring");
    
    
    //[_blogTableView removeFromSuperview];
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
