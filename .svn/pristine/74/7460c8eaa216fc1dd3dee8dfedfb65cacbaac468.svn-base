//
//  CYHDSendTopicViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-4.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "CYHDSendTopicViewController.h"

@interface CYHDSendTopicViewController (){
    
    UILabel                 *_navTitleLable;
    UIImageView             *_downImgView;
    
    
}

@end

@implementation CYHDSendTopicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
- (void)printState{
    NSLog(@"state STA = %d",_locateState);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _locateState = YES;
    _selectBSort = [NSMutableString string];
//    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(printState) userInfo:nil repeats:YES];
    CGFloat topBgViewHeight = APP_HEIGHT/2.6;
    UIImageView *topBgView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_X, APP_VIEW_Y, APP_WIDTH, topBgViewHeight)];
    [topBgView setBackgroundColor:[UIColor whiteColor]];
    topBgView.userInteractionEnabled = YES;
    [self.view addSubview:topBgView];
//
    CGFloat space = 20;
    //文字输入框
    UIImageView *tvBgView = [[UIImageView alloc] initWithFrame:CGRectMake(space - 2, space - 2, APP_WIDTH - 2*space + 4, topBgViewHeight - 2*space + 4+5)];
    [tvBgView setImage:[UIImage imageNamed:@"bg_input_textview.png"]];
    tvBgView.userInteractionEnabled = YES;
    [topBgView addSubview:tvBgView];
//
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(space, space, APP_WIDTH - 2*space, topBgViewHeight - 2*space-17)];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.delegate = self;
    [topBgView addSubview:_textView];
//
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(1.5*space, topBgView.bottom + space, 120, 25)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"总可以输入400字";
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];
//
//    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.titleLabel.textColor = [UIColor whiteColor];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:20];
    submitButton.backgroundColor = COLOR_BUTTON_BLUE;
    [submitButton setFrame:CGRectMake(APP_WIDTH - 1.5*space - 120, label.frame.origin.y - 0.3*space, 120, 30)];
    
    
    [submitButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
//
    CGFloat bottomBgViewHeight = APP_HEIGHT - APP_NAV_HEIGHT - topBgViewHeight - 50;
    UIImageView *bottomBgView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_X,  submitButton.bottom + 20, APP_WIDTH, bottomBgViewHeight)];
    [bottomBgView setBackgroundColor:[UIColor whiteColor]];
    bottomBgView.userInteractionEnabled = YES;
    [self.view addSubview:bottomBgView];
//
    _addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_addImageButton setFrame:CGRectMake(space, space, 80, 80)];
    [_addImageButton setFrame:LGRectMake(40, 40, 160, 160)];
    [_addImageButton setImage:[UIImage imageNamed:@"btn_choose_pic.png"] forState:UIControlStateNormal];
    [_addImageButton addTarget:self action:@selector(addImages:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBgView addSubview:_addImageButton];
//
    UILabel *imgLabel = [[UILabel alloc] initWithFrame:CGRectMake(space, _addImageButton.frame.origin.y + _addImageButton.frame.size.height + 0.5*space, 150, 25)];
    imgLabel.backgroundColor = [UIColor clearColor];
    [imgLabel setText:@"最多可上传3张图片"];
    imgLabel.textColor = [UIColor lightGrayColor];
    [bottomBgView addSubview:imgLabel];
//
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
//    tap.delegate = self;
//    [self.view addGestureRecognizer:tap];
//    
    _uploadPhotos = [[NSMutableArray alloc] initWithCapacity:0];
    _uploadedPhotoUrls = [[NSMutableArray alloc] initWithCapacity:0];
    
    _locationView  = [[UIView alloc]initWithFrame:CGRectMake(5+space, topBgView.frame.size.height-37, 100, 17)];
    _locationView.alpha = 1;
    [topBgView addSubview:_locationView];
    _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_locationButton setFrame:CGRectMake(0, 0, 17, 17)];
    [_locationButton setBackgroundImage:[UIImage imageNamed:@"btn_addfuction_yes.png"] forState:UIControlStateNormal];
    [_locationButton setBackgroundImage:[UIImage imageNamed:@"btn_addfuction_no.png"] forState:UIControlStateSelected];
