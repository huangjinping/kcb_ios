//
//  ScanViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/6/29.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "ScanViewController.h"
#import "ScanView.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import "JDSBHSearchPayViewController.h"

@interface ScanViewController ()<
AVCaptureVideoDataOutputSampleBufferDelegate
>
@property (assign ,nonatomic)   BOOL deviceAuthorized;

@property (nonatomic) AVCaptureSession  *session;
@property (nonatomic) AVCaptureDeviceInput *input;
@property (nonatomic) AVCaptureVideoDataOutput *output;
@property (nonatomic) dispatch_queue_t sessionQueue;
@property (nonatomic) UIBackgroundTaskIdentifier backgroundRecordingID;
@property (nonatomic) id runtimeErrorHandlingObserver;
@property (assign, nonatomic) BOOL lockInterfaceRotation;

@property (assign, nonatomic) BOOL analysising;
@property (assign, nonatomic) BOOL done;


@property (nonatomic) ScanView  *scanView;
@property (nonatomic) NSTimer   *timer;

@end

@implementation ScanViewController



- (void)loadView{
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    ScanView *scanview = [[ScanView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT + APP_STATUS_BAR_HEIGHT)];
    ((AVCaptureVideoPreviewLayer*)scanview.layer).videoGravity = AVLayerVideoGravityResizeAspectFill;

    self.view = scanview;

    self.scanView = scanview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.analysising = NO;
    self.done = NO;
    
    UILabel *label = [[UILabel alloc] initWithFrame:LGRectMake(30, 150, self.view.w - 30*2, 200)];
    [label convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_BUTTON_YELLOW textAlignment:NSTextAlignmentCenter];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor whiteColor];
    [label setText:@"请将订单编号置于下方黄色框内\n(例如\"编号：1234567890\"置于框内即可)"];
    [self.view addSubview:label];
    
    UIView *view = [[UIView alloc] initWithFrame:LGRectMake(0, 350, self.view.w, 100)];
    view.backgroundColor = [UIColor yellowColor];
    view.alpha = 0.5;
    [self.view addSubview:view];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setBackgroundColor:[UIColor clearColor]];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton addTarget: self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setFrame:CGRectMake(0, 0, 50, 40)];
    [self.view addSubview:cancelButton];
    
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    self.session = session;
    [self.scanView setSession:session];
    
    [self checkDeviceAuthorizationStatus];
    
    
    dispatch_queue_t sessionQueue = dispatch_queue_create("session queue", DISPATCH_QUEUE_SERIAL);
    [self setSessionQueue:sessionQueue];
    
    dispatch_async(sessionQueue, ^{
        
        [self setBackgroundRecordingID:UIBackgroundTaskInvalid];
        NSError *err = nil;
        AVCaptureDevice *device = [ScanViewController deviceWithMediaType:AVMediaTypeVideo preferringPosition:AVCaptureDevicePositionBack];
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&err];
        if (err) {
            ENTLog(@"%@", err);
        }else{
            if ([session canAddInput:input]) {
                [session addInput:input];
                [self setInput:input];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[(AVCaptureVideoPreviewLayer*)[[self scanView] layer] connection] setVideoOrientation:(AVCaptureVideoOrientation)[self interfaceOrientation]];
                });
            }
        }
        
        AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
        dispatch_queue_t outputQueue = dispatch_queue_create("output call back queue", DISPATCH_QUEUE_SERIAL);
        [output setSampleBufferDelegate:self queue:outputQueue];
        output.videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
        //output.availableVideoCVPixelFormatTypes
        if ([session canAddOutput:output]) {
            [session addOutput:output];
            [self setOutput:output];
        }
        
        
    });
    
    
}

