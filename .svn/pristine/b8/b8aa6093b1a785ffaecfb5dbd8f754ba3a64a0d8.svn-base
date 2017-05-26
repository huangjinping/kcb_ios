//
//  ZijiayouViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/5/28.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "ZijiayouViewController.h"
#import "ZijiayouCard.h"
#import "ZijiayouShowVIPCardMsgViewController.h"

@interface ZijiayouViewController ()<
AdvertisementImageViewDelegate,
UITableViewDataSource,
UITableViewDelegate
>
{
    UITableView     *_rootTableView;
    UIView          *_advertisementView;
    
    NSMutableArray      *_listDataArr;
    NSMutableArray      *_cardDataArr;

    
}
@end

@implementation ZijiayouViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listDataArr = [[NSMutableArray alloc] initWithCapacity:0];
    _cardDataArr = [[NSMutableArray alloc] initWithCapacity:0];
    _advertisementView = [[UIView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, 0)];//APP_WIDTH*250/640
    [self.view addSubview:_advertisementView];
    
    _rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _advertisementView.bottom, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - _advertisementView.height)];
    [self.view addSubview:_rootTableView];
    
    [self getAdvertisement];
    [self netGetListNew:@"0"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"自驾游"];

}




- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idstr = @"zijiayoucell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idstr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idstr];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


}



#pragma mark- 广告
/***********************************广告**********************************************/
- (void)advertisementImageView:(AdvertisementImageView *)aImageView didTapedWithImgsrc:(NSString *)imgsrc andHref:(NSString *)href{
    for (ZijiayouCard *card in _cardDataArr) {
        if ([card.titlePic isEqualToString:imgsrc]) {
            ZijiayouShowVIPCardMsgViewController    *zjysvipcmVC = [[ZijiayouShowVIPCardMsgViewController alloc] init];
            zjysvipcmVC.card = card;
            [self.navigationController pushViewController:zjysvipcmVC animated:YES];
        }
    }
    
    
    
}

- (void)showAdvertisementWithData:(NSMutableDictionary*)dict{
    [_advertisementView setFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_WIDTH*250/640)];
    [_rootTableView setFrame:CGRectMake(0, _advertisementView.bottom, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - _advertisementView.height)];
    for (UIView *v in _advertisementView.subviews) {
        [v removeFromSuperview];
    }
    
    AdvertisementScrollView *asV = [[AdvertisementScrollView alloc] initWithFrame:_advertisementView.bounds dataDict:dict andDelegate:self];
    [_advertisementView addSubview:asV];
}

