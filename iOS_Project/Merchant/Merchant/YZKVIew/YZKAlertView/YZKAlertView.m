//
//  YZKAlertView.m
//  TestAlert
//
//  Created by yzk on 14/11/13.
//  Copyright (c) 2014年 Seungbo Cho. All rights reserved.
//

#import "YZKAlertView.h"

#define Do_IsIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)

#define YZKALERT_VIEW_WIDTH       (0.875*[[UIScreen mainScreen] bounds].size.width)
#define DO_YES_TAG          100
#define DO_NO_TAG           200

#pragma mark - YZKAlertViewController

@interface YZKAlertViewController : UIViewController
@property (nonatomic, strong) YZKAlertView *alertView;
@end

@implementation YZKAlertViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view = _alertView;
}
@end


#pragma mark - YZKAlertView

@implementation YZKAlertView
{
    NSString                *_strAlertTitle;
    NSString                *_strAlertBody;
    BOOL                    _bNeedNo;
    
    RIButtonItem            *_doYes;
    RIButtonItem            *_doNo;
    RIButtonItem            *_doDone;
    
    UIWindow                *_alertWindow;
    UIView                  *_vAlert;
}

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
        self.dRound = 5;
    }
    return self;
}

// With Title, Alert body, Yes button, No button
- (void)YZKAlertTitle:(NSString *)strTitle
                 body:(NSString *)strBody
                 left:(RIButtonItem *)yes
                right:(RIButtonItem *)no
{
    _strAlertTitle  = strTitle;
    _strAlertBody   = strBody;
    _bNeedNo        = YES;
    
    _doYes  = yes;
    _doNo   = no;
    
    [self showAlertView];
}

// Without any button
- (void)YZKAlertTitle:(NSString *)strTitle
                 body:(NSString *)strBody
             duration:(double)dDuration
                 done:(RIButtonItem *)done
{
    _strAlertTitle  = strTitle;
    _strAlertBody   = strBody;
    _bNeedNo        = NO;
    
    _doYes          = nil;
    _doNo           = nil;
    _doDone         = done;
    
    [self showAlertView];
    
    if (dDuration > 0) {
        [NSTimer scheduledTimerWithTimeInterval:dDuration
                                         target:self
                                       selector:@selector(onTimer)
                                       userInfo:nil
                                        repeats:NO];
    }
}

- (void)onTimer
{
    [self hideAlert];
}

- (void)hideAlert
{
    _nTag = DO_YES_TAG;
    [self hideAnimation];
}

