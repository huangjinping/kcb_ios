//
//  ActivityCell1.h
//  
//
//  Created by 辛鹏贺 on 16/1/19.
//
//

#import <UIKit/UIKit.h>

@interface ActivityCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailNameLabel;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) UIImage *backgroundImg;

- (void)configCellWithDic:(NSDictionary *)dic;

@end
