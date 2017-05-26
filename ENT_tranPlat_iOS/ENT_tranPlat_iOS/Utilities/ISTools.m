//
//  ISTools.m
//  iovsp
//
//  Created by 张召岳 on 15/7/29.
//  Copyright (c) 2015年 shenguodian. All rights reserved.
//

#import "ISTools.h"
static ISTools * _tools =nil;
@implementation ISTools

+(instancetype)shanreIovspInstance
{
    if (!_tools)
    {
        _tools =[[ISTools alloc]init];
        _tools.dataDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    
    return _tools;
}


-(void)showAlertViewTitle:(NSString*)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

-(NSString*)stringWithData:(NSObject*)data
{
    if ([data isEqual:[NSNull null]]) {
        return @"";
    }
    if ([data isKindOfClass:[NSString class]]) {
        return (NSString*)data;
    }
    if ([data isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber*)data;
        return [number stringValue];
    }
    return @"";
}

-(NSDictionary*)myCustomLabel
{
    NSDictionary* style = @{@"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:21.0f],@"font":[UIFont systemFontOfSize:10.0f],@"orange": [UIColor orangeColor]};
    return style;
}

// 自适应高度
//-(CGFloat)TheAdaptive:(NSString*)string font:(CGFloat)font width:(CGFloat)width
//{
//    CGSize textSize =CGSizeMake(width, MAXFLOAT);
//    CGSize addressHeight =[string sizeWithFont:[UIFont systemFontOfSize:font] maxSize:textSize];
//    return addressHeight.height;
//}

// 字典转换成Json字符串
- (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
// json串转换成字典
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    
  
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

-(NSString*)getKilometersWithOneLat:(NSString*)ontLat oneLon:(NSString*)ontLon  andWithTwoLat:(NSString*)twoLat withTwoLon:(NSString*)twoLon
{
    NSString * kilometersStr=@"";
    CLLocation *orig=[[CLLocation alloc] initWithLatitude:[ontLat doubleValue]  longitude:[ontLon doubleValue]];
    CLLocation* dist=[[CLLocation alloc] initWithLatitude:[twoLat doubleValue] longitude:[twoLon doubleValue] ];
    
    CLLocationDistance kilometers=[orig distanceFromLocation:dist]/1000;
//    NSLog(@"距离:%f",kilometers);
    if (kilometers>1)
    {
        kilometersStr =[NSString stringWithFormat:@"%.1fKm",kilometers];
    }
    else
    {
        kilometersStr =[NSString stringWithFormat:@"%.1fm",kilometers*1000];
    }
    
    return kilometersStr;
}

#pragma mark - Handle URL Scheme

- (NSString *)getApplicationName
{
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    return [bundleInfo valueForKey:@"CFBundleDisplayName"];
}

- (NSString *)getApplicationScheme
{
    NSDictionary *bundleInfo    = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier  = [[NSBundle mainBundle] bundleIdentifier];
    NSArray *URLTypes           = [bundleInfo valueForKey:@"CFBundleURLTypes"];
    
    NSString *scheme;
    for (NSDictionary *dic in URLTypes)
    {
        NSString *URLName = [dic valueForKey:@"CFBundleURLName"];
        if ([URLName isEqualToString:bundleIdentifier])
        {
            scheme = [[dic valueForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
            break;
        }
    }
    
    return scheme;
}

@end
