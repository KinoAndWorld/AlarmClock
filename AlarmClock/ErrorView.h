//
//  ErrorView.h
//  AlarmClock
//
//  Created by user on 4/16/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ErrorView : UIView
-(void)PlayAnimation:(NSString*)errorInfo;
@property (nonatomic, retain)IBOutlet UILabel *ErrorInfo;
@end
