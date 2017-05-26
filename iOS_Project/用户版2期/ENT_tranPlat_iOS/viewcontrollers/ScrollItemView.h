//
//  ScrollItemView.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/6.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollItemView : UIView

@property (nonatomic, strong)NSArray *items;

-(ScrollItemView *)initWithItems:(NSArray *)items;

@end