static void *CapturingStillImageContext = &CapturingStillImageContext;
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];//??
    self.navigationController.navigationBarHidden = YES;

    dispatch_async([self sessionQueue], ^{
        
        //[self addObserver:self forKeyPath:@"stillImageOutput.capturingStillImage" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:CapturingStillImageContext];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subjectAreaDidChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:[[self input] device]];
        
        
        __weak ScanViewController *weakSelf = self;
        [self setRuntimeErrorHandlingObserver:[[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureSessionRuntimeErrorNotification object:[self session] queue:nil usingBlock:^(NSNotification *note) {
            
            ScanViewController *strongSelf = weakSelf;
            dispatch_async([strongSelf sessionQueue], ^{
                
                [[strongSelf session] startRunning];
              //  [[strongSelf recordButton] setTitle:NSLocalizedString(@"Record", @"Recording button record title") forState:UIControlStateNormal];
            });
        }]];
        [[self session] startRunning];
    });
}



- (void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    
    
    dispatch_async([self sessionQueue], ^{
        [[self session] stopRunning];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVCaptureDeviceSubjectAreaDidChangeNotification object:[[self input] device]];
        [[NSNotificationCenter defaultCenter] removeObserver:[self runtimeErrorHandlingObserver]];
        
        //[self removeObserver:self forKeyPath:@"stillImageOutput.capturingStillImage" context:CapturingStillImageContext];
    });
}


- (BOOL)shouldAutorotate
{
    // Disable autorotation of the interface when recording is in progress.
    return ![self lockInterfaceRotation];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [[(AVCaptureVideoPreviewLayer *)[[self scanView] layer] connection] setVideoOrientation:(AVCaptureVideoOrientation)toInterfaceOrientation];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == CapturingStillImageContext)
    {
        BOOL isCapturingStillImage = [change[NSKeyValueChangeNewKey] boolValue];
        
        if (isCapturingStillImage)
        {
            [self runStillImageCaptureAnimation];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}




#pragma mark Actions
// 通过抽样缓存数据创建一个UIImage对象
- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    // 为媒体数据设置一个CMSampleBuffer的Core Video图像缓存对象
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // 锁定pixel buffer的基地址
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // 得到pixel buffer的基地址
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // 得到pixel buffer的行字节数
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // 得到pixel buffer的宽和高
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    //NSLog(@"%zu,%zu",width,height);
    
    // 创建一个依赖于设备的RGB颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // 用抽样缓存的数据创建一个位图格式的图形上下文（graphics context）对象
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    
    
    // 根据这个位图context中的像素数据创建一个Quartz image对象
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // 解锁pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // 释放context和颜色空间
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    //    cgimageget`
    
    // 用Quartz image创建一个UIImage对象image
    //UIImage *image = [UIImage imageWithCGImage:quartzImage];
    UIImage *image = [UIImage imageWithCGImage:quartzImage scale:1.0f orientation:UIImageOrientationRight];
    
    // 释放Quartz image对象
    CGImageRelease(quartzImage);
    
    return (image);
    
    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    
    if (self.analysising){
        return;
    }
    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
    if (image == nil) {
        return;
    }
    CGFloat bili = image.size.height/APP_HEIGHT;
    UIImage *smallImage = [self getImageFromImage:image subImageRect:CGRectMake(0, 350*PX_Y_SCALE*bili, image.size.width, 100*PX_Y_SCALE*bili)];
    
    
    //[[[ALAssetsLibrary alloc] init] writeImageToSavedPhotosAlbum:[smallImage CGImage] orientation:(ALAssetOrientation)[smallImage imageOrientation] completionBlock:nil];
    
    
    
    [self netOCRImageWithimage:smallImage];
}


