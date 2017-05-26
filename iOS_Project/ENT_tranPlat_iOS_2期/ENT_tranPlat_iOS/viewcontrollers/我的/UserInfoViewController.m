//
//  UserInfoViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-5.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "UserInfoViewController.h"
#import "ResetUserRealNameViewController.h"
#import "ResetUserAddrViewController.h"
#import "ResetUserTelViewController.h"
#import "ResetUserPWViewController.h"
#import "ResetUserEmailViewController.h"

@interface UserInfoViewController ()<
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
ResetUserPWViewControllerDelegate
>
{
    UIImageView         *_userPhotoImgView;
    UILabel             *_userNameL;
    UILabel             *_realNameL;
    UILabel             *_addrL;

    UILabel             *_userTelL;
    UILabel             *_emailL;
    
    BOOL                _passwordDidChanged;

}
@property (nonatomic, retain)   NSData     *tempImageData;

@end

@implementation UserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

#define TAG_BUTTON_USER_IMAGE   10000
#define TAG_BUTTON_USER_NAME    10001
#define TAG_BUTTON_REAL_NAME    10002
#define TAG_BUTTON_ADDR         10003
#define TAG_BUTTON_USER_TEL     10004
#define TAG_BUTTON_USER_EMAIL   10005
#define TAG_BUTTON_RESET_PW     10006
//初始化视图
- (void)loadView_
{
    UIScrollView *rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT - APP_NAV_HEIGHT)];
    rootScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:rootScrollView];
    
    CGFloat firstLineHeight = 80 + 30*2;
    CGFloat sigleLineHeight = 30*3;
    
    /******************************头像、用户名、真实姓名、通讯地址***************************************************/
    UIImageView *bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:30 width:APP_PX_WIDTH height:(firstLineHeight + sigleLineHeight*3)];
    [rootScrollView addSubview:bgImgView];
    UILabel *lable = [[UILabel alloc] initWithFrame:LGRectMake(30, (firstLineHeight - 30)/2, 200, 30)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    lable.text = @"头像";
    [bgImgView addSubview:lable];
    _userPhotoImgView = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 30*3 - 80, (firstLineHeight - 80)/2, 80, 80)];
    [bgImgView addSubview:_userPhotoImgView];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, firstLineHeight + 30, 200, 30)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    lable.text = @"用户名";
    [bgImgView addSubview:lable];
    _userNameL = [[UILabel alloc] initWithFrame:LGRectMake(bgImgView.w - 30*3 - 400, lable.t, 400, 30)];
    [_userNameL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentRight];
    [bgImgView addSubview:_userNameL];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, firstLineHeight + sigleLineHeight + 30, 200, 30)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    lable.text = @"真实姓名";
    [bgImgView addSubview:lable];
    _realNameL = [[UILabel alloc] initWithFrame:LGRectMake(bgImgView.w - 30*3 - 400, lable.t, 400, 30)];
    [_realNameL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentRight];
    [bgImgView addSubview:_realNameL];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, firstLineHeight + sigleLineHeight*2 + 30, 200, 30)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    lable.text = @"通讯地址";
    [bgImgView addSubview:lable];
    _addrL = [[UILabel alloc] initWithFrame:LGRectMake(bgImgView.w - 30*3 - 400, lable.t, 400, 30)];
    [_addrL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentRight];
    [bgImgView addSubview:_addrL];
    //*****横线
    UILabel *lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, firstLineHeight - 1)];
    [bgImgView addSubview:lineL];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, firstLineHeight + sigleLineHeight - 1)];
    [bgImgView addSubview:lineL];lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, firstLineHeight + sigleLineHeight*2 - 1)];
    [bgImgView addSubview:lineL];
    //******箭头
    UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 30 - 30, (firstLineHeight - 30)/2, 30, 30)];
    [arrowImgView setImage:[UIImage imageNamed:@"arrow_right.png"]];
    [bgImgView addSubview:arrowImgView];
