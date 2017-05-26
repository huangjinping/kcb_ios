//
//  D_CellCell.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-9-11.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>


@class D_CellCell;
@protocol D_CellCellDelegate <NSObject>

@optional
- (void)D_CellCell:(D_CellCell*)cell beTaped:(UITapGestureRecognizer*)tap;

- (void)D_CellCell:(D_CellCell*)cell removeFriend:(NSString*)friendName;
@end
@interface D_CellCell : UIView<
UIGestureRecognizerDelegate
>
{
    
    UIButton                *_removeButton;
}

@property (nonatomic, assign)   id<D_CellCellDelegate>      delegate_;

@property (nonatomic, retain, readonly) NSString *identifier;


@property (nonatomic, retain) NSString           *friendId;

@property (nonatomic, retain) UIImageView           *imgView;
@property (nonatomic, retain) UILabel               *titleLabel;
@property (nonatomic, retain) UILabel               *subTitleLabel;
@property (nonatomic, retain) UIView                *contentView;


- (id)initWithIdentifier:(NSString*)identifier;
@end
