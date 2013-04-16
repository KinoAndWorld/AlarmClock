//
//  RegiestView.m
//  AlarmClock
//
//  Created by user on 4/16/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "RegiestView.h"
#import "Config.h"

@interface RegiestView ()

@end

@implementation RegiestView

@synthesize ScrollView ,UserName,PassWorld,Email,NikeName,image_UserNameIcon,image_Password,UserNameIndicaor;
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
    
    UIImage*img =[UIImage imageNamed:@"color5.png"];
    [ScrollView setBackgroundColor:[UIColor colorWithPatternImage:img]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 -(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint point = CGPointMake(0,0);
    if (textField.frame.origin.y > 200) {
        point = CGPointMake(0,textField.frame.origin.y - 150);
    }
    ScrollView.contentOffset = point;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.01];
    [UIView setAnimationDelay:0.2];
    [ScrollView setFrame:CGRectMake(ScrollView.frame.origin.x, ScrollView.frame.origin.y, ScrollView.frame.size.width, 200)];
    [UIView commitAnimations];
    
    if (textField == UserName) {
         [image_UserNameIcon setImage:[UIImage imageNamed:@"ui_regiestUeserNameIcon_gray.png"]];
    }

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == UserName) {
        [self ChickUserNameIsOK];
    }
}

-(IBAction)Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)Done:(id)sender
{
  
}

#pragma NETWORK

-(void)ChickUserNameIsOK
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:S_URL]];
    [request setDelegate:self];
    [request setUsername:@"chickUserName"];
    [request setPostValue:@"chickUserName" forKey:@"action"];
    
    [request setPostValue:UserName.text forKey:@"name"];
    [request setPostValue:PassWorld.text forKey:@"pw"];
    [request setPostValue:NikeName.text forKey:@"nikeName"];
    // [request setPostValue:nikeName.text forKey:@"phoneNum"];
    [request startAsynchronous];
    [UserNameIndicaor    startAnimating];
}
-(void)ChickUserNameIsOKResult:(int)isOK
{
    [UserNameIndicaor    stopAnimating];
    if (isOK == 1) {
        [image_UserNameIcon setImage:[UIImage imageNamed:@"ui_regiestUeserNameIcon_green.png"]];
    }
    else {
        [image_UserNameIcon setImage:[UIImage imageNamed:@"ui_regiestUeserNameIcon_red.png"]];
    }
}
-(void)requestStart:(ASIFormDataRequest*)request
{
    
}
-(void)Regiest
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:S_URL]];
    [request setDelegate:self];
    [request setUsername:@"regiest"];
    [request setPostValue:@"regiest" forKey:@"action"];
    
    [request setPostValue:UserName.text forKey:@"name"];
    [request startAsynchronous];
}


- (void) requestFinished:(ASIHTTPRequest *)request {
    
    NSString *pString = [NSString stringWithString:[request responseString]];
    NSLog(@"Response finish:%@",pString);
    NSString *pResult = @"log in fail";
    if ([request.username isEqualToString:@"login"]) {
        if ([pString intValue] == 1) {
            pResult = @"log in sucuss";
        }
    }
    else if ([request.username isEqualToString:@"chickUserName"]) {
        [self ChickUserNameIsOKResult:[pString intValue]];return;
    }
    else{
        pResult = @"regiest sucuss";
        if ([pString intValue] != 1) {
            pResult = @"regiest fail";
        }
    }

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"result"
                          
                                                   message:pResult
                          
                                                  delegate:nil
                          
                                         cancelButtonTitle:@"yes"
                          
                                         otherButtonTitles:nil];
    
    [alert show];
    
    [alert release];
}
- (void) requestFailed:(ASIHTTPRequest *)request {
    //NSString *responseString = [request responseString];
    NSLog(@"Response Fail %d : %@", request.responseStatusCode, [request responseString]);
}

@end
