//
//  SARProcessView.m
//  ReimbursementForABB
//
//  Created by wendy on 15/8/31.
//  Copyright (c) 2015年 wendy. All rights reserved.
//

#import "SARProcessView.h"

@implementation ProcessList
- (id)initWithFrame:(CGRect)frame leftText:(NSString *)lText status:(NSString *)status rightText:(NSString *)rText isLast:(BOOL)last
{
    if ((self = [super initWithFrame:frame])) {
       
        NSString *imgString = nil;
        if ([status isEqualToString:@"START"]) {
            imgString = @"check_complete";
        }else if ([status isEqualToString:@"ACCEPT"]){
            imgString = @"check_loadComplete";
            
        }else if([status isEqualToString:@"APPROVE"]){
            imgString = @"check_loading";
        }else if([status isEqualToString:@"CANCEL"]){
            imgString = @"check_load";
        }else if([status isEqualToString:@"REQUEST"]){
            imgString = @"check_load";
        }

        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgString]];
        imgView.frame = CGRectMake(0, 0, 40, 40);
        [self addSubview:imgView];

        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right + 20, 0, 200, 20)];
        rightLabel.textColor = kColor666;
        rightLabel.textAlignment = NSTextAlignmentLeft;
        rightLabel.text = rText;
        rightLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:rightLabel];

        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right + 20, rightLabel.bottom, 200, 20)];
        leftLabel.textColor = [UIColor lightGrayColor];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        leftLabel.text = lText;
        leftLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:leftLabel];

        
        UIImageView *lineImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_bg"]];
        lineImg.frame = CGRectMake(imgView.left + (imgView.width - 2) / 2, imgView.bottom, 3, self.height - imgView.height);

        if (last) {
            lineImg.hidden = YES;
        }

        [self addSubview:lineImg];
    }

    return self;
}

@end
@implementation SARProcessView

- (id)initWithFrame:(CGRect)frame listItem:(NSArray *)array
{
    CGRect btnRect = CGRectMake(100, 0, self.width-100, 90);

    if ((self = [super initWithFrame:frame])) {
        for (int i =0 ; i<array.count; i++) {
            ProcessList * list = [[ProcessList alloc] initWithFrame:btnRect leftText:@"2015-12-23 23:59" status:@"APPROVE" rightText:@"黎明" isLast:(i == array.count -1)];
            [self addSubview:list];
            btnRect.origin.y +=90;
        }
    }

    return self;
}

@end
