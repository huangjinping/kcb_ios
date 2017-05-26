//
//  dateCell.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/8/25.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "dateCell.h"

@implementation dateCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGSize size = self.bounds.size;
        //标题
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
       
        label.numberOfLines = 2;
      
        label.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:label];
        _dateLabel = label;
//        _dateLabel.backgroundColor = [UIColor whiteColor];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        
 
    }
    return self;
}
@end
