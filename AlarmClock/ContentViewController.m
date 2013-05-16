//
//  ContentViewController.m
//  AlarmClock
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "ContentViewController.h"
#import "ContentHeadCell.h"
#import "ContentCell.h"
#import "loginViewController.h"
#import "Config.h"
#import "AppDelegate.h"
#import "ContentHeadCell_logIn.h"
#import "EMAsyncImageView.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

@synthesize tableView,pSoundContentArr;
-(void)RefrshDataWithUserInfoType :(NSString*) userType
{
    [tableView reloadData];
}
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
    pSoundContentArr = [[NSMutableArray alloc] initWithCapacity:20];
    pContentArr = [[NSMutableArray alloc] initWithCapacity:20];
    
    self.tableView = [[[UITableView alloc] init] autorelease];
    tableView.frame = self.view.bounds;
    tableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.dataSource = self;
    tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"color2.png"]];
    [tableView setBackgroundView:tableBg];
    [tableBg release];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   // tableView.allowsSelection = NO;
    [self.view addSubview:tableView];
    
    [self refreshView];
    // Do any additional setup after loading the view from its nib.
    
    queue = [[ASINetworkQueue alloc] init];
    [queue go];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) refreshView{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString:S_URL]];
    [request setDelegate:self];
    [request setUsername:@"getList"];
    [request setPostValue:@"getList" forKey:@"action"];
    [request setPostValue:@"0" forKey:@"row"];
    [request startAsynchronous];
}
-(void) getUserAudio:(NSArray*)DataArray;
{
    for (int i = 0; i<[DataArray count]; i++) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/userAudio/%@.mp3",IMAGE_URL,[[DataArray objectAtIndex:i] objectForKey:@"name"]]];
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *downloadPath = [[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3",[[DataArray objectAtIndex:i] objectForKey:@"name"]]] retain];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setUsername:[[DataArray objectAtIndex:i] objectForKey:@"name"]];
        request.delegate = self;
         [request setDidReceiveResponseHeadersSelector:@selector(didReceiveResponseHeaders:)];
        [request setDownloadDestinationPath:downloadPath];
       
        [queue addOperation:request];
    }
}
;
- (void)didReceiveResponseHeaders:(ASIHTTPRequest *)request
{
    NSLog(@"didReceiveResponseHeaders %@",[request.responseHeaders valueForKey:@"Content-Length"]);
}
#pragma mark - NETWORK Delegate
- (void) requestFinished:(ASIHTTPRequest *)request {

    if ([request.username isEqualToString:@"getList"]) {
        //@todo
        NSString *pString = [NSString stringWithString:[request responseString]];
        NSLog(@"Response finish:%@",pString);
        pString = [AppDelegate getClearContext:pString];
        NSDictionary *pContent = [pString objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
        [pContentArr removeAllObjects];
        [pContentArr addObjectsFromArray:[pContent objectForKey:@"list"]];
        [self getUserAudio:[pContent objectForKey:@"list"]];
    }
    else
    {
        NSLog(@"request.username:%@",request.username);
       // [pSoundContentArr addObject:request.username];
        for (int i = 0; i < [pContentArr count]; i++) {
            NSDictionary *pDic =  [pContentArr objectAtIndex:i];
            if ([[pDic objectForKey:@"name"] isEqual:request.username]) {
                [pSoundContentArr addObject:pDic];
            }
        }
    }
    [tableView reloadData];
}
- (void) requestFailed:(ASIHTTPRequest *)request {
    //NSString *responseString = [request responseString];
    NSLog(@"Response Fail %d : %@", request.responseStatusCode, [request responseString]);

}



#pragma mark - Standard TableView delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0) {
        return 170;
    }
    return 80;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pContentArr count] + 1;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:UserInfoData]);
        if ([[NSUserDefaults standardUserDefaults] objectForKey:UserInfoData]
            &&[[[NSUserDefaults standardUserDefaults] objectForKey:UserInfoData] objectForKey:@"status"]
            && [[[[NSUserDefaults standardUserDefaults] objectForKey:UserInfoData] objectForKey:@"status"] isEqualToString:logInTag]) {
            // chick user is login
            static NSString *CustomCellIdentifier = @"ContentHeadCell_logIn";
            cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
            if (cell == nil) {
                NSString *NIBName =@"ContentHeadCell_logIn";
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:NIBName owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            NSDictionary *pUserData = [RootViewController getUserData];
            if (pUserData && [pUserData objectForKey:@"faceImg"]) {
                ((ContentHeadCell_logIn*)cell).UserImg.imageUrl = [pUserData objectForKey:@"faceImg"];
                ((ContentHeadCell_logIn*)cell).name.text = [pUserData objectForKey:@"name"];
            }

        }
        else{
            static NSString *CustomCellIdentifier = @"ContentHeadCell";
            cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
            if (cell == nil) {
            NSString *NIBName =@"ContentHeadCell";
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:NIBName owner:self options:nil];
            cell = [nib objectAtIndex:0];
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
        static NSString *CustomCellIdentifier = @"ContentCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
        if (cell == nil) {
            NSString *NIBName =@"ContentCell";
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:NIBName owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
   
        [((ContentCell*)cell).Text setText:[[pContentArr objectAtIndex:indexPath.row - 1] objectForKey:@"nikeName"]];
        
        if ([[pContentArr objectAtIndex:indexPath.row - 1] objectForKey:@"userImg"] != nil && [[[pContentArr objectAtIndex:indexPath.row - 1] objectForKey:@"userImg"] length] > 0) {
             ((ContentCell*)cell).picView.imageUrl = [[pContentArr objectAtIndex:indexPath.row - 1] objectForKey:@"userImg"];
        }
        else{
            ((ContentCell*)cell).picView.imageUrl = [NSString stringWithFormat:@"%@/userPic/%@.png",IMAGE_URL,[[pContentArr objectAtIndex:indexPath.row - 1] objectForKey:@"name"]];
        }
        if ([pSoundContentArr containsObject:[pContentArr objectAtIndex:indexPath.row - 1]]) {
            ((ContentCell*)cell).PlaySoundButton.hidden = NO;
        }
        ((ContentCell*)cell).ID = [[pContentArr objectAtIndex:indexPath.row - 1] objectForKey:@"ID"];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return;
    }
    if (player) {
        if ([player isPlaying]) {
            [player stop];
            NSLog(@"播放停止");
        }
    }
    [self Playsound:[[pContentArr objectAtIndex:indexPath.row - 1] objectForKey:@"name"]];
}

-(void)Playsound:(NSString*)name
{
    NSString *cafFilePath = [NSString stringWithFormat:@"%@/%@.mp3",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],name];
    //NSLog(@"cafFilePath:%@",cafFilePath);
    NSFileManager *file_manager = [NSFileManager defaultManager];
    NSDictionary *p = [file_manager  attributesOfItemAtPath:cafFilePath error:nil];
     //NSLog(@"file:%@",p);
    NSError *playerError;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[[[NSURL alloc] initFileURLWithPath:cafFilePath] autorelease] error:&playerError];
    player = audioPlayer;
    player.volume = 100.0f;
    if (player == nil)
    {
        NSLog(@"ERror creating player: %@", [playerError description]);
    }
    player.delegate = self;
  //  [audioPlayer release];
    [player play];
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
     NSLog(@" player over: %d", (int)flag);
}
@end
