//
//  AddClockCon.h
//  AlarmClock
//
//  Created by user on 5/3/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPPickerViewCell.h"
@class AlarmClockViewCon;
@interface AddClockCon : UIViewController<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,CPPickerViewCellDelegate, CPPickerViewCellDataSource>
{
    IBOutlet UITableView *pTabelView;
    IBOutlet UIDatePicker *pPick;
    UITextField *pTagText;
    
    NSMutableDictionary *pClockDataDic;
    UISwitch *pSwich ;
    AlarmClockViewCon *ClockCell;
}
@property (strong, nonatomic) NSMutableArray *settingsStorage;
@property (strong, nonatomic) NSMutableDictionary *pClockDataDic;
@property (strong, nonatomic) AlarmClockViewCon *ClockCell;
@property (strong, nonatomic) UITableView *pTabelView;
+(NSString*)getNameForRepeat:(NSArray*)Data;
@end
