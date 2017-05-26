//
//  SelectCarTypeViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/21.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectCarTypeViewController;
@protocol SelectCarTypeViewControllerDelegate <NSObject>

@required
- (void)selectCarTypeViewController:(SelectCarTypeViewController*)vc selectCarType:(NSString*)carType andCarTypeCode:(NSString*)code;

@end
@interface SelectCarTypeViewController : BasicViewController

@property (nonatomic , assign)  id<SelectCarTypeViewControllerDelegate> delegate_;
@end
