//
//  EditClockViewController.m
//  AlarmClock
//
//  Created by user on 5/15/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "EditClockViewController.h"
#import "Config.h"
#include "ClockManager.h"
#include "AlarmClockViewCon.h"
@interface EditClockViewController ()

@end

@implementation EditClockViewController
@synthesize indexInArray;
-(IBAction)Done :(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    NSDate * date = [pPick date];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    comps =[calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit)
            
                       fromDate:date];
    NSInteger second = [comps second];
    
    [pClockDataDic setObject:[date dateByAddingTimeInterval:-second] forKey:@"data"];
    NSMutableArray *pDataDic = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:UserClock]] ;
    NSMutableDictionary *pDic = [NSMutableDictionary dictionaryWithDictionary:[pDataDic objectAtIndex:indexInArray]];
    NSLog(@"pDataDic:%@",pDataDic);
    [pDic setObject:[pClockDataDic objectForKey:@"data"] forKey:@"data"];
    [pDataDic removeObjectAtIndex:indexInArray];
    [pDataDic insertObject:pClockDataDic atIndex:indexInArray];
    
     NSLog(@"pDataDic:%@",pDataDic);
//    NSMutableArray *pTempArray = [NSMutableArray arrayWithArray:pDataDic];
//    [pTempArray addObject:pClockDataDic];
//    NSMutableArray *pTempArray2 = [NSArray arrayWithArray:pTempArray];
    [[NSUserDefaults standardUserDefaults] setObject:pDataDic forKey:UserClock];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [ClockCell loadData];
    [ClockCell.pTableView reloadData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    pClockDataDic = [NSMutableDictionary    dictionaryWithDictionary:[[[NSUserDefaults standardUserDefaults] objectForKey:UserClock] objectAtIndex:indexInArray]];
    [pClockDataDic retain];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
