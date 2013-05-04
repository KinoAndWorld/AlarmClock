//
//  FriendCotentViewCon.m
//  AlarmClock
//
//  Created by user on 4/26/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "FriendCotentViewCon.h"
#import "Config.h"
@implementation FriendCotentViewCon
-(void) refreshView{
    NSString *pString = [[NSUserDefaults   standardUserDefaults] objectForKey:@"userID"];
    if (!pString) {
        pString = @"XXXY";
    }
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:S_URL]];
    [request setDelegate:self];
    [request setUsername:@"getList"];
    [request setPostValue:@"getList" forKey:@"action"];
    [request setPostValue:pString forKey:@"id"];
    [request setPostValue:@"0" forKey:@"row"];
    [request startAsynchronous];
}
@end
