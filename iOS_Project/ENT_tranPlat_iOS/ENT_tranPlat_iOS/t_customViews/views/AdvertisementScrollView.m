//
//  AdvertisementScrollView.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-13.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "AdvertisementScrollView.h"

@implementation AdvertisementScrollView

- (id)initWithFrame:(CGRect)frame dataDict:(NSDictionary*)hrefsAndSrcs andDelegate:(id<AdvertisementImageViewDelegate>)advertisementImageDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _rootScrollView = [[UIScrollView alloc] initWithFrame:frame];
        [_rootScrollView setContentSize:CGSizeMake(frame.size.width * [hrefsAndSrcs count], frame.size.height)];
        [_rootScrollView setDelegate:self];
        _rootScrollView.showsHorizontalScrollIndicator = NO;
        //[_rootScrollView setPagingEnabled:YES];
        [self addSubview:_rootScrollView];
        
        NSArray *srcs = [hrefsAndSrcs allKeys];
        for (int i =0; i < [srcs count]; i++) {
            NSString *src = [srcs objectAtIndex:i];
            AdvertisementImageView *aimgV = [[AdvertisementImageView alloc] initWithFrame:CGRectMake(i * frame.size.width, 0, frame.size.width, frame.size.height) imgsrc:src andHref:[hrefsAndSrcs objectForKey:src]];
            [aimgV setAImageView_Delegate:advertisementImageDelegate];
            [_rootScrollView addSubview:aimgV];
        }
        
        if ([srcs count] == 0) {
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            [imgV setBackgroundColor:[UIColor blueColor]];
//            [imgV setImage:[UIImage imageNamed:@"advert.png"]];
            [imgV setImage:[UIImage imageNamed:@"advertisementPlaceHoder.png"]];
            [_rootScrollView addSubview:imgV];
           
        }
        
        _lastScrollOffsetX = -1;
        [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)autoScroll{
    CGFloat currentOffsetX = _rootScrollView.contentOffset.x;
    CGFloat maxX = _rootScrollView.contentSize.width - _rootScrollView.frame.size.width;
    CGFloat minX = 0;

    CGFloat newOffsetX ;
    if (currentOffsetX > _lastScrollOffsetX) {//递增中
        
        _lastScrollOffsetX = currentOffsetX;
        if (currentOffsetX == maxX) {//已达到最大值
            newOffsetX = currentOffsetX - _rootScrollView.frame.size.width;
        }else{
            newOffsetX = currentOffsetX + _rootScrollView.frame.size.width;
        }
    }else{//递减中
        _lastScrollOffsetX = currentOffsetX;
        if (currentOffsetX == minX) {
            newOffsetX = currentOffsetX + _rootScrollView.frame.size.width;
        }else{
            newOffsetX = currentOffsetX - _rootScrollView.frame.size.width;
        }
    }
    
    
    [_rootScrollView scrollRectToVisible:CGRectMake(newOffsetX, 0, _rootScrollView.frame.size.width, _rootScrollView.frame.size.height) animated:YES];
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
