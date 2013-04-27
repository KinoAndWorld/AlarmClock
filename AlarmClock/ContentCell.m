//
//  ContentHeadCell.m
//  AlarmClock
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "ContentCell.h"

@implementation ContentCell

@synthesize picView,Text,PlaySoundButton,pString;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)PlaySound:(id)sender
{
    
}
@end
