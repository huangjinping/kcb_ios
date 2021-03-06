//
//  ExtendClass.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-15.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

/******************************************************
 * 模块名称:   ExtendClass.h
 * 模块功能:   类别集合
 * 创建日期:   14-7-15
 * 创建作者:   闫燕
 * 修改日期:
 * 修改人员:
 * 修改内容:
 ******************************************************/

#import "ExtendClass.h"


@implementation ExtendClass

@end

@implementation UIAlertView (EXTEND)

/***************************************************************
 功能：提示无代理的信息
 参数：
 返回：无
 ****************************************************************/
+ (void)alertTitle:(NSString*)title msg:(NSString*)msg{
    if ([title isEqualToString:@""]){
        title = nil;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确认"
                                          otherButtonTitles:nil, nil];

    [alert show];
}

@end

@implementation NSString (EXTEND)

/***************************************************************
 功能：校验电话号码
 参数：无
 返回：bool
 ****************************************************************/
- (BOOL)isValidPhoneNum{
    if (!self) {
        return NO;
    }
    if ([self isEqualToString:@""]) {
        return NO;
    }
    //第一位不为1
    if (![[self substringToIndex:1] isEqualToString:@"1"]) {
        return NO;
    }
    //11位
    if ([self length] != 11) {
        return NO;
    }
    //手机号格式验证
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    if (([regextestmobile evaluateWithObject:self])== NO){
//        return NO;
//    }

    return YES;
}

/***************************************************************
 功能：校验邮政编码
 参数：无
 返回：bool
 ****************************************************************/
- (BOOL)isValidPostCode{
    //6位
    if ([self length] != 6) {
        return NO;
    }
    return YES;
}

/***************************************************************
 功能：校验电子邮箱
 参数：无
 返回：bool
 ****************************************************************/
- (BOOL)isValidEmail{
    if ([self rangeOfString:@"@"].location == NSNotFound) {
        return NO;
    }
    return YES;
}


- (BOOL)verifyLastNum:(NSString*)idNum{
    NSInteger sigleNum;
    NSInteger sum = 0;
    for (int i = 0; i < 17; i ++) {
        sigleNum = [[idNum substringWithRange:NSMakeRange(i, 1)] integerValue];
        //系数7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2
        switch (i) {
            case 0: { sum = sum + sigleNum * 7; break;}
            case 1: { sum = sum + sigleNum * 9; break;}
            case 2: { sum = sum + sigleNum * 10; break;}
            case 3: { sum = sum + sigleNum * 5; break;}
            case 4: { sum = sum + sigleNum * 8; break;}
            case 5: { sum = sum + sigleNum * 4; break;}
            case 6: { sum = sum + sigleNum * 2; break;}
            case 7: { sum = sum + sigleNum * 1; break;}
            case 8: { sum = sum + sigleNum * 6; break;}
            case 9: { sum = sum + sigleNum * 3; break;}
            case 10: { sum = sum + sigleNum * 7; break;}
            case 11: { sum = sum + sigleNum * 9; break;}
            case 12: { sum = sum + sigleNum * 10; break;}
            case 13: { sum = sum + sigleNum * 5; break;}
            case 14: { sum = sum + sigleNum * 8; break;}
            case 15: { sum = sum + sigleNum * 4; break;}
            case 16: { sum = sum + sigleNum * 2; break;}
        }
    }
    //余数对应0 1 2 3 4 5 6 7 8 9 10
    //1 0 X 9 8 7 6 5 4 3 2
    NSInteger remainder = sum%11;
    int lastNum = 0;
    switch (remainder) {
        case 0:{lastNum = 1; break;}
        case 1:{lastNum = 0; break;}
        case 2:{lastNum = 10; break;}
        case 3:{lastNum = 9; break;}
        case 4:{lastNum = 8; break;}
        case 5:{lastNum = 7; break;}
        case 6:{lastNum = 6; break;}
        case 7:{lastNum = 5; break;}
        case 8:{lastNum = 4; break;}
        case 9:{lastNum = 3; break;}
        case 10:{lastNum = 2; break;}
    }
    NSString *lastNumStr;
    if (lastNum == 10) {
        lastNumStr = [NSString stringWithFormat:@"%@", @"X"];
    }else{
        lastNumStr = [NSString stringWithFormat:@"%d", lastNum];
    }
    
    if ([[idNum substringFromIndex:17] isEqualToString:lastNumStr]) {
        ENTLog(@"YES!!lastSupporseToBe:%@, lastBe:%@", lastNumStr, [idNum substringFromIndex:17]);
        return true;
    }else{
        ENTLog(@"NO!!lastSupporseToBe:%@, lastBe:%@", lastNumStr, [idNum substringFromIndex:17]);
        return false;
    }
    
}


- (NSDictionary*)getCodeCityDictOfIdentitycard{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"身份证号码省市地区" ofType:@"txt"];
    NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [fileContent componentsSeparatedByString:@"\n"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (NSString *str in array) {
        NSString *code = [str substringToIndex:6];
        NSString *city = [str substringFromIndex:7];
        [dict setObject:city forKey:code];
    }
    return dict;
}

/***************************************************************
 功能：校验身份证号码
 参数：无
 返回：bool
 ****************************************************************/
- (BOOL)isValidIDNumber{
    
    //校验位数
    if ([self length] != 18) {
        ENTLog(@"身份证位数错误！");
        return NO;
    }
    
    //校验计算最后一位码
    if (![self verifyLastNum:self]) {
        ENTLog(@"身份证code错误！");
        return NO;
    }
    
    //获取当前年
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSInteger currentY = [[currentDateStr substringWithRange:NSMakeRange(0, 4)] integerValue];
    NSInteger currentM = [[currentDateStr substringWithRange:NSMakeRange(5, 2)] integerValue];
    NSInteger currentD = [[currentDateStr substringWithRange:NSMakeRange(8, 2)] integerValue];
    //获取身份证生日
    NSInteger y = [[self substringWithRange:NSMakeRange(6, 4)]integerValue];
    NSInteger m = [[self substringWithRange:NSMakeRange(10, 2)]integerValue];
    NSInteger d = [[self substringWithRange:NSMakeRange(12, 2)]integerValue];
    
    //校验生日--当前日期以前出生
    if (y > currentY) {//生日大于今年
        ENTLog(@"身份证前7、8、9、10位错误！");
        return NO;
    }else if(y == currentY){//生日等于今年
        if (m > currentM) {//生日大于今年今月
            ENTLog(@"身份证前11、12位错误！");
            return NO;
        }else if(m == currentM){//生日等于今年今月
            if (d > currentD) {//生日大于今天
                ENTLog(@"身份证前13、14位错误！");
                return NO;
            }
        }
    }
    //校验生日--月：1～12月
    if (m > 12 || m < 1) {
        ENTLog(@"身份证前11、12位错误！");
        return NO;
    }
    //校验生日--天：不大于每月的最多天数
    if (d > 31 || d < 1) {
        ENTLog(@"身份证前13、14位错误！");
        return NO;
    }else if(m == 4 || m == 6 || m == 9 || m == 11){
        if (d == 30) {
            ENTLog(@"身份证前13、14位错误！");
            return NO;
        }
    }else if(m == 2){
        if (d > 29) {
            ENTLog(@"身份证前13、14位错误！");
            return NO;
        }
    }
    
    
    //前17为必须数字
    NSString *regex = @"^[0-9]*$";
    NSPredicate *identityCard17Predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL flag17 = [identityCard17Predicate evaluateWithObject:[self substringWithRange:NSMakeRange(0, 16)]];
    if (!flag17) {
        ENTLog(@"身份证存在特殊字符！");
        return NO;
    }
    
    //最后一位是数字或者X
    NSString *lastChar = [self substringWithRange:NSMakeRange(17, 1)];
    NSPredicate *identityCard18Predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL flag = [identityCard18Predicate evaluateWithObject:lastChar];
    if (!flag) {//不是数字
        if (![lastChar isEqualToString:@"X"]) {//不是X
            ENTLog(@"身份证最后一位存在特殊字符！");
            return NO;
        }
    }
    return YES;
}

/***************************************************************
 功能：校验真实姓名
 参数：无
 返回：bool
 ****************************************************************/
- (BOOL)isValidRealname{

     //校验信息
     //姓名
     NSRegularExpression *regx = [NSRegularExpression regularExpressionWithPattern:@"\\d+" options:NSRegularExpressionCaseInsensitive error:nil];
     NSTextCheckingResult *match = [regx firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
     BOOL isMatch = match!=nil;
    
    return isMatch;
}



/***********************************************************************
 *功能：   获取格式为yyyy-MM-dd HH-mm-SS的日期NSDate
 *参数：   NSString 日期
 *返回值：  NSDate 日期
 ***********************************************************************/
- (NSDate*)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-SS"];
    NSDate *date = [formatter dateFromString:self];
    return date;
}

/***********************************************************************
 *功能：   获取格式为xx的日期NSDate
 *参数：   NSString 日期格式
 *返回值： NSDate 日期
 ***********************************************************************/
- (NSDate*)convertToDateWithFormat:(NSString*)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:self];
    return date;
}


