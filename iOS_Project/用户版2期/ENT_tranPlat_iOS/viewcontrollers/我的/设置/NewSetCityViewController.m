//
//  NewSetCityViewController.m
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 16/2/19.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "NewSetCityViewController.h"
#import "pinyin.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
@interface NewSetCityViewController ()<UISearchBarDelegate,UISearchDisplayDelegate
>
{
    
    NSMutableArray *dataList;
    
    NSMutableDictionary             *_letterCitysDict;
    NSMutableDictionary             *_sectionnameCitysDict;
    NSArray                  *_sectionStrings;
    NSMutableArray *_searchResults;
    UISearchDisplayController *searchDisplayController;
    UISearchBar *_mySearchBar;
    NSMutableArray *_cityname;
    NSArray                  *_sectionStringss;
    
    
}
@property (nonatomic, strong) UIView *headerView;
@end

@implementation NewSetCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mySearchBar  = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 1000*x_6_plus, 125*y_6_plus)];
    _mySearchBar.center = _headerView.boundsCenter;
    _mySearchBar.delegate = self;
    [_mySearchBar setPlaceholder:@"请输入您的所在城市"];
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:_mySearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_WIDTH, 165*y_6_plus)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = _mySearchBar;
   // self.tableView.tableHeaderView = self.headerView;
   // [self.tableView registerClass:[BrandCell class] forCellReuseIdentifier:cellId];
    self.tableView.sectionIndexColor = [UIColor blackColor];
    self.tableView.sectionIndexBackgroundColor = kClearColor;
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"txt"];
    NSData *resourceData = [NSData dataWithContentsOfFile:resourcePath];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *resourceDict = [parser objectWithData:resourceData];
    
    NSArray *resourceArr = [resourceDict objectForKey:@"pl"];
    NSMutableArray *citysArray = [[NSMutableArray alloc] initWithCapacity:0];
    dataList=[[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *dataTemp=[[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSDictionary *dict in resourceArr) {
        NSArray *provinceCitys = [dict objectForKey:@"list"];
        [citysArray addObjectsFromArray:provinceCitys];
        [dataTemp addObjectsFromArray:provinceCitys];
        
    }
    
    
    
    
    //数据家索引
    for(int i=0;i<[dataTemp count];i++){
        
        NSString *firstLetter=[NSString stringWithFormat:@"%c",pinyinFirstLetter([dataTemp[i][@"name"] characterAtIndex:0])];
        [(NSMutableDictionary*)dataTemp[i] setObject:firstLetter forKey:@"head"];
    }
    
    
    [dataTemp sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSMutableDictionary *dic1=obj1;
        NSMutableDictionary *dic2=obj2;
        NSString *str1=dic1[@"head"];
        NSString *str2=dic2[@"head"];
        
        return [str1 compare: str2];
    }];
    
    
    
    NSMutableArray *titleArr=[[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0;i< [dataTemp count]; i++) {
        NSMutableDictionary *dic= dataTemp[i];
        if ([dataList count]==0) {
            NSMutableArray *data=[[NSMutableArray alloc] init];
            [titleArr addObject:dic[@"head"]];
            [dataList addObject:data];
        }else{
           NSString * head= [[dataList lastObject]lastObject][@"head"];
            
            if (![head isEqualToString:dic[@"head"]]) {
                [titleArr addObject:dic[@"head"]];
                NSMutableArray *data=[[NSMutableArray alloc] init];
                [dataList addObject:data];
            }
        }
        [[dataList lastObject] addObject:dataTemp[i]];
    }
    
    NSLog(@"%@",titleArr);
    
    
    
    
    
    // NSLog(@"%@",_letterCitysDict);
    
    //***加入索引
    _letterCitysDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    _cityname = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *cityAndCode in citysArray){
        // ENTLog(@"%@", [[cityAndCode objectForKey:@"name"] substringToIndex:1]);
        NSString *firstLetter = [cityAndCode objectForKey:@"name"];
        
        [_cityname addObject:firstLetter];
    }
    
    
    
    
    
    for (NSDictionary *cityAndCode in citysArray)
    {
        // ENTLog(@"%@", [[cityAndCode objectForKey:@"name"] substringToIndex:1]);
        NSString *firstLetter = [NSString stringWithFormat:@"%c",pinyinFirstLetter([[cityAndCode objectForKey:@"name"] characterAtIndex:0])];
        // NSString *firstLetter = [Helper getShellByChinese:[[cityAndCode objectForKey:@"name"] characterAtIndex:0]];
        NSMutableArray *lCitys = [_letterCitysDict valueForKey:firstLetter];//根据首字母选出对应的城市组成的数组
        if (lCitys)//数组已经存在，加入一条数据（城市）
        {
            [lCitys addObject:cityAndCode];
        }else {//数组不存在，创建数组（加入城市）加入字典
            [_letterCitysDict setObject:[NSMutableArray arrayWithObject:cityAndCode] forKey:firstLetter];
        }
    }
    
    _sectionnameCitysDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    NSArray *letters = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"a", nil], [NSArray arrayWithObjects:@"b", nil], [NSArray arrayWithObjects:@"c",  nil], [NSArray arrayWithObjects:@"d", nil],[NSArray arrayWithObjects:@"e", nil],[NSArray arrayWithObjects:@"f", nil], [NSArray arrayWithObjects:@"g", nil], [NSArray arrayWithObjects:@"h",  nil], [NSArray arrayWithObjects:@"j", nil], [NSArray arrayWithObjects:@"k", nil], [NSArray arrayWithObjects:@"l", nil], [NSArray arrayWithObjects:@"m",  nil], [NSArray arrayWithObjects:@"n", nil], [NSArray arrayWithObjects:@"p", nil], [NSArray arrayWithObjects:@"q", nil], [NSArray arrayWithObjects:@"r",  nil], [NSArray arrayWithObjects:@"s", nil],[NSArray arrayWithObjects:@"t", nil], [NSArray arrayWithObjects:@"w",  nil], [NSArray arrayWithObjects:@"x", nil],[NSArray arrayWithObjects:@"y", nil], [NSArray arrayWithObjects:@"z",nil] , nil];
    
    
    
    
    for (int i = 0; i < [letters count]; i++) {
        NSArray *secLetters = [letters objectAtIndex:i];
        
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSString *l in secLetters) {
            NSArray *arr = [_letterCitysDict objectForKey:l];
            [array addObjectsFromArray:arr];
        }
        
        NSString *key = @"";
        switch (i) {
            case 0:
                key = @"A";
                break;
            case 1:
                key = @"B";
                break;
            case 2:
                key = @"C";
                break;
            case 3:
                key = @"D";
                break;
            case 4:
                key = @"E";
                break;
            case 5:
                key = @"F";
                break;
            case 6:
                key = @"G";
                break;
            case 7:
                key = @"H";
                break;
//            case 8:
//                key = @"I";
//                break;
            case 8:
                key = @"J";
                break;
            case 9:
                key = @"K";
                break;
            case 10:
                key = @"L";
                break;
            case 11:
                key = @"M";
                break;
            case 12:
                key = @"N";
                break;
//            case 14:
//                key = @"O";
//                break;
            case 13:
                key = @"P";
                break;
            case 14:
                key = @"Q";
                break;
            case 15:
                key = @"R";
                break;
            case 16:
                key = @"S";
                break;
            case 17:
                key = @"T";
                break;
//            case 18:
//                key = @"U";
//                break;
//            case 19:
//                key = @"V";
//                break;
            case 18:
                key = @"W";
                break;
            case 19:
                key = @"X";
                break;
            case 20:
                key = @"Y";
                break;
            case 21:
                key = @"Z";
                break;
                
            default:
                break;
        }
        [_sectionnameCitysDict setObject:array forKey:key];
        
    }

   // i o u  v
    _sectionStrings = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G",@"H", @"J", @"K", @"L", @"M", @"N", @"P", @"Q", @"R", @"S", @"T",  @"W", @"X", @"Y", @"Z", nil];
    
    _sectionStringss = [NSArray arrayWithObjects:@"*",@"A", @"B", @"C", @"D", @"E", @"F", @"G",@"H", @"J", @"K", @"L", @"M", @"N",  @"P", @"Q", @"R", @"S", @"T", @"W", @"X", @"Y", @"Z",@"*", nil];
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    //"i" @"o"@"U"@"
    return _sectionStringss;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return _searchResults.count;
    }
    else {
//        return [[_sectionnameCitysDict allKeys] count];
        return [dataList count];
    }
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    NSInteger count = 0;
    
    for(NSString *character in _sectionStringss)
    {
        if([character isEqualToString:title])
        {
            return count-1;
        }
        count ++;
    }
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return _searchResults.count;
    }
    else {
//        NSString *key = [_sectionStrings objectAtIndex:section];
//        return [(NSArray*)[_sectionnameCitysDict objectForKey:key] count];
        return [(NSMutableArray *)dataList[section] count];
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 0;
    }
    else {
    return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    UILabel *l = [[UILabel alloc] init];
    
    l.backgroundColor = kLineBorderGrayColor;
    
    l.alpha = 1;
    l.font = [UIFont systemFontOfSize:20];
    l.text = [_sectionStrings objectAtIndex:section];
        return l;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    cell.textLabel.font = V3_38PX_FONT;
    cell.textLabel.textColor = [UIColor colorWithHex:0x666666];
   
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = _searchResults[indexPath.row];
    }
    else {
//        NSString *key = [_sectionStrings objectAtIndex:indexPath.section];
       NSDictionary *dic=  dataList[indexPath.section][indexPath.row];
        
        
//        NSArray *citys = [_sectionnameCitysDict objectForKey:key];
//        NSDictionary *cityAndCode = [citys objectAtIndex:indexPath.row];
        cell.textLabel.text = [dic objectForKey:@"name"];
    }

    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
            NSString *l = _searchResults[indexPath.row];
            NSString *key = [NSString stringWithFormat:@"%c",pinyinFirstLetter([l characterAtIndex:0])];
          NSString *upperCaseString1 = [key uppercaseString];
            NSArray *citys = [_sectionnameCitysDict objectForKey:upperCaseString1];
        
        for (NSDictionary *cityname in citys) {
            if ([[cityname objectForKey:@"name"] isEqualToString:l]) {
                
                NSLog(@"%@",cityname);
                
                [[NSUserDefaults standardUserDefaults] setObject:[cityname objectForKey:@"name"] forKey:KEY_CITY_NAME_IN_USERDEFAULT];
                [[NSUserDefaults standardUserDefaults] setObject:[cityname objectForKey:@"cityCode"] forKey:KEY_CITY_CODE_IN_USERDEFAULT];
                [[NSUserDefaults standardUserDefaults] setObject:[cityname objectForKey:@"adCode"] forKey:KEY_CITY_ADCODE_IN_USERDEFAULT];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                UserInfo *user = [[[DataBase sharedDataBase] selectActiveUser] lastObject];
                user.citySet = [cityname objectForKey:@"name"];
                [user update];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CITY_SET_CHANGED object:nil];
                
            }
            
            
        }

    

        }else{
            
//            NSString *key = [_sectionStrings objectAtIndex:indexPath.section];
//            NSArray *citys = [_sectionnameCitysDict objectForKey:key];
            
            NSDictionary *cityname =dataList[indexPath.section][indexPath.row];
            NSLog(@"%@",cityname);
            UserInfo *user = [[[DataBase sharedDataBase] selectActiveUser] lastObject];
            user.citySet = [cityname objectForKey:@"name"];
            [user update];
    
            [[NSUserDefaults standardUserDefaults] setObject:[cityname objectForKey:@"name"] forKey:KEY_CITY_NAME_IN_USERDEFAULT];
            [[NSUserDefaults standardUserDefaults] setObject:[cityname objectForKey:@"cityCode"] forKey:KEY_CITY_CODE_IN_USERDEFAULT];
            [[NSUserDefaults standardUserDefaults] setObject:[cityname objectForKey:@"adCode"] forKey:KEY_CITY_ADCODE_IN_USERDEFAULT];

            if (_block) {
                _block([cityname objectForKey:@"adCode"]);
            }
             [[NSUserDefaults standardUserDefaults] synchronize];

    
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CITY_SET_CHANGED object:nil];
    }
        
    [self performSelector:@selector(gobackPage) withObject:nil afterDelay:0.3f];
    
    
    
}

