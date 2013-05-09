//
//  AlarmClockCell.h
//  AlarmClock
//
//  Created by user on 5/2/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmClockCell : UITableViewCell
{
    
    UISwitch *Swish;
    UILabel *Time;
    UILabel *AM;
    UILabel *Tag;
    UILabel *Info;
    UIImageView *pAcc;
    NSDictionary *ClockInfo;
    
}
@property (retain, nonatomic) NSDictionary *ClockInfo;
-(void)UpdataData;
@end
