//
//  AppDelegate.h
//  AlarmClock
//
//  Created by user on 4/8/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
@class SinaWeibo;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    SinaWeibo *sinaweibo;
    NSMutableDictionary *pUserPicDic;
    AVAudioPlayer *audioPlayer ;
    UIBackgroundTaskIdentifier bgTask;
    bool inBackground;
}
@property (readonly, nonatomic) SinaWeibo *sinaweibo;
+(NSString*)getClearContext:(NSString*)string;
-(void)PushAClock:(id)info;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSMutableDictionary *pUserPicDic;
@property (strong, nonatomic) RootViewController *pRootViewCon;
@property (strong, nonatomic)  AVAudioPlayer *audioPlayer ;
@property (nonatomic)UIBackgroundTaskIdentifier bgTask;
@end
