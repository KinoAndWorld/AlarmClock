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
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:S_URL]];
    [request setDelegate:self];
    [request setUsername:@"getFriendList"];
    [request setPostValue:@"getFriendList" forKey:@"action"];
    [request setPostValue:@"nil" forKey:@"name"];
    [request setPostValue:@"0" forKey:@"row"];
    [request startAsynchronous];
}
@end