- (void)cancelButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)netOCRImageWithimage:(UIImage*)image{
    self.analysising = YES;
    //image = [UIImage imageNamed:@"tongshoujixiangce.jpg"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    NSString *imgStr = [imageData base64Encoding];
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDict setObject:@"iPhone" forKey:@"fromdevice"];
    [bodyDict setObject:@"10.10.10.0" forKey:@"clientip"];//默认值10.10.10.0
    [bodyDict setObject:@"Recognize" forKey:@"detecttype"];
    [bodyDict setObject:@"CHN_ENG" forKey:@"languagetype"];
    [bodyDict setObject:@"1" forKey:@"imagetype"];//2是原图，1是base64图
    [bodyDict setObject:imgStr forKey:@"image"];
    
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:@"apis.baidu.com" apiPath:@"apistore/idlocr/ocr" customHeaderFields:[NSDictionary dictionaryWithObjectsAndKeys:@"b428ff0698d4974665f0d6de693f9b40", @"apikey",  nil]];//@"application/x-www-form-urlencoded", @"Content-Type",
    MKNetworkOperation *op = [en operationWithPath:@"" params:bodyDict httpMethod:@"POST"];
    ENTLog(@"OCR解析：%@", op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString *responseStr = completedOperation.responseString;
        if (responseStr) {
            
            
            responseStr = [responseStr stringReplaceFromUnicode];
            responseStr = [responseStr stringDecode];
            ENTLog(@"OCR解析：%@", responseStr);
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSDictionary *resDict = [parser objectWithString:responseStr];
            NSString *errNum = [resDict analysisStrValueByKey:@"errNum"];
            if ([errNum isEqualToString:@"0"]) {//succ
                
                
                /*
                
                {"errNum":"0","errMsg":"success","querySign":"495289983,1258281120","retData":[{"rect":{"left":"0","top":"0","width":"1081","height":"136"},"word":"编号:1359W8W59m·景|8|愚|N|1|||||||"}]}
                 */
                
                //NSString *querySign = [resDict analysisStrValueByKey:@"querySign"];
                NSArray *retDataArr = [resDict analysisArrValueByKey:@"retData"];
                if ([retDataArr count] != 0 ) {
                    for (NSDictionary *dict in retDataArr) {
                        NSString *word = [dict analysisStrValueByKey:@"word"];
                        if ([word rangeOfString:@"编号"].length != 0) {
                            //[UIAlertView alertTitle:@"" msg:word];
                            //[self cancelButtonClicked];
                            
                            if (!self.done) {
                                self.done = YES;
                                JDSBHSearchPayViewController *jdsbhvc = [[JDSBHSearchPayViewController alloc] init];
                                NSString *jdsbh = [word substringFromIndex:[word rangeOfString:@"编号"].location + [word rangeOfString:@"编号"].length];
                                if ([jdsbh hasPrefix:@":"]) {
                                    jdsbh = [jdsbh substringFromIndex:1];
                                }
                                if ([jdsbh length] > 16) {
                                    jdsbh = [jdsbh substringToIndex:16];
                                }
                                jdsbhvc.jdsbh = jdsbh;
                                [self.navigationController pushViewController:jdsbhvc animated:YES];
                            }
                            
                        }
                    }
                }
            }else{
                //NSString *errMsg = [resDict analysisStrValueByKey:@"errMsg"];

            }
            
            
            
        }else{//服务器异常返回为空
        
        }
        
        self.analysising = NO;
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        self.analysising = NO;

        ENTLog(@"OCR解析：%@", error);
    }];
    [en enqueueOperation:op];
    
}

