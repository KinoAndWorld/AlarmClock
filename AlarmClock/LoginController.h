//
//  LoginController.h
//  AlarmClock
//
//  Created by user on 4/19/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
@interface LoginController : UIViewController<UITextFieldDelegate>
@property (nonatomic, retain)IBOutlet UITextField *UserName,*PassWorld;
@property (nonatomic, retain)ErrorView *pErrorView;
@end