//    [_locationButton addTarget:self action:@selector(locationClicked:) forControlEvents:UIControlEventTouchUpInside];
    _locationButton.selected = YES;
    [_locationView addSubview:_locationButton];
//
    UIImageView *locationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(17, 0, 17, 17)];
    locationImageView.image = [UIImage imageNamed:@"cb_location_add.png"];
    [_locationView addSubview:locationImageView];
    _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(34, 0, 100, 17)];
    _locationLabel.text = @"定位城市";
    _locationLabel.textAlignment = NSTextAlignmentLeft;
    _locationLabel.font = [UIFont systemFontOfSize:13];
    _locationLabel.textColor = COLOR_FONT_NOMAL;
    [_locationView addSubview:_locationLabel];
    
    
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"txt"];
    NSData *resourceData = [NSData dataWithContentsOfFile:resourcePath];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *resourceDict = [parser objectWithData:resourceData];
    
    NSArray *resourceArr = [resourceDict objectForKey:@"pl"];
    _citysDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    _provinceArr= [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *dict in resourceArr) {
        NSString *pname = [dict objectForKey:@"pname"];
        NSArray *citys = [dict objectForKey:@"list"];
        [_provinceArr addObject:pname];
        [_citysDict setObject:citys forKey:pname];
    }

    self.locatedCityString = [[NSString alloc] init];
    [self locationService];
//    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(locationService) userInfo:nil repeats:NO];

}
- (void)viewDidDisappear:(BOOL)animated{
    
    [_navTitleLable removeFromSuperview];
    [_downImgView removeFromSuperview];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    _navTitleLable = [[UILabel alloc]initWithFrame:CGRectMake((APP_WIDTH-100)/2, 0, 100, 44)];
    _navTitleLable.textColor = [UIColor whiteColor];
    _navTitleLable.backgroundColor = [UIColor clearColor];
    _navTitleLable.font = [UIFont fontWithName:@"RTWSYueGoTrial-Regular" size:17];
    _navTitleLable.textAlignment = NSTextAlignmentCenter;
    [self.navigationController.navigationBar addSubview:_navTitleLable];

    if (self.isHu) {
        _navTitleLable.text = [_titleArray objectAtIndex:0];
        _selectBSort = [NSMutableString stringWithString:@"5"];
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.frame = CGRectMake((APP_WIDTH-100)/2, 0, 100, 44);
        [menuBtn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.navigationBar addSubview:menuBtn];
        
        _downImgView = [[UIImageView alloc]initWithFrame:CGRectMake((APP_WIDTH-15)/2, 44-10, 15, 10)];
        _downImgView.image = [UIImage imageNamed:@"arrow_down.png"];
        [self.navigationController.navigationBar addSubview:_downImgView];
    }
    else{
        [self setCustomNavigationTitle:_navTitleStr];
    }
    NSInteger count = [_bsortArray count];
    NSDictionary *menuDict = [[NSDictionary alloc]initWithObjectsAndKeys:_titleArray,@"title", nil];
    
    _addMenuView = [[MenuView alloc]initWithFrame:CGRectMake((APP_WIDTH-100)/2, -30*count, 100, 30*count) titlesAndLogos:menuDict height:@"30"];
    _addMenuView._delegate = self;
    [self.view addSubview:_addMenuView];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}
- (void)menuBtnClicked:(UIButton *)myBtn{
    
    myBtn.selected = !myBtn.selected;
    if (myBtn.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            NSInteger count = [_bsortArray count];
            _addMenuView.frame = CGRectMake((APP_WIDTH-100)/2, APP_VIEW_Y, 100, 30*count);
            
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            NSInteger count = [_bsortArray count];
            _addMenuView.frame = CGRectMake((APP_WIDTH-100)/2, -30*count, 100, 30*count);
            
        }];
        
    }

    
    
}
- (void)menuView:(MenuView*)menuView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
    [UIView animateWithDuration:0.5 animations:^{
        NSInteger count = [_bsortArray count];
        _addMenuView.frame = CGRectMake((APP_WIDTH-100)/2, -30*count, 100, 30*count);
        
    }];

    _selectBSort = [_bsortArray objectAtIndex:indexPath.row];
    
    _navTitleLable.text = [_titleArray objectAtIndex:indexPath.row];
    
}

