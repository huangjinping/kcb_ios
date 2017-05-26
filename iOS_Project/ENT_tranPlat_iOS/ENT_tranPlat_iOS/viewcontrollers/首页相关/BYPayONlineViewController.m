//
//  BYPayONlineViewController.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/9/14.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BYPayONlineViewController.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "BYPayInfoViewController.h"



@interface BYPayONlineViewController ()
@end

@implementation BYPayONlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needPayAccount=0.01;
    UILabel *lable = [[UILabel alloc] initWithFrame:LGRectMake(0, APP_VIEW_Y*PX_Y_SCALE + 120, APP_PX_WIDTH, 30)];
    [lable setText:@"套餐总价"];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lable];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(0, lable.b + 30, APP_PX_WIDTH, 60)];
    //[lable setText:self.price];
    [lable setText:[NSString stringWithFormat:@"￥ %.2f",self.baoyang.selectedAllPrice]];
    [lable convertNewLabelWithFont:SYS_FONT_SIZE(60) textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:lable];
    
    
    CGFloat contentLineHeight = 90;
    CGFloat space = 30;
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:lable.b + space + space +space  width:APP_PX_WIDTH height:contentLineHeight*3];
    [self.view addSubview:bgImgView];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [lable setText:@"订单编号 "];
    
    [bgImgView addSubview:lable];
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30,   space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    
    NSArray *array = [_orderNo componentsSeparatedByString:@","]; //从字符A中
    
    NSString *string = array[0];
    [lable setText:string];
    [bgImgView addSubview:lable];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [lable setText:@"收款单位："];
    [bgImgView addSubview:lable];
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [lable setText:@"开车邦"];
    [bgImgView addSubview:lable];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight*2 + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentLeft];
    [lable setText:@"商品名称："];
    [bgImgView addSubview:lable];
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, contentLineHeight*2 + space, bgImgView.w - 30*2, space)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_INFO_SHOW textAlignment:NSTextAlignmentRight];
    [lable setText:@"保养服务订单"];
    [bgImgView addSubview:lable];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = LGRectMake(space, bgImgView.b + space*2, APP_PX_WIDTH - space*2, 70);
    [button setTitle:@"立即支付" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_NOMAL;
    [button addTarget:self action:@selector(payButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[[UIImage imageNamed:@"button_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 200, 44, 200)] forState:UIControlStateNormal];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:button];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    self.baoyang.hphm=[[[self.infoModel valueForKey:@"orderInfo"]valueForKey:@"vehicleInfo"]valueForKey:@"hphm"];
    //    self.baoyang.peopleDate=[[[self.infoModel valueForKey:@"orderInfo"]valueForKey:@"bookingInfo"]valueForKey:@"maintainDate"];
    //    self.baoyang.peopleTime=[[[self.infoModel valueForKey:@"orderInfo"]valueForKey:@"bookingInfo"]valueForKey:@"maintainTime"];
    //    self.baoyang.name=[[[self.infoModel valueForKey:@"orderInfo"]valueForKey:@"businesInfo"]valueForKey:@"shopInfoName"];
    //    self.baoyang.address=[[[self.infoModel valueForKey:@"orderInfo"]valueForKey:@"businesInfo"]valueForKey:@"address"];
    //    self.orderNo=[NSString stringWithFormat:@"%@,%@",[self.infoModel valueForKey:@"ordid"],[self.infoModel valueForKey:@"verifycode"]];
    //    float number =[[[self.infoModel valueForKey:@"orderInfo"]valueForKey:@"totalPrice"]integerValue];;
    //    self.baoyang.selectedAllPrice=number;
    
    [self setCustomNavigationTitle:@"爱车保养订单"];
}


- (void)payButtonClicked{
    
    [UIAlertView alertTitle:nil msg:@"服务未开启,敬请期待."];
//        if (_ZhiFuBao == YES) {
//            NSLog(@"支付宝支付");
//            [self gotoAlipay];
//    
//        }else{
//    
//            NSLog(@"微信支付");
//            [self gotoAlipay];
//        }
//        
}
-(void)gotoAlipay{
    /*=========== =================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = PartnerID;
    NSString *seller = SellerID;
    NSString *privateKey = PartnerPrivatekey;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    NSArray *array = [_orderNo componentsSeparatedByString:@","]; //从字符A中
    
    
    ;
    order.tradeNO = array[0]; //订单ID（由商家自行制定）
    order.productName = [NSString stringWithFormat:@"车辆保养订单"]; //商品标题
    order.productDescription = [NSString stringWithFormat:@"车辆(云AU336Z)保养服务订单,预约2013-10-10(09:00~10:00)到小矮人人民西路店保养"]; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",_needPayAccount];; //商品价格
    order.notifyURL =  @"http://buss.956122.com/alipayBack.do"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    //order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"ENT";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    ENTLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(PartnerPrivatekey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            NSLog(@"reslut = %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] intValue]==9000) {
                NSString *string = @"订单支付成功";
                BYPayInfoViewController *vc =[[BYPayInfoViewController alloc]init];
                vc.titLabel=string;
                
                vc.baoyang = self.baoyang;
                
                NSArray *array = [_orderNo componentsSeparatedByString:@","]; //从字符A中
                
                vc.orderNo=array[0];
                vc.DDInfo =array[1];
                
                vc.isSucceed=YES;
                vc.isIng =NO;
                [self.navigationController pushViewController:vc animated:YES];
            }else if([[resultDic objectForKey:@"resultStatus"] intValue]==8000){
                NSString *string = @"订单正在处理";
                BYPayInfoViewController *vc =[[BYPayInfoViewController alloc]init];
                vc.titLabel=string;
                vc.isSucceed=NO;
                vc.isIng =YES;
                NSArray *array = [_orderNo componentsSeparatedByString:@","]; //从字符A中
                
                vc.orderNo=array[0];
                
                vc.baoyang = self.baoyang;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if([[resultDic objectForKey:@"resultStatus"] intValue]==4000){
                NSString *string = @"订单支付失败";
                BYPayInfoViewController *vc =[[BYPayInfoViewController alloc]init];
                vc.titLabel=string;
                vc.isSucceed=NO;
                vc.baoyang = self.baoyang;
                NSArray *array = [_orderNo componentsSeparatedByString:@","]; //从字符A中
                
                vc.orderNo=array[0];
                vc.DDInfo =array[1];;
                vc.isIng =NO;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if([[resultDic objectForKey:@"resultStatus"] intValue]==6001){
                NSString *string = @"用户中途取消";
                BYPayInfoViewController *vc =[[BYPayInfoViewController alloc]init];
                vc.titLabel=string;
                vc.isSucceed=NO;
                vc.baoyang = self.baoyang;
                NSArray *array = [_orderNo componentsSeparatedByString:@","]; //从字符A中
                
                vc.orderNo=array[0];
                vc.DDInfo =array[1];
                vc.isIng =NO;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if([[resultDic objectForKey:@"resultStatus"] intValue]==6002){
                NSString *string = @"网路连接错误";
                BYPayInfoViewController *vc =[[BYPayInfoViewController alloc]init];
                vc.titLabel=string;
                vc.isSucceed=NO;
                vc.baoyang = self.baoyang;
                NSArray *array = [_orderNo componentsSeparatedByString:@","]; //从字符A中
                
                vc.orderNo=array[0];
                vc.DDInfo =array[1];
                vc.isIng =NO;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                NSString *string = @"订单支付失败";
                BYPayInfoViewController *vc =[[BYPayInfoViewController alloc]init];
                vc.titLabel=string;
                vc.isSucceed=NO;
                vc.isIng =NO;
                vc.baoyang = self.baoyang;
                NSArray *array = [_orderNo componentsSeparatedByString:@","]; //从字符A中
                
                vc.orderNo=array[0];
                vc.DDInfo =array[1];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
            
            
        }];
        
        
        
    }
    
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