/***********************************************************************
 *功能：   发表博文的日期显示形式转换
 *参数：   无
 *返回值： NSString 日期
 ***********************************************************************/
- (NSString*)convertBlogAddDate{
    NSDate *addDate = [self convertToDateWithFormat:@"yyyy-MM-dd HH:mm:SS"];
    NSString *todayZeroString = [[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
    todayZeroString = [todayZeroString stringByAppendingString:@" 00:00:00"];
    NSDate *todayZeroDate = [todayZeroString convertToDateWithFormat:@"yyyy-MM-dd HH:mm:SS"];
    NSTimeInterval timeInterval = [addDate timeIntervalSinceDate:todayZeroDate];
    NSString *addDateString = @"";
    if (timeInterval > 0) {
        
        addDateString = [@"今天 " stringByAppendingString:[self substringFromIndex:11]];
    }else{
        addDateString = self;
    }
    
    return addDateString;
}

/***********************************************************************
 *功能：   创建userid
 *参数：   NSString userName用户名
 *返回值： NSString userid
 ***********************************************************************/
- (NSString*)userIdString{
    return [[[NSDate date] string] stringByAppendingString:self];
}

- (NSInteger)versionStringConvertToInt{
    
    if (self) {
        NSString *originString = [[NSString alloc] initWithString:self];
        
        NSString *intString = @"";
        while (1) {
            NSRange range = [originString rangeOfString:@"."];
            if (range.location != NSNotFound) {
                intString = [intString stringByAppendingString:[originString substringToIndex:range.location]];
                
                originString = [originString substringFromIndex:range.location +1];
            }else{
                intString = [intString stringByAppendingString:originString];
                break;
            }
            
            
        }
        
        if (intString.length == 3) {
            return [intString integerValue];
        }else if (intString.length == 2){
            return [[intString stringByAppendingString:@"0"] integerValue];
        }
    }
    
    return 0;
}

- (NSString*)stringReplaceFromUnicode

{
    
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                           
                                                           mutabilityOption:NSPropertyListImmutable
                           
                                                                     format:NULL
                           
                                                           errorDescription:NULL];
    
    
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    
}

- (NSString *)stringDecode

{
    
    NSMutableString *outputStr = [NSMutableString  stringWithString:self];
    
    [outputStr replaceOccurrencesOfString:@"+"
     
                               withString:@" "
     
                                  options:NSLiteralSearch
     
                                    range:NSMakeRange(0, [outputStr length])];
    
    
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}




@end



@implementation NSDate (EXTEND)

/***********************************************************************
 *功能：   获取格式为yyyy-MM-dd HH-mm-SS的日期字符串
 *参数：   NSDate 日期
 *返回值：  NSString 日期
 ***********************************************************************/
- (NSString*)string{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-SS"];
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}

/***********************************************************************
 *功能：   获取格式为xx的日期字符串
 *参数：   NSDate 日期
 *返回值：  NSString 格式
 ***********************************************************************/
- (NSString*)stringWithFormat:(NSString*)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateStr = [formatter stringFromDate:self];
    return dateStr;
}

