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
+(NSDate *)GetRecentAlock
{
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
    
    return nextData;
}
@end
