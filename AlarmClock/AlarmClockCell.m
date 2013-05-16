//
//  AlarmClockCell.m
//  AlarmClock
//
//  Created by user on 5/2/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "AlarmClockCell.h"
#include "AddClockCon.h"
#include "Config.h"
@implementation AlarmClockCell
@synthesize ClockInfo;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *pImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 89)];
        pImageView.backgroundColor = [UIColor lightTextColor];
        [self addSubview:pImageView];
        
        Swish = [[UISwitch alloc] initWithFrame:CGRectMake(220, 24, 40, 20)];
        [self addSubview:Swish];
        [Swish addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
        Time = [[UILabel alloc] initWithFrame:CGRectMake(42, 24, 100, 20)];
        Time.backgroundColor = [UIColor clearColor];
        Time.font = [UIFont boldSystemFontOfSize:24];
        Time.text = @"7:00";
        Time.textColor = [UIColor colorWithWhite:0.2 alpha:255];
        [self addSubview:Time];
        
        AM = [[UILabel alloc] initWithFrame:CGRectMake(10, 24, 100, 20)];
        AM.backgroundColor = [UIColor clearColor];
        AM.font = [UIFont systemFontOfSize:15];
        AM.text = @"上午";
        AM.textColor = [UIColor colorWithWhite:0.3 alpha:255];
        [self addSubview:AM];
        
        Tag = [[UILabel alloc] initWithFrame:CGRectMake(10, 44, 100, 20)];
        Tag.backgroundColor = [UIColor clearColor];
        Tag.font = [UIFont systemFontOfSize:15];
        Tag.text = @"闹钟";
        Tag.textColor = [UIColor colorWithWhite:0.3 alpha:255];
        [self addSubview:Tag];
        
        
        Info = [[UILabel alloc] initWithFrame:CGRectMake(10, 64,300, 20)];
        Info.backgroundColor = [UIColor clearColor];
        Info.font = [UIFont systemFontOfSize:15];
        Info.text = @"永不";
        Info.textColor = [UIColor colorWithWhite:0.3 alpha:255];
        [self addSubview:Info];
        
        pAcc = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"narrow.png"]];
        [self addSubview:pAcc];
        pAcc.frame = CGRectMake(330, 40, 10, 15);
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}
-(void)switchAction:(id)sender
{
    if (Swish.isOn) {
        NSArray *clockArray = [[NSUserDefaults standardUserDefaults] objectForKey:UserClock];
        NSMutableArray *newclockArray = [NSMutableArray arrayWithArray:clockArray];
        int index = 0;
        for (NSDictionary *dic in clockArray) {
            if ([[dic objectForKey:@"data"] isEqualToDate:[ClockInfo objectForKey:@"data"]]) {
                NSMutableDictionary *newDic = [NSMutableDictionary  dictionaryWithDictionary:dic];
                [newDic setObject: @"1" forKey:@"isOpen"];
                [newclockArray setObject:[NSDictionary dictionaryWithDictionary:newDic] atIndexedSubscript:index];
                break;
            }
            index ++;
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:newclockArray] forKey:UserClock];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        NSArray *clockArray = [[NSUserDefaults standardUserDefaults] objectForKey:UserClock];
        NSMutableArray *newclockArray = [NSMutableArray arrayWithArray:clockArray];
        int index = 0;
        for (NSDictionary *dic in clockArray) {
            if ([[dic objectForKey:@"data"] isEqualToDate:[ClockInfo objectForKey:@"data"]]) {
                NSMutableDictionary *newDic = [NSMutableDictionary  dictionaryWithDictionary:dic];
                [newDic setObject: @"0" forKey:@"isOpen"];
                [newclockArray setObject:[NSDictionary dictionaryWithDictionary:newDic] atIndexedSubscript:index];
                break;
            }
            index ++;
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:newclockArray] forKey:UserClock];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
-(void)UpdataData
{
    NSDate *pdata = [ClockInfo objectForKey:@"data"];
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"HH:mm"];
    NSString *dateStr=[dateformat  stringFromDate:pdata];
     Time.text = dateStr;
    [dateformat release];
    Info.text =[AddClockCon getNameForRepeat:[ClockInfo objectForKey:@"repeat"]];
    Tag.text = [ClockInfo objectForKey:@"tag"];
    if ([[ClockInfo objectForKey:@"isOpen"] isEqual:@"1"]) {
        [Swish setOn:YES];
    }
    else{
        [Swish setOn:NO];
    }
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) setEditing:(BOOL)editting animated:(BOOL)animated
{
    [super setEditing:editting animated:animated];
    if (editting) {
        [UIView beginAnimations:nil context:nil];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.3];
		
		Time.frame = CGRectMake(72, Time.frame.origin.y, Time.frame.size.width, Time.frame.size.height);
		AM.frame = CGRectMake(40, AM.frame.origin.y, AM.frame.size.width, AM.frame.size.height);
		Tag.frame = CGRectMake(40, Tag.frame.origin.y, Tag.frame.size.width, Tag.frame.size.height);
        Info.frame = CGRectMake(40, Info.frame.origin.y, Info.frame.size.width, Info.frame.size.height);
        Swish.frame = CGRectMake(190, Swish.frame.origin.y, Swish.frame.size.width, Swish.frame.size.height);
		Swish.alpha = 0;
        pAcc.frame = CGRectMake(290, pAcc.frame.origin.y, pAcc.frame.size.width, pAcc.frame.size.height);
		[UIView commitAnimations];

    }
    else{
        [UIView beginAnimations:nil context:nil];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.3];
		
		Time.frame = CGRectMake(42, Time.frame.origin.y, Time.frame.size.width, Time.frame.size.height);
		AM.frame = CGRectMake(10, AM.frame.origin.y, AM.frame.size.width, AM.frame.size.height);
		Tag.frame = CGRectMake(10, Tag.frame.origin.y, Tag.frame.size.width, Tag.frame.size.height);
          Info.frame = CGRectMake(10, Info.frame.origin.y, Info.frame.size.width, Info.frame.size.height);
        Swish.frame = CGRectMake(220, Swish.frame.origin.y, Swish.frame.size.width, Swish.frame.size.height);
		Swish.alpha = 1;
        pAcc.frame = CGRectMake(330, pAcc.frame.origin.y, pAcc.frame.size.width, pAcc.frame.size.height);
		[UIView commitAnimations];
    }
}
@end
