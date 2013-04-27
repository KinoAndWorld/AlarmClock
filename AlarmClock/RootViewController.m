//
//  RootViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 2/20/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"
#import "ContentViewController.h"
#import "FriendCotentViewCon.h"
#import "AppDelegate.h"
#include "Config.h"
#include "EMAsyncImageView.h"
#import "SoundView.h"
#import "lame.h"
@implementation RootViewController

@synthesize userInfo,tencentOAuthUserInfo;

@synthesize player,Text,titleText1,titleText2,titleText3,titleBack;
@synthesize recordedFile,recorderButton,YESButton,NOButton;
-(IBAction)LogOUt:(id)sender
{
    [_tencentOAuth logout:self];
    [((RootViewController*)[UIApplication sharedApplication].delegate).sinaweibo logOut];
    [pPublicContentViewController.tableView reloadData];
}
-(IBAction)ChickPublic:(id)sender
{
    pPublicContentViewController.view.hidden = NO;
    pFriendContentViewController.view.hidden = YES;
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.05];
	[UIView setAnimationDelegate:self];
    titleBack.frame = CGRectMake( 60,  titleBack.frame.origin.y, titleBack.frame.size.width ,  titleBack.frame.size.height);
	[UIView commitAnimations];
   
}
-(IBAction)ChickFriend:(id)sender
{
    pPublicContentViewController.view.hidden = YES;
     pFriendContentViewController.view.hidden = NO;
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.05];
	[UIView setAnimationDelegate:self];
    titleBack.frame = CGRectMake( 127,  titleBack.frame.origin.y, titleBack.frame.size.width ,  titleBack.frame.size.height);
	[UIView commitAnimations];
 
}
-(IBAction)ChickPrivate:(id)sender
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.05];
	[UIView setAnimationDelegate:self];
    titleBack.frame = CGRectMake( 200,  titleBack.frame.origin.y, titleBack.frame.size.width ,  titleBack.frame.size.height);
	[UIView commitAnimations];
}
+(void)SetUserInfoData:(NSString*)ID name:(NSString*) name faceImg:(NSString*) faceImg typeString:(NSString*) typeString status:(NSString*)status
{
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              ID, @"id",
                              name, @"name",
                               faceImg, @"faceImg",
                              typeString, @"typeString",
                              status , @"status", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:UserInfoData];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSDictionary *)getUserData
{
   return [[NSUserDefaults standardUserDefaults] objectForKey:UserInfoData];
    
}
- (void)removeUserData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserInfoData];
    [EMAsyncImageView RemoveAllImage];
}
-(void)RefrshDataWithUserInfoType :(NSString*) userType
{
    [pPublicContentViewController RefrshDataWithUserInfoType:userType];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:UserInfoData]);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = true;
    
    pPublicContentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    [self.view addSubview:pPublicContentViewController.view];
    [self.view sendSubviewToBack:pPublicContentViewController.view];
    [pPublicContentViewController.view setFrame:CGRectMake(0, 44, pPublicContentViewController.view.frame.size.width, pPublicContentViewController.view.frame.size.height)];
    
    pFriendContentViewController = [[FriendCotentViewCon alloc] initWithNibName:@"ContentViewController" bundle:nil];
    [self.view addSubview:pFriendContentViewController.view];
    [self.view sendSubviewToBack:pFriendContentViewController.view];
    [pFriendContentViewController.view setFrame:CGRectMake(0, 44, pFriendContentViewController.view.frame.size.width, pFriendContentViewController.view.frame.size.height)];
    
    
    NSString *appid = @"222222";
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:appid
											andDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *tencentweiboInfo = [defaults objectForKey:@"TencentWeiboAuthData"];
    if ([tencentweiboInfo objectForKey:@"AccessTokenKey"] && [tencentweiboInfo objectForKey:@"ExpirationDateKey"])
    {
        _tencentOAuth.accessToken = [tencentweiboInfo objectForKey:@"AccessTokenKey"];
        _tencentOAuth.expirationDate = [tencentweiboInfo objectForKey:@"ExpirationDateKey"];
        _tencentOAuth.openId= [tencentweiboInfo objectForKey:@"openId"];
        _tencentOAuth.redirectURI = [tencentweiboInfo objectForKey:@"redirectURI"];
       // sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    
    _permissions = [[NSArray arrayWithObjects:
                     kOPEN_PERMISSION_GET_USER_INFO,
                     kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                     kOPEN_PERMISSION_ADD_ALBUM,
                     kOPEN_PERMISSION_ADD_IDOL,
                     kOPEN_PERMISSION_ADD_ONE_BLOG,
                     kOPEN_PERMISSION_ADD_PIC_T,
                     kOPEN_PERMISSION_ADD_SHARE,
                     kOPEN_PERMISSION_ADD_TOPIC,
                     kOPEN_PERMISSION_CHECK_PAGE_FANS,
                     kOPEN_PERMISSION_DEL_IDOL,
                     kOPEN_PERMISSION_DEL_T,
                     kOPEN_PERMISSION_GET_FANSLIST,
                     kOPEN_PERMISSION_GET_IDOLLIST,
                     kOPEN_PERMISSION_GET_INFO,
                     kOPEN_PERMISSION_GET_OTHER_INFO,
                     kOPEN_PERMISSION_GET_REPOST_LIST,
                     kOPEN_PERMISSION_LIST_ALBUM,
                     kOPEN_PERMISSION_UPLOAD_PIC,
                     kOPEN_PERMISSION_GET_VIP_INFO,
                     kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                     kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                     kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                     nil] retain];
    
    //========audio
    
    [recorderButton addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    [recorderButton addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
    [recorderButton addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpOutside];
    [YESButton addTarget:self action:@selector(UploadAudio) forControlEvents:UIControlEventTouchUpInside];
    [NOButton addTarget:self action:@selector(CancleUploadAudio:) forControlEvents:UIControlEventTouchUpInside];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.caf"];
    NSLog(@"%@",path);
    self.recordedFile = [[[NSURL alloc] initFileURLWithPath:path] autorelease];
    NSLog(@"%@",recordedFile);
    
    YESButton.hidden = YES;
    NOButton.hidden = YES;
    recorderButton.hidden = NO;
    
    CGAffineTransform at = CGAffineTransformMakeRotation(24*M_PI/180.0);
    [Text setTransform:at];
    
    CALayer *contentLayer = [Text layer];
    contentLayer.anchorPoint = CGPointMake(0.5,0.5);
}


#pragma mark -
#pragma mark Rotation

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
#pragma mark - SinaWeibo Action

- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}

- (void)removeAuthData
{
    [userInfo release];userInfo = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)storeAuthData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)getSinaUserInfo
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo requestWithURL:@"users/show.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
}
#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [self storeAuthData];
    [self getSinaUserInfo];
    
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
    [self removeUserData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

//清除过期缓存
- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self removeAuthData];
}

