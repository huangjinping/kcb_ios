//
//  HomeOrderCell.h
//  Merchant
//
//  Created by Wendy on 15/12/30.
//  Copyright © 2015年 tranPlat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeOrderCell : UITableViewCell
@property (nonatomic,retain)UILabel *serverTypeLab;
@property (nonatomic,retain)UILabel *orderTimeLab;
@property (nonatomic,retain)UILabel *modelsLab;
@property (nonatomic,retain)UILabel *mobileLab;
@property (nonatomic,retain)UILabel *amountLab;
@property (nonatomic,retain)UILabel *appointmentLab;
@property (nonatomic,retain)UILabel *statusLab;
@property (nonatomic,retain)UIButton *actionBtn;
@property (nonatomic,retain)UILabel *comsumerLabel;
- (void)setCellMobileLab:(NSString *)value;
- (void)setCellModelsLab:(NSString *)value;
- (void)setCellAmountLab:(NSString *)value;
- (void)setCellAppointmentLab:(NSString *)value;
- (void)setCellStatusLab:(NSString *)value;
- (void)setCellComsumerLab:(NSString *)value;
@end
