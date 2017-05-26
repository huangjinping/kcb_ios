//
//  FaxianViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/17.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "FaxianViewController.h"

@interface FaxianViewController ()

@end

@implementation FaxianViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setBackButtonHidden:YES];
    [self setCustomNavigationTitle:@"发现"];
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
