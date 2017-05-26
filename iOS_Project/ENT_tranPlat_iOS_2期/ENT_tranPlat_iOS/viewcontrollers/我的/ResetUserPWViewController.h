//
//  ResetUserPWViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/5/4.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ResetUserPWViewControllerDelegate <NSObject>
@required
- (void)passwordChanged;

@end

@interface ResetUserPWViewController : BasicViewController
@property (nonatomic, assign)   id<ResetUserPWViewControllerDelegate> delegate_;

@property (nonatomic, assign)   BOOL    needOldPW;
@property (nonatomic, retain)   NSString *userName;
@end