//    arrowImgView = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 30 - 30, firstLineHeight + 30, 30, 30)];
//    [arrowImgView setImage:[UIImage imageNamed:@"arrow_right.png"]];
//    [bgImgView addSubview:arrowImgView];
    arrowImgView = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 30 - 30, firstLineHeight + sigleLineHeight + 30, 30, 30)];
    [arrowImgView setImage:[UIImage imageNamed:@"arrow_right.png"]];
    [bgImgView addSubview:arrowImgView];
    arrowImgView = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 30 - 30, firstLineHeight + sigleLineHeight*2 + 30, 30, 30)];
    [arrowImgView setImage:[UIImage imageNamed:@"arrow_right.png"]];
    [bgImgView addSubview:arrowImgView];
    //******action
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:LGRectMake(0, 0, bgImgView.w, firstLineHeight)];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:TAG_BUTTON_USER_IMAGE];
    [btn setBackgroundColor:[UIColor clearColor]];
    [bgImgView addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:LGRectMake(0, firstLineHeight, bgImgView.w, sigleLineHeight)];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:TAG_BUTTON_USER_NAME];
    [btn setBackgroundColor:[UIColor clearColor]];
    [bgImgView addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:LGRectMake(0, firstLineHeight + sigleLineHeight, bgImgView.w, sigleLineHeight)];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:TAG_BUTTON_REAL_NAME];
    [btn setBackgroundColor:[UIColor clearColor]];
    [bgImgView addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:LGRectMake(0, firstLineHeight + sigleLineHeight*2, bgImgView.w, sigleLineHeight)];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:TAG_BUTTON_ADDR];
    [btn setBackgroundColor:[UIColor clearColor]];
    [bgImgView addSubview:btn];
    
    /******************************手机号码、电子邮箱***************************************************/
    bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgImgView.b + 30 width:APP_PX_WIDTH height:(sigleLineHeight*2)];
    [rootScrollView addSubview:bgImgView];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 200, 30)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    lable.text = @"手机号码";
    [bgImgView addSubview:lable];
    _userTelL = [[UILabel alloc] initWithFrame:LGRectMake(bgImgView.w - 30*3 - 400, lable.t, 400, 30)];
    [_userTelL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentRight];
    [bgImgView addSubview:_userTelL];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, sigleLineHeight + 30, 200, 30)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    lable.text = @"电子邮箱";
    [bgImgView addSubview:lable];
    _emailL = [[UILabel alloc] initWithFrame:LGRectMake(bgImgView.w - 30*3 - 400, lable.t, 400, 30)];
    [_emailL convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentRight];
    [bgImgView addSubview:_emailL];
    
    //*****横线
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, sigleLineHeight - 1)];
    [bgImgView addSubview:lineL];
    lineL = [UILabel lineLabelWithPXPoint:CGPointMake(30, sigleLineHeight*2 - 1)];
    [bgImgView addSubview:lineL];
    
    //*****箭头
    arrowImgView = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 30 - 30, 30, 30, 30)];
    [arrowImgView setImage:[UIImage imageNamed:@"arrow_right.png"]];
    [bgImgView addSubview:arrowImgView];
    arrowImgView = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 30 - 30, sigleLineHeight + 30, 30, 30)];
    [arrowImgView setImage:[UIImage imageNamed:@"arrow_right.png"]];
    [bgImgView addSubview:arrowImgView];
    //******action
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:LGRectMake(0, 0, bgImgView.w, sigleLineHeight)];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:TAG_BUTTON_USER_TEL];
    [btn setBackgroundColor:[UIColor clearColor]];
    [bgImgView addSubview:btn];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:LGRectMake(0, sigleLineHeight, bgImgView.w, sigleLineHeight)];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:TAG_BUTTON_USER_EMAIL];
    [btn setBackgroundColor:[UIColor clearColor]];
    [bgImgView addSubview:btn];
    /******************************密码修改***************************************************/
    bgImgView = [UIImageView backgroudTwoLineImageViewWithPXX:0 y:bgImgView.b + 30 width:APP_PX_WIDTH height:sigleLineHeight];
    [rootScrollView addSubview:bgImgView];
    
    lable = [[UILabel alloc] initWithFrame:LGRectMake(30, 30, 200, 30)];
    [lable convertNewLabelWithFont:FONT_NOMAL textColor:COLOR_FONT_NOMAL textAlignment:NSTextAlignmentLeft];
    lable.text = @"密码修改";
    [bgImgView addSubview:lable];
    arrowImgView = [[UIImageView alloc] initWithFrame:LGRectMake(bgImgView.w - 30 - 30, 30, 30, 30)];
    [arrowImgView setImage:[UIImage imageNamed:@"arrow_right.png"]];
    [bgImgView addSubview:arrowImgView];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:LGRectMake(0, 0, bgImgView.w, sigleLineHeight)];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:TAG_BUTTON_RESET_PW];
    [btn setBackgroundColor:[UIColor clearColor]];
    [bgImgView addSubview:btn];
    
    /******************************退出登录***************************************************/
    UIButton *logoutButton = [UIButton mainButtonWithPXY:bgImgView.b + 30 title:@"退出登录" target:self action:@selector(logoutButtonClicked)];
    [rootScrollView addSubview:logoutButton];
    
    if (logoutButton.bottom > rootScrollView.height) {
        [rootScrollView setContentSize:CGSizeMake(rootScrollView.width, logoutButton.bottom)];
    }
    
}

