//
//  ContentHeadCell.h
//  AlarmClock
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMAsyncImageView.h"
@interface ContentCell2 : UITableViewCell
@property (nonatomic, retain) IBOutlet EMAsyncImageView 	*picView;
@property (nonatomic, retain) IBOutlet UILabel 	*Text;
@property (nonatomic, retain) IBOutlet UILabel 	*FriendNum;
@property (nonatomic, retain) IBOutlet UIButton 	*PlaySoundButton;
@property (nonatomic, retain) NSString *pString;
@property (nonatomic, retain) NSString *ID;
@end
