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
@implementation AppDelegate
@synthesize sinaweibo;
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
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
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