- (void)reloadView{
    UserInfo *user = [[[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName] lastObject];
    
    [_userNameL setText:user.userName];
    [_realNameL setText:user.realName];
    _realNameL.textColor = COLOR_FONT_NOMAL;
    if ([_realNameL.text isEqualToString:@""]) {
        [_realNameL setText:@"未设置"];
        _realNameL.textColor = COLOR_FONT_INFO_SHOW;

    }
    
    
    [_addrL setText:user.addr];
    _addrL.textColor = COLOR_FONT_NOMAL;
    if ([_addrL.text isEqualToString:@""]) {
        [_addrL setText:@"未添加"];
        _addrL.textColor = COLOR_FONT_INFO_SHOW;

    }
    
    [_userTelL setText:user.contactNum];
    _userTelL.textColor = COLOR_FONT_NOMAL;
    if ([_userTelL.text isEqualToString:@""]) {
        [_userTelL setText:@"未设置"];
        _userTelL.textColor = COLOR_FONT_INFO_SHOW;

    }
    
    [_emailL setText:user.email];
    _emailL.textColor = COLOR_FONT_NOMAL;
    if ([_emailL.text isEqualToString:@""]) {
        [_emailL setText:@"未添加"];
        _emailL.textColor = COLOR_FONT_INFO_SHOW;

    }

    if (!user.photoLocalPath || [user.photoLocalPath isEqualToString:@""]) {
        [_userPhotoImgView setImage:[UIImage imageNamed:@"chat_portrait_photo"]];
    }else{
        [_userPhotoImgView setImage:[UIImage imageWithContentsOfFile:user.photoLocalPath]];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photoDownloadFinished:) name:NOTIFICATION_FINISH_DOWNLOAD_PHOTO object:nil];

    [self loadView_];
    _passwordDidChanged = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setCustomNavigationTitle:@"我的账户"];
    
    [self reloadView];

    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    if (iOS7) {
        self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    }
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    
    if (_passwordDidChanged) {
        UserInfo *user = [[[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName] lastObject];
        user.isActive = ACTIVE_USER_NO;
        [user update];
        APP_DELEGATE.loginSuss = NO;
        APP_DELEGATE.userId = @"";
        APP_DELEGATE.userName = @"";
        
        APP_DELEGATE.firstTimeOnUserPage = YES;
        [self gobackPage];
    }
}

#pragma mark- notification
- (void)photoDownloadFinished:(NSNotification*)notify{
    [self reloadView];
}

#pragma mark- 事件

- (void)buttonClicked:(UIButton*)button{
    if (button.tag == TAG_BUTTON_USER_IMAGE) {//设置用户头像
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
        [sheet showInView:self.view];
    }else if (button.tag == TAG_BUTTON_USER_NAME) {//用户名不可更改
        
    }else if (button.tag == TAG_BUTTON_REAL_NAME) {//跳转修改真实姓名
        ResetUserRealNameViewController *rurnVC = [[ResetUserRealNameViewController alloc] init];
        [self.navigationController pushViewController:rurnVC animated:YES];
    }else if (button.tag == TAG_BUTTON_ADDR) {//跳转修改地址
        ResetUserAddrViewController *ruaVC = [[ResetUserAddrViewController alloc] init];
        [self.navigationController pushViewController:ruaVC animated:YES];
    }else if (button.tag == TAG_BUTTON_USER_TEL) {//跳转修改手机号码
        ResetUserTelViewController *rutVC = [[ResetUserTelViewController alloc] init];
        [self.navigationController pushViewController:rutVC animated:YES];
    }else if (button.tag == TAG_BUTTON_USER_EMAIL) {//跳转修改电子邮箱
        ResetUserEmailViewController *ruevc = [[ResetUserEmailViewController alloc] init];
        [self.navigationController pushViewController:ruevc animated:YES];
    }else if (button.tag == TAG_BUTTON_RESET_PW) {//跳转修改密码
        ResetUserPWViewController *rupwVC = [[ResetUserPWViewController alloc] init];
        rupwVC.delegate_ = self;
        rupwVC.needOldPW = YES;
        [self.navigationController pushViewController:rupwVC animated:YES];
    }
}