- (NSString*)weekDay
{
    NSString *weekDayStr = nil;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSString *str = [self description];
    if (str.length >= 10) {
        NSString *nowString = [str substringToIndex:10];
        NSArray *array = [nowString componentsSeparatedByString:@"-"];
        if (array.count == 0) {
            array = [nowString componentsSeparatedByString:@"/"];
        }
        if (array.count >= 3) {
            int year = (int)[[array objectAtIndex:0] integerValue];
            int month = (int)[[array objectAtIndex:1] integerValue];
            int day = (int)[[array objectAtIndex:2] integerValue];
            [comps setYear:year];
            [comps setMonth:month];
            [comps setDay:day];
        }
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
    int week = (int)[weekdayComponents weekday];
    //week ++;
    switch (week) {
        case 1:
            weekDayStr = @"星期日";
            break;
        case 2:
            weekDayStr = @"星期一";
            break;
        case 3:
            weekDayStr = @"星期二";
            break;
        case 4:
            weekDayStr = @"星期三";
            break;
        case 5:
            weekDayStr = @"星期四";
            break;
        case 6:
            weekDayStr = @"星期五";
            break;
        case 7:
            weekDayStr = @"星期六";
            break;
        default:
            weekDayStr = @"";  
            break;  
    }  
    return weekDayStr;  
}

@end


@implementation  NSURL (EXTEND)

/***********************************************************************
 *功能：   将url地址串解析出web对应的title
 *参数：   无
 *返回值： NSString title
 ***********************************************************************/
- (NSString*)webTitle{
    
    NSError *error = nil;
    NSURLRequest *webDataRequesst = [NSURLRequest requestWithURL:self cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:1.5f];
    NSData *data = [NSURLConnection sendSynchronousRequest:webDataRequesst returningResponse:nil error:&error];
    
    if (error || data == nil) {
        return @"0";

        //return [NSString stringWithFormat:@"%@", self];
        //return @"网址解析失败";
    }
    
    NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSStringEncoding enc =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    if ([s length] == 0) {
        s = [NSString stringWithContentsOfURL:self encoding:enc error:nil];
    }
    NSRange r = [s rangeOfString:@"<title>"];
    if (r.location != NSNotFound) {
        s = [s substringFromIndex:r.location + r.length];
    }
    
    r = [s rangeOfString:@"</title>"];
    if (r.location != NSNotFound) {
        s = [s substringToIndex:r.location];
    }
    
    if (!s) {
        return @"0";
        //return [NSString stringWithFormat:@"%@", self];

       // s = @"网址解析失败";
    }
    
    return s;

}




@end



@implementation UIView (EXTEND)

/***************************************************************
 功能：拿到View的控制器对象
 参数：
 返回：无
 ****************************************************************/
- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    } while (next != nil);
    
    return nil;
}


