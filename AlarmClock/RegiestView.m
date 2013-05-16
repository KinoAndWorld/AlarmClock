//
//  RegiestView.m
//  AlarmClock
//
//  Created by user on 4/16/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "RegiestView.h"
#import "Config.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#include "AppDelegate.h"
@interface RegiestView ()

@end

@implementation RegiestView

@synthesize ScrollView ,UserName,PassWorld,Email,NikeName,PhoneNum,image_UserNameIcon,image_Password,UserNameIndicaor,pErrorView,userImgButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    userImg = @"NULL";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage*img =[UIImage imageNamed:@"color5.png"];
    [ScrollView setBackgroundColor:[UIColor colorWithPatternImage:img]];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ErrorView" owner:self options:nil];
    pErrorView = [nib objectAtIndex:0];
    [self.view insertSubview:pErrorView atIndex:1];
   
    
//    if (iPhone5) {
//        ScrollView.frame = CGRectMake(30, 200,  ScrollView.frame.size.width,  ScrollView.frame.size.height);
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 -(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint point = CGPointMake(0,0);
    if (textField.frame.origin.y  > 200 &&  ScrollView.frame.size.height > 250) {
        point = CGPointMake(0,textField.frame.origin.y - 150);
        ScrollView.contentOffset = point;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.01];
    [UIView setAnimationDelay:0.2];
    if (iPhone5) {
        [ScrollView setFrame:CGRectMake(ScrollView.frame.origin.x, ScrollView.frame.origin.y, ScrollView.frame.size.width, 300)];
    }
    else
    [ScrollView setFrame:CGRectMake(ScrollView.frame.origin.x, ScrollView.frame.origin.y, ScrollView.frame.size.width, 200)];
    [UIView commitAnimations];
    
    if (textField == UserName) {
         [image_UserNameIcon setImage:[UIImage imageNamed:@"ui_regiestUeserNameIcon_gray.png"]];
    }
    if (textField == PassWorld) {
        [PassWorld setSecureTextEntry:NO];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == UserName && textField.text.length > 0) {
        [self ChickUserNameIsOK];
    }
    else if (textField == PassWorld  && textField.text.length > 0) {
         [PassWorld setSecureTextEntry:YES];
        if (![self ChickPasswordIsOK]) 
            [image_Password setImage:[UIImage imageNamed:@"ui_regiestPassWordIcon_red.png"]];
        else
            [image_Password setImage:[UIImage imageNamed:@"ui_regiestPassWordIcon_gray.png"]];
    }
    else if (textField == Email && textField.text.length > 0) {
        if (![self ChickEmailIsOK]) {
            [pErrorView PlayAnimation:@"请输入正确的邮箱"];
        }
    }
}

-(IBAction)Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)Done:(id)sender
{
    [self Regiest];
}
-(IBAction)UseSinaWeibo:(id)sender
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (userImgButton.tag != -1 && delegate.pRootViewCon.userInfo && [delegate.pRootViewCon.userInfo objectForKey:@"avatar_large"]) {
        userPic = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[delegate.pRootViewCon.userInfo objectForKey:@"avatar_large"]]]];
        [userImgButton setImage:userPic forState:UIControlStateNormal];
        userImg = @"SINA";
    }
    else{
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(waitForSinaWeiboRequest:) userInfo:nil repeats:YES];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [[delegate.pRootViewCon sinaweibo] logIn];
    }
}
-(IBAction)UseTencentWeibo:(id)sender
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (userImgButton.tag != -1 && delegate.pRootViewCon.tencentOAuthUserInfo && [delegate.pRootViewCon.tencentOAuthUserInfo objectForKey:@"figureurl_2"]) {
        userPic = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[delegate.pRootViewCon.tencentOAuthUserInfo objectForKey:@"figureurl_2"]]]];
        [userImgButton setImage:userPic forState:UIControlStateNormal];
        userImg = @"TENCENT";
    }
    else{
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(waitForSinaWeiboRequest:) userInfo:nil repeats:YES];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.pRootViewCon TencentLogin];
    }
}
-(IBAction)UseRenren:(id)sender
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (userImgButton.tag != -1 && delegate.pRootViewCon.tencentOAuthUserInfo && [delegate.pRootViewCon.tencentOAuthUserInfo objectForKey:@"figureurl_2"]) {
        userPic = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[delegate.pRootViewCon.tencentOAuthUserInfo objectForKey:@"figureurl_2"]]]];
        [userImgButton setImage:userPic forState:UIControlStateNormal];
        userImg = @"RENREN";
    }
    else{
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(waitForSinaWeiboRequest:) userInfo:nil repeats:YES];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [[delegate.pRootViewCon sinaweibo] logIn];
    }
}
-(IBAction)ChoosePic:(id)sender
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  
                                  initWithTitle:@"更换头像?"
                                  
                                  delegate:self       
                                  
                                  cancelButtonTitle:@"取消"
                                  
                                  destructiveButtonTitle:nil
                                  
                                  otherButtonTitles:@"从 新浪微博 导入",@"从 腾讯微博 导入",@"从 人人网 导入",@"拍照",@"从相册选择" ,nil]; 
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
    
    [actionSheet release];   
}
-(IBAction)LogOut:(id)sender
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [[delegate.pRootViewCon sinaweibo] logOut];
}