- (void)logoutButtonClicked{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"退出登录" message:@"是否确认退出登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
}

- (void)passwordChanged{
    
    _passwordDidChanged = YES;
   
}



#pragma mark- UIALERTVIEW DELEGATE
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.cancelButtonIndex) {
        
    }else{
        
        UserInfo *user = [[[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName] lastObject];
        user.isActive = ACTIVE_USER_NO;
        [user update];
        APP_DELEGATE.loginSuss = NO;
        APP_DELEGATE.userId = @"";
        APP_DELEGATE.userName = @"";
        
        [self gobackPage];
    }
    
}

#pragma mark- UIACTIONSHEET DELEGATE
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //ENTLog(@"%d", buttonIndex);
    if (buttonIndex == 0){//拍照
    
        BOOL cameraAvilible = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        if (cameraAvilible) {
//            BOOL deviceRearA = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
//            BOOL DeviceFrontA = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
//            if (DeviceFrontA && DeviceFrontA) {
//                
//            }else{
//            
//            }
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            ipc.delegate = self;
            [self presentViewController:ipc animated:YES completion:nil];

        }else{
            [UIAlertView alertTitle:@"" msg:@"当前设备不支持拍照！"];
        }
        
    }else if (buttonIndex == 1){//从相册选择

        BOOL photoLibraryAvilible = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
        if (photoLibraryAvilible) {
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            ipc.delegate = self;
            [self presentViewController:ipc animated:YES completion:nil];
            
        }else{
            [UIAlertView alertTitle:@"" msg:@"当前设备不支持从相册选择！"];
        }
        

    }else if (buttonIndex == 2){//取消
    
    
    }
}


#pragma mark-  UIImagePickerController DELEGATE
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((APP_WIDTH - 20)/2, (APP_HEIGHT - 20)/2, 20, 20)];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview:indicator];
    
    UIImage *originImg = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imgData = UIImageJPEGRepresentation(originImg, 1);
    
    CGFloat lengthFor1M = 4302692/2.2;//1M 的长度
    CGFloat per = lengthFor1M/imgData.length;
    if (per < 1) {
        imgData = UIImageJPEGRepresentation(originImg, per);
        
    }
    //  ENTLog(@"%d",imgData.length);
    
    [UIHelper createThumbImage:[UIImage imageWithData:imgData] size:CGSizeMake(200, 200) percent:0.5 onCompletion:^(NSData *imgData) {
        
        [indicator removeFromSuperview];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        [self uploadImage:imgData];
    }];
    
}


#pragma mark-  网络请求

- (void)updateUserInfoToServerWithImgUrl:(NSString*)url{
    UserInfo *user = [[[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName] lastObject];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"updateuser" forKey:@"action"];
    [dict setObject:APP_DELEGATE.userName forKey:@"username"];
    [dict setObject:user.realName forKey:@"realname"];
    [dict setObject:user.email forKey:@"email"];
    [dict setObject:user.contactNum forKey:@"mobilephone"];
    [dict setObject:user.addr forKey:@"address"];
    [dict setObject:user.postCode forKey:@"postcode"];
    [dict setObject:url forKey:@"photo"];//新地址
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"正在更新头像地址...";
    [[Network sharedNetwork] postBody:dict isResponseJson:NO doShowIndicator:NO callBackWithObj:dict onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if(result == postSucc){
            NSDictionary *userInfoDict = (NSDictionary*)callBackObj;
            
            //将修改后的信息保存到数据库中
            user.email = [userInfoDict analysisStrValueByKey:@"email"];
            user.contactNum = [userInfoDict analysisStrValueByKey:@"mobilephone"];
            user.postCode = [userInfoDict analysisStrValueByKey:@"postcode"];
            user.realName = [userInfoDict analysisStrValueByKey:@"realname"];
            user.addr = [userInfoDict analysisStrValueByKey:@"address"];
            user.photoServerPath = [userInfoDict analysisStrValueByKey:@"photo"];
            user.userName = [userInfoDict analysisStrValueByKey:@"username"];
            
            NSString *writePath = [[LOCAL_PATH_CACHES stringByAppendingPathComponent:user.userName] stringByAppendingString:@".jpg"];
            BOOL writeSucc = [self.tempImageData writeToFile:writePath atomically:YES];
            if (writeSucc) {
                user.photoLocalPath = writePath;
                self.tempImageData = nil;
            }

            //更新数据库
            [user update];
            [self reloadView];//刷新界面
            
            [self.view showAlertText:@"头像更新成功!"];
        }else{
            [UIAlertView alertTitle:@"提示信息" msg:@"头像地址更新至服务器,服务器异常！"];
        }
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } onError:^(NSString *errorStr) {
        [UIAlertView alertTitle:@"提示信息" msg:[@"头像地址更新至服务器失败!" stringByAppendingString:errorStr]];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }];
}


