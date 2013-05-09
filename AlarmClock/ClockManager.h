//
//  ClockManager.h
//  AlarmClock
//
//  Created by user on 5/7/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface ClockManager : NSObject
+(void)UpdataClockByName:(NSMutableDictionary   *) info;
+(void)CreatAClock:(NSMutableDictionary   *) info;
+(void)PushAClock:(NSTimeInterval) time;
+(bool)ChickIsAlarmTime;
+(NSTimeInterval)LastAlarmTime;
@end
