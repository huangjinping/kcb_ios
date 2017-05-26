//
//  CarLineController.m
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/7.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "CarLineController.h"
#import "CarDisplacementController.h"

@interface CarLineController ()

@property (nonatomic, strong) NSMutableDictionary *dataArr;

@end

@implementation CarLineController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"获取车系"];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.dataArr = [NSMutableDictionary dictionary];
    self.tableView.tableFooterView = [UIView new];
    [self requestData];
}

- (void)requestData{
    [UITools showIndicatorToView:self.view];
    [[NetworkEngine sharedNetwork] postBody:@{@"brandID":_Id} apiPath:kCarlineURL hasHeader:NO finish:^(ResultState state, id resObj) {
        [self.tableView.header endRefreshing];
        [UITools hideHUDForView:self.view];
        if (state == StateSucceed) {
            NSArray *obj = [resObj[@"body"][0][@"serieslist"] analysisConvertToArray];
            for (NSDictionary  *dic in obj) {
                NSMutableArray *letterArr = [self.dataArr objectForKey:dic[@"carBrandTechnology"]];
                if (!letterArr) {
                    letterArr = [NSMutableArray array];
                    [self.dataArr setValue:letterArr forKey:dic[@"carBrandTechnology"]];
                }
                [letterArr addObject:dic];
            }
//            if (obj.count == 1) {
//                [self.dataArr addObject:obj];
//            }else{
//                NSMutableArray *mArr = [NSMutableArray arrayWithObject:obj[0]];
//                BOOL res = NO;
//                for (int i = 0; i< obj.count-1; i++) {
//                    if ([obj[i][@"carBrandTechnology"] isEqualToString:obj[i+1][@"carBrandTechnology"]]) {
//                        [mArr addObject:obj[i+1]];
//                        if (i+1 == obj.count-1) {
//                            [self.dataArr addObject:mArr];
//                        }
//                        continue;
//                    }else{
//                        res = YES;
//                        if (i+1 != obj.count-1) {
//                            [self.dataArr addObject:mArr];
//                            mArr = [NSMutableArray arrayWithObject:obj[i+1]];
//                            continue;
//                        }else{
//                            [self.dataArr addObject:@[obj[i+1]]];
//                            break;
//                        }
//                    }
//                }
//                
//                if (!res) {
//                    [self.dataArr addObject:mArr];
//                }
//            }
            
            [self.tableView reloadData];
        }
    } failed:^(NSError *error) {
        [UITools hideHUDForView:self.view];
        [self.tableView.header endRefreshing];
    }];
}

- (void)configCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)index{
    cell.textLabel.text = self.dataArr[self.dataArr.allKeys[index.section]][index.row][@"carSeriesName"];
//    cell.textLabel.text = self.dataArr[index.section][index.row][@"carSeriesName"];
    cell.textLabel.font = V3_36PX_FONT;
    cell.textLabel.textColor = [UIColor colorWithHex:0x666666];
}

#pragma mark UITableViewDelegate && UITableViewdataArr

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [(NSArray *)self.dataArr[self.dataArr.allKeys[section]] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.allKeys.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.width, 32*y_6_SCALE)];
    v.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(10*x_6_SCALE, 0, tableView.width, 32*y_6_SCALE)];
    l.text = self.dataArr.allKeys[section];
//    l.text = self.dataArr[section][0][@"carBrandTechnology"];
    
    [v addSubview:l];
    
    return v;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CarDisplacementController *clv = [[CarDisplacementController alloc]init];
    clv.icon = self.icon;
    clv.line = self.dataArr[self.dataArr.allKeys[indexPath.section]][indexPath.row][@"carSeriesName"];
    clv.needHome = self.needHome;
    clv.seriesId = [NSString stringWithFormat:@"%@",self.dataArr[self.dataArr.allKeys[indexPath.section]][indexPath.row][@"id"]];
    clv.saveCarInfo = self.saveCarInfo;
    clv.clpp1 = self.clpp1;
    clv.level = self.dataArr[self.dataArr.allKeys[indexPath.section]][indexPath.row][@"level"];
    clv.seriesId = self.dataArr[self.dataArr.allKeys[indexPath.section]][indexPath.row][@"id"];
    [self.navigationController pushViewController:clv animated:YES];
}

@end
