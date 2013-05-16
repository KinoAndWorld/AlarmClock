//
//  ContentHeadCell.m
//  AlarmClock
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "ContentHeadCell.h"
#import "RootViewController.h"
#import "AppDelegate.h"
#import "loginViewController.h"
#import "RegiestView.h"
#import "LoginChooseViewConViewController.h"    
@implementation ContentHeadCell
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

-(IBAction)PushRegistView:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    RegiestView *pLogInview ;
    if (iPhone5) {
    pLogInview = [[RegiestView alloc] initWithNibName:@"RegiestView_ip5" bundle:nil];
    }
    else{
     pLogInview = [[RegiestView alloc] initWithNibName:@"RegiestView" bundle:nil];
    }
   
    [appDelegate.pRootViewCon.navigationController pushViewController:pLogInview animated:YES];
    [pLogInview release];
}
-(IBAction)PushLoginView:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    LoginChooseViewConViewController *pLogInview = [[LoginChooseViewConViewController alloc] initWithNibName:@"LoginChooseViewConViewController" bundle:nil];
    [appDelegate.pRootViewCon.navigationController pushViewController:pLogInview animated:YES];
    [pLogInview release];
}
@end
