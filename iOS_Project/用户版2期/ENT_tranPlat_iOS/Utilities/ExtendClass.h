//
//  ExtendClass.h
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

#import <Foundation/Foundation.h>
#import <objc/objc.h>
#import <objc/runtime.h>

#import "CarInfo.h"
#import "DriverInfo.h"


#define TAG_VIEW_HUD_SUPER_VEIW_TAG         10000000

@interface ExtendClass : NSObject

@end


@interface NSString (EXTEND)
/***************************************************************
 功能：校验电话号码
 参数：无
 返回：bool
 ****************************************************************/
- (BOOL)isValidPhoneNum;

/***************************************************************
 功能：校验邮政编码
 参数：无
 返回：bool
 ****************************************************************/
- (BOOL)isValidPostCode;

/***************************************************************
 功能：校验电子邮箱
 参数：无
 返回：bool
 ****************************************************************/
- (BOOL)isValidEmail;

/***************************************************************
 功能：校验身份证号码
 参数：无
 返回：bool
 ****************************************************************/
- (BOOL)isValidIDNumber;

/***************************************************************
 功能：校验真实姓名
 参数：无
 返回：bool
 ****************************************************************/
- (BOOL)isValidRealname;

/***********************************************************************
 *功能：   获取格式为yyyy-MM-dd HH-mm-SS的日期NSDate
 *参数：   NSString 日期
 *返回值：  NSDate 日期
 ***********************************************************************/
- (NSDate*)date;

/***********************************************************************
 *功能：   获取格式为xx的日期NSDate
 *参数：   NSString 日期格式
 *返回值： NSDate 日期
 ***********************************************************************/
- (NSDate*)convertToDateWithFormat:(NSString*)format;

/***********************************************************************
 *功能：   发表博文的日期显示形式转换
 *参数：   无
 *返回值： NSString 日期
 ***********************************************************************/
- (NSString*)convertBlogAddDate;


/***********************************************************************
 *功能：   创建userid
 *参数：   NSString userName用户名
 *返回值： NSString userid
 ***********************************************************************/
- (NSString*)userIdString;

/***********************************************************************
 *功能：   将版本号格式（x.x.x）转为整型(xxx)
 *参数：   无
 *返回值： NSInteger 整型版本号
 ***********************************************************************/
- (NSInteger)versionStringConvertToInt;

- (NSString*)stringReplaceFromUnicode;
- (NSString *)stringDecode;
@end


@interface NSDate (EXTEND)



/***********************************************************************
 *功能：   获取格式为yyyy-MM-dd HH-mm-SS的日期字符串
 *参数：   NSDate 日期
 *返回值：  NSString 日期
 ***********************************************************************/
- (NSString*)string;

/***********************************************************************
 *功能：   获取格式为xx的日期字符串
 *参数：   NSDate 日期
 *返回值：  NSString 格式
 ***********************************************************************/
- (NSString*)stringWithFormat:(NSString*)format;
/*
 返回星期几
 */
- (NSString*)weekDay;
@end

@interface NSURL (EXTEND)

/***********************************************************************
 *功能：   将url地址串解析出web对应的title
 *参数：   无
 *返回值： NSString title
 ***********************************************************************/
- (NSString*)webTitle;

@end

@interface NSArray (EXTEND)

//登陆后，更新car信息，先删除所有，后添加
- (void)updateCarsAfterLogin;

//登陆后，更新driver信息，先删除所有，后添加
- (void)updateDriversAfterLogin;

- (NSArray *)byCarArray;

@end

#pragma mark- views!

@interface NSDictionary (EXTEND)
/***********************************************************************
 *功能：   解析网络数据容错
 *参数：   NSString key
 *返回值： NSString
 ***********************************************************************/
- (NSString*)analysisStrValueByKey:(NSString*)key;


/***********************************************************************
 *功能：   解析网络数据容错
 *参数：   NSString key
 *返回值： NSArray
 ***********************************************************************/
- (NSArray*)analysisArrValueByKey:(NSString*)key;

/***********************************************************************
 *功能：   解析网络数据容错
 *参数：   NSString key
 *返回值： NSDictionary
 ***********************************************************************/
- (NSDictionary*)analysisDictValueByKey:(NSString*)key;


@end



@interface UIView (EXTEND)

/***************************************************************
 功能：拿到View的控制器对象
 参数：
 返回：无
 ****************************************************************/
- (UIViewController *)viewController;


/***************************************************************
 功能：显示提示信息
 参数：NSString 提示内容
 返回：无
 ****************************************************************/
- (void)showAlertText:(NSString*)alertText;

@end


@interface UIAlertView (EXTEND)


/***************************************************************
 功能：提示无代理的信息
 参数：
 返回：无
 ****************************************************************/
+ (void)alertTitle:(NSString*)title msg:(NSString*)msg;

@end



@interface UITextField (LimitLength)
/***********************************************************************
 *功能：   设置TextFiled的输入长度
 *参数：   int length 设置长度
 *返回值： 无
 ***********************************************************************/
- (void)limitCHTextLength:(int)length;

/***********************************************************************
 *功能：   创建指定属性的textfield
 *参数：   CGRect frame
 *返回值： UITextFieled
 ***********************************************************************/
+ (UITextField*)registTextFieldWithFrame:(CGRect)rect delegate:(id)sender;

/***********************************************************************
 *功能：   创建指定属性的textfield
 *参数：   CGRect frame
 *返回值： UITextFieled
 ***********************************************************************/
+ (UITextField*)mainTextFieldWithFrame:(CGRect)rect placeholder:(NSString*)placeholder tag:(NSInteger)tag delegate:(id)sender;
@end


@interface UITabBarController (EXTEND)

/***************************************************************
 功能：隐藏自定义的TabBar
 参数：bool
 返回：无
 ****************************************************************/
- (void)hiddenCustomTabBar:(BOOL)hidden;




@end


@interface UIImage  (EXTEND)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end

@interface UILabel  (EXTEND)
- (void)fitSpace:(CGFloat)space;
- (void)convertNewLabelWithFont:(UIFont*)font textColor:(UIColor*)color textAlignment:(NSInteger)ali;
+ (UILabel*)lineLabelWithPXPoint:(CGPoint)p;
+ (UILabel*)lineLabelWithPoint:(CGPoint)p;
@end




@interface UIButton (EXTEND)
+ (UIButton*)mainButtonWithPXY:(CGFloat)y title:(NSString*)title target:(id)target action:(SEL)act;
@end


@interface UIImageView (EXTEND)

+ (UIImageView*)backgroudTwoLineImageViewWithPXX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;
@end

@interface UIViewController (EXTEND)
- (void)goToLoginPage;
@end