//隐藏提示信息
- (void)hideAlertText{
    for (UIView *v in self.subviews) {
        if (v.tag == TAG_VIEW_HUD_SUPER_VEIW_TAG) {
            [v removeFromSuperview];
            break;
        }
    }
}


/***************************************************************
 功能：显示提示信息
 参数：NSString 提示内容
 返回：无
 ****************************************************************/
- (void)showAlertText:(NSString*)alertText{
    
    CGFloat viewWidth = APP_WIDTH;
    
    //CGSize textSize = [alertText sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(viewWidth,1000) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat viewHeight = 300;
    //CGFloat viewHeight = textSize.height + 100;
    //(self.frame.size.height - viewHeight)/2
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - viewWidth)/2, 0, viewWidth, viewHeight)];
    
    view.tag = TAG_VIEW_HUD_SUPER_VEIW_TAG;
    [view setBackgroundColor:[UIColor clearColor]];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:view.bounds];
    hud.mode = MBProgressHUDModeText;
    //hud.labelText = @"";
    hud.detailsLabelText = alertText;//
    //hud.backgroundColor = [UIColor yellowColor];
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    //hud.labelFont = [UIFont systemFontOfSize:14];
    //hud.color = COLOR_BUTTON_BLUE;
    hud.opacity = 0.6;
    [view addSubview:hud];
    [self addSubview:view];
    
    [hud show:YES];
    
    [self performSelector:@selector(hideAlertText) withObject:nil afterDelay:2.0f];

}


@end

@implementation NSArray (EXTEND)

//登陆后，更新car信息，先删除所有，后添加
- (void)updateCarsAfterLogin{
    for (NSObject *obj in self) {
        if (![obj isKindOfClass:[CarInfo class]]) {
            
                ENTLog(@"obj in array is not carinfo class!!!");
                return;
            
        }
    }
    [[DataBase sharedDataBase] deleteCarInfoByUserId:APP_DELEGATE.userId];
    for (CarInfo *car in self) {
        [[DataBase sharedDataBase] insertCarInfo:car];
    }
}


