//
//  ContentViewController.h
//  AlarmClock
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASINetworkQueue.h"
#import <AVFoundation/AVFoundation.h>
@interface ContentViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,AVAudioPlayerDelegate,AVAudioSessionDelegate>
{
    NSMutableArray *pContentArr;
    NSMutableArray *pSoundContentArr;
    ASINetworkQueue *queue;
    AVAudioPlayer *player;
}
@property (nonatomic, retain) UITableView *tableView;
-(void)RefrshDataWithUserInfoType :(NSString*) userType;
@end
