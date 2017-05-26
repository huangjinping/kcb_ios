//
//  DealingRecordCell.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-12.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "DealingRecordCell.h"

@implementation DealingRecordCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat space = 10;
        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, space, APP_WIDTH, 235)];
        _bgImgView.backgroundColor = [UIColor whiteColor];
        //[_bgImgView setImage:[UIImage imageNamed:@"bg_white"]];
        [self addSubview:_bgImgView];
        UILabel *line = [UILabel lineLabelWithPXPoint:CGPointMake(0, 0)];
        [_bgImgView addSubview:line];
        _bottomLine = [UILabel lineLabelWithPXPoint:CGPointMake(0, _bgImgView.h - 1)];
        [_bgImgView addSubview:_bottomLine];
        
        _cellNumL = [[UILabel alloc] initWithFrame:CGRectMake(20, 9, 200, 113)];
        _cellNumL.backgroundColor = [UIColor clearColor];
        _cellNumL.font = [UIFont systemFontOfSize:101];
        _cellNumL.textAlignment = NSTextAlignmentLeft;
        _cellNumL.textColor = COLOR_CELL_NUM_LEBEL_TEXT;
        [self addSubview:_cellNumL];
        
        CGFloat ySpace = 0;
        CGFloat xStart = 20;
        CGFloat yStart = 20;
        CGFloat lHeight = 25;
        CGFloat lWidth = 100;
        CGFloat longlWidth = 170;

        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(xStart, yStart, lWidth, lHeight)];
        l.backgroundColor = [UIColor clearColor];
        l.font = [UIFont systemFontOfSize:15];
        l.textAlignment = NSTextAlignmentRight;
        l.textColor = COLOR_FONT_NOMAL;
        l.text = @"车辆类型：";
        [self addSubview:l];
        _hpzlL = [[UILabel alloc] initWithFrame:CGRectMake(l.right + 5, l.top, longlWidth, lHeight)];
        _hpzlL.backgroundColor = [UIColor clearColor];
        _hpzlL.font = [UIFont systemFontOfSize:15];
        _hpzlL.textAlignment = NSTextAlignmentLeft;
        _hpzlL.textColor = COLOR_FONT_NOMAL;
        [self addSubview:_hpzlL];
        
        l = [[UILabel alloc] initWithFrame:CGRectMake(xStart, (lHeight + ySpace)*1 + yStart, lWidth, lHeight)];
        l.backgroundColor = [UIColor clearColor];
        l.font = [UIFont systemFontOfSize:15];
        l.textAlignment = NSTextAlignmentRight;
        l.textColor = COLOR_FONT_NOMAL;
        l.text = @"车牌号码：";
        [self addSubview:l];
        _hphmL = [[UILabel alloc] initWithFrame:CGRectMake(l.right + 5, l.top, longlWidth, lHeight)];
        _hphmL.backgroundColor = [UIColor clearColor];
        _hphmL.font = [UIFont systemFontOfSize:15];
        _hphmL.textAlignment = NSTextAlignmentLeft;
        _hphmL.textColor = COLOR_FONT_NOMAL;
        [self addSubview:_hphmL];
        
        l = [[UILabel alloc] initWithFrame:CGRectMake(xStart, (lHeight + ySpace)*2 + yStart, lWidth, lHeight)];
        l.backgroundColor = [UIColor clearColor];
        l.font = [UIFont systemFontOfSize:15];
        l.textAlignment = NSTextAlignmentRight;
        l.textColor = COLOR_FONT_NOMAL;
        l.text = @"处理序号：";
        [self addSubview:l];
        _dealNumL = [[UILabel alloc] initWithFrame:CGRectMake(l.right + 5, l.top, longlWidth, lHeight)];
        _dealNumL.backgroundColor = [UIColor clearColor];
        _dealNumL.font = [UIFont systemFontOfSize:15];
        _dealNumL.textAlignment = NSTextAlignmentLeft;
        _dealNumL.textColor = COLOR_FONT_NOMAL;
        [self addSubview:_dealNumL];
        
        l = [[UILabel alloc] initWithFrame:CGRectMake(xStart, (lHeight + ySpace)*3 + yStart, lWidth, lHeight)];
        l.backgroundColor = [UIColor clearColor];
        l.font = [UIFont systemFontOfSize:15];
        l.textAlignment = NSTextAlignmentRight;
        l.textColor = COLOR_FONT_NOMAL;
        l.text = @"处理时间：";
        [self addSubview:l];
        _timeLabel = l;
        _dealTimeL = [[UILabel alloc] initWithFrame:CGRectMake(l.right + 5, l.top, longlWidth, lHeight)];
        _dealTimeL.backgroundColor = [UIColor clearColor];
        _dealTimeL.font = [UIFont systemFontOfSize:15];
        _dealTimeL.textAlignment = NSTextAlignmentLeft;
        _dealTimeL.textColor = COLOR_FONT_NOMAL;
        [self addSubview:_dealTimeL];
        
        l = [[UILabel alloc] initWithFrame:CGRectMake(xStart, (lHeight + ySpace)*4 + yStart, lWidth, lHeight)];
        l.backgroundColor = [UIColor clearColor];
        l.font = [UIFont systemFontOfSize:15];
        l.textAlignment = NSTextAlignmentRight;
        l.textColor = COLOR_FONT_NOMAL;
        l.text = @"决定书编号：";
        [self addSubview:l];
        _jdsbhLabel = l;
        _jdsbhL = [[UILabel alloc] initWithFrame:CGRectMake(l.right + 5, l.top, longlWidth, lHeight)];
        _jdsbhL.backgroundColor = [UIColor clearColor];
        _jdsbhL.font = [UIFont systemFontOfSize:15];
        _jdsbhL.textAlignment = NSTextAlignmentLeft;
        _jdsbhL.textColor = COLOR_FONT_NOMAL;
        [self addSubview:_jdsbhL];
        
        l = [[UILabel alloc] initWithFrame:CGRectMake(xStart, (lHeight + ySpace)*5 + yStart, lWidth, lHeight)];
        l.backgroundColor = [UIColor clearColor];
        l.font = [UIFont systemFontOfSize:15];
        l.textAlignment = NSTextAlignmentRight;
        l.textColor = COLOR_FONT_NOMAL;
        l.text = @"状态：";
        [self addSubview:l];
        _statusLabel = l;
        _dealStatusL = [[UILabel alloc] initWithFrame:CGRectMake(l.right + 5, l.top, longlWidth, lHeight)];
        _dealStatusL.backgroundColor = [UIColor clearColor];
        _dealStatusL.font = [UIFont systemFontOfSize:15];
        _dealStatusL.textAlignment = NSTextAlignmentLeft;
        _dealStatusL.textColor = [UIColor redColor];
        [self addSubview:_dealStatusL];;
    }
    
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