//登陆后，更新driver信息，先删除所有，后添加
- (void)updateDriversAfterLogin{
    for (NSObject *obj in self) {
        if (![obj isKindOfClass:[DriverInfo class]]) {
            
                ENTLog(@"obj in array is not DriverInfo class!!!");
                return;
            
        }
    }
    [[DataBase sharedDataBase] deleteDriverInfoByUserId:APP_DELEGATE.userId];
    for (DriverInfo *driver in self) {
        [[DataBase sharedDataBase] insertDriverInfo:driver];
    }
    
    
    
}



@end


@implementation  NSDictionary (EXTEND)
/***********************************************************************
 *功能：   解析网络数据容错
 *参数：   NSString key
 *返回值： NSString
 ***********************************************************************/
- (NSString*)analysisStrValueByKey:(NSString*)key{
    NSObject *value = [self objectForKey:key];
    if (!value) {
        return @"";
    }
    if (![value isKindOfClass:[NSString class]]) {
        if ([value isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%@", value];
        }else{
            return @"";
        }
    }else{
        return (NSString*)value;
    }
}



/***********************************************************************
 *功能：   解析网络数据容错
 *参数：   NSString key
 *返回值： NSArray
 ***********************************************************************/
- (NSArray*)analysisArrValueByKey:(NSString*)key{
    
    NSObject *value = [self objectForKey:key];
    if ([value isKindOfClass:[NSArray class]]) {
        return (NSArray*)value;
    }else{
        return [NSArray arrayWithObjects:nil, nil];
    }
    
}

/***********************************************************************
 *功能：   解析网络数据容错
 *参数：   NSString key
 *返回值： NSDictionary
 ***********************************************************************/
- (NSDictionary*)analysisDictValueByKey:(NSString*)key{
    NSObject *value = [self objectForKey:key];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary*)value;
    }else{
        return [NSDictionary dictionaryWithObjects:nil forKeys:nil];
    }
}


@end


@implementation UITextField (LimitLength)
/***********************************************************************
 *功能：   设置TextFiled的输入长度
 *参数：   int length 设置长度
 *返回值： 无
 ***********************************************************************/
static NSString *kLimitTextLengthKey = @"kLimitTextLengthKey";
- (void)limitCHTextLength:(int)length
{
    objc_setAssociatedObject(self, (__bridge const void *)(kLimitTextLengthKey), [NSNumber numberWithInt:length], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(textFieldTextLengthLimit:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldTextLengthLimit:(id)sender
{
    NSNumber *lengthNumber = objc_getAssociatedObject(self, (__bridge const void *)(kLimitTextLengthKey));
    int length = [lengthNumber intValue];
    
    bool isChinese;//判断当前输入法是否是中文
    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString: @"en-US"]) {
        isChinese = false;
    }else{
        isChinese = true;
    }

    NSString *str = [[self text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
    if (isChinese) { //中文输入法下
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            //ENTLog(@"汉字");
            if (str.length > length) {
                NSString *strNew = [NSString stringWithString:str];
                [self setText:[strNew substringToIndex:length]];
            }
        }
        else
        {
            //ENTLog(@"输入的英文还没有转化为汉字的状态");
            
        }
    }else{
        //ENTLog(@"输入英文str=%@; 本次长度=%d",str,[str length]);
        if ([str length] > length) {
            NSString *strNew = [NSString stringWithString:str];
            [self setText:[strNew substringToIndex:length]];
        }
    }
    
    
}


/***********************************************************************
 *功能：   创建指定属性的textfield
 *参数：   CGRect frame
 *返回值： UITextFieled
 ***********************************************************************/
+ (UITextField*)registTextFieldWithFrame:(CGRect)rect delegate:(id)sender{
    UITextField *tf = [[UITextField alloc] initWithFrame:rect];
    
    [tf setTextAlignment:NSTextAlignmentCenter];
    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    tf.borderStyle = UITextBorderStyleNone;
    tf.delegate = sender;
    //tf.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;

    [tf setFont:[UIFont systemFontOfSize:17]];
    [tf setClearButtonMode:UITextFieldViewModeWhileEditing];
    tf.background = [UIImage imageNamed:@"bg_input_textfield.png"];
    
    return tf;
}

/***********************************************************************
 *功能：   创建指定属性的textfield
 *参数：   CGRect frame
 *返回值： UITextFieled
 ***********************************************************************/
+ (UITextField*)mainTextFieldWithFrame:(CGRect)rect placeholder:(NSString*)placeholder tag:(NSInteger)tag delegate:(id)sender{
    UITextField *tf = [[UITextField alloc] initWithFrame:rect];
    if (placeholder) {
        tf.placeholder = placeholder;
    }
    if (tag) {
        tf.tag = tag;
    }
    
    [tf setTextAlignment:NSTextAlignmentLeft];
    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tf.borderStyle = UITextBorderStyleNone;
    tf.backgroundColor = [UIColor clearColor];
    tf.delegate = sender;
    tf.textColor = COLOR_FONT_NOMAL;
    //tf.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [tf setFont:FONT_NOMAL];
    //[tf setClearButtonMode:UITextFieldViewModeWhileEditing];
    
    return tf;
}


@end


@implementation TabBarViewController (EXTEND)

- (void)hiddenCustomTabBar:(BOOL)hidden{
    UIView *v = [self.view.subviews lastObject];
    [UIView animateWithDuration:.35 animations:^{
        v.left = hidden ? -APP_WIDTH : 0;
    }];;
}

@end

@implementation  UIImage  (EXTEND)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size

{
    
    @autoreleasepool {
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context,
                                       
                                       color.CGColor);
        
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
        
        return img;
        
    }
    
}
@end

@implementation UILabel  (EXTEND)
- (void)fitSpace:(CGFloat)space{
    
    if ([self respondsToSelector:@selector(setAttributedText:)]) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:space];//调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
        
        self.attributedText = attributedString;
        [self sizeToFit];
    }
}