#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [userInfo release], userInfo = nil;
         
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        [statuses release], statuses = nil;
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" failed!", postStatusText]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        NSLog(@"Post status failed with error : %@", error);
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" failed!", postImageStatusText]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        NSLog(@"Post image status failed with error : %@", error);
    }
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [userInfo release];
        userInfo = [result retain];
        NSLog(@"userInfo : %@", userInfo);
        [RootViewController SetUserInfoData:[userInfo objectForKey:@"id"] name:[userInfo objectForKey:@"screen_name"] faceImg:[userInfo objectForKey:@"avatar_large"] typeString:@"SINA" status:logInTag];
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        [statuses release];
        statuses = [[result objectForKey:@"statuses"] retain];
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        [postStatusText release], postStatusText = nil;
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        [postImageStatusText release], postImageStatusText = nil;
    }
}
#pragma mark - tencent Delegate

- (TencentOAuth *)tencentweibo
{
    return _tencentOAuth;
}

- (void)TencentLogin {
    if (![_tencentOAuth isSessionValid]) {
        [_tencentOAuth authorize:_permissions inSafari:NO];
    }
    else{
        [self tencentDidLogin];
    }

}

- (void)removeTencentAuthData
{
    [tencentOAuthUserInfo release];tencentOAuthUserInfo = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TencentWeiboAuthData"];
}

- (void)storeTencentAuthData
{	
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              _tencentOAuth.accessToken, @"AccessTokenKey",
                              _tencentOAuth.expirationDate, @"ExpirationDateKey",
                              _tencentOAuth.openId ,@"openId",
                              _tencentOAuth.redirectURI ,@"redirectURI",
                               nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"TencentWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 * Called when the user successfully logged in.
 */
- (void)tencentDidLogin {

    if (_tencentOAuth.accessToken
        && 0 != [_tencentOAuth.accessToken length])
    {
    }
    else
    {
    }
    [self storeTencentAuthData];
    [self onClickGetUserInfo];
    //[self SetUserInfoData:_tencentOAuth.userID typeString:@"QQ" status:1];
}

- (void)onClickGetUserInfo {
	if(![_tencentOAuth getUserInfo]){
        [self showInvalidTokenOrOpenIDMessage];
    }
}
- (void)showInvalidTokenOrOpenIDMessage{
    [self removeTencentAuthData];
    UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"可能授权已过期，请重新获取" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
    [alert show];
}
/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{

	
}

/**
 * Called when the notNewWork.
 */
-(void)tencentDidNotNetWork
{
	
}

/**
 * Called when the logout.
 */
-(void)tencentDidLogout
{
    [self removeTencentAuthData];
    [self removeUserData];
}
/**
 * Called when the get_user_info has response.
 */
- (void)getUserInfoResponse:(APIResponse*) response {
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		tencentOAuthUserInfo=response.jsonResponse;
        [tencentOAuthUserInfo retain];
        NSLog(@"tencentOAuthUserInfo:%@",tencentOAuthUserInfo);
        NSString *pID = [_tencentOAuth.openId substringWithRange:NSMakeRange(1, 10)];
        [RootViewController SetUserInfoData:pID name:[tencentOAuthUserInfo objectForKey:@"nickname"] faceImg:[tencentOAuthUserInfo objectForKey:@"figureurl_2"] typeString:@"TENCENT" status:logInTag];
	}
	else
    {
        tencentOAuthUserInfo = nil;
	}
}

