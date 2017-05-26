//
//  ChatAddFriendViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-12.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChatUserCell.h"


@interface ChatAddFriendViewController : BasicViewController<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate
>
{
    UITextField                     *_searchTF;
    UITableView                     *_rootTableView;

    
    NSMutableArray                 *_searchResultChatUsers;
    NSMutableArray                 *_recommendResultChatUsers;

}
@end
