//
//  ShareSetViewController.h
//  ENT_tranPlat_iOS
//
//  Created by YF on 14-10-20.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "BasicViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"

#define TABLE_ROW_HEIGHT    55


@interface ShareSetViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate,WXApiDelegate,UITextViewDelegate>{
    
    
    
    
    UITextView              *_textView;
    
    NSMutableArray          *_tableDatasource;
    
    UITableView             *_tableView;

}

@end
