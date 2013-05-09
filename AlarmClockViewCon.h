//
//  AlarmClockViewCon.h
//  AlarmClock
//
//  Created by user on 5/2/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmClockViewCon : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *pTableView;
    NSMutableArray *pDataDic;
}
@property (strong, nonatomic)UITableView *pTableView;
-(IBAction)Done:(id)sender;
- (IBAction)tableViewEdit:(id)sender;
-(void)loadData;
@end
