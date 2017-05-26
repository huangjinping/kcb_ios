

//
//  ActivityView.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 15/12/25.
//  Copyright © 2015年 ___ENT___. All rights reserved.
//

#import "ActivityView.h"
#import "ActivityLayout.h"
#import "ActivityCell1.h"

@interface ActivityView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

static NSString *cell1 = @"cell1";

@implementation ActivityView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        ActivityLayout *layout = [[ActivityLayout alloc]init];
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor lightGrayColor];
        [collectionView registerNib:[UINib nibWithNibName:@"ActivityCell1" bundle:nil] forCellWithReuseIdentifier:cell1];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [self addSubview:collectionView];
    }
    
    return self;
}

#pragma mark - UICollectionViewDelegate && UIcollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ActivityCell1 *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell1 forIndexPath:indexPath];
    if (!Cell) {
        Cell = [[ActivityCell1 alloc]init];
    }
    
    return Cell;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:.2 animations:^{
        cell.transform = CGAffineTransformMakeScale(0.98f, 0.98f);
    }];
    
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:.2 animations:^{
        cell.transform = CGAffineTransformIdentity;
    }];
}

@end
