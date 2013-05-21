//
//  AppDelegate.m
//  AlarmClock
//
//  Created by user on 4/8/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "AppDelegate.h"
#import "SinaWeibo.h"
#include "Config.h"
#include "EMAsyncImageView.h"
#include "ClockManager.h"
#include "ContentViewController.h"

@implementation AppDelegate
@synthesize sinaweibo,bgTask;
@synthesize pRootViewCon,pUserPicDic;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    pRootViewCon = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:pRootViewCon];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:pRootViewCon];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    
    pUserPicDic = [[NSMutableDictionary alloc] initWithCapacity:20];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(volumeChanged:)
                                                 name:@"AVSystemController_SystemVolumeDidChangeNotification"
                                               object:nil];
    
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(-100, 0, 10, 0)];
    [volumeView sizeToFit];
    [self.window addSubview:volumeView];
    
    //silence-10sec
   NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: @"silence-10sec" ofType: @"mp3"];
    NSError  *error;
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[[[NSURL alloc]initFileURLWithPath:soundFilePath] autorelease] error:&error];
    if (!audioPlayer) {
    NSLog(@"error:%@ ",error);
    }
    [audioPlayer prepareToPlay];
    audioPlayer.numberOfLoops = -1;
    audioPlayer.volume = 1;
    
    [audioPlayer play];


    isAlarmBegin = NO;
    
    

    theQueuePlayer = [[AVQueuePlayer alloc] initWithItems:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];
    
    AVPlayerLayer *layer = [AVPlayerLayer  playerLayerWithPlayer:theQueuePlayer];
    theQueuePlayer.actionAtItemEnd = AVPlayerItemStatusReadyToPlay;
    layer.frame = CGRectMake(0, 0, 1024, 768);
    
    [self.window.layer addSublayer:layer];
    
    
    return YES;
}
# pragma mark -
# pragma mark AVAudioSession Delegate Methods
- (void)beginInterruption {
    NSLog(@"beginInterruption");
   
}
- (void)endInterruption {
     NSLog(@"endInterruption");

}
- (void)endInterruptionWithFlags:(NSUInteger)flags {
      NSLog(@"endInterruptionWithFlags");
      [audioPlayer play];
}
- (void)inputIsAvailableChanged:(BOOL)isInputAvailable {
      NSLog(@"inputIsAvailableChanged");
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag

{

}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error

{

}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
-(void)playerItemDidReachEnd:(NSNotification*)sender
{
     NSLog(@"next");
    if (sender.object == [[theQueuePlayer items] lastObject]) {
        NSLog(@"play last");
         AVPlayerItem *newItem = [AVPlayerItem playerItemWithAsset:[(AVPlayerItem*)sender.object asset]];
        [theQueuePlayer insertItem:newItem afterItem:sender.object];
    }
   
    [theQueuePlayer advanceToNextItem];
    [theQueuePlayer play];
    
   
   
}
- (void)volumeChanged:(NSNotification *)notification
{
    if (isAlarmBegin) {
         NSLog(@"sleep");
        [self BeginAClock:5];
        [theQueuePlayer pause];
        isAlarmBegin = NO;
        
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: @"Sleep" ofType: @"mp3"];
        NSError  *error;
        AVAudioPlayer *audioPlayer1 = [[AVAudioPlayer alloc]initWithContentsOfURL:[[[NSURL alloc]initFileURLWithPath:soundFilePath] autorelease] error:&error];
        if (!audioPlayer1) {
            NSLog(@"error:%@ ",error);
        }
        [audioPlayer1 prepareToPlay];
        audioPlayer1.volume = 1;
        
        [audioPlayer1 play];
    }
   
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     NSMutableDictionary *pClockInfo = [NSMutableDictionary dictionary];
    
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[AVAudioSession sharedInstance] setDelegate:self];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"haha" ofType:@"mp3"];
    
    NSArray *pArray = [NSArray arrayWithArray:pRootViewCon.pPublicContentViewController.pSoundContentArr];
    NSString *path2;
    if (!pArray || [pArray count] <= 0) {
        path2 =  [[NSBundle mainBundle] pathForResource:@"haha" ofType:@"mp3"];
    }
    else{
        NSDictionary *pContent = [pArray objectAtIndex:arc4random() % [pArray count]];
        path2 = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@.mp3",[pContent objectForKey:@"name"]]];
       
        [pClockInfo setObject:[pContent objectForKey:@"name"] forKey:@"voiceName"];
    }

    NSURL *url =[NSURL fileURLWithPath:path];
    NSURL *url2 =[NSURL fileURLWithPath:path2];
    AVPlayerItem *thePlayerItemA = [AVPlayerItem playerItemWithURL:url];
    AVPlayerItem *thePlayerItemB = [AVPlayerItem playerItemWithURL:url2];
    
    [theQueuePlayer removeAllItems];
    [theQueuePlayer insertItem:thePlayerItemA afterItem:nil];
    [theQueuePlayer insertItem:thePlayerItemB afterItem:thePlayerItemA];
    
    NSTimeInterval time = [ClockManager LastAlarmTime];
    if (time <= 0 ) {
        NSLog(@"no Alarm");
        [pClockInfo removeObjectForKey:@"clockData"];
    }
    else{
        NSLog(@"next Alarm: %@",[NSDate dateWithTimeIntervalSinceNow:time]);
        [pClockInfo setObject:[NSDate dateWithTimeIntervalSinceNow:time] forKey:@"clockData"];
        [self BeginAClock:time];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:pClockInfo forKey:NextClockInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)BeginAClock:(NSTimeInterval)time
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray* oldNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
        // Clear out the old notification before scheduling a new one.
        if ([oldNotifications count] > 0)
            [[UIApplication sharedApplication] cancelAllLocalNotifications];
        // Create a new notification.
        
        [NSThread sleepForTimeInterval:time];
        [self PushAClock:1];
        
        [[UIApplication sharedApplication] endBackgroundTask:self.bgTask];
        
    });
}
-(void)PushAClock:(NSTimeInterval)time
{
    
    //[audioPlayer play];
    //[theQueuePlayer play];
    UILocalNotification* alarm = [[[UILocalNotification alloc] init] autorelease];
    if (alarm)
    {
        alarm.fireDate = [NSDate date];
        alarm.timeZone = [NSTimeZone defaultTimeZone];
        alarm.repeatInterval = 0;
        alarm.soundName = @"";
        alarm.alertBody = @"Time to wake up!";
        [[UIApplication sharedApplication] scheduleLocalNotification:alarm];
        
        //   [audioPlayer playAtTime:audioPlayer.deviceCurrentTime + time];
       // [theQueuePlayer advanceToNextItem];
        [theQueuePlayer play];
         isAlarmBegin = YES;
        
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [theQueuePlayer pause];
    isAlarmBegin = NO;
    
   NSDictionary *clockInfo = [[NSUserDefaults standardUserDefaults] objectForKey:NextClockInfo];
    NSDate *date = [clockInfo objectForKey:@"clockData"];
    NSLog(@"clockInfo:%@",clockInfo);
    
    if (isAlarmBegin) {
        NSArray *pCLockArray = [[NSUserDefaults standardUserDefaults] objectForKey:UserClock];
        for (NSMutableDictionary *pDic in pCLockArray) {
            if ([ClockManager  ChickISSameClock:[pDic objectForKey:@"data"] :date] && ![ClockManager ChickISHaveRepeat:[pDic objectForKey:@"repeat"]] ) {
                [pDic setObject:@"0" forKey:@"isOpen"];
                NSLog(@"clock is change");
            }
        }
        NSLog(@"pCLockArray:%@",pCLockArray);
        [[NSUserDefaults standardUserDefaults] setObject:pCLockArray forKey:UserClock];
    }
    
    [pRootViewCon UpdataClockText];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [EMAsyncImageView RemoveAllImage];
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSLog(@"URL: %@", url);
    NSRange range1 = [[NSString stringWithFormat:@"%@", url] rangeOfString:@"tencent"];
    if (range1.length >0) {
        return [TencentOAuth HandleOpenURL:url];
    }
    return [self.sinaweibo handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"URL: %@", url);
    NSRange range1 = [[NSString stringWithFormat:@"%@", url] rangeOfString:@"tencent"];
    if (range1.length >0) {
        return [TencentOAuth HandleOpenURL:url];
    }
    return [self.sinaweibo handleOpenURL:url];
}


+(NSString*)getClearContext:(NSString*)string
{
    NSString *pNewString = string;
    if ([string length] > 1) {
        if ([[string substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"\ufeff"]) {
            pNewString =  [string	stringByReplacingOccurrencesOfString:@"\ufeff" withString:@""];
        }
    }
    
    
    return pNewString;
}

@end
