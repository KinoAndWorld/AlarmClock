//
//  RepeatViewController.h
//  AlarmClock
//
//  Created by user on 5/5/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddClockCon;
@interface RepeatViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *pTabelView;
    AddClockCon *pAddClockCon;
}
@property (strong, nonatomic) AddClockCon *pAddClockCon;
@end