- (void)uploadImage:(NSData*)imageData{
    
    NSData *d = [[NSData alloc] initWithData:imageData];
    self.tempImageData = d;
    
    //网络请求上传图片
    NSString *str = [imageData base64Encoding];
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:@"clubs.956122.com"];//
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setObject:str forKey:@"byteString"];
    [body setObject:@"test" forKey:@"project"];
    [body setObject:@"jpg" forKey:@"fileType"];
    MKNetworkOperation *op = [en operationWithPath:@"uploadPic.action" params:body httpMethod:@"POST"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"正在上传头像...";
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        
        NSString *resString = completedOperation.responseString;
        
        //succ
        if ([resString rangeOfString:@"http://"].location != NSNotFound) {
//            UserInfo *user = [[[DataBase sharedDataBase] selectUserByName:APP_DELEGATE.userName] lastObject];
//
//            NSString *writePath = [[LOCAL_PATH_CACHES stringByAppendingPathComponent:user.userName] stringByAppendingString:@".jpg"];
//            BOOL writeSucc = [imageData writeToFile:writePath atomically:YES];
//            if (writeSucc) {
//                user.photoLocalPath = writePath;
//            }
//            user.photoServerPath = resString;
//            [user update];//更新本地user地址
//            [self reloadView];//刷新界面
            [self updateUserInfoToServerWithImgUrl:resString];//上传user新地址
        }else{
            
            [UIAlertView alertTitle:@"提示信息" msg:@"头像上传失败，服务器异常"];
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [UIAlertView alertTitle:@"提示信息" msg:@"头像上传失败，请检查您的网络连接"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
    [en enqueueOperation:op];
}






#ifdef aaaaaaaaaaaaaaaaa
- (BOOL)keepAndRuleCommitText{
    
    
    
    
    if ([self.realName isValidRealname]) {
        
        [UIAlertView alertTitle:@"提示信息" msg:@"姓名的格式不正确"];
        return NO;
        
    } else if ([_emailText.text rangeOfString:@"@"].length == 0){//电子邮箱校验
        
        [UIAlertView alertTitle:@"提示信息" msg:@"电子邮箱格式不正确"];
        return NO;
        
    } else if (![self.contactNum isValidPhoneNum]){//手机号码校验
        
        [UIAlertView alertTitle:@"提示信息" msg:@"手机号格式不正确"];
        return NO;
        
    }else if (![self.postCode isEqualToString:@""] && !self.postCode && self.postCode.length != 6){//邮编校验
        
        [UIAlertView alertTitle:@"提示信息" msg:@"邮编必须为6位"];
        return NO;
        
    } else if (self.postCode.length == 6){
        
        NSLog(@"%@,%d",self.postCode,self.postCode.length);
        
        NSString *regexPhone = @"\\d{6}";
        NSPredicate *predicatephone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexPhone];
        
        if (![predicatephone evaluateWithObject:self.postCode]) {
            
            [UIAlertView alertTitle:@"提示信息" msg:@"邮编必须为数字"];
            return NO;
        }
    }
    
    return YES;
}
- (void)saveChangeAfterUploadPhoto:(BOOL)afterUploadPhoto{
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (afterUploadPhoto) {
        [dict setObject:@"updateuser" forKey:@"action"];
        [dict setObject:APP_DELEGATE.userName forKey:@"username"];
        [dict setObject:self.userInfo.realName forKey:@"realname"];
        [dict setObject:self.userInfo.email forKey:@"email"];
        [dict setObject:self.userInfo.contactNum forKey:@"mobilephone"];
        [dict setObject:self.userInfo.addr forKey:@"address"];
        [dict setObject:self.userInfo.postCode forKey:@"postcode"];
        [dict setObject:self.userInfo.photoServerPath forKey:@"photo"];
    }else{
        if (![self keepAndRuleCommitText]) {
            return;
        }
        [dict setObject:@"updateuser" forKey:@"action"];
        [dict setObject:APP_DELEGATE.userName forKey:@"username"];
        [dict setObject:self.realName forKey:@"realname"];
        [dict setObject:self.email forKey:@"email"];
        [dict setObject:self.contactNum forKey:@"mobilephone"];
        [dict setObject:self.addr forKey:@"address"];
        [dict setObject:self.postCode forKey:@"postcode"];
        [dict setObject:self.userInfo.photoServerPath forKey:@"photo"];
    }
    
    
    
    
    
    
    [[Network sharedNetwork] postBody:dict isResponseJson:NO doShowIndicator:YES callBackWithObj:dict onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        
        if(result == postSucc){
            NSDictionary *userInfoDict = (NSDictionary*)callBackObj;
            
            //将修改后的信息保存到数据库中
            self.userInfo.email = [userInfoDict objectForKey:@"email"];
            self.userInfo.contactNum = [userInfoDict objectForKey:@"mobilephone"];
            self.userInfo.postCode = [userInfoDict objectForKey:@"postcode"];
            self.userInfo.realName = [userInfoDict objectForKey:@"realname"];
            self.userInfo.addr = [userInfoDict objectForKey:@"address"];
            
            
            //更新数据库
            [self.userInfo update];
            
            if (!afterUploadPhoto) {
                //重新加载，显示数据
                [self _loadData];
                //改变当前视图的状态
                [self isWriting];
            }
            [self.view showAlertText:@"保存成功"];
        }else{
            [UIAlertView alertTitle:@"提示信息" msg:@"信息提交至服务器失败,服务器异常！"];
        }
        
        
        
    } onError:^(NSString *errorStr) {
        [UIAlertView alertTitle:@"提示信息" msg:[@"信息提交至服务器失败!" stringByAppendingString:errorStr]];
        
    }];
}



