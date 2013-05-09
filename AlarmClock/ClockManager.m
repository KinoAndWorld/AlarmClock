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

+(void)UpdataClockByName:(NSMutableDictionary   *) info
{
    if ([[info objectForKey:@"isOpen"] isEqual:@"1"]) {
        [ClockManager CreatAClock:info];
    }
    else{
        [ClockManager CancleAClock:info];
    }
}
+(NSTimeInterval)LastAlarmTime
{
    NSTimeInterval time= 0;
    NSArray *pDic = [[NSUserDefaults standardUserDefaults] objectForKey:UserClock];
    NSDate *nextData = [NSDate date];
    bool isChick = false;
    for (int i = 0; i < [pDic count]; i++) {
        NSDictionary *pDicdory = [pDic objectAtIndex:i];
        if (pDicdory) {
            NSDate *pDate = [pDicdory objectForKey:@"data"];
            if (!isChick && [nextData earlierDate:pDate]) {
                nextData = pDate;isChick = true;
            }
            else if([pDate earlierDate:nextData]){
                nextData = pDate;
            }
        }
        
    }
    
    time = [ nextData timeIntervalSinceNow  ];
    return  time;
}
+(bool)ChickIsAlarmTime
{
   NSArray *pDic = [[NSUserDefaults standardUserDefaults] objectForKey:UserClock];
    for (int i = 0; i < [pDic count]; i++) {
        NSDictionary *pDicdory = [pDic objectAtIndex:i];
        if (pDicdory) {
            NSDate *pDate = [pDicdory objectForKey:@"data"];
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df autorelease];
            df.dateFormat  = @"yyyy/MM/dd HH:mm";
            NSString *str2 = [df stringFromDate:[NSDate date]];
            NSString *str1 = [df stringFromDate:pDate];
            NSLog(@"data:%@",str1);
            NSLog(@"now data:%@",str2);
           
            if ([str1 isEqual:str2]) {
                NSLog(@"clock is work");
                NSMutableArray  *ptemp = [NSMutableArray arrayWithArray:pDic];
                [ptemp removeObject:pDicdory];
                NSArray *ptemp2 = [NSArray arrayWithArray:ptemp];
                [[NSUserDefaults standardUserDefaults] setObject:ptemp2 forKey:UserClock];
                return YES;
            }
        }

    }
    return NO;
}
+(void)CreatAClock:(NSMutableDictionary   *) info
{
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [NSThread sleepForTimeInterval:10];
//        [ClockManager PushAClock:info];
//    });
//    
//    
//    return;

}
+(void)PushAClock:(NSTimeInterval)time
{  
    
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil)
    {
        notification.fireDate = [NSDate dateWithTimeInterval:time sinceDate:[NSDate date]];//[info objectForKey:@"data"];
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.soundName = @"../Documents/downloadFile.caf";
        //notification.repeatInterval = 1;
        //notification.alertBody=@"TIME！";
        
        notification.alertBody = [NSString stringWithFormat:@"1212 时间到了!"];
        
       // notification.userInfo = info;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        
    }
    
    [((AppDelegate*)[UIApplication sharedApplication].delegate).audioPlayer play];

}
+(void)CancleAClock:(NSMutableDictionary   *) info
{
    //[[UIApplication sharedApplication] cancelLocalNotification:<#(UILocalNotification *)#>];
}
@end