- (void)showAlertView
{
    double dHeight = 0;
    self.backgroundColor = YZKALERT_COLOR;
    
    // make back view -----------------------------------------------------------------------------------------------
    _vAlert = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YZKALERT_VIEW_WIDTH, 0)];
    _vAlert.alpha = 1;
    _vAlert.backgroundColor = [UIColor clearColor];
    [self addSubview:_vAlert];
    
    // Title --------------------------------------------------------------------------------------------------------
    if (_strAlertTitle != nil && _strAlertTitle.length > 0)
    {
        UIView *vTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _vAlert.frame.size.width, 0)];
        vTitle.backgroundColor = YZKALERT_TITLE_BACKGROUNDCOLOR;
        [_vAlert addSubview:vTitle];
        
        UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(YZKALERT_TITLE_INSET.left, YZKALERT_TITLE_INSET.top,_vAlert.frame.size.width - (YZKALERT_TITLE_INSET.left + YZKALERT_TITLE_INSET.right) , 0)];
        lbTitle.text = _strAlertTitle;
        lbTitle.backgroundColor = [UIColor clearColor];
        lbTitle.textAlignment = NSTextAlignmentCenter;
        lbTitle.numberOfLines = 0;
        lbTitle.font = YZKALERT_TITLE_FONT;
        lbTitle.textColor = YZKALERT_TITLE_COLOR;
        lbTitle.frame = CGRectMake(YZKALERT_TITLE_INSET.left, YZKALERT_TITLE_INSET.top, lbTitle.frame.size.width, [self getTextHeight:lbTitle]);
        [vTitle addSubview:lbTitle];
        
        vTitle.frame = CGRectMake(0, 0, _vAlert.frame.size.width, lbTitle.frame.size.height + (YZKALERT_TITLE_INSET.top + YZKALERT_TITLE_INSET.bottom));
        dHeight = vTitle.frame.size.height+0.5;
    }
    
    // Body ---------------------------------------------------------------------------------------------------------
    UIView *vBody = [[UIView alloc] initWithFrame:CGRectMake(0, dHeight - 0.5, _vAlert.frame.size.width, 0)];
    [_vAlert addSubview:vBody];
    vBody.backgroundColor = YZKALERT_BODY_BACKGROUNDCOLOR;
    
    // Body text ----------------------------------------------------------------------------------------------------
    UILabel *lbBody = [[UILabel alloc] initWithFrame:CGRectMake(YZKALERT_BODY_INSET.left, YZKALERT_BODY_INSET.top,_vAlert.frame.size.width - (YZKALERT_BODY_INSET.left + YZKALERT_BODY_INSET.right) , 0)];
    lbBody.text = _strAlertBody;
    lbBody.backgroundColor = [UIColor clearColor];
    lbBody.textAlignment = NSTextAlignmentCenter;
    lbBody.numberOfLines = 0;
    lbBody.font = YZKALERT_BODY_FONT;
    lbBody.textColor = YZKALERT_BODY_COLOR;
    lbBody.frame = CGRectMake(YZKALERT_BODY_INSET.left, lbBody.frame.origin.y, lbBody.frame.size.width, [self getTextHeight:lbBody]);
    [vBody addSubview:lbBody];
    
    vBody.frame = CGRectMake(0, dHeight - 0.5, _vAlert.frame.size.width,lbBody.frame.size.height + (YZKALERT_BODY_INSET.top + YZKALERT_BODY_INSET.bottom) + 0.5);
    dHeight += vBody.frame.size.height;
    
    // No button -----------------------------------------------------------------------------------------------------
    UIButton *btNo;
    if (_doNo != nil)
    {
        btNo                 = [UIButton buttonWithType:UIButtonTypeCustom];
        btNo.frame           = CGRectMake(0, dHeight, _vAlert.frame.size.width, 40);
        btNo.backgroundColor = YZKALERT_BUTTON_BACKGROUNDCOLOR;
        btNo.tag             = DO_NO_TAG;
        btNo.titleLabel.font = YZKALERT_BUTTON_FONT;
        [btNo setTitleColor:YZKALERT_BUTTON_COLOR forState:UIControlStateNormal];
        [btNo setTitle:_doNo.label forState:UIControlStateNormal];
//        [btNo setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
        [btNo addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
        
        [_vAlert addSubview:btNo];
        
        dHeight += 40;
    }
    
    // Yes button -----------------------------------------------------------------------------------------------------
    if (_doYes != nil)
    {
        UIButton *btYes = [UIButton buttonWithType:UIButtonTypeCustom];
        if (_doNo == nil) {
            btYes.frame = CGRectMake(0, dHeight, _vAlert.frame.size.width, 40);
            dHeight += 40;
        }else {
            btNo.frame = CGRectMake(0, btNo.frame.origin.y, _vAlert.frame.size.width / 2.0 - 1, 40);
            btYes.frame = CGRectMake(_vAlert.frame.size.width / 2.0 - 0.5, btNo.frame.origin.y, _vAlert.frame.size.width / 2.0 + 0.5, 40);
        }
        
        btYes.backgroundColor = YZKALERT_BUTTON_BACKGROUNDCOLOR;
        btYes.tag = DO_YES_TAG;
        btYes.titleLabel.font = YZKALERT_BUTTON_FONT;
        [btYes setTitleColor:YZKALERT_BUTTON_COLOR forState:UIControlStateNormal];
        [btYes setTitle:_doYes.label forState:UIControlStateNormal];
//        [btYes setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        [btYes addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
        
        [_vAlert addSubview:btYes];
    }
    
    _vAlert.frame = CGRectMake(0, 0, YZKALERT_VIEW_WIDTH, dHeight);
    
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//    effectView.frame = CGRectMake(0, 0, YZKALERT_VIEW_WIDTH, dHeight);
//    [effectView addSubview:_vAlert];
//    [self addSubview:effectView];
//    _vAlert = effectView;
    
    
    YZKAlertViewController *viewController = [[YZKAlertViewController alloc] initWithNibName:nil bundle:nil];
    viewController.alertView = self;
    
    if (!_alertWindow)
    {
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        window.opaque = NO;
        window.windowLevel = UIWindowLevelAlert;
        window.rootViewController = viewController;
        _alertWindow = window;
        
        self.frame = window.frame;
        _vAlert.center = window.center;
    }
    [_alertWindow makeKeyAndVisible];
    
    if (_dRound > 0)
    {
        CALayer *layer = [_vAlert layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:_dRound];
    }
    
    [self showAnimation];
}

