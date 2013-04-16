//
//  RegiestView.h
//  AlarmClock
//
//  Created by user on 4/16/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegiestView : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain)IBOutlet UIScrollView *ScrollView;
@property (nonatomic, retain)IBOutlet UITextField *UserName,*PassWorld,*Email,*NikeName;
@property (nonatomic, retain)IBOutlet UIImageView *image_UserNameIcon,*image_Password;
@property (nonatomic, retain)IBOutlet UIActivityIndicatorView *UserNameIndicaor;
@end
