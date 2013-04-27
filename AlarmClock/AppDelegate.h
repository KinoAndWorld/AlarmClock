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
}

@property (readonly, nonatomic) SinaWeibo *sinaweibo;
+(NSString*)getClearContext:(NSString*)string;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSMutableDictionary *pUserPicDic;
@property (strong, nonatomic) RootViewController *pRootViewCon;
@end