- (void)uploadImage{
    
    if ([_textView.text length] == 0 || [_textView.text isEqualToString:@"\n"]) {
        [UIAlertView alertTitle:@"" msg:@"博文内容不能为空"];
        return;
    }
    
    if (!_locateState){
        [self.view showAlertText:@"定位中..."];
        return;
    }
    
    if ([_uploadPhotos count] == 0) {
        [self uploadTextWithPicUrl:[NSArray arrayWithObjects:nil, nil]];
        return;
    }
    
    //网络请求上传图片
    NSData *imgData = [_uploadPhotos objectAtIndex:0];
    NSString *str = [imgData base64Encoding];
    NSString *urlString = @"clubs.956122.com";
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:urlString];
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setObject:str forKey:@"byteString"];
    [body setObject:@"addClubs" forKey:@"project"];
    [body setObject:@"jpg" forKey:@"fileType"];
    MKNetworkOperation *op = [en operationWithPath:@"uploadPic.action" params:body httpMethod:@"POST"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *resString = completedOperation.responseString;
        //succ
        if ([resString rangeOfString:@"http://"].location != NSNotFound) {
            //succ
            [_uploadPhotos removeObjectAtIndex:0];
            [_uploadedPhotoUrls addObject:resString];
            
            if ([_uploadPhotos count]) {
                [self uploadImage];
            }else{
                [self uploadTextWithPicUrl:_uploadedPhotoUrls];
            }
            
        }else{
            
            [UIAlertView alertTitle:@"提示信息" msg:@"上传图片失败，服务器异常"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        }
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
       // [UIAlertView alertTitle:@"提示信息" msg:[NSString stringWithFormat:@"上传图片失败，%@", error]];
        [UIAlertView alertTitle:@"提示信息" msg:@"上传图片失败，服务器异常"];
    }];
    
    [en enqueueOperation:op];
    
}
- (void)uploadTextWithPicUrl:(NSArray*)picUrls{
    
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];

    [bodyDict setObject:APP_DELEGATE.userName forKey:@"username"];
//    if ([self.bsort integerValue] > 0 ) {
//        [bodyDict setObject:self.bsort forKey:@"bsort"];
//    }
//    else{
//        [bodyDict setObject:_selectBSort forKey:@"bsort"];
//    }
    [bodyDict setObject:@"1" forKey:@"bsort"];
    [bodyDict setObject:@"0" forKey:@"btype"];//0 原创 1转载
    [bodyDict setObject:_textView.text forKey:@"content"];
    //[bodyDict setObject:@"" forKey:@"blogid"];//被转载博文id
    //[bodyDict setObject:@"" forKey:@"title"];//转载说明
    
    NSString *urls = [[NSString alloc] init];
    for (NSString *url in picUrls) {
        
        if (![urls isEqualToString:@""]) {
            urls = [urls stringByAppendingString:@","];
        }
        urls = [urls stringByAppendingString:url];
    }
    
    [bodyDict setObject:urls forKey:@"imgurl"];
    //[bodyDict setObject:@"" forKey:@"videourl"];
    
    NSString *modelAndCity = @"";
    if (_locationButton.selected && self.locatedCityString) {
        modelAndCity = [[[UIDevice currentDevice].model stringByAppendingString:@"  "] stringByAppendingString:self.locatedCityString];
    }else{
        modelAndCity = [UIDevice currentDevice].model;
    }
    [bodyDict setObject:modelAndCity forKey:@"model"];

    [[ChatNetwork sharedChatNetwork] chatPostBody:bodyDict onUrl:@"addBlog.do" withPostMethod:@"POST" isResponseJson:YES doShowIndicator:YES onView:self.view callBackWithObj:nil onCompletion:^(PostResult result, id requestObj, NSObject *callBackObj) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (result == postSucc) {
            [self.view showAlertText:@"发布博文成功！"];
            [self performSelector:@selector(gobackPage) withObject:nil afterDelay:2.0f];
        }else{
            [self.view showAlertText:[@"发布博文失败！" stringByAppendingString:(NSString*)requestObj]];
        }
        
    } onError:^(NSString *errorStr) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.view showAlertText:[@"发布博文失败！" stringByAppendingString:(NSString*)errorStr]];
        
    }];
    

