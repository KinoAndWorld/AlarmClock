//
//  AlarmClockCell.m
//  AlarmClock
//
//  Created by user on 5/2/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "AlarmClockCell.h"

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
        
        Swish = [[UISwitch alloc] initWithFrame:CGRectMake(220, 35, 40, 20)];
        [self addSubview:Swish];
        
        Time = [[UILabel alloc] initWithFrame:CGRectMake(42, 34, 100, 20)];
        Time.backgroundColor = [UIColor clearColor];
        Time.font = [UIFont boldSystemFontOfSize:24];
        Time.text = @"7:00";
        Time.textColor = [UIColor colorWithWhite:0.2 alpha:255];
        [self addSubview:Time];
        
        AM = [[UILabel alloc] initWithFrame:CGRectMake(10, 34, 100, 20)];
        AM.backgroundColor = [UIColor clearColor];
        AM.font = [UIFont systemFontOfSize:15];
        AM.text = @"上午";
        AM.textColor = [UIColor colorWithWhite:0.3 alpha:255];
        [self addSubview:AM];
        
        Tag = [[UILabel alloc] initWithFrame:CGRectMake(10, 54, 100, 20)];
        Tag.backgroundColor = [UIColor clearColor];
        Tag.font = [UIFont systemFontOfSize:15];
        Tag.text = @"闹钟";
        Tag.textColor = [UIColor colorWithWhite:0.3 alpha:255];
        [self addSubview:Tag];
        
        
        pAcc = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"narrow.png"]];
        [self addSubview:pAcc];
        pAcc.frame = CGRectMake(330, 40, 10, 15);
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
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
        Swish.frame = CGRectMake(220, Swish.frame.origin.y, Swish.frame.size.width, Swish.frame.size.height);
		Swish.alpha = 1;
        pAcc.frame = CGRectMake(330, pAcc.frame.origin.y, pAcc.frame.size.width, pAcc.frame.size.height);
		[UIView commitAnimations];
    }
}
@end
