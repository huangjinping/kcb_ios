//
//  AdvertisementScrollView.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-13.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>
#import "AdvertisementImageView.h"


@interface AdvertisementScrollView : UIView<
UIScrollViewDelegate,
AdvertisementImageViewDelegate
>
{
    UIScrollView            *_rootScrollView;
    
    CGFloat                 _lastScrollOffsetX;

}


- (id)initWithFrame:(CGRect)frame dataDict:(NSDictionary*)hrefsAndSrcs andDelegate:(id<AdvertisementImageViewDelegate>)advertisementImageDelegate;


@end
