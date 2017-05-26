//
//  ChatImageView.h
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-9-26.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatImageView;

@protocol ChatImageDelegate <NSObject>

- (void)chatImageClicked:(ChatImageView *)communityImageView;

@end


@interface ChatImageView : UIImageView{
    UILabel *titleLable;
}

- (void)addTitle;
@property (nonatomic, assign) id<ChatImageDelegate>delegate;

@property (nonatomic, copy) NSString *dname;

@property (nonatomic, assign) int sort;

@end
