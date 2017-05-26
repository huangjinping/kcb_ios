//
//  EditPhotoViewController.h
//  PatDog
//
//  Created by yzk on 14-8-19.
//  Copyright (c) 2014年 cooperLink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditPhotoView.h"
//#import "BaseViewController.h"
@class EditPhotoViewController;
@protocol EditPhotoViewControllerDelegate <NSObject>

- (void)editPhotoViewController:(EditPhotoViewController *)controller didEditImage:(UIImage *)image;

@end

@interface EditPhotoViewController : UIViewController

@property (nonatomic,assign) EditShapeType shapeType;
@property (nonatomic,retain) UIImage *image;
@property (nonatomic,assign) id<EditPhotoViewControllerDelegate> delegate;

@end