#if 0
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDict setObject:@"saveEntry" forKey:@"action"];
    [bodyDict setObject:@"android" forKey:@"pageflag"];
    [bodyDict setObject:APP_DELEGATE.userName forKey:@"username"];
    if (!_textView.text) {
        _textView.text = @" ";
    }
    [bodyDict setObject:_textView.text forKey:@"content"];
    [bodyDict setObject:[[NSDate date] string] forKey:@"datedic"];
    [bodyDict setObject:picUrl forKey:@"pics"];
    
    MKNetworkEngine *en = [[MKNetworkEngine alloc] initWithHostName:@"sns.956122.com/manager"];
    MKNetworkOperation *op = [en operationWithPath:@"android.do" params:bodyDict httpMethod:@"POST"];
    //异常1，成功0
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *resStr = completedOperation.responseString;
        if ([resStr integerValue] == 0) {
            //succ
            [UIAlertView alertTitle:@"提示信息" msg:@"发送成功"];
        }else if ([resStr integerValue] == 1){
            //failed
            [UIAlertView alertTitle:@"提示信息" msg:@"发送失败"];
        }else{
            //failed
            [UIAlertView alertTitle:@"提示信息" msg:@"发送失败"];
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        [UIAlertView alertTitle:@"提示信息" msg:@"发送失败"];
        
    }];
    
    [en enqueueOperation:op];
    
#endif
}

- (void)submit:(UIButton*)button{
    
  
    [self uploadImage];
    

}

- (void)addImages:(UIButton*)button{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;

    BOOL valibleLibrary = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    if (valibleLibrary) {
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imgPicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
//        imgPicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];

        [self presentViewController:imgPicker animated:YES completion:^{
            
            
        }];

    }else{
        [self.view showAlertText:@"当前设备系统不支持打开相册功能"];

    }
    
    
    
}

- (void)tap{
    [_textView resignFirstResponder];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }else{
        return YES;
    }
}
- (void)locationService
{
    if ([Helper locationServiceEnable]) {
            [self.locationManager startUpdatingLocation];
            self.locationManager.distanceFilter = kCLDistanceFilterNone;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
            self.locationManager.delegate = self;
            _locateState = NO;
    }
    else{
        [UIAlertView alertTitle:@"定位服务" msg:@"请在设置-隐私-定位服务中开启定位服务"];
        _locationLabel.text = @"定位失败";
    }
}

#pragma mark-定位相关
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    _locationLabel.text = @"定位中...";
    CLLocation *loc = [locations firstObject];
    NSString *longitudeStr = [NSString stringWithFormat:@"%f",loc.coordinate.longitude];
    NSString *latitudeStr = [NSString stringWithFormat:@"%f",loc.coordinate.latitude];
    [self reverseGeocodeWithLatitude:latitudeStr Longtitude:longitudeStr];
    [self.locationManager stopUpdatingLocation];

}

- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error {
    _locationLabel.text = @"定位失败";
    NSString *errorString;
    [manager stopUpdatingLocation];
//    NSLog(@"Error: %@",[error localizedDescription]);
    switch([error code]) {
        case kCLErrorDenied:
            //Access denied by user
            errorString = @"请在设置-隐私-定位服务中开启<开车邦>定位服务";
            //Do something...
            break;
        case kCLErrorLocationUnknown:
            //Probably temporary...
            errorString = @"位置数据不可用";
            //Do something else...
            break;
        default:
            errorString = @"发生一个未知的错误";
            break;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位服务" message:errorString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    _locateState = YES;

}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }
            break;
            
        default:
            break;
    }
    
    
}

