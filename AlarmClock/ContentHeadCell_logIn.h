//
//  ContentHeadCell.h
//  AlarmClock
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMAsyncImageView.h"
@interface ContentHeadCell_logIn : UITableViewCell <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain)IBOutlet EMAsyncImageView *UserImg;
@property (nonatomic, retain)IBOutlet UILabel *name;
@end
