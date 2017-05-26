//
//  BasicViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-14.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicViewController : UIViewController
{
    UIImageView                 *_navigationImgView;
    UIButton                    *_backButton;
    UILabel                     *_titleLabel;
    UIButton                    *_blogButton;
    
    
    BOOL                        _customNavExist;
}

//@property (nonatomic, retain)       NSString      *customNavigationTitle;




- (void)setCustomNavigationHidden:(BOOL)hidden;
- (void)setCustomNavigationTitle:(NSString *)title;

- (void)setBackButtonHidden:(BOOL)hidden;
- (void)gobackPage;

//- (void)isHomePage;





@end