#pragma mark-  按钮操作
- (void)locationClicked:(UIButton *)myBtn{
    if (!myBtn.selected) {
        [self locationService];
    }
    else{
        [self.locationManager stopUpdatingLocation];
        _locationLabel.text = @"定位城市";
    }
    myBtn.selected = !myBtn.selected;
    [self printState];
}

- (CLGeocoder *)geocoder
{
    if (_geocoder==nil) {
        _geocoder=[[CLGeocoder alloc]init];
    }
    return _geocoder;
}
- (CLLocationManager *)locationManager{
    if (_locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
    }
    return _locationManager;
}
- (void)reverseGeocodeWithLatitude:(NSString *)latitudeStr Longtitude:(NSString *)longtitudeStr {
    if ([longtitudeStr integerValue]==0||[latitudeStr integerValue]==0){
        _locateState = YES;
        [self.view showAlertText:@"定位超时,请重新定位"];
        _locationLabel.text = @"定位失败";
        return;
    };
    
    CLLocationDegrees latitude=[latitudeStr doubleValue];
    CLLocationDegrees longitude=[longtitudeStr doubleValue];
    
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error||placemarks.count==0) {
            [self.view showAlertText:@"获取城市名称失败,请检查网络"];
            _locationLabel.text = @"定位失败";
        }
        else//编码成功
        {
            //显示最前面的地标信息
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            NSMutableString *cityMStr = [NSMutableString string];
            if ([firstPlacemark.locality length] > 0 ) {
                cityMStr = [NSMutableString stringWithString:firstPlacemark.locality];
            }
            else{
                cityMStr = [NSMutableString stringWithString:firstPlacemark.administrativeArea];

            }
            _locationLabel.text = cityMStr;
            self.locatedCityString = cityMStr;
            }
    }];
    _locateState = YES;
}



#pragma mark-  picker delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:APP_DELEGATE.window.bounds];
    hud.mode = MBProgressHUDModeIndeterminate;
    [APP_DELEGATE.window addSubview:hud];
    
    [hud showAnimated:YES whileExecutingBlock:^{
        
        UIImage *originImg = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        NSData *imgData = UIImageJPEGRepresentation(originImg, 1);
        
        CGFloat lengthFor1M = 4302692/2.2;//1M 的长度
        CGFloat per = lengthFor1M/imgData.length;
        if (per < 1) {
            imgData = UIImageJPEGRepresentation(originImg, per);
        }
        //UI添加图片
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:_addImageButton.frame];
        [UIHelper createThumbImage:[UIImage imageWithData:imgData] size:CGSizeMake(imgView.width, imgView.height) percent:1 onCompletion:^(NSData *imgData) {
            [imgView setImage:[UIImage imageWithData:imgData]];
            
        }];
        [_addImageButton.superview addSubview:imgView];
        [_addImageButton setFrame:CGRectMake(imgView.right + 20, _addImageButton.origin.y, _addImageButton.width, _addImageButton.height)];
        //数据添加图片
        [_uploadPhotos addObject:imgData];
        
    } onQueue:dispatch_get_main_queue() completionBlock:^{
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    
    
    //[self handleImg:originImg];

    
}

- (void)handleImg:(UIImage*)originImg{
    
    
    
}

#pragma mark-  textview delegate

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        NSString *str = [textView.text substringFromIndex:textView.text.length - 1];
        if ([str isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
        }
    }
    
    if (textView.text.length > 400 && textView.markedTextRange == nil)
    {
        textView.text = [textView.text substringToIndex:400];

    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    [UIView animateWithDuration:0.5 animations:^{
        NSInteger count = [_bsortArray count];
        _addMenuView.frame = CGRectMake((APP_WIDTH-100)/2, -30*count, 100, 30*count);
        
    }];

    return YES;
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
