//
//  ChatSearchUserCell.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-25.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatUserCell : UITableViewCell




@property (nonatomic, retain) IBOutlet UIImageView  *photoImgView;
@property (nonatomic, retain) IBOutlet UILabel      *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel      *introduceLabel;
@property (nonatomic, retain) IBOutlet UIButton     *actionButton;
//- (IBAction)chatUserCellActionButtonClicked:(id)sender;
@end
