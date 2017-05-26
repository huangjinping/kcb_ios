//
//  ListView.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-31.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KEY_MENU_VIEW_TITLES    @"title"
#define KEY_MENU_VIEW_LOGOS     @"logos"

#define LIST_VIEW_HEIGHT        50

@class MenuView;
@protocol MenuViewDelegate <NSObject>

@optional
- (void)menuView:(MenuView*)menuView didSelectRowAtIndexPath:(NSIndexPath*)indexPath;

@end

@interface MenuView : UIView<
UITableViewDataSource,
UITableViewDelegate
>
{
    UITableView             *_roottv;
}
@property (nonatomic, assign)   id<MenuViewDelegate>         _delegate;

@property (nonatomic, retain)   NSDictionary         *titlesAndLogos;


- (id)initWithFrame:(CGRect)frame titlesAndLogos:(NSDictionary*)titlesAndLogos;
@end