- (BOOL)rightString:(NSString*)string{
    
    //校验15位数字
 
    NSRegularExpression *regx = [NSRegularExpression regularExpressionWithPattern:@"^\\d{15,}$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *match = [regx firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    BOOL isMatch = match!=nil;
    
    return isMatch;
    
    
}
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


//图片裁剪
-(UIImage *)getImageFromImage:(UIImage*)superImage subImageRect:(CGRect)subImageRect {
    
    superImage = [self fixOrientation:superImage];
    CGImageRef subImageRef = CGImageCreateWithImageInRect(superImage.CGImage, subImageRect);
    UIGraphicsBeginImageContext(subImageRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextRotateCTM(context,M_PI/2);
    CGContextDrawImage(context, CGRectMake(0, 0, 10, 10), subImageRef);
    UIImage* returnImage = [UIImage imageWithCGImage:subImageRef] ;//]scale:1 orientation:UIImageOrientationRight];
    
    UIGraphicsEndImageContext(); //返回裁剪的部分图像
    return returnImage;
}


- (void)subjectAreaDidChange:(NSNotification *)notification
{
    CGPoint devicePoint = CGPointMake(.5, .5);
    [self focusWithMode:AVCaptureFocusModeContinuousAutoFocus exposeWithMode:AVCaptureExposureModeContinuousAutoExposure atDevicePoint:devicePoint monitorSubjectAreaChange:NO];
}

#pragma mark File Output Delegate

//- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
//{
//    if (error)
//        NSLog(@"%@", error);
//    
//    [self setLockInterfaceRotation:NO];
//    
//    // Note the backgroundRecordingID for use in the ALAssetsLibrary completion handler to end the background task associated with this recording. This allows a new recording to be started, associated with a new UIBackgroundTaskIdentifier, once the movie file output's -isRecording is back to NO — which happens sometime after this method returns.
//    UIBackgroundTaskIdentifier backgroundRecordingID = [self backgroundRecordingID];
//    [self setBackgroundRecordingID:UIBackgroundTaskInvalid];
//    
//    [[[ALAssetsLibrary alloc] init] writeVideoAtPathToSavedPhotosAlbum:outputFileURL completionBlock:^(NSURL *assetURL, NSError *error) {
//        if (error)
//            NSLog(@"%@", error);
//        
//        [[NSFileManager defaultManager] removeItemAtURL:outputFileURL error:nil];
//        
//        if (backgroundRecordingID != UIBackgroundTaskInvalid)
//            [[UIApplication sharedApplication] endBackgroundTask:backgroundRecordingID];
//    }];
//}
#pragma mark Device Configuration

- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposeWithMode:(AVCaptureExposureMode)exposureMode atDevicePoint:(CGPoint)point monitorSubjectAreaChange:(BOOL)monitorSubjectAreaChange
{
    dispatch_async([self sessionQueue], ^{
        AVCaptureDevice *device = [[self input] device];
        NSError *error = nil;
        if ([device lockForConfiguration:&error])
        {
            if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:focusMode])
            {
                [device setFocusMode:focusMode];
                [device setFocusPointOfInterest:point];
            }
            if ([device isExposurePointOfInterestSupported] && [device isExposureModeSupported:exposureMode])
            {
                [device setExposureMode:exposureMode];
                [device setExposurePointOfInterest:point];
            }
            [device setSubjectAreaChangeMonitoringEnabled:monitorSubjectAreaChange];
            [device unlockForConfiguration];
        }
        else
        {
            NSLog(@"%@", error);
        }
    });
}

+ (void)setFlashMode:(AVCaptureFlashMode)flashMode forDevice:(AVCaptureDevice *)device
{
    if ([device hasFlash] && [device isFlashModeSupported:flashMode])
    {
        NSError *error = nil;
        if ([device lockForConfiguration:&error])
        {
            [device setFlashMode:flashMode];
            [device unlockForConfiguration];
        }
        else
        {
            NSLog(@"%@", error);
        }
    }
}

+ (AVCaptureDevice *)deviceWithMediaType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
    AVCaptureDevice *captureDevice = [devices firstObject];
    
    for (AVCaptureDevice *device in devices)
    {
        if ([device position] == position)
        {
            captureDevice = device;
            break;
        }
    }
    
    return captureDevice;
}

#pragma mark UI

- (void)runStillImageCaptureAnimation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[self scanView] layer] setOpacity:0.0];
        [UIView animateWithDuration:.25 animations:^{
            [[[self scanView] layer] setOpacity:1.0];
        }];
    });
}

- (void)checkDeviceAuthorizationStatus
{
    //testing
    [self setDeviceAuthorized:YES];
    return;
    NSString *mediaType = AVMediaTypeVideo;
    
    [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
        if (granted)
        {
            //Granted access to mediaType
            [self setDeviceAuthorized:YES];
        }
        else
        {
            //Not granted access to mediaType
            dispatch_async(dispatch_get_main_queue(), ^{
                [[[UIAlertView alloc] initWithTitle:@"AVCam!"
                                            message:@"AVCam doesn't have permission to use Camera, please change privacy settings"
                                           delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil] show];
                [self setDeviceAuthorized:NO];
            });
        }
    }];
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
