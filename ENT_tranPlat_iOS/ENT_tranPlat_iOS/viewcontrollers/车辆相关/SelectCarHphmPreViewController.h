//
//  SelectCarHphmPreViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/21.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectCarHphmPreViewController;
@protocol SelectCarHphmPreViewControllerDelegate <NSObject>

@required
- (void)selectCarHphmPreViewController:(SelectCarHphmPreViewController*)vc selectHphmPre:(NSString*)hphmPre;

@end

@interface SelectCarHphmPreViewController : BasicViewController
@property (nonatomic , assign)  id<SelectCarHphmPreViewControllerDelegate> delegate_;

@end