#pragma mark - AUDIO

- (void)audio_PCMtoMP3
{
    NSAutoreleasePool *pool =[[NSAutoreleasePool alloc] init];
    NSString *cafFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.caf"];
    
    NSString *mp3FilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.mp3"];
    
    
    
    NSFileManager* fileManager=[NSFileManager defaultManager];
    if([fileManager removeItemAtPath:mp3FilePath error:nil])
    {
        NSLog(@"删除");
    }
    
    @try {
        int read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        
    }
    [self performSelectorOnMainThread:@selector(Tomp3Over) withObject:nil waitUntilDone:NO];
    [pool release];
}
-(void)Tomp3Over
{
    
}
-(void)touchDown
{
    NSLog(@"==%@==",recordedFile);
    Text.text = @"松开完成";
    session = [AVAudioSession sharedInstance];
    session.delegate = self;
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];
    /*
     NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
     [NSNumber numberWithFloat:44100.0], AVSampleRateKey,
     [NSNumber numberWithInt:kAudioFormatMPEG4AAC], AVFormatIDKey,
     [NSNumber numberWithInt:2], AVNumberOfChannelsKey,
     nil];
     */
    //录音设置
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    //录音格式 无法使用
    [settings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //采样率
    [settings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];//44100.0
    //通道数
    [settings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
    //线性采样位数
    //[recordSettings setValue :[NSNumber numberWithInt:16] forKey: AVLinearPCMBitDepthKey];
    //音频质量,采样质量
    [settings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    
    
    recorder = [[AVAudioRecorder alloc] initWithURL:recordedFile settings:settings error:nil];
    [recorder prepareToRecord];
    [recorder record];
    [settings release];
}
-(void)touchUp
{
    YESButton.hidden = NO;
    NOButton.hidden = NO;
    recorderButton.hidden = YES;
    
    Text.text = @"是否上传";
    [recorder stop];
    [NSThread detachNewThreadSelector:@selector(audio_PCMtoMP3) toTarget:self withObject:nil];
    if(recorder)
    {
        [recorder release];
        recorder = nil;
    }
    NSString *cafFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.caf"];
    
    NSError *playerError;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[[[NSURL alloc] initFileURLWithPath:cafFilePath] autorelease] error:&playerError];
    self.player = audioPlayer;
    player.volume = 100.0f;
    if (player == nil)
    {
        NSLog(@"ERror creating player: %@", [playerError description]);
    }
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategorySoloAmbient error: nil];
    player.delegate = self;
    [audioPlayer release];
    [player play];
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
}
-(void)UploadAudio
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:UserInfoData] && [[[NSUserDefaults standardUserDefaults] objectForKey:UserInfoData] objectForKey:@"id"]) {
        Text.text = @"上传中";
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:S_URL]];
        [request setDelegate:self];
        [request setUsername:@"uploadUserAudio"];
        [request setPostValue:@"uploadUserAudio" forKey:@"action"];
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.mp3"];
        NSString *name = [NSString stringWithFormat:@"%@.mp3",[[[NSUserDefaults standardUserDefaults] objectForKey:UserInfoData] objectForKey:@"id"]];
        [request setFile:path withFileName:name andContentType:@"mp3" forKey:@"userAudio"];
        [request startAsynchronous];
    }
    else{
        Text.text = @"请登陆";
    
    }
}
-(void)CancleUploadAudio:(id)sender
{
    Text.text = @"按下录音";
    YESButton.hidden = YES;
    NOButton.hidden = YES;
    recorderButton.hidden = NO;
}

#pragma mark - NETWORK Delegate
- (void) requestFinished:(ASIHTTPRequest *)request {
    
    NSString *pString = [NSString stringWithString:[request responseString]];
    NSLog(@"Response finish:%@",pString);
    pString = [AppDelegate getClearContext:pString];
    NSDictionary *pContent = [pString objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    if ([request.username isEqualToString:@"uploadUserAudio"]) {
        Text.text = @"上传成功";
        YESButton.hidden = YES;
        NOButton.hidden = YES;
        recorderButton.hidden = NO;
        [[NSTimer scheduledTimerWithTimeInterval:2
                                          target:self   selector:@selector(CancleUploadAudio:)
                                                      userInfo:nil repeats:NO]                              retain];
    }

}
- (void) requestFailed:(ASIHTTPRequest *)request {
    //NSString *responseString = [request responseString];
    NSLog(@"Response Fail %d : %@", request.responseStatusCode, [request responseString]);
}

@end
