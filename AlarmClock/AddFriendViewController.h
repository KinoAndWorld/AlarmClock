//
//  AddFriendViewController.h
//  AlarmClock
//
//  Created by user on 5/25/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASINetworkQueue.h"
@interface AddFriendViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *pTextArray1;
    NSArray *pTextArray;
      NSMutableArray *pContentArr;
    IBOutlet UITableView *pTable;
    ASINetworkQueue *queue;
    NSMutableArray *pSoundContentArr;
}
@end
