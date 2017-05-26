//
//  DealingViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-28.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>


//#define TAG_BUTTON_SELECTED         101
//#define TAG_BUTTON_UN_SELECTED      102

@interface DealingViewController : BasicViewController

//- (IBAction)confirm:(UIButton*)btn;
//
//- (IBAction)submit:(UIButton*)btn;


//上界面传递
//@property (nonatomic, retain) NSString      *personName;
//@property (nonatomic, retain) NSString      *idNumber;

//@property (nonatomic, retain) NSString      *addr;
//@property (nonatomic, retain) NSString      *content;
@property (nonatomic, retain) CarInfo      *car;
@property (nonatomic, retain) CarPeccancyMsg      *carPeccancyMsg;

@property (nonatomic, assign) BOOL      isYunnan;

@end
