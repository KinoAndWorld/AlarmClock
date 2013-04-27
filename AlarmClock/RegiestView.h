//
//  RegiestView.h
//  AlarmClock
//
//  Created by user on 4/16/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
@interface RegiestView : UIViewController <UITextFieldDelegate,SinaWeiboRequestDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImage *userPic;
    NSString *userImg;
}

@property (nonatomic, retain)ErrorView *pErrorView;
@property (nonatomic, retain)IBOutlet UIScrollView *ScrollView;
@property (nonatomic, retain)IBOutlet UITextField *UserName,*PassWorld,*Email,*NikeName,*PhoneNum;
@property (nonatomic, retain)IBOutlet UIImageView *image_UserNameIcon,*image_Password;
@property (nonatomic, retain)IBOutlet UIButton *userImgButton;
@property (nonatomic, retain)IBOutlet UIActivityIndicatorView *UserNameIndicaor;
@end
