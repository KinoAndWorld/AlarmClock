//
//  loginViewController.h
//  AlarmClock
//
//  Created by user on 4/8/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
@interface loginViewController : UIViewController{
    IBOutlet UITextField *name;
    IBOutlet UITextField *password;
    
    IBOutlet UITextField *name2;
    IBOutlet UITextField *password2;
    IBOutlet UITextField *nikeName;
}
@property(nonatomic,retain)UITextField *name;
@property(nonatomic,retain)UITextField *password;
@property(nonatomic,retain)UITextField *name2;
@property(nonatomic,retain)UITextField *password2;
@property(nonatomic,retain)UITextField *nikeName;
@end
