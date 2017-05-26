//
//  RidersInteractionViewController.m
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-11-10.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "RidersInteractionViewController.h"

@interface RidersInteractionViewController ()

@end

@implementation RidersInteractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, 30)];
    label1.text = @"互动模块（发帖论坛）使用协议";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:label1];
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, label1.bottom, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - label1.height)];
    textView.text = @"请您仔细阅读以下条款，如果您对本协议的任何条款表示异议，您可以选择不进入互动模块；进入互动模块则意味着您将同意遵守本协议下全部规定，并完全服从于本APP对互动内容及参与互动用户的统一管理。\n\n第一章 总则\n\n第1条 互动模块是北京易恩通智能科技有限公司向用户提供的信息发布平台，为用户提供讨论、交流的平台。\n第2条 本协议最终解释权归属北京易恩通智能科技有限公司。\n第3条 互动模块所有权、经营权、管理权均属北京易恩通智能科技有限公司。\n\n第二章 用户\n第4条  用户的个人信息受到保护，不接受任何个人或单位的查询。国家机关依法查询除外。\n第5条  用户享有言论自由的权利。\n第6条  用户的言行不得违反《计算机信息网络国际联网安全保护管理办法》、《互联网信息服务管理办法》、《互联网电子公告服务管理规定》、《维护互联网安全的决定》、《互联网新闻信息服务管理规定》等相关法律规定，不得在互动模块发布、传播或以其它方式传送含有下列内容之一的信息：\n1.反对宪法所确定的基本原则的；\n2.危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；\n3.损害国家荣誉和利益的；\n4.煽动民族仇恨、民族歧视、破坏民族团结的；\n5.破坏国家宗教政策，宣扬邪教和封建迷信的；\n6.散布谣言，扰乱社会秩序，破坏社会稳定的；\n7.散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；\n8.侮辱或者诽谤他人，侵害他人合法权利的；\n9.煽动非法集会、结社、游行、示威、聚众扰乱社会秩序的；\n10.以非法民间组织名义活动的；\n11.含有虚假、有害、胁迫、侵害他人隐私、骚扰、侵害、中伤、粗俗、猥亵、或其它道德上令人反感的内容；\n12.含有中国法律、法规、规章、条例以及任何具有法律效力之规范所限制或禁止的其它内容的。\n\n第7条 用户不得在互动模块内发布任何形式的广告，包括但不限于：\n1.发布带有任何有联系方式的网络创业、网络兼职及非真实性中奖信息；\n2.内容包含带有任何联系方式的学历职称代办，专业代做试题，作业，论文等题目以及售卖考试答案等信息；\n3.发布任何带有联系方式的银行卡代办、买卖发票、非法彩票等信息；\n4.含有联系方式的黑客、收费删帖、办证刻章等违法信息；\n5.非官方认证的发布任何带有联系方式的医院、美容、药品、祛斑、医生专家和整容等信息。\n第8条 用户应承担一切因其个人的行为而直接或间接导致的民事或刑事法律责任，因用户行为给北京易恩通智能科技有限公司造成损失的，用户应负责赔偿。\n第9条 本APP拥有对违反本站规则的用户进行处理的权力，直至禁止其在互动模块发布信息。\n第10条 任何用户发现互动贴子内容涉嫌侮辱或者诽谤他人、侵害他人合法权益的或违反本协议的，有权在该贴上点击举报按钮进行举报。";
    textView.font = [UIFont systemFontOfSize:14];
    textView.textColor = COLOR_FONT_NOMAL;
    [self.view addSubview:textView];

    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"互动模块（发帖论坛）使用协议"];
    _titleLabel.frame = CGRectMake(APP_X + 20, _titleLabel.frame.origin.y, APP_WIDTH - 20, _titleLabel.height);

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
