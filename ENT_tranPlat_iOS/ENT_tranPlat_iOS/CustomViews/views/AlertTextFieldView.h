//
//  ENTAlertTextFieldView.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-26.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class ENTAlertTextFieldView;
//@protocol ENTAlertTextFieldViewDelegate <NSObject>
//
//@optional
//- (void)entAlertTextFieldView:(ENTAlertTextFieldView*)alertTextView didFinishedEntry:(NSArray*)entryTexts;
//
//@end

@interface AlertTextFieldView : UIImageView<
UITextFieldDelegate
>

{
    UIViewController          *_sender;
    
    SEL                         _sel;
    
    
    int                         _offset;
    
    UIView                      *_bgView;
}

//@property (nonatomic, assign)   id<ENTAlertTextFieldViewDelegate> _delegate;

- (NSString*)textAtIndex:(NSInteger)index;

- (void)show;

- (id)initWithTarget:(UIViewController*)sender selector:(SEL)sel placehoders:(NSArray*)placehoderStrings;
@end
