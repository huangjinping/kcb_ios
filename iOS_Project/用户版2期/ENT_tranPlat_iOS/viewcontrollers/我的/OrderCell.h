//
//  OrderCell.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/13.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderCell;
@protocol OrderCellDelegate <NSObject>

@optional
- (void)orderCancle:(OrderCell *)cell;
- (void)orderRefound:(OrderCell *)cell;
- (void)orderConfirmFininshed:(OrderCell *)cell;
- (void)orderWattingForComment:(OrderCell *)cell;
- (void)orderForPaying:(OrderCell *)cell;

@end
@interface OrderCell : UITableViewCell

@property (nonatomic, weak) id<OrderCellDelegate>delegate;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *bookingTime;
@property (nonatomic, strong) NSString *merchantName;
@property (nonatomic, strong) NSString *merchantAddress;
@property (nonatomic, strong) NSString *merchantPhone;

- (void)configCellWithDic:(NSDictionary *)dic;

@end
