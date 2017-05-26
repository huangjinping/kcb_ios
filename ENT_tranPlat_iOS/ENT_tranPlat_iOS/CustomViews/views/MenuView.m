//
//  ListView.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-31.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

- (void)setTitlesAndLogos:(NSDictionary *)titlesAndLogos{
    if (_titlesAndLogos) {
        _titlesAndLogos = nil;
    }
    _titlesAndLogos = [NSDictionary dictionaryWithDictionary:titlesAndLogos];
    [_roottv reloadData];
}
- (id)initWithFrame:(CGRect)frame titlesAndLogos:(NSDictionary*)titlesAndLogos height:(NSString *)height
{
    self = [super initWithFrame:frame];
    if (self) {
        _cellHeight = height;
        self.titlesAndLogos = [[NSDictionary alloc] initWithDictionary:titlesAndLogos];
//        [self setValue:self.titlesAndLogos forKey:@"titlesAndLogos"];
//
//        [self addObserver:self forKeyPath:@"titlesAndLogos" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
//        self.backgroundColor = [UIColor blueColor];
        _roottv = [[UITableView alloc] initWithFrame:self.bounds];
        _roottv.separatorColor = [UIColor whiteColor];
        _roottv.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _roottv.delegate = self;
        _roottv.dataSource = self;
        _roottv.scrollEnabled = NO;
        if ([_roottv respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [_roottv setSeparatorInset:UIEdgeInsetsZero];
            
        }
        [self addSubview:_roottv];
        
        [[NSNotificationCenter defaultCenter] addObserver:_roottv selector:@selector(reloadData) name:NOTIFICATION_FINISH_DOWNLOAD_PHOTO object:nil];
        
    }
    return self;
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    if ([keyPath isEqualToString:@"titlesAndLogos"]) {
//        [_roottv reloadData];
//    }
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = [self.titlesAndLogos objectForKey:KEY_MENU_VIEW_TITLES];
    return [arr count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_cellHeight integerValue];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"listcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = COLOR_NAV;
        CGFloat cellHeight = [_cellHeight integerValue];
        CGFloat space = 10;
        UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(space, (cellHeight - 20)/2, 20, 20)];
        [cell.contentView addSubview:logoView];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(logoView.right + space, 0, (self.frame.size.width - logoView.right - space - space), cellHeight)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor whiteColor];
        [cell.contentView addSubview:titleLabel];
        
    }
    UIImageView *logoImgView = [cell.contentView.subviews objectAtIndex:0];
    NSString *logoName = [(NSArray*)[self.titlesAndLogos objectForKey:KEY_MENU_VIEW_LOGOS] objectAtIndex:indexPath.row];
    [logoImgView setImage:[UIImage imageNamed:logoName]];
    UILabel *titleLabel = [cell.contentView.subviews objectAtIndex:1];
    [titleLabel setText:[(NSArray*)[self.titlesAndLogos objectForKey:KEY_MENU_VIEW_TITLES] objectAtIndex:indexPath.row]];
    
    //暂时
//    if ([(NSArray*)[self.titlesAndLogos objectForKey:KEY_MENU_VIEW_TITLES] count] > 4) {
//        if (indexPath.row == 0) {
//            UserInfo *user = [[[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName] lastObject];
//            UIImage *portraitImage = [UIImage imageWithContentsOfFile:[user photoLocalPath]];
//            if (portraitImage) {
//                [logoImgView setImage:portraitImage];
//            }else{
//                [logoImgView setImage:[UIImage imageNamed:@"chat_portrait_photo.png"]];
//            }
//
//        }
//    }
    
    
    if (indexPath.row == 0) {
        UIImageView *imgLineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
        imgLineView.backgroundColor = [UIColor darkGrayColor];
        [cell addSubview:imgLineView];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self._delegate respondsToSelector:@selector(menuView:didSelectRowAtIndexPath:)]) {
        [self._delegate menuView:self didSelectRowAtIndexPath:indexPath];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
