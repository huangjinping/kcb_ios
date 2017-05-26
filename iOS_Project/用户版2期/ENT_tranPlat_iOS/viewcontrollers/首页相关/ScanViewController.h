//
//  ScanViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/6/29.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanViewController : UIViewController
/**预览图层，来显示照相机拍摄到的画面*/
@property (nonatomic, strong) AVCaptureVideoPreviewLayer * previewLayer;
@end
