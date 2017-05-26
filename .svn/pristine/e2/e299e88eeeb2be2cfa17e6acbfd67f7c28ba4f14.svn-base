//
//  UILabel+RedStarPrefix.m
//  ReimbursementForABB
//
//  Created by WeiHan on 10/19/15.
//  Copyright © 2015 wendy. All rights reserved.
//

#import "UILabel+RedStarPrefix.h"

@implementation UILabel (RedStarPrefix)

- (void)markStarRequired
{
    NSString *strStar = @"*";
    NSString *text = self.text ? : self.attributedText.string;

    if ([text hasPrefix:strStar]) {
        return;
    }

    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", strStar, text] attributes:nil];
    [attributeText setAttributes:@{ NSForegroundColorAttributeName: [UIColor redColor] } range:NSMakeRange(0, strStar.length)];

    self.attributedText = attributeText;
}

@end