//wait for sina weibo
-(void)waitForSinaWeiboRequest:(NSTimer *)timer
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (delegate.pRootViewCon.userInfo) {
        [timer invalidate];
        [self UseSinaWeibo:nil];
    }
    if (delegate.pRootViewCon.tencentOAuthUserInfo) {
        [timer invalidate];
        [self UseTencentWeibo:nil];
    }
}
-(bool)ChickPasswordIsOK
{
    if (PassWorld.text.length >= 6) {
        return YES;
    }
    [pErrorView PlayAnimation:@"密码不能少于6位"];
    return NO;
}
-(bool)ChickEmailIsOK
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:Email.text];
}
-(void)regiestDone
{
    [RootViewController SetUserInfoData:UserName.text name:NikeName.text faceImg:[NSString stringWithFormat:@"%@/userPic/%@.png",IMAGE_URL,UserName.text] typeString:@"FREE" status:logInTag];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
     [delegate.pRootViewCon RefrshDataWithUserInfoType:nil];
    [RootViewController   ReloadAllData];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma NETWORK

-(void)ChickUserNameIsOK
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:S_URL]];
    [request setDelegate:self];
    [request setUsername:@"chickUserName"];
    [request setPostValue:@"chickUserName" forKey:@"action"];
    
    [request setPostValue:UserName.text forKey:@"name"];
    [request startAsynchronous];
    [UserNameIndicaor    startAnimating];
}
-(void)ChickUserNameIsOKResult:(int)isOK
{
    [UserNameIndicaor    stopAnimating];
    if (isOK == 1) {
        [image_UserNameIcon setImage:[UIImage imageNamed:@"ui_regiestUeserNameIcon_green.png"]];
    }
    else {
        [image_UserNameIcon setImage:[UIImage imageNamed:@"ui_regiestUeserNameIcon_red.png"]];
        [pErrorView PlayAnimation:[NSString stringWithFormat:@"用户名 %@ 不可用",UserName.text]];
    }
}

-(void)Regiest
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:S_URL]];
    [request setDelegate:self];
    [request setUsername:@"regiest"];
    [request setPostValue:@"regiest" forKey:@"action"];
    
    [request setPostValue:UserName.text forKey:@"name"];
    [request setPostValue:PassWorld.text forKey:@"pw"];
    [request setPostValue:NikeName.text forKey:@"nikeName"];
    [request setPostValue:Email.text forKey:@"email"];
    [request setPostValue:PhoneNum.text forKey:@"phoneNum"];
    [request setPostValue:userImg forKey:@"userImg"];
    [request startAsynchronous];
    
    if ([userImg isEqualToString:@"FREE"] && userImgButton.imageView.image != nil) {
        NSString *path = [self getPicPath];
        [UIImagePNGRepresentation(userImgButton.imageView.image) writeToFile:path atomically:YES];
        [self UploadUserPic];
    }

}
-(void)UploadUserPic
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:S_URL]];
    [request setDelegate:self];
    [request setUsername:@"UploadPic"];
    [request setPostValue:@"uploadUserPic" forKey:@"action"];
    NSString *path = [self getPicPath];
    NSString* picName = [NSString stringWithFormat:@"%@.png",UserName.text];
    [request setFile:path withFileName:picName andContentType:@"image/png" forKey:@"userPic"];
    [request startAsynchronous];
}
-(NSString *)getPicPath
{
    return [NSString stringWithFormat:@"%@/Documents/%@.png", NSHomeDirectory(), UserName.text];
}
#pragma mark - NETWORK Delegate
- (void) requestFinished:(ASIHTTPRequest *)request {
    
    NSString *pString = [NSString stringWithString:[request responseString]];
    NSLog(@"Response finish:%@",pString);
    pString = [AppDelegate getClearContext:pString];
    NSDictionary *pContent = [pString objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    if ([request.username isEqualToString:@"chickUserName"]) {
        [self ChickUserNameIsOKResult:[[pContent objectForKey:@"result"] intValue]];return;
    }
    else if ([request.username isEqualToString:@"regiest"]) {
        if (![[pContent objectForKey:@"result"] intValue]) {
            [pErrorView PlayAnimation:[pContent objectForKey:@"info"]];
        }
        else{
            if ([[pContent objectForKey:@"userInfo"] isKindOfClass:[NSDictionary class]]) {
                [[NSUserDefaults standardUserDefaults] setObject:[[pContent objectForKey:@"userInfo"] objectForKey:@"ID"] forKey:@"userID"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }
            [self regiestDone];
        }
    }
}
- (void) requestFailed:(ASIHTTPRequest *)request {
    //NSString *responseString = [request responseString];
    NSLog(@"Response Fail %d : %@", request.responseStatusCode, [request responseString]);
    
    [pErrorView PlayAnimation:[NSString stringWithFormat:@"请检查网络"]];
    [UserNameIndicaor stopAnimating];
}



#pragma mark - UIActionSheetDelegate Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet

didDismissWithButtonIndex:(NSInteger)buttonIndex

{
    if( buttonIndex != [actionSheet cancelButtonIndex]){
        if (buttonIndex == 0) {
            [self UseSinaWeibo:nil];return;
        }
        else if (buttonIndex == 1) {
            [self UseTencentWeibo:nil];return;
        }
        else if (buttonIndex == 2) {
            [self UseRenren:nil];return;
        }
        else{
        NSUInteger sourceType = 0;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 3:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 4:
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 5:
                    return;
            }
        } else {
            if (buttonIndex == 4) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
      
        [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    }
    
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:nil];
	userPic = [RegiestView OriginImage:[info objectForKey:UIImagePickerControllerEditedImage] scaleToSize:CGSizeMake(70, 70)] ;
    
	[self.userImgButton setImage:userPic forState:UIControlStateNormal];
    userImg = @"FREE";
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissViewControllerAnimated:YES completion:nil];
}


+ (UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    CGSize newSize;
    if (image.size.height / image.size.width > 1){
        newSize.height = size.height;
        newSize.width = size.height / image.size.height * image.size.width;
    } else if (image.size.height / image.size.width < 1){
        newSize.height = size.width / image.size.width * image.size.height;
        newSize.width = size.width;
    } else {
        newSize = size;
    }
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}
@end
