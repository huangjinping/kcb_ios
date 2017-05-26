//
//  ZijiayouShowVIPCardMsgViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/3.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "ZijiayouShowVIPCardMsgViewController.h"
#import "ZijiayouBuyVIPCardViewController.h"

@interface ZijiayouShowVIPCardMsgViewController ()<
AdvertisementImageViewDelegate,
SegmentButtonViewDelegate
>
{
    UIView          *_advertisementView;
    UIScrollView    *_hrzScrollView;
    UIView          *_detailView;
    UIScrollView    *_rootScrollView;

    CGFloat         _index0Bottom;
    CGFloat         _index1Bottom;
    CGFloat         _index2Bottom;

}
@end

@implementation ZijiayouShowVIPCardMsgViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _index0Bottom = 0;
    _index1Bottom = 0;
    _index2Bottom = 0;
    CGFloat buttonBgHeight = 60 + 20 + 20;

    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - buttonBgHeight*PX_Y_SCALE)];
    _rootScrollView.backgroundColor = COLOR_VIEW_CONTROLLER_BG;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_rootScrollView];

    _advertisementView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_WIDTH*250/640)];
    [_rootScrollView addSubview:_advertisementView];
    [self showAdvertisementWithData:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"", self.card.titlePic, nil]];
    
    
    UIView  *desBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _advertisementView.bottom, APP_WIDTH, 0)];
    [desBgView setBackgroundColor:[UIColor whiteColor]];
    [_rootScrollView addSubview:desBgView];
    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, desBgView.width - 15*2, 0)];
    [desLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    desLabel.numberOfLines = 0;
    [desLabel setText:self.card.des];
    [desLabel setSize:[desLabel.text sizeWithFont:desLabel.font constrainedToSize:CGSizeMake(desLabel.width, 1000)]];
    [desBgView addSubview:desLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(desLabel.left, desLabel.bottom + 20, desLabel.width, 17)];
    [priceLabel convertNewLabelWithFont:[UIFont systemFontOfSize:17] textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentLeft];
    [priceLabel setText:[@"￥" stringByAppendingString:self.card.price]];
    [desBgView addSubview:priceLabel];
    [desBgView setFrame:CGRectMake(desBgView.left, desBgView.top, desBgView.width, priceLabel.bottom + 20)];
    
    _detailView = [[UIView alloc] initWithFrame:CGRectMake(0, desBgView.bottom + 20, desBgView.width, 0)];
    [_detailView setBackgroundColor:[UIColor whiteColor]];
    [_rootScrollView addSubview:_detailView];
    SegmentButtonView *segBView = [[SegmentButtonView alloc] initWithFrame:CGRectMake(0, 0, _detailView.width, 34) backgroundColor:[UIColor whiteColor] andLineColor:COLOR_NAV];
    [segBView setTitles:[NSArray arrayWithObjects:@"详情", @"图集", @"须知", nil] withTitleNorColor:COLOR_FONT_NOMAL andTitleSelColor:COLOR_NAV];
    segBView.delegate = self;
    [_detailView addSubview:segBView];
    
    _hrzScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, segBView.bottom, _detailView.width, 0)];
    _hrzScrollView.showsHorizontalScrollIndicator = NO;
    _hrzScrollView.userInteractionEnabled = NO;
    [_detailView addSubview:_hrzScrollView];
    
    for (int i = 0; i<3; i++) {
        if (i == 0) {
            UILabel *detailLable = [[UILabel alloc] initWithFrame:CGRectMake(i*APP_WIDTH + 15, 15, _detailView.width - 15*2, 0)];
            [detailLable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
            detailLable.numberOfLines = 0;
            [detailLable setText:self.card.detail];
            CGSize size = [detailLable.text sizeWithFont:detailLable.font constrainedToSize:CGSizeMake(detailLable.width, 10000) lineBreakMode:NSLineBreakByWordWrapping];
            [detailLable setSize:size];
            [_hrzScrollView addSubview:detailLable];
            _index0Bottom = detailLable.bottom;
        }else if (i == 2){
            UILabel *itemDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*APP_WIDTH + 15, 15, _detailView.width - 15*2, 0)];
            [itemDescLabel convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
            itemDescLabel.numberOfLines = 0;
            [itemDescLabel setText:self.card.itemDesc];
            [itemDescLabel setSize:[itemDescLabel.text sizeWithFont:itemDescLabel.font constrainedToSize:CGSizeMake(itemDescLabel.width, 10000)]];
            [_hrzScrollView addSubview:itemDescLabel];
            _index2Bottom = itemDescLabel.bottom;
        }
    }
    
    [_hrzScrollView setSize:CGSizeMake(_hrzScrollView.width, _index0Bottom)];
    [_hrzScrollView setContentSize:CGSizeMake(APP_WIDTH*3, _hrzScrollView.height)];

    [_detailView setSize:CGSizeMake(_detailView.width, _hrzScrollView.bottom)];
    [_rootScrollView setContentSize:CGSizeMake(_rootScrollView.width, _detailView.bottom)];
    
    
    
    UIView *buttonBgView = [[UIView alloc] initWithFrame:BGRectMake(0, _rootScrollView.b, APP_PX_WIDTH, buttonBgHeight)];
    buttonBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonBgView];
    UILabel *lineLabel = [UILabel lineLabelWithPXPoint:CGPointMake(0, 0)];
    [lineLabel setSize:CGSizeMake((APP_PX_WIDTH)*PX_X_SCALE, lineLabel.height)];
    [buttonBgView addSubview:lineLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = LGRectMake(30, 15, buttonBgView.w - 30*2, buttonBgView.h - 15*2);
    [button setTitle:@"立即预定" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_NOMAL;
    [button addTarget:self action:@selector(yudingButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    [buttonBgView addSubview:button];
/*
 
 

 */
    
    
//    des。
//    详情 ----》 detail ;
//    图集 ----》 pics
//    须知 ----》itemDesc
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"会员卡详情"];


}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    dispatch_queue_t queue = dispatch_queue_create("pics_download_queue", DISPATCH_QUEUE_SERIAL);
    NSArray *imgUrlArr = [self.card.pics componentsSeparatedByString:@","];
    __block CGFloat y = 0;
    for (NSString *imgUrl in imgUrlArr) {
        if (![imgUrl isEqualToString:@""]) {
            
            
            dispatch_async(queue, ^{
                UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(1*APP_WIDTH + 15, y + 15, _detailView.width - 15*2, 0)];
                [_hrzScrollView addSubview:imgV];
                
                NSURLRequest *rq = [NSURLRequest requestWithURL:[NSURL URLWithString:imgUrl]];
                NSData *data = [NSURLConnection sendSynchronousRequest:rq returningResponse:nil error:nil];
                UIImage *img = [UIImage imageWithData:data];
                [imgV setImage:img];
                [imgV setSize:CGSizeMake(imgV.width, imgV.width/img.size.width*img.size.height)];
                y = imgV.bottom;
                _index1Bottom = y;
            });
            
            
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


#pragma mark- delegate
- (void)segmentButtonView:(SegmentButtonView *)segmentButtonView showView:(NSInteger)index{
    CGFloat bottom = 0;
    switch (index) {
        case 0:
            bottom = _index0Bottom;
            break;
        case 1:
            bottom = _index1Bottom;
            break;
        case 2:
            bottom = _index2Bottom;
            break;
        default:
            break;
    }
    [_hrzScrollView setSize:CGSizeMake(_hrzScrollView.width, bottom)];
    [_hrzScrollView setContentSize:CGSizeMake(APP_WIDTH*3, _hrzScrollView.height)];
    [_detailView setSize:CGSizeMake(_detailView.width, _hrzScrollView.bottom)];
    [_rootScrollView setContentSize:CGSizeMake(_rootScrollView.width, _detailView.bottom)];

    
    [_hrzScrollView scrollRectToVisible:CGRectMake(APP_WIDTH*index, 0, APP_WIDTH, _hrzScrollView.height) animated:YES];
}


- (void)advertisementImageView:(AdvertisementImageView *)aImageView didTapedWithImgsrc:(NSString *)imgsrc andHref:(NSString *)href{

}




#pragma actions

- (void)yudingButtonClicked{
    ZijiayouBuyVIPCardViewController *zjybvipcVC = [[ZijiayouBuyVIPCardViewController alloc] init];
    zjybvipcVC.card = self.card;
    [self.navigationController pushViewController:zjybvipcVC animated:YES];
}


- (void)showAdvertisementWithData:(NSMutableDictionary*)dict{
    for (UIView *v in _advertisementView.subviews) {
        [v removeFromSuperview];
    }
    
    AdvertisementScrollView *asV = [[AdvertisementScrollView alloc] initWithFrame:_advertisementView.bounds dataDict:dict andDelegate:self];
    [_advertisementView addSubview:asV];
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
