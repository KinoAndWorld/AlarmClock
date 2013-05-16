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
+(bool)ChickIsAlarmTime;
+(NSTimeInterval)LastAlarmTime;
+(NSDate *)GetRecentAlock;
+(bool)ChickISHaveRepeat:(NSArray *)pRepeatArray;
+(bool)ChickISSameClock:(NSDate *)date1 :(NSDate*)date2;
@end