- (void)buttonTarget:(UIButton *)sender
{
    _nTag = sender.tag;
    [self hideAnimation];
}

- (double)getTextHeight:(UILabel *)lbText
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    NSDictionary *attributes = @{NSFontAttributeName:lbText.font};
    CGRect rect = [lbText.text boundingRectWithSize:CGSizeMake(lbText.frame.size.width, MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil];
    
    return ceil(rect.size.height);
#else
    CGSize size = [lbText.text sizeWithFont:lbText.font
                          constrainedToSize:CGSizeMake(lbText.frame.size.width, MAXFLOAT)];
    return ceil(size.height);
#endif
}

- (void)hideAlertView
{
    if (_doDone != nil) {
        if (_doDone.action) {
            _doDone.action();
        }
    }else {
        if (_nTag == DO_YES_TAG) {
            if (_doYes.action) {
                _doYes.action();
            }
        }else {
            if (_doNo.action) {
                _doNo.action();
            }
        }
    }
    
    [self removeFromSuperview];
    [_alertWindow removeFromSuperview];
    _alertWindow = nil;
}

- (void)showAnimation
{
    CGRect r = _vAlert.frame;
    CGPoint ptCenter = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    self.alpha = 0.0;
    
    switch (_nAnimationType) {
        case YZKAlertTransitionStyleTopDown:
            _vAlert.center = CGPointMake(self.bounds.size.width / 2.0, -self.bounds.size.height / 2.0);
            break;
            
        case YZKAlertTransitionStyleBottomUp:
            _vAlert.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0 + self.bounds.size.height);
            break;
            
        case YZKAlertTransitionStyleFade:
            _vAlert.center = ptCenter;
            _vAlert.alpha = 0.0;
            break;
            
        case YZKAlertTransitionStylePop:
            _vAlert.alpha = 0.0;
            _vAlert.center = ptCenter;
            _vAlert.transform = CGAffineTransformMakeScale(0.05, 0.05);
            break;
            
        case YZKAlertTransitionStyleLine:
            _vAlert.frame = CGRectMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0, 1, 1);
            _vAlert.clipsToBounds = YES;
            break;
            
        default:
            break;
    }
    
    double dDuration = 0.2;
    
    switch (_nAnimationType) {
        case YZKAlertTransitionStyleTopDown:
        case YZKAlertTransitionStyleBottomUp:
            dDuration = 0.3;
            break;
            
        default:
            break;
    }
    
    [UIView animateWithDuration:dDuration animations:^(void) {
        
        self.alpha = 1.0;
        
        switch (_nAnimationType) {
            case YZKAlertTransitionStyleTopDown:
            case YZKAlertTransitionStyleBottomUp:
                _vAlert.center = ptCenter;
                break;
                
            case YZKAlertTransitionStyleFade:
                _vAlert.alpha = 1.0;
                break;
                
            case YZKAlertTransitionStylePop:
                _vAlert.alpha = 1.0;
                _vAlert.transform = CGAffineTransformMakeScale(1.05, 1.05);
                break;
                
            case YZKAlertTransitionStyleLine:
                _vAlert.frame = CGRectMake((self.bounds.size.width - YZKALERT_VIEW_WIDTH) / 2, self.bounds.size.height / 2.0, YZKALERT_VIEW_WIDTH, 1);
                break;
            default:
                break;
        }
        
    } completion:^(BOOL finished) {
        
        switch (_nAnimationType) {
            case YZKAlertTransitionStylePop:
            {
                [UIView animateWithDuration:0.1 animations:^(void) {
                    _vAlert.alpha = 1.0;
                    _vAlert.transform = CGAffineTransformMakeScale(1.0, 1.0);
                }];
            }
                break;
                
            case YZKAlertTransitionStyleLine:
            {
                [UIView animateWithDuration:0.2 animations:^(void) {
                    [UIView setAnimationDelay:0.1];
                    _vAlert.center = ptCenter;
                    _vAlert.frame = CGRectMake(_vAlert.frame.origin.x, _vAlert.frame.origin.y - r.size.height / 2.0, r.size.width, r.size.height);
                }];
            }
                break;
            default:
                break;
        }
    }];
}