- (void)getAdvertisement{
    //1、顶部图片：/cardpic.do?servicetype=
        //servicetype 服务项目类型，自驾游（5）http://buss.956122.com//cardpic.do?servicetype=5
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:NET_ADDR_BUSS_956122
                           ];//@"132.96.77.198:8090"
    MKNetworkOperation *op = [en operationWithPath:@"cardpic.do" params:[NSDictionary dictionaryWithObjectsAndKeys:@"5", @"servicetype", nil] httpMethod:@"POST"];
    ENTLog(@"\n自驾游-广告%@",op.url);///cardpic.do?servicetype=5
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString *reqStr = completedOperation.responseString;
        ENTLog(@"自驾游card返回：%@", reqStr);
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *responseDict = [parser objectWithString:reqStr];
        //0 是失败  1是成功
        NSString *code = [responseDict analysisStrValueByKey:@"code"];
        NSMutableDictionary *advertiseHrefWithImgsrcDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        if ([code isEqualToString:@"1"]) {//succ
            //msgStr = [msgStr substringWithRange:NSMakeRange(0, msgStr.length)];
            NSArray *msgArr = [responseDict analysisArrValueByKey:@"msg"];
            
            for (NSDictionary *dict in msgArr) {
                NSString *actualPrice = [dict analysisStrValueByKey:@"actualPrice"];
                NSString *address = [dict analysisStrValueByKey:@"address"];
                NSString *cityName = [dict analysisStrValueByKey:@"cityName"];
                NSString *createtime = [dict analysisStrValueByKey:@"createtime"];
                NSString *des = [dict analysisStrValueByKey:@"des"];
                NSString *endtime = [dict analysisStrValueByKey:@"endtime"];
                NSString *isdelete = [dict analysisStrValueByKey:@"isdelete"];
                NSString *isrecommend = [dict analysisStrValueByKey:@"isrecommend"];
                NSString *itemCreatetime = [dict analysisStrValueByKey:@"itemCreatetime"];
                NSString *itemDesc = [dict analysisStrValueByKey:@"itemDesc"];
                NSString *itemId = [dict analysisStrValueByKey:@"itemId"];
                NSString *name = [dict analysisStrValueByKey:@"name"];
                NSString *phone = [dict analysisStrValueByKey:@"phone"];
                NSString *titlePic = [dict analysisStrValueByKey:@"titlePic"];
                NSString *pics = [dict analysisStrValueByKey:@"pics"];
                NSString *price = [dict analysisStrValueByKey:@"price"];
                NSString *serviceItemId = [dict analysisStrValueByKey:@"serviceItemId"];
                NSString *shopId = [dict analysisStrValueByKey:@"shopId"];
                NSString *shopInfoName = [dict analysisStrValueByKey:@"shopInfoName"];
                NSString *shopIsdelete = [dict analysisStrValueByKey:@"shopIsdelete"];
                NSString *shopinfoId = [dict analysisStrValueByKey:@"shopinfoId"];
                NSString *starttime = [dict analysisStrValueByKey:@"starttime"];
                
                
                NSString *shopType = [dict analysisStrValueByKey:@"shopType"];
                NSString *closetime = [dict analysisStrValueByKey:@"closetime"];
                NSString *opentime = [dict analysisStrValueByKey:@"opentime"];
                NSString *grade = [dict analysisStrValueByKey:@"grade"];
                NSString *contacts = [dict analysisStrValueByKey:@"contacts"];
                NSString *detail = [dict analysisStrValueByKey:@"detail"];

                ZijiayouCard *cardmsg = [[ZijiayouCard alloc] initWithActualPrice:actualPrice address:address cityName:cityName createtime:createtime des:des endtime:endtime isdelete:isdelete isrecommend:isrecommend itemCreatetime:itemCreatetime itemDesc:itemDesc itemId:itemId name:name phone:phone pics:pics price:price serviceItemId:serviceItemId shopId:shopId shopInfoName:shopInfoName shopIsdelete:shopIsdelete shopinfoId:shopinfoId starttime:starttime shopType:shopType closetime:closetime opentime:opentime grade:grade contacts:contacts detail:detail andTitlePic:titlePic];
                [_cardDataArr addObject:cardmsg];
                
                [advertiseHrefWithImgsrcDict setObject:@"" forKey:titlePic];
                

            }
            [self showAdvertisementWithData:advertiseHrefWithImgsrcDict];
        }else{
            NSString *msgStr = [responseDict analysisStrValueByKey:@"msg"];

            [UIAlertView alertTitle:@"获取自驾游会员卡相关内容失败" msg:msgStr];
        }
        
        

    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [self performSelector:@selector(getAdvertisement) withObject:nil afterDelay:1*10.0f];
        
    }];
    [en enqueueOperation:op];
}



- (void)netGetListNew:(NSString*)isnew{//刷新，isnew = 1，历史，isnew = 0
    /*
     
     2、自驾游分页列表：/goods.do ( int countsum, int indexid, int isnew, String city, int servicetype)
     countsum  否  int    查询记录数，默认一次查询10条记录
     indexid    否  int    标示记录坐标ID（根据该ID查询相邻数据）
     isnew  否  int    加载方式（0：加载历史、1：加载最新）默认为“1”
     city 城市名城
     servicetype 服务项目类型，自驾游（5）

     */
    
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:NET_ADDR_BUSS_956122];
    
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDict setObject:@"10" forKey:@"countsum"];//默认查询10条
    int count = (int)_listDataArr.count;
    NSString *indexId = [NSString stringWithFormat:@"%d", count];
    [bodyDict setObject:indexId forKey:@"indexid"];
    [bodyDict setObject:isnew forKey:@"isnew"];
    NSString *cityName  = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_CITY_NAME_IN_USERDEFAULT];
    [bodyDict setObject:cityName forKey:@"city"];
    [bodyDict setObject:@"5" forKey:@"servicetype"];

    MKNetworkOperation *op = [en operationWithPath:@"goods.do" params:bodyDict httpMethod:@"POST"];
    ENTLog(@"自驾游-列表%@",op.url);
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
       // NSString *reqStr = completedOperation.responseString;
        
        
        //if isnew=1   _listDataArr insertatindex 0  else _listDataArr addobject
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        ENTLog(@"%@", error);

        
    }];
    [en enqueueOperation:op];

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
