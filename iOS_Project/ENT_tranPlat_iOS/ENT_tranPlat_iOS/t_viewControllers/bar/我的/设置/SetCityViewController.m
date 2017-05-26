//
//  SetCityViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-5.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "SetCityViewController.h"

#import "pinyin.h"

@interface SetCityViewController ()<
UITableViewDataSource,
UITableViewDelegate
>
{
    //NSMutableArray                  *_citysArray;
    NSMutableDictionary             *_letterCitysDict;
    NSMutableDictionary             *_sectionnameCitysDict;
    
    //NSMutableDictionary                  *_lettersShowDict;
    NSArray                  *_sectionStrings;
    //NSMutableArray              *_provinceArr;
    
}

@end

@implementation SetCityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)gobackPage{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UITableView *rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(APP_X, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    [rootTableView setDelegate:self];
    [rootTableView setDataSource:self];
    rootTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:rootTableView];
    
    //read
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"txt"];
    NSData *resourceData = [NSData dataWithContentsOfFile:resourcePath];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *resourceDict = [parser objectWithData:resourceData];
    
    NSArray *resourceArr = [resourceDict objectForKey:@"pl"];
    NSMutableArray *citysArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *dict in resourceArr) {
        NSArray *provinceCitys = [dict objectForKey:@"list"];
        [citysArray addObjectsFromArray:provinceCitys];
    }
    
    //***加入索引
    _letterCitysDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (NSDictionary *cityAndCode in citysArray)
    {
        NSString *firstLetter = [NSString stringWithFormat:@"%c",pinyinFirstLetter([[cityAndCode objectForKey:@"name"] characterAtIndex:0])];
        NSMutableArray *lCitys = [_letterCitysDict valueForKey:firstLetter];//根据首字母选出对应的城市组成的数组
        if (lCitys)//数组已经存在，加入一条数据（城市）
        {
            [lCitys addObject:cityAndCode];
        }else {//数组不存在，创建数组（加入城市）加入字典
            [_letterCitysDict setObject:[NSMutableArray arrayWithObject:cityAndCode] forKey:firstLetter];
        }
    }
    
    _sectionnameCitysDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [_sectionnameCitysDict setObject:[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"北京", @"name", @"0101", @"code", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"广州", @"name", @"2801", @"code", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"上海", @"name", @"0201", @"code", nil], [NSDictionary dictionaryWithObjectsAndKeys:@"深圳", @"name", @"2806", @"code", nil], nil] forKey:@"热门城市"];
    

    NSArray *letters = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", nil], [NSArray arrayWithObjects:@"h", @"i", @"j", @"k", @"l", @"m", @"n", nil], [NSArray arrayWithObjects:@"o", @"p", @"q", @"r", @"s", @"t", nil], [NSArray arrayWithObjects:@"u", @"v", @"w", @"x", @"y", @"z", nil], nil];

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
                key = @"A~G";
                break;
            case 1:
                key = @"H~N";
                break;
            case 2:
                key = @"O~T";
                break;
            case 3:
                key = @"U~Z";
                break;
            default:
                break;
        }
        [_sectionnameCitysDict setObject:array forKey:key];

    }
    


    //_lettersShowDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSArray arrayWithObjects: nil], @"热门城市", [NSArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", nil], @"A~G", [NSArray arrayWithObjects:@"h", @"i", @"j", @"k", @"l", @"m", @"n", nil], @"H~N", [NSArray arrayWithObjects:@"o", @"p", @"q", @"r", @"s", @"t", nil], @"O~T", [NSArray arrayWithObjects:@"u", @"v", @"w", @"x", @"y", @"z", nil], @"U~Z", nil];
    
    
    _sectionStrings = [NSArray arrayWithObjects:@"热门城市", @"A~G", @"H~N", @"O~T", @"U~Z", nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"选择城市"];


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[_sectionnameCitysDict allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key = [_sectionStrings objectAtIndex:section];
    return [(NSArray*)[_sectionnameCitysDict objectForKey:key] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *l = [[UILabel alloc] init];
    l.backgroundColor = [UIColor lightGrayColor];
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
    NSString *key = [_sectionStrings objectAtIndex:indexPath.section];
    NSArray *citys = [_sectionnameCitysDict objectForKey:key];
    NSDictionary *cityAndCode = [citys objectAtIndex:indexPath.row];
    cell.textLabel.text = [cityAndCode objectForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [_sectionStrings objectAtIndex:indexPath.section];
    NSArray *citys = [_sectionnameCitysDict objectForKey:key];
    NSDictionary *cityAndCode = [citys objectAtIndex:indexPath.row];
    UserInfo *user = [[[DataBase sharedDataBase] selectActiveUser] lastObject];
    user.citySet = [cityAndCode objectForKey:@"name"];
    [user update];
    
    [[NSUserDefaults standardUserDefaults] setObject:[cityAndCode objectForKey:@"name"] forKey:KEY_CITY_NAME_IN_USERDEFAULT];
    [[NSUserDefaults standardUserDefaults] setObject:[cityAndCode objectForKey:@"code"] forKey:KEY_CITY_CODE_IN_USERDEFAULT];

    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CITY_SET_CHANGED object:nil];
    [self performSelector:@selector(gobackPage) withObject:nil afterDelay:0.3f];
    
    
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
