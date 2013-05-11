//
//  AppDelegate.h
//  AlarmClock
//
//  Created by user on 4/8/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@class SinaWeibo;
@interface AppDelegate : UIResponder <UIApplicationDelegate,AVAudioPlayerDelegate>
{
    SinaWeibo *sinaweibo;
    NSMutableDictionary *pUserPicDic;
    AVAudioPlayer *audioPlayer ;
    AVQueuePlayer *theQueuePlayer;
    UIBackgroundTaskIdentifier bgTask;
    bool isAlarmBegin;
}
@property (readonly, nonatomic) SinaWeibo *sinaweibo;
+(NSString*)getClearContext:(NSString*)string;
-(void)PushAClock:(NSTimeInterval)time;
-(void)InitTheAudioPlayer;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSMutableDictionary *pUserPicDic;
@property (strong, nonatomic) RootViewController *pRootViewCon;
@property (strong, nonatomic)  AVAudioPlayer *audioPlayer ;
@property (nonatomic)UIBackgroundTaskIdentifier bgTask;
@end