#pragma UISearchDisplayDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _searchResults = [[NSMutableArray alloc]init];
    if (_mySearchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:_mySearchBar.text]) {
        for (int i=0; i<_cityname.count; i++) {
            if ([ChineseInclude isIncludeChineseInString:_cityname[i]]) {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:_cityname[i]];
                NSRange titleResult=[tempPinYinStr rangeOfString:_mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [_searchResults addObject:_cityname[i]];
                }
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:_cityname[i]];
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:_mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleHeadResult.length>0) {
                    [_searchResults addObject:_cityname[i]];
                }
            }
            else {
                NSRange titleResult=[_cityname[i] rangeOfString:_mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [_searchResults addObject:_cityname[i]];
                }
            }
        }
    } else if (_mySearchBar.text.length>0&&[ChineseInclude isIncludeChineseInString:_mySearchBar.text]) {
        for (NSString *tempStr in _cityname) {
            NSRange titleResult=[tempStr rangeOfString:_mySearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [_searchResults addObject:tempStr];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"选择城市"];
    
}
- (void)gobackPage{
    NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
    NSString *c = [u objectForKey:KEY_CITY_ADCODE_IN_USERDEFAULT];
    NSString *cityName = [u objectForKey:KEY_CITY_NAME_IN_USERDEFAULT];
    if (![c isLegal] || ![cityName isLegal]) {
        [UITools alertWithMsg:@"请选择一个城市"];
        
        return;
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
