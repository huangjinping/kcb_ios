//
//  EditPhotoViewController.m
//  PatDog
//
//  Created by yzk on 14-8-19.
//  Copyright (c) 2014年 cooperLink. All rights reserved.
//

#import "EditPhotoViewController.h"
#import "Utils.h"

@interface EditPhotoViewController ()
<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView  *_imageView;
    CGFloat       min,max;
    CGRect        screenFrame;
}
@end

@implementation EditPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    screenFrame = [[UIScreen mainScreen] bounds];
    CGFloat y          = (screenFrame.size.height-64)/2;
    CGFloat x          = screenFrame.size.width/2;

    
    self.edgesForExtendedLayout                         = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars               = NO;
    self.modalPresentationCapturesStatusBarAppearance   = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets           = NO;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.hidesBackButton              = YES;
    self.navigationItem.title                        = @"编辑图片";
    [self setupBackBarItem];
    
    [self handleImage]; //对图片的方向进行处理，以及压缩图片

    min = MAX(kRectSizeWidth/self.image.size.width, kRectSizeHeight/self.image.size.height);
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height-64)];
    _scrollView.backgroundColor                = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator   = NO;
    _scrollView.delegate                       = self;
    _scrollView.minimumZoomScale               = min;
    _scrollView.maximumZoomScale               = 1.5;
    _scrollView.scrollsToTop                   = NO;
    _scrollView.contentInset                   = UIEdgeInsetsMake(y-kRectSizeHeight/2, x-kRectSizeWidth/2, y-kRectSizeHeight/2, x-kRectSizeWidth/2);
    _scrollView.contentSize                    = CGSizeMake(self.image.size.width,self.image.size.height);
    [self.view addSubview:_scrollView];

    _imageView                        = [[UIImageView alloc] initWithImage:self.image];
    _imageView.contentMode            = UIViewContentModeScaleAspectFill;
    _imageView.backgroundColor        = [UIColor clearColor];
    _imageView.userInteractionEnabled = YES;
    [_scrollView addSubview:_imageView];
    [_scrollView setZoomScale:min animated:NO];
    [_scrollView setContentOffset:CGPointMake(self.image.size.width*min/2-x, self.image.size.height*min/2-y)];

    
    EditPhotoView *view         = [[EditPhotoView alloc] init];
    CGRect frame                = _scrollView.frame;
    view.frame                  = frame;
    view.shapeType              = self.shapeType;
    view.backgroundColor        = [UIColor clearColor];
    view.userInteractionEnabled = NO;
    [self.view addSubview:view];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(APP_WIDTH-30-40, _scrollView.bottom-45, 40, 40);
//    [btn addBorder];
    [btn setTitle:@"确定"];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn setTitleColor:kDefaultBarTintColor forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn addTarget:self action:@selector(confirmButtonClicked)];
    
    UIBarButtonItem *itemOK = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(confirmButtonClicked)];
    [itemOK setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *itemCancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonClicked)];
    [itemCancel setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *space = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFlexibleSpace target : nil action : nil ];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,  _scrollView.bottom-45, APP_WIDTH, 44)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    toolbar.translucent = YES;
    
    toolbar.items = @[itemCancel,space,itemOK];
    
    [self.view addSubview:toolbar];
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)handleImage
{
    //调整照片角度
    self.image = [self rotateImage:self.image];
    //压缩图片
    self.image = [UIImage compressImageWith:self.image];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

-(UIImage *)getImageWithStartPoint:(CGPoint)point
{
    CGSize subImageSize    = CGSizeMake(kRectSizeWidth/_scrollView.zoomScale, kRectSizeHeight/_scrollView.zoomScale);
    //定义裁剪的区域相对于原图片的位置
    CGRect subImageRect    = CGRectMake(point.x, point.y, subImageSize.width, subImageSize.height);
    CGImageRef imageRef    = self.image.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, subImageRect);
    UIImage* subImage      = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    //返回裁剪的部分图像

    return subImage;
}

- (void)setupBackBarItem
{
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_back_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarItemClicked)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
}

- (void)backBarItemClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Button Clicked Method

- (void)confirmButtonClicked
{
    CGPoint contentOffset = _scrollView.contentOffset;
//    CGFloat y          = (screenFrame.size.height-64)/2 -kCircleRadius;
//    CGFloat x          = screenFrame.size.width/2 -kCircleRadius;
    CGFloat y          = (screenFrame.size.height-64)/2 -kRectSizeHeight/2;
    CGFloat x          = screenFrame.size.width/2 -kRectSizeWidth/2;

    CGPoint startPoint    = CGPointMake((contentOffset.x+x)/_scrollView.zoomScale, (contentOffset.y+y)/_scrollView.zoomScale);
    
    UIImage *image        = [self getImageWithStartPoint:startPoint];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(editPhotoViewController:didEditImage:)]) {
        [self.delegate editPhotoViewController:self didEditImage:image];
    }
}
- (void)cancelButtonClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

#pragma mark - private method

- (UIImage *)rotateImage:(UIImage *)aImage
{
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    CGFloat scaleRatio = 1;
    
    CGFloat boundHeight;
    UIImageOrientation orient = aImage.imageOrientation;
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

@end
