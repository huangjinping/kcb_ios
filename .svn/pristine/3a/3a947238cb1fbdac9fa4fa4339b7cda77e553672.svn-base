//
//  FiltViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/5/5.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FiltViewController;
@protocol FiltViewControllerDelegate <NSObject>

@required
- (void)filtViewController:(FiltViewController*)vc chooseHphm:(NSArray*)hphms andDate:(NSString*)date;

@end

@interface FiltViewController : BasicViewController

@property (nonatomic, assign)   id<FiltViewControllerDelegate>  delegate_;
- (id)initWithChosenHphm:(NSArray*)hphms chosenDate:(NSString*)date andHphmDatasource:(NSArray*)hphmDatasource;
@end
