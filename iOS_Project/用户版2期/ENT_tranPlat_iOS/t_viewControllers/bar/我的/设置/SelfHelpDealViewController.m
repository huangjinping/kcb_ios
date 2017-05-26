//
//  SelfHelpDealViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-6.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "SelfHelpDealViewController.h"

@interface SelfHelpDealViewController ()

@end

@implementation SelfHelpDealViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, 30)];
    label1.text = @"交通违法行为网上自助处理使用协议";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont boldSystemFontOfSize:16];
    label1.textColor = COLOR_FONT_NOMAL;
    [self.view addSubview:label1];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, label1.bottom, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT - label1.height)];
    textView.text = @"    欢迎您使用全国道路交通违法自助服务平台办理交通违法行为网上自助处理业务，请认真阅读以下协议内容，按规范操作。\n \n1、必须成功注册为本系统用户后，才能使用本系统。用户注册成功后应当妥善保管帐号和登录口令，注册帐号仅限本人使用，不得向他人出售、转让、转借、出租。凡在本系统办理的所有业务，均视为帐号持有人本人真实意愿。\n \n2、本系统注册免费，用户在系统中进行的所有业务办理均不收取任何法定外手续费用。\n  \n3、用户在本网站注册时提供的个人资料，本网站不会以任何方式泄露给任何一方。\n \n4、由于用户将个人密码告知他人或与他人共享注册账户，导致的个人资料泄露，本网站不负任何责任。\n   \n5、任何由于黑客攻击、计算机病毒侵入或发作、因政府管制而造成的暂时性关闭等影响网络正常处理交通违法或交款的不可抗力而造成的损失，本网站不承担责任。\n  \n6、本系统为北京市公安局交通管理局“交通违法自助处理服务平台”，并无任何其它服务或代理机构。为确保用户合法权益，请不要委托他人或机构进行代办业务。\n  \n7、本系统服务范围： \n    （1）北京市公安局交通管理局籍机动车在全国范围内及全国机动车在北京市公安局交通管理局范围内的电子监控交通违法信息查询； \n    （2）公安机关交通管理部门作出的交通违法处罚决定，提供网上缴纳交通违法罚款服务；\n    （3）交通违法自助处理服务。处理范围：\n    注册用户绑定并通过本系统合法性验证的非重点管理的机动车，在本系统中可查询到并可以适用简易程序处理的电子监控交通违法行为，可以使用本系统进行自助处理。\n    机动车使用性质为公路客运、旅游客运、公交客运、出租客运、校车、危险品运输、教练车及车辆类型为中型以上载货汽车、中型以上非营运载客汽车等重点管理的机动车不提供自助处理服务。\n  \n8、在本系统接受交通违法自助处理的处理对象（当事人）为注册用户自行绑定并通过系统合法性验证的机动车所有人。违法行为发生在北京市公安局交通管理局内的，处罚机关为违法行为发生地的县级或者相当于同级的公安机关交通管理部门；违法行为发生在北京市公安局交通管理局外的，处罚机关为机动车注册登记地设区的市级或者相当于同级的公安机关交通管理部门。\n    \n9、用户在自助处理前应当认真核对交通违法信息，对全国道路交通违法自助服务平台查询到的违法行为事实及拟给予的处罚无异议后，再进行自助处理。如有异议或本系统无法满足办理要求的，请到违法行为发生地或机动车登记地公安交通管理部门服务窗口接受处理。\n \n10、用户使用互联网自助方式接受的处罚与到公安机关交通管理部门接受的处罚具有同等法律效力。\n    \n11、用户使用全国道路交通违法自助服务平台进行交通违法自助处理流程结束后，本平台将处罚决定书的内容告知被处罚人时，即视为公安机关交通管理部门已依法向自助处理申请人送达了行政处罚决定书，并自此日起计算被处罚人行使法律救济权利的期限。\n    \n12、被处罚人自接受自助处理之日起3个月内，可以持机动车行驶证及有效身份证明，到实施处罚的公安机关交通管理部门违法处理窗口打印《公安交通管理简易程序处罚决定书》。\n    \n13、用户使用本系统自助处理交通违法后，应当于自助处理之日起15日内缴纳交通违法罚款，逾期不缴纳的，每日按罚款本金的3%收取滞纳金，滞纳金数额不得超过罚款本金。\n    \n14、用户可通过本系统提供的“网上支付”服务缴纳交通违法罚款，也可自行打印本系统提供的《公安交通管理简易程序处罚决定书电子凭证》，持《公安交通管理简易程序处罚决定书电子凭证》到北京市公安局交通管理局内指定的银行网点缴纳。\n    \n15、用户不得有破坏本系统正常运行或违反国家信息安全法律法规行为以及冒用、套用他人驾驶证信息进行交通违法处理，否则，北京市公安局交通管理局公安机关交通管理部门有权对其帐号进行注销，并追究法律责任。\n    \n16、北京市公安局交通管理局对本协议负有最终解释权，并有权根据具体情况对已注册用户帐号进行适时处理及决定本系统暂停服务或停止服务。";

    textView.font = [UIFont systemFontOfSize:14];
    textView.textColor = COLOR_FONT_NOMAL;
    [self.view addSubview:textView];
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"交通违法网上自助处理使用协议"];
    _titleLabel.frame = CGRectMake(APP_X + 20, _titleLabel.frame.origin.y, APP_WIDTH - 20, _titleLabel.height);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