- (void)convertNewLabelWithFont:(UIFont*)font textColor:(UIColor*)color textAlignment:(NSInteger)ali{
    [self setFont:font];
    self.textColor = color;
    self.textAlignment = ali;
    self.backgroundColor = [UIColor clearColor];
}


+ (UILabel*)lineLabelWithPXPoint:(CGPoint)p{
    UILabel *line = [[UILabel alloc] initWithFrame:LGRectMake(p.x, p.y, APP_PX_WIDTH, 1)];
    //    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(p.x*PX_X_SCALE, p.y*PX_X_SCALE, APP_PX_WIDTH, 1*PX_X_SCALE)];

    [line setBackgroundColor:COLOR_FRAME_LINE];
    return line;
}
+ (UILabel*)lineLabelWithPoint:(CGPoint)p{
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(p.x, p.y, APP_PX_WIDTH, 1)];
    //    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(p.x*PX_X_SCALE, p.y*PX_X_SCALE, APP_PX_WIDTH, 1*PX_X_SCALE)];
    
    [line setBackgroundColor:COLOR_FRAME_LINE];
    return line;
}
@end

@implementation UIButton (EXTEND)

+ (UIButton*)mainButtonWithPXY:(CGFloat)y title:(NSString*)title target:(id)target action:(SEL)act{
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b setBackgroundImage:[UIImage imageNamed:@"button_green.png"] forState:UIControlStateNormal];
    [b setTitleColor:[UIHelper getColor:@"#ffffff"] forState:UIControlStateNormal];
    b.titleLabel.font = BOLD_FONT_SIZE(40);
    [b setFrame:LGRectMake(30, y, APP_PX_WIDTH - 30*2, 90)];
    [b setTitle:title forState:UIControlStateNormal];
    [b addTarget:target action:act forControlEvents:UIControlEventTouchUpInside];
    return b;
}

@end


@implementation UIImageView (EXTEND)

+ (UIImageView*)backgroudTwoLineImageViewWithPXX:(CGFloat)x y:(CGFloat)y width:(CGFloat)wi height:(CGFloat)he{
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:BGRectMake(x, y, wi, he)];
    [bgImgView setBackgroundColor:[UIColor whiteColor]];
    [bgImgView setUserInteractionEnabled:YES];
    
    UILabel *line = [UILabel lineLabelWithPXPoint:CGPointMake(x, 0)];
    [bgImgView addSubview:line];
    line = [UILabel lineLabelWithPXPoint:CGPointMake(x, he - 1)];
    [bgImgView addSubview:line];

    return bgImgView;
}

@end

@implementation UIViewController (EXTEND)
- (void)goToLoginPage{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController  *navVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    if (iOS7) {
        UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, APP_WIDTH, 20)];
        statusBarView.backgroundColor = COLOR_NAV;
        [navVC.navigationBar addSubview:statusBarView];
        navVC.navigationBar.barTintColor = COLOR_NAV;
    }
    
    [self.navigationController presentViewController:navVC animated:YES completion:nil];
}
@end
