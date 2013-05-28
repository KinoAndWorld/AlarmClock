//
//  ContentHeadCell.m
//  AlarmClock
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "ContentCell2.h"
#import "ASIFormDataRequest.h"
#import "Config.h"
@implementation ContentCell2

@synthesize picView,Text,PlaySoundButton,pString,ID,FriendNum;
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
-(void)dealloc
{
    [super dealloc];
}
-(IBAction)PlaySound:(id)sender
{
    
}
-(IBAction)AddFriend:(id)sender
{
    if ([[NSUserDefaults   standardUserDefaults] objectForKey:@"userID"] == nil) {
        NSLog(@"未登陆！");
        return;
    }
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:S_URL]];
    [request setDelegate:self];
    [request setUsername:@"AddFriend"];
    [request setPostValue:@"AddFriend" forKey:@"action"];
    [request setPostValue:[[NSUserDefaults   standardUserDefaults] objectForKey:@"userID"] forKey:@"userName"];
    [request setPostValue:ID forKey:@"friendName"];
    NSLog(@"userid:%@  to  id: %@",[[NSUserDefaults   standardUserDefaults] objectForKey:@"userID"],ID);
    [request startAsynchronous];
}
#pragma mark - NETWORK Delegate
- (void) requestFinished:(ASIHTTPRequest *)request {
    
        //@todo
        NSString *pString = [NSString stringWithString:[request responseString]];
        NSLog(@"Response finish:%@",pString);

}
- (void) requestFailed:(ASIHTTPRequest *)request {
    //NSString *responseString = [request responseString];
    NSLog(@"Response Fail %d : %@", request.responseStatusCode, [request responseString]);
    
}
@end