#endif


//- (void)buttonAction:(UIButton *)button
//{
//    if (button.tag == 100) {
//        
//        //弹出相册选取控制器
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//            UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
//            imagePC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//            imagePC.delegate = self;
//            [self presentViewController:imagePC animated:YES completion:nil];
//            
//        }else{
//            [self.view showAlertText:@"当前设备不支持相册功能，无法设置头像"];
//        }
//
//        
////    }else if (button.tag == 101){
////        //违法处理明细响应
////        NSArray *arr = [[DataBase sharedDataBase] selectCarByUserId:APP_DELEGATE.userId];
////        if ([arr count] == 0) {
////            [self.view showAlertText:@"当前未绑定任何车辆，故无法查询违法处理明细信息。"];
////            return;
////        }
////        DealingRecordViewController *dealVC = [[DealingRecordViewController alloc] init];
////        [self.navigationController pushViewController:dealVC animated:YES];
////        
////    }else if (button.tag == 102){
////        //罚款缴纳明细响应
////        PayRecordViewController *payVC = [[PayRecordViewController alloc] init];
////        [self.navigationController pushViewController:payVC animated:YES];
////        
////    }else if (button.tag == 103){
////        //信息中心响应
////        InformationCenterListViewController *informationVC = [[InformationCenterListViewController alloc]init];
////        [self.navigationController pushViewController:informationVC animated:YES];
//        
//    }else if (button.tag == 104){
//
//        //存储用户的个人信息
//        self.realName = _realNameText.text;
//        self.email = _emailText.text;
//        self.contactNum = _contactNumText.text;
//        self.addr = _addrText.text;
//        self.postCode = _postCodeText.text;
//        
//        //保存响应
//        [self saveChangeAfterUploadPhoto:NO];
//    
//    }else if (button.tag == 105){
//       
//        //取消响应
//        [self isWriting];
//        [self _loadData];
//        
//    } else if (button.tag == 106){
//        
//        [self isWriting];
//    }
//}
//


@end
