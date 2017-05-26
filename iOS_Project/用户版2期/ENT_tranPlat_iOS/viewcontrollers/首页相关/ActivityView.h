//
//  ActivityView.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 15/12/25.
//  Copyright © 2015年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActivityView;
@protocol ActivityViewDelegate <NSObject>

- (void)activityView:(ActivityView *)activityView DidSelectItemAtPath:(NSInteger)path;

@end
@interface ActivityView : UIView

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, weak) id<ActivityViewDelegate>delegate;

@end
