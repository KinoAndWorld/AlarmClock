//
//  LoginController.m
//  AlarmClock
//
//  Created by user on 4/19/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "LoginController.h"
#import "AppDelegate.h"
#import "RootViewController.h"
@interface LoginController ()

@end

@implementation LoginController
@synthesize UserName,PassWorld,pErrorView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ErrorView" owner:self options:nil];
    pErrorView = [nib objectAtIndex:0];
    [self.view insertSubview:pErrorView atIndex:1];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Back:(id)sender
{
[self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)Login:(id)sender
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:S_URL]];
    [request setDelegate:self];
    [request setUsername:@"logIn"];
    [request setPostValue:@"logIn" forKey:@"action"];
    
    [request setPostValue:UserName.text forKey:@"name"];
    [request setPostValue:PassWorld.text forKey:@"pw"];
    [request startAsynchronous];
    
}

#pragma mark - NETWORK Delegate
- (void) requestFinished:(ASIHTTPRequest *)request {
    
    NSString *pString = [NSString stringWithString:[request responseString]];
    NSLog(@"Response finish:%@",pString);
    pString = [AppDelegate getClearContext:pString];
    NSDictionary *pContent = [pString objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    if ([request.username isEqualToString:@"logIn"]) {
        if (![[pContent objectForKey:@"result"] intValue]) {
            [pErrorView PlayAnimation: [NSString stringWithFormat:@"%@",[pContent objectForKey:@"info"]]];
        }
        else{
           
            if ([[pContent objectForKey:@"userInfo"] isKindOfClass:[NSDictionary class]]) {
                [[NSUserDefaults standardUserDefaults] setObject:[[pContent objectForKey:@"userInfo"] objectForKey:@"ID"] forKey:@"userID"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                 [RootViewController SetUserInfoData:UserName.text name:[[pContent objectForKey:@"userInfo"] objectForKey:@"nikeName"] faceImg:[NSString stringWithFormat:@"%@/userPic/%@.png",IMAGE_URL,UserName.text] typeString:@"FREE" status:logInTag];
            }
            [RootViewController   ReloadAllData];

        }
        
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.pRootViewCon RefrshDataWithUserInfoType:nil];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }

}
- (void) requestFailed:(ASIHTTPRequest *)request {
    //NSString *responseString = [request responseString];
    NSLog(@"Response Fail %d : %@", request.responseStatusCode, [request responseString]);
    
    [pErrorView PlayAnimation:[NSString stringWithFormat:@"请检查网络"]];
   // [UserNameIndicaor stopAnimating];
}

@end
