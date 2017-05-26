
//
//  MineOrderSortView.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/14.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "MineOrderSortView.h"
#import "MineOrderSortCell.h"
#import "OrderSortLayout.h"

@interface MineOrderSortView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;

@end

static NSString *cellId = @"cellId";

@implementation MineOrderSortView

+ (MineOrderSortView *)shareOrderSortView{
    MineOrderSortView *mV = [[MineOrderSortView alloc]initWithFrame:CGRectMake(0, 0, APP_WIDTH, 62*y_6_SCALE)];
    
    return mV;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        OrderSortLayout *layout = [[OrderSortLayout alloc]init];
        layout.itemSize = CGSizeMake(self.width/4, self.height);
        layout.maxItemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = kWhiteColor;
        _collectionView.pagingEnabled = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[MineOrderSortCell class] forCellWithReuseIdentifier:cellId];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [self addSubview:_collectionView];
    }
    
    return self;
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    
    [self.collectionView reloadData];
}

#pragma maek - UICollectionViewDelegate && UICollectionDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MineOrderSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[MineOrderSortCell alloc]init];
    }
    if (self.dataSource.count) {
        for (NSObject *obj in self.dataSource) {
            NSAssert([obj isKindOfClass:[NSDictionary class]], @"dataSource必须是字典集合!");
        }
    }
    NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
    
    switch (indexPath.item) {
        case 0:
            cell.IconBadgeNumber = [[u objectForKey:WATTINGFORPAY] integerValue];
            break;
        case 1:
            cell.IconBadgeNumber = [[u objectForKey:WATTINGFORSERVICE] integerValue];
            break;
        case 2:
            cell.IconBadgeNumber = [[u objectForKey:WATTINGFORCOMMNET] integerValue];
            break;
        case 3:
            cell.IconBadgeNumber = [[u objectForKey:WATTINGFORREFOUND] integerValue];
            break;
            
        default:
            break;
    }
    
    if (!APP_DELEGATE.loginSuss) {
        cell.IconBadgeNumber = 0;
    }
    
    cell.nameLabel.text = self.dataSource[indexPath.item][@"name"];
    cell.icon.image = [UIImage imageNamed:self.dataSource[indexPath.row][@"icon"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(didSelectItem:atIndex:)]) {
        [_delegate didSelectItem:self atIndex:indexPath.item];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

@end
