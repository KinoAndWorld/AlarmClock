//
//  Config.h
//  AlarmClock
//
//  Created by user on 4/16/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#ifndef AlarmClock_Config_h
#define AlarmClock_Config_h
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "ErrorView.h"
#import "JSONKit.h"
static NSString *S_URL = @"http://192.168.1.104/~user/AlarmClock/index.php";
static NSString *IMAGE_URL = @"http://192.168.1.104/~user/AlarmClock";
static NSString *UserInfoData = @"UserInfoData";
static NSString *UserClock = @"UserClock";
static NSString *NextClockInfo = @"NextClockInfo";
static NSString *logInTag = @"logined";
#define kAppKey             @"2330639301"
#define kAppSecret          @"b40da38bc76d70a2ffcd1f4f7a754390"
#define kAppRedirectURI     @"http://weibo.com/u/3195606297"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)




#ifndef kAppKey
#error
#endif

#ifndef kAppSecret
#error
#endif

#ifndef kAppRedirectURI
#error
#endif


#endif
