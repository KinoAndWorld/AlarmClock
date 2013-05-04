//
//  LoginChooseViewConViewController.m
//  AlarmClock
//
//  Created by user on 4/18/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "LoginChooseViewConViewController.h"

#include "AppDelegate.h"
#include "RootViewController.h"
#include "LoginController.h"
#import "Config.h"
#import "ContentViewController.h"
#import "FriendCotentViewCon.h"
@interface LoginChooseViewConViewController ()

@end

@implementation LoginChooseViewConViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)back:(id)sender
{
[self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)LoginWithDida:(id)sender
{
    LoginController *pview = [[LoginController alloc] initWithNibName:@"LoginController" bundle:nil];
    [self.navigationController pushViewController:pview animated:YES];;
    [pview release];
    
}
-(IBAction)LoginWithQQ:(id)sender
{
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(waitForWeiboRequest:) userInfo:nil repeats:YES];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.pRootViewCon TencentLogin];
}
-(IBAction)LoginWithSina:(id)sender
{
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(waitForWeiboRequest:) userInfo:nil repeats:YES];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [[delegate.pRootViewCon sinaweibo] logIn];

}
-(IBAction)LoginWithRenRen:(id)sender
{

}
//wait for sina weibo
-(void)waitForWeiboRequest:(NSTimer *)timer
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (delegate.pRootViewCon.userInfo) {
        NSLog(@"userInfo:%@",delegate.pRootViewCon.userInfo);

        
    }
    else if (delegate.pRootViewCon.tencentOAuthUserInfo) {
        NSLog(@"userInfo:%@",delegate.pRootViewCon.tencentOAuthUserInfo);
    }

    NSDictionary *authData = [[NSUserDefaults standardUserDefaults] objectForKey:UserInfoData];
    if (authData && [authData objectForKey:@"id"]) {
         [timer invalidate];
        NSLog(@"authData:%@",authData);
        [self Regiest:[authData objectForKey:@"id"]
             nikeName:[authData objectForKey:@"name"]
               imgUrl:[authData objectForKey:@"faceImg"]];
    }
}

#pragma mark - network

-(void)Regiest:(NSString*)name nikeName:(NSString*)nikeName imgUrl:(NSString*)imgUrl
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:S_URL]];
    [request setDelegate:self];
    [request setUsername:@"RegiestOtherCount"];
    [request setPostValue:@"RegiestOtherCount" forKey:@"action"];
    
    [request setPostValue:name forKey:@"name"];
    [request setPostValue:nikeName forKey:@"nikeName"];
    [request setPostValue:imgUrl forKey:@"userImg"];
    [request startAsynchronous];
    
}

#pragma mark - NETWORK Delegate
- (void) requestFinished:(ASIHTTPRequest *)request {
    
    NSString *pString = [NSString stringWithString:[request responseString]];
    NSLog(@"Response finish:%@",pString);
    pString = [AppDelegate getClearContext:pString];
   NSDictionary *pContent = [pString objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    if ([[pContent objectForKey:@"userInfo"] isKindOfClass:[NSDictionary class]]) {
        [[NSUserDefaults standardUserDefaults] setObject:[[pContent objectForKey:@"userInfo"] objectForKey:@"ID"] forKey:@"userID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [RootViewController   ReloadAllData];
    }

    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.navigationController popViewControllerAnimated:YES];
    [delegate.pRootViewCon RefrshDataWithUserInfoType:nil];
}
- (void) requestFailed:(ASIHTTPRequest *)request {
    //NSString *responseString = [request responseString];
    NSLog(@"Response Fail %d : %@", request.responseStatusCode, [request responseString]);
    

}

@end
