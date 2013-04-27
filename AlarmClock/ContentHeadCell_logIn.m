//
//  ContentHeadCell.m
//  AlarmClock
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "ContentHeadCell_logIn.h"
#import "RootViewController.h"
#import "AppDelegate.h"
#import "loginViewController.h"
#import "RegiestView.h"
#import "LoginChooseViewConViewController.h"    
@implementation ContentHeadCell_logIn
@synthesize UserImg,name;
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

@end
