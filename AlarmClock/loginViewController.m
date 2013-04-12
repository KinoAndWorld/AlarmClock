//
//  loginViewController.m
//  AlarmClock
//
//  Created by user on 4/8/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController

@synthesize name,password,name2,password2,nikeName;

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

-(IBAction)login:(id)sender
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:@"http://localhost/~user/AlarmClock/User/Login.php"]];
    [request setDelegate:self];
    [request setUsername:@"login"];

    [request setPostValue:name.text forKey:@"name"];
    [request setPostValue:password.text forKey:@"pw"];
    
    [request startAsynchronous];
}
-(IBAction)regiest:(id)sender
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:@"http://localhost/~user/AlarmClock/User/Regiest.php"]];
    [request setDelegate:self];
    [request setUsername:@"regiest"];
    
    [request setPostValue:name2.text forKey:@"name"];
    [request setPostValue:password2.text forKey:@"pw"];
    [request setPostValue:nikeName.text forKey:@"nikeName"];
   // [request setPostValue:nikeName.text forKey:@"phoneNum"];
    [request startAsynchronous];
}
-(IBAction)selectPic:(id)sender
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:@"http://localhost/~user/AlarmClock/User/UploadUserPic.php"]];
    [request setDelegate:self];
    [request setUsername:@"regiest"];
    NSString* path =  [[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"];
    NSString* picName = [NSString stringWithFormat:@"%@.png" ,name2.text];
    [request setFile:path withFileName:picName andContentType:@"image/png" forKey:@"userPic"];
    [request startAsynchronous];
}
-(IBAction)uploadMusic:(id)sender
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:@"http://localhost/~user/AlarmClock/User/UploadUserMusic.php"]];
    [request setDelegate:self];
    [request setUsername:@"regiest"];
    NSString* path =  [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp3"];
    NSString* picName = [NSString stringWithFormat:@"%@.mp3" ,name2.text];
    [request setFile:path withFileName:picName andContentType:@"audio/mpeg" forKey:@"userMusic"];
    [request startAsynchronous];

}
-(IBAction)downloadMusic:(id)sender
{
    NSString * path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    path=[path stringByAppendingPathComponent : @"plsqldev714.mp3" ];
    
    NSURL *url = [ NSURL URLWithString : @"http://localhost/~user/AlarmClock/User/userMusic/fdaf.mp3" ];
    
    ASIHTTPRequest *request = [ ASIHTTPRequest requestWithURL :url];
    
    [request setDownloadDestinationPath :path];
    [request setDelegate:self];
    [request startSynchronous ];
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
    [loginViewController ShowDocFiles];
}

+(void)ShowDocFiles
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //在这里获取应用程序Documents文件夹里的文件及文件夹列表
    // NSSearchPathDirectory * dir = [];
    
    // NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSAllLibrariesDirectory, NSAllDomainsMask, YES);
    NSString *documentDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSError *error = nil;
    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    fileList = [fileManager contentsOfDirectoryAtPath:documentDir error:&error];
    NSLog(@"documentDir:%@",documentDir);
    
    NSMutableArray *dirArray = [[NSMutableArray alloc] init];
    BOOL isDir = NO;
    //在上面那段程序中获得的fileList中列出文件夹名
    for (NSString *file in fileList) {
        NSString *path = [documentDir stringByAppendingPathComponent:file];
        [fileManager fileExistsAtPath:path isDirectory:(&isDir)];
        if (isDir) {
            [dirArray addObject:file];
        }
        isDir = NO;
    }
    NSLog(@"Every Thing in the dir:%@",fileList);
    NSLog(@"All folders:%@",dirArray);
}

@end
