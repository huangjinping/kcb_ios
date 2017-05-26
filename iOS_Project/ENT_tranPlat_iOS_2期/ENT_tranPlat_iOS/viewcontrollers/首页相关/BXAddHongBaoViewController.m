//
//  BXAddHongBaoViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/20.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BXAddHongBaoViewController.h"

@interface BXAddHongBaoViewController ()<
UITextFieldDelegate
>
{
    UITextField             *_telTF;
}
@end

@implementation BXAddHongBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIScrollView *rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:rootScrollView];
    
    CGFloat contentLineHeight = 30*3;
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:30 width:APP_PX_WIDTH height:contentLineHeight];
    [rootScrollView addSubview:bgImgView];
    _telTF = [[UITextField alloc] initWithFrame:LGRectMake(30, 20, 400, 50)];
    [_telTF setBorderStyle:UITextBorderStyleNone];
    _telTF.placeholder = @"填写优惠券关联的手机号码";
    UserInfo *user = [[[DataBase sharedDataBase] selectActiveUser] lastObject];
    if (user.contactNum && ![user.contactNum isEqualToString:@""]) {
        [_telTF setText:user.contactNum];
    }
    _telTF.delegate = self;
    [_telTF setReturnKeyType:UIReturnKeySearch];
    [bgImgView addSubview:_telTF];
    
//    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [searchButton setImage:[UIImage imageNamed:@"btn_search.png"] forState:UIControlStateNormal];
//    [searchButton setFrame:LGRectMake(bgImgView.w - 50 - 30, 20, 50, 50)];
//    [searchButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [bgImgView addSubview:searchButton];

    [_telTF becomeFirstResponder];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadNavigationBarWithBackHomeButton:YES];
    [self setCustomNavigationTitle:@"添加优惠券/红包"];

}

- (void)searchButtonClicked{
    [self netSearchHongBao:_telTF.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self searchButtonClicked];
    return YES;
}

- (void)netSearchHongBao:(NSString*)tel{
    NSString *time = [[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
    NSString *token = [NSString stringWithFormat:@"mobile=%@&time=%@&key=%@", tel, time, @"956122"];
    NSDictionary *bodyDict = [NSDictionary dictionaryWithObjectsAndKeys:tel, @"mobile", time, @"time", token, @"token", nil];
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:NET_ADDR_BUSS_956122];
    MKNetworkOperation *op = [en operationWithPath:@"bxhb.do" params:bodyDict httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//        SBJsonParser *parser = [[SBJsonParser alloc] init];
//        NSString *resStr = completedOperation.responseString;
//        NSDictionary *dict = [parser objectWithString:resStr];
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        
        
    

    }];
    [en enqueueOperation:op];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
