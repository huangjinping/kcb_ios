//
//  QRCell.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/13.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "QRCell.h"
#import "QRCodeGenerator.h"

@implementation QRCell
{
    UIImageView *_myQRView;
    UILabel *_traNu;
    UILabel *_nameLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _myQRView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH-180, 0, 316*x_6_plus, 316*y_6_plus)];
        _myQRView.contentMode = UIViewContentModeScaleToFill;
        _traNu = [[UILabel alloc] init];
        _traNu.textColor = [UIColor whiteColor];
        _traNu.font = WY_FONT_SIZE(46);
        _traNu.backgroundColor = kTextOrangeColor;
        _traNu.layer.masksToBounds = YES;
        _traNu.layer.cornerRadius = 3*x_6_SCALE;
        _traNu.textAlignment = NSTextAlignmentCenter;
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"订单消费码";
        _nameLabel.font=WY_FONT_SIZE(30);
        
        [self.contentView addSubview:_myQRView];
        [self.contentView addSubview:_traNu];
        [self.contentView addSubview:_nameLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _nameLabel.frame = CGRectMake(460*x_6_plus, 30*y_6_plus, 170*x_6_plus, 50*y_6_plus);
   
     _traNu.origin = CGPointMake(0, _nameLabel.bottom+25*y_6_plus);
    _myQRView.frame = CGRectMake(0,_traNu.bottom+30*y_6_plus, 330*x_6_plus,  330*x_6_plus);
    _myQRView.centerX = self.contentView.boundsCenter.x;
    _traNu.centerX = self.contentView.boundsCenter.x;
    _nameLabel.centerX = self.contentView.boundsCenter.x;
}

- (void)setTraN:(NSString *)traN{
    _traNu.text = traN;
    [_traNu sizeToFit];
    _traNu.width += 20*x_6_plus;
    _traNu.height += 20*y_6_plus;
    
    [self setNeedsLayout];
}

- (void)setConsmueCode:(NSString *)consmueCode{
    if (iOS7) {
        UIImage *img = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:consmueCode] withSize:_myQRView.width];
        _myQRView.image = img;
    }else{
        _myQRView.image = [QRCodeGenerator qrImageForString:consmueCode imageSize:_myQRView.width];
    }
}

- (CIImage *)createQRForString:(NSString *)qrString {
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // 创建filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 设置内容和纠错级别
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 返回CIImage
    return qrFilter.outputImage;
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
- (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)    // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }
        else
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

@end
