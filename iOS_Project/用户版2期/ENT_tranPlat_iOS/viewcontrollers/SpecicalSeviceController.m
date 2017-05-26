//
//  SpecicalSeviceController.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/6.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "SpecicalSeviceController.h"
#import "ScrollItemView.h"

@implementation SpecicalSeviceController
{
    BOOL _res;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
}

- (void)configUI{
    ScrollItemView *sv = [[ScrollItemView alloc]initWithItems:@[@"1",@"2"]];
    sv.origin = CGPointMake(0, 100);
    [self.view addSubview:sv];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];;
    btn.frame = CGRectMake(0, sv.bottom, 60, 60);
    btn.backgroundColor = [UIColor orangeColor];
    [btn addActionBlock:^(id weakSender) {
        if (_res) {
            sv.items = @[@"1",@"2"];
        }else{
            sv.items = @[@""];

        }
        _res = !_res;
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

@end
