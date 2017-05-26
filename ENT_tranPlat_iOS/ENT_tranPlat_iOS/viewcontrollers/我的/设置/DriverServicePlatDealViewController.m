//
//  DriverServicePlatDealViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-6.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "DriverServicePlatDealViewController.h"

@interface DriverServicePlatDealViewController ()

@end

@implementation DriverServicePlatDealViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)tapDealZZFW:(UITapGestureRecognizer*)tap{
    SelfHelpDealViewController *shdVC = [[SelfHelpDealViewController alloc] init];
    [self.navigationController pushViewController:shdVC animated:YES];
}


- (void)tapDealHDMK:(UITapGestureRecognizer*)tap{
    RidersInteractionViewController *riVC = [[RidersInteractionViewController alloc] init];
    [self.navigationController pushViewController:riVC animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, 30)];
    label1.text = @"开车邦用户使用条款包含";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:label1];
    CGFloat bottom = label1.bottom;
    if (self.showOtherDeals) {
        UILabel *dealLabel = [[UILabel alloc] initWithFrame:LGRectMake(0, label1.b + 10, APP_PX_WIDTH, 24)];
        [dealLabel convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_LINK textAlignment:NSTextAlignmentCenter];
        [dealLabel setUserInteractionEnabled:YES];
        [dealLabel setText:@"《交通违法行为网上自助处理使用协议》"];
        [self.view addSubview:dealLabel];
        UITapGestureRecognizer *tapDeal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDealZZFW:)];
        [dealLabel addGestureRecognizer:tapDeal];
        
        
        dealLabel = [[UILabel alloc] initWithFrame:LGRectMake(0, dealLabel.b + 20, APP_PX_WIDTH, 24)];
        [dealLabel convertNewLabelWithFont:FONT_NOTICE textColor:COLOR_LINK textAlignment:NSTextAlignmentCenter];
        [dealLabel setUserInteractionEnabled:YES];
        [dealLabel setText:@"《互动模块（发帖论坛）使用协议》"];
        [self.view addSubview:dealLabel];
        tapDeal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDealHDMK:)];
        [dealLabel addGestureRecognizer:tapDeal];
        bottom = dealLabel.bottom;
    }
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, bottom, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - label1.height)];
    textView.text = @"            欢迎阅读全国驾驶员服务平台(开车邦)网站http://www.956122.com（以下简称“本网站”）服务条款，其阐述之内容和条件适用于您使用本网站提供的各项服务。 \n \n1.服务条款的确认 \n    您点击服务条款页面下的“我同意”按钮，即视为您已阅读、了解并完全同意服务条款中的各项内容，包括本网站对服务条款所作的任何修改。除另行明确声明外，本网站任何服务范围或功能的变化均受服务条款约束。 \n \n2.服务条款的修改  　\n    本网站在必要时可修改服务条款，并在网站进行公告，一经公告，立即生效。如您继续使用服务，则视为您已接受修订的服务条款。 \n　\n3.用户注册   \n    考虑到本网站用户服务的重要性，您同意在注册时提供真实、完整及准确的个人资料，并及时更新。   \n    如您提供的资料不准确，或本网站有合理的理由认为该资料不真实、不完整、不准确，本网站有权暂停或终止您的注册身份及资料，并拒绝您使用本网站的服务。 \n  \n4.用户资料及保密    　　\n    注册时，请您选择填写用户名和密码，并按页面提示提交相关信息。您负有对用户名和密码保密的义务，并对该用户名和密码下发生的所有活动承担责任。您同意邮件服务和手机短信的服务的使用由您自己承担风险。本网站不会向您所使用服务所涉及相关方之外的其他方公开或透露您的个人资料，除非法律规定。  \n \n5.责任的免除和限制    　　\n    （1）遇以下情况，本网站不承担任何责任，包括但不仅限于：    　　\n     ①因不可抗力、系统故障、通讯故障、网络拥堵、供电系统故障、恶意攻击等造成本网站未能及时、准确、完整地提供服务。    　\n     ②无论在任何原因下，您通过使用本网站上的信息或由本网站链接的其他网站上的信息，或其他与本网站链接的网站上的信息所导致的任何损失或损害。    　　\n   （2）本网站负责对本网站上的信息进行审核与更新，但并不就信息的时效性、准确性以及服务功能的完整性和可靠性承担任何义务和赔偿责任。    　　\n   （3）如用户利用系统差错、故障或其他原因导致的漏洞，损害本网站及任何第三方的权益，本网站将终止该用户资格，并保留法律追究的权利。    　　\n   （4）如果本网站发现有影响用户信息安全的行为，本网站有权对用户信息实施保护。必要时用户需经重新验证身份后方可继续使用。  \n \n6.拒绝提供担保    　　\n    本网站对以下情形不做任何担保，包括但不仅限于：   \n   （1）服务一定能满足您的要求。    　　\n   （2）服务不会受中断。    　　\n   （3）服务的安全性、及时性、完整性和准确性。  　\n   （4）服务所涉及相关方的服务。    　　\n   （5）您从本网站收到口头或书面的意见或信息。  \n   （6）他人使用与您相同的身份信息注册。    \n　　\n7.网站链接    　　\n   本网站包含有链接的第三方网站。这些链接纯粹为用户提供方便。本网站无法就所链接的第三方网站的内容或可用性予以控制或对其负责。如果您决定访问任何与本网站相链接的第三方网站，则应完全自行承担相应风险和责任。  \n  　\n8.保障    　\n    您同意保障和维护本网站的利益，并承担您或其他人使用您的用户资料造成本网站或任何第三方的损失或损害的赔偿责任。  \n  　　\n9.知识产权    　　\n    本网站所有内容和资源的版权归本网站所有（除非本网站已经标明版权所有人），页面所有信息受《中华人民共和国著作权法》及相关法律法规和中国加入的所有知识产权方面的国际条约的保护。未经本网站事先的书面许可，任何单位和个人不得就本网站上的相关资源以任何方式、任何文字做全部或局部复制、修改、发送、储存、发布、交流或分发，或利用本网站上的相关资源创建其他商业用途的资源。否则本网站将追究其法律责任。  \n  　　\n10.法律适用和管辖    　　\n    本服务条款之效力、解释、变更、执行与争议解决均适用中华人民共和国法律。    　　因您使用本网站而导致的争议，您同意接受本网站注册地人民法院的管辖。    　　本网站享有对服务条款的最终解释与修改权。";
    textView.font = [UIFont systemFontOfSize:14];
    textView.textColor = COLOR_FONT_NOMAL;
    [self.view addSubview:textView];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"用户使用条款"];
    _titleLabel.frame = CGRectMake(APP_X + 20, _titleLabel.frame.origin.y, APP_WIDTH - 20, _titleLabel.height);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
