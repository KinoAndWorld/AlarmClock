//
//  RootViewController.h
//  REMenuExample
//
//  Created by Roman Efimov on 2/20/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <AVFoundation/AVFoundation.h>
@class ContentViewController;
@class FriendCotentViewCon;
@class AlarmClockViewCon;
@interface RootViewController : UIViewController<SinaWeiboDelegate, SinaWeiboRequestDelegate,TencentSessionDelegate,AVAudioPlayerDelegate,AVAudioSessionDelegate,AVAudioRecorderDelegate>
{
    NSDictionary *userInfo;
    NSArray *statuses;
    NSString *postStatusText;
    NSString *postImageStatusText;
    TencentOAuth* _tencentOAuth;
   	NSMutableArray* _permissions;
    NSDictionary *tencentOAuthUserInfo;
    ContentViewController *pPublicContentViewController;
    FriendCotentViewCon *pFriendContentViewController;
    
    AVAudioSession *session;
    
    NSURL *recordedFile;
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
}
@property (readonly, nonatomic) NSDictionary *userInfo;
@property (readonly, nonatomic) ContentViewController *pPublicContentViewController;
@property (readonly, nonatomic) FriendCotentViewCon *pFriendContentViewController;
@property (readonly, nonatomic) NSDictionary *tencentOAuthUserInfo;

@property (nonatomic , retain) AVAudioPlayer *player;
@property (nonatomic , retain) NSURL *recordedFile;
@property (nonatomic , retain) IBOutlet UIButton *recorderButton;
@property (nonatomic , retain) IBOutlet UILabel *LeftText,*Text,*titleText1,*titleText2,*titleText3;
@property (nonatomic , retain) IBOutlet UIButton *YESButton,*NOButton;
@property (nonatomic , retain) IBOutlet UIImageView *titleBack;
- (SinaWeibo *)sinaweibo;
- (TencentOAuth *)tencentweibo;
- (void)TencentLogin;
-(void)RefrshDataWithUserInfoType :(NSString*) userType;
+(void)SetUserInfoData:(NSString*)ID name:(NSString*) name faceImg:(NSString*) faceImg typeString:(NSString*) typeString status:(NSString*)status;
+ (NSDictionary *)getUserData;
+(bool)ChickIsLogIn;
+(void)ReloadAllData;
-(void)UpdataClockText;
-(void)ChickWhichViewIsappear;
@end