- (void)hideAnimation
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
    double dDuration = 0.2;
    switch (_nAnimationType) {
        case YZKAlertTransitionStyleTopDown:
        case YZKAlertTransitionStyleBottomUp:
            dDuration = 0.3;
            break;
        case YZKAlertTransitionStylePop:
            dDuration = 0.1;
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:dDuration animations:^(void) {
        
        switch (_nAnimationType) {
            case YZKAlertTransitionStyleTopDown:
                if (_nTag == DO_YES_TAG)
                    _vAlert.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0 + self.bounds.size.height);
                else
                    _vAlert.center = CGPointMake(self.bounds.size.width / 2.0, -self.bounds.size.height / 2.0);
                
                [UIView setAnimationDelay:0.1];
                self.alpha = 0.0;
                break;
                
            case YZKAlertTransitionStyleBottomUp:
                if (_nTag == DO_YES_TAG)
                    _vAlert.center = CGPointMake(self.bounds.size.width / 2.0, -self.bounds.size.height / 2.0);
                else
                    _vAlert.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0 + self.bounds.size.height);
                
                [UIView setAnimationDelay:0.1];
                self.alpha = 0.0;
                break;
                
            case YZKAlertTransitionStyleFade:
                _vAlert.alpha = 0.0;
                
                [UIView setAnimationDelay:0.1];
                self.alpha = 0.0;
                break;
                
            case YZKAlertTransitionStylePop:
                _vAlert.transform = CGAffineTransformMakeScale(1.05, 1.05);
                break;
                
            case YZKAlertTransitionStyleLine:
                _vAlert.frame = CGRectMake((self.bounds.size.width - YZKALERT_VIEW_WIDTH) / 2, self.bounds.size.height / 2.0, YZKALERT_VIEW_WIDTH, 1);
                break;
            default:
                break;
        }
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^(void) {
            
            switch (_nAnimationType) {
                case YZKAlertTransitionStylePop:
                    [UIView setAnimationDelay:0.05];
                    self.alpha = 0.0;
                    _vAlert.transform = CGAffineTransformMakeScale(0.05, 0.05);
                    _vAlert.alpha = 0.0;
                    break;
                    
                case YZKAlertTransitionStyleLine:
                    [UIView setAnimationDelay:0.1];
                    _vAlert.frame = CGRectMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0, 1, 1);
                    
                    [UIView setAnimationDelay:0.2];
                    self.alpha = 0.0;
                    break;
                default:
                    break;
            }
            
        } completion:^(BOOL finished) {
            [self hideAlertView];
        }];
    }];
}

-(void)receivedRotate: (NSNotification *)notification
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        
        [UIView animateWithDuration:0.1 animations:^(void) {
            
            _vAlert.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2 animations:^(void) {
                _vAlert.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
                _vAlert.alpha = 0.9;
            }];
        }];
    });
}

@end
