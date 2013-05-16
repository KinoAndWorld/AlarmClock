//
//  ClockManager.m
//  AlarmClock
//
//  Created by user on 5/7/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "ClockManager.h"
#import "Config.h"
#include "AppDelegate.h"
@implementation ClockManager


+(NSTimeInterval)LastAlarmTime
{
    NSTimeInterval time= 0;
    NSDate *nextData = [ClockManager GetRecentAlock];
    if (!nextData) {
        return 0;
    }
    time = [ nextData timeIntervalSinceNow  ];
    return  time;
}
+(bool)ChickIsAlarmTime
{

    return NO;
}
+(bool)ChickISHaveRepeat:(NSArray *)pRepeatArray
{
    bool isHaveLoop = false;
    for (int i = 0; i < [pRepeatArray count]; i++) {
        if ([pRepeatArray[i] isEqual:@"1"]) {
            isHaveLoop = true;  break;
        }
    }//判断是否有重复
    
    return isHaveLoop;
}
+(bool)ChickISSameClock:(NSDate *)date1 :(NSDate*)date2
{
    NSDateFormatter *formatter =[[[NSDateFormatter alloc] init] autorelease];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    //int week=0;
    comps = [calendar components:unitFlags fromDate:date1];
    int week = [comps weekday];
    int year=[comps year];
    int month = [comps month];
    int day = [comps day];
    int hour = [comps hour];
    int min = [comps minute];
    int sec = [comps second];
    week = (week + 6) % 7 - 1; // 0 -- 星期一 1-- 星期2
    //======  闹钟日期
    
    NSLog(@"%d",calendar.firstWeekday);
    
    //======  取得今天日期
    NSDateFormatter *formatter2 =[[[NSDateFormatter alloc] init] autorelease];
    [formatter2 setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar2 = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *comps2 = [[[NSDateComponents alloc] init] autorelease];
    comps2 = [calendar2 components:unitFlags fromDate:date2];
    int weekNow = [comps2 weekday];
    weekNow = (weekNow + 6) % 7 - 1; // 0 -- 星期一 1-- 星期2
    int hourNow = [comps2 hour];
    int minNow = [comps2 minute];
    int secNow = [comps2 second];
    
    if (hour == hourNow && min == minNow) {
        return YES;
    }
    return NO;
}
+(NSDate *)GetRecentAlock
{
    NSArray *pDic = [[NSUserDefaults standardUserDefaults] objectForKey:UserClock];
    NSDate *nextData = [NSDate dateWithTimeIntervalSinceNow:999999];
    bool isChick = false;
    for (int i = 0; i < [pDic count]; i++) {
        NSDictionary *pDicdory = [pDic objectAtIndex:i];
        if (pDicdory) {
            NSLog(@"pDicdory:%@",pDicdory);
            NSDate *pDate = [pDicdory objectForKey:@"data"];
            if ([[pDicdory objectForKey:@"isOpen"] isEqual:@"0"]) {
                continue;
            }
            isChick = true;
            NSArray *pRepeatArray = [pDicdory objectForKey:@"repeat"];
            //======  闹钟日期
            NSDateFormatter *formatter =[[[NSDateFormatter alloc] init] autorelease];
            [formatter setTimeStyle:NSDateFormatterMediumStyle];
            NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
            NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
            NSInteger unitFlags = NSYearCalendarUnit |
            NSMonthCalendarUnit |
            NSDayCalendarUnit |
            NSWeekdayCalendarUnit |
            NSHourCalendarUnit |
            NSMinuteCalendarUnit |
            NSSecondCalendarUnit;
            //int week=0;
            comps = [calendar components:unitFlags fromDate:pDate];
            int week = [comps weekday];
            int year=[comps year];
            int month = [comps month];
            int day = [comps day];
            int hour = [comps hour];
            int min = [comps minute];
            int sec = [comps second];
            week = (week + 6) % 7 - 1; // 0 -- 星期一 1-- 星期2
            //======  闹钟日期
            
            NSLog(@"%d",calendar.firstWeekday);
            
            //======  取得今天日期
            NSDateFormatter *formatter2 =[[[NSDateFormatter alloc] init] autorelease];
            [formatter2 setTimeStyle:NSDateFormatterMediumStyle];
            NSCalendar *calendar2 = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
            NSDateComponents *comps2 = [[[NSDateComponents alloc] init] autorelease];
            comps2 = [calendar2 components:unitFlags fromDate:[NSDate date]];
            int weekNow = [comps2 weekday];
            weekNow = (weekNow + 6) % 7 - 1; // 0 -- 星期一 1-- 星期2
            int hourNow = [comps2 hour];
            int minNow = [comps2 minute];
             int secNow = [comps2 second];
            //======  取得今天日期
            
            //判断是否有重复
            bool isHaveLoop = false;
            for (int i = 0; i < [pRepeatArray count]; i++) {
                if ([pRepeatArray[i] isEqual:@"1"]) {
                    isHaveLoop = true;  break;
                }
            }//判断是否有重复
            
            if (!isHaveLoop) {  //不重复的情况
                pDate = [NSDate dateWithTimeIntervalSinceNow:(hour - hourNow)*60*60 + (min - minNow)*60 - secNow];
                NSDate *pNow = [NSDate date];
                NSDate *pNextDateTemp;
                NSLog(@"now:%@",pNow);
                NSLog(@"pDate:%@",pDate);
                int dayDur = ((hour - hourNow)*60 + (min - minNow) )<= 0? 1:0;
                 pNextDateTemp = [[pNow dateByAddingTimeInterval:dayDur*24*60*60] dateByAddingTimeInterval:(hour - hourNow)*60*60 + (min - minNow)*60 - secNow];
                NSLog(@"pNextDateTemp:%@",pNextDateTemp);
                if ([[pNextDateTemp earlierDate:nextData] isEqualToDate:pNextDateTemp]) {
                    nextData = pNextDateTemp;
                }
//                if ([[pNow earlierDate:pDate] isEqualToDate:pNow] && [[pDate earlierDate:nextData] isEqualToDate:pDate]) { //本天
//                    nextData = pDate;
//                }
//                else if([[pNow earlierDate:pDate] isEqualToDate:pDate])
//                    
//                    if([[[pDate dateByAddingTimeInterval:24*60*60] earlierDate:nextData] isEqualToDate:[pDate dateByAddingTimeInterval:24*60*60]]){  //第二天
//                        
//                    nextData = [pDate dateByAddingTimeInterval:24*60*60];
//                }
            }
            else{   //重复的情况
                
                // 取得离现在最近的日期
                NSDate *now = [NSDate date];
                NSDate *nearestDate = [NSDate dateWithTimeIntervalSinceNow:9999999];
                for (int i = 0; i < 7 ; i++) {
                    if ([pRepeatArray[i] isEqual:@"1"]) {
                        NSDate *pLoopDate;
                        if (weekNow > i) { //
                            pLoopDate = [[now dateByAddingTimeInterval:(7 - weekNow + i)*24*60*60] dateByAddingTimeInterval:(hour - hourNow)*60*60 + (min - minNow)*60- secNow];
                        }
                        else{
                            pLoopDate = [[now dateByAddingTimeInterval:(i - weekNow)*24*60*60] dateByAddingTimeInterval:(hour - hourNow)*60*60 + (min - minNow)*60- secNow];
                        }
                        if ([[pLoopDate earlierDate:nearestDate] isEqualToDate:pLoopDate]) {
                            nearestDate = pLoopDate;
                        }
                    }
                }// 取得离现在最近的日期
                
                if ([[nearestDate earlierDate:nextData] isEqualToDate:nearestDate]) {
                    nextData = nearestDate;
                }
            }//重复的情况
        }
    }
    NSLog(@"nextData:%@",nextData);
    if (!isChick) {
        return nil;
    }
    return nextData;
}
@end
