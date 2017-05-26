//
//  AdvertisementImageView.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-13.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "AdvertisementImageView.h"

@implementation AdvertisementImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame imgsrc:(NSString*)src andHref:(NSString*)href{
    if (self = [super initWithFrame:frame]) {
        _imgsrc = [[NSString alloc] initWithString:src];
        _href = [[NSString alloc] initWithString:href];
        
        //__weak UIImageView *wself = self;
        [self setImageWithURL:[NSURL URLWithString:_imgsrc] placeholderImage:[UIImage imageNamed:@"advertisementPlaceHoder.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
            //image = [UIImage imageWithData:UIImageJPEGRepresentation(image, 0.0001)];
            //[wself setImage:image];
        }];
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)taped{
    if ([self.aImageView_Delegate respondsToSelector:@selector(advertisementImageView:didTapedWithImgsrc:andHref:)]) {
        [self.aImageView_Delegate advertisementImageView:self didTapedWithImgsrc:_imgsrc andHref:_href];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
