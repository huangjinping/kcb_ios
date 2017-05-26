//
//  InfoTableViewCell.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/10/13.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "InfoTableViewCell.h"
#import "UIKit+AFNetworking.h"

@implementation InfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setYcmodel:(SHModel *)ycmodel{
    
    
    [_titlePic setImageWithURL:[NSURL URLWithString:ycmodel.titlePic]];
    

    _titlePic.clipsToBounds = YES;
    _titlePic.layer.cornerRadius = 5;
    
    _contacts.text=ycmodel.name;
//    _contacts.font=SYS_FONT_SIZE(40)  ;
    _contacts.textColor=[UIColor blackColor];

   
    _des.text=ycmodel.des;
//    _des.font=SYS_FONT_SIZE(35);
    _des.textColor=COLOR_FONT_NOTICE;
    if(ycmodel.grade == 8){
        
        _imge.image=[UIImage imageNamed:@"xing3"];
    }else if (ycmodel.grade == 4){
        
        _imge.image=[UIImage imageNamed:@"xing5"];
        
    }else if (ycmodel.grade == 5){
        
        _imge.image=[UIImage imageNamed:@"xing4"];
    }

    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
