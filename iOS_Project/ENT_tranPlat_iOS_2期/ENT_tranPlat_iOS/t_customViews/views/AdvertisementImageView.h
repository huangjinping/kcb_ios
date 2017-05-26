//
//  AdvertisementImageView.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-13.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@class AdvertisementImageView;

@protocol AdvertisementImageViewDelegate <NSObject>

@optional
- (void)advertisementImageView:(AdvertisementImageView*)aImageView didTapedWithImgsrc:(NSString*)imgsrc andHref:(NSString*)href;

@end


@interface AdvertisementImageView : UIImageView
{
    NSString        *_imgsrc;
    NSString        *_href;
}
@property (nonatomic, assign)   id<AdvertisementImageViewDelegate>    aImageView_Delegate;

- (id)initWithFrame:(CGRect)frame imgsrc:(NSString*)src andHref:(NSString*)href;
@end
