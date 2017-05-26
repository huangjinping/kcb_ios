//
//  CommonWebViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-11-27.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonWebViewController : BasicViewController<
UIWebViewDelegate

>


@property (nonatomic, retain, readwrite)    NSURL        *url;
@end
