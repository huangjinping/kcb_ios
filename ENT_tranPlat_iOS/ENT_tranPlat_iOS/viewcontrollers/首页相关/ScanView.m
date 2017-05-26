//
//  SaomiaoViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/6/24.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "ScanView.h"


@interface ScanView ()

@end

@implementation ScanView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
    }
    return self;
}

+(Class)layerClass{
    return [AVCaptureVideoPreviewLayer class];
}

- (AVCaptureSession*)session{
    return ([(AVCaptureVideoPreviewLayer*)[self layer] session]);
}

- (void)setSession:(AVCaptureSession *)session{
    [(AVCaptureVideoPreviewLayer*)self.layer setSession:session];
}

@end
