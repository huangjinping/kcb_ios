//
//  ZbarViewController.m
//  Merchant
//
//  Created by Wendy on 16/2/29.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import "ZbarViewController.h"

@interface ZbarViewController ()<ZBarReaderDelegate>

@end

@implementation ZbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.readerDelegate  =  self ;
    ZBarImageScanner  *mScanner =  self.scanner;
    self.tracksSymbols = YES;
    self.showsZBarControls = YES;
    self.supportedOrientationsMask = ZBarOrientationMask(UIInterfaceOrientationMaskPortrait);
    UIView  *view = [[UIView alloc]  initWithFrame : self.view.bounds];
    view. backgroundColor  = [UIColor   grayColor ];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg"]];
    imageView.size = CGSizeMake(280, 280);
    imageView.center = self.view.center;
    [view addSubview:imageView];
    self.cameraOverlayView  = view;
    [mScanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.readerView start];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.readerView stop];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    id<NSFastEnumeration>results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for (symbol in results) {
        break;
    }
    NSString *text = symbol.data;
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
