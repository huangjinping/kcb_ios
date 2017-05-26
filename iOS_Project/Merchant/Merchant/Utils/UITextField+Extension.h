//
//  UITextField+Extension.h
//  Merchant
//
//  Created by harris.huang on 16/3/2.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)
- (NSInteger)curOffset;
- (void)makeOffset:(NSInteger)offset;
- (void)makeOffsetFromBeginning:(NSInteger)offset;
@end
