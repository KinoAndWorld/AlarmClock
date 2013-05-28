//
//  AddFriendViewController.m
//  AlarmClock
//
//  Created by user on 5/25/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "AddFriendViewController.h"
#import "ContentCell2.h"
#include "Config.h"
#import "AppDelegate.h"
@interface AddFriendViewController ()

@end

@implementation AddFriendViewController

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
    pTextArray1 = [NSArray arrayWithObjects:@"通信录",@"新浪微博",@"腾讯微博",@"人人网",@"短信邀请好友",@"微信邀请好友", nil];
    [pTextArray1 retain];
    pTextArray = [NSArray arrayWithObjects:@"从你的联系人列表寻找",@"从你的新浪微博好友列表寻找",@"从你的腾讯微博好友列表寻找",@"从你的人人网友列表寻找",@"用短信邀请好友",@"从你的微信好友列表寻找", nil];
    [pTextArray retain];
    // Do any additional setup after loading the view from its nib.
    
    [self refreshView];
    queue = [[ASINetworkQueue alloc] init];
    [queue go];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Done :(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Standard TableView delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0) {
        return 50;
    }
    else if(indexPath.row == 7){
        return 18;
    }
    return 65;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pContentArr count] + 8;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;

    static NSString *CustomCellIdentifier = @"Add";
    
   // cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CustomCellIdentifier] autorelease];
    }
    
    if(indexPath.row == 0) {
        UISearchBar *pBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        [cell addSubview:pBar];
        [pBar setTintColor:[UIColor lightGrayColor]];
        [pBar release];
    }
    else if (indexPath.row > 0 && indexPath.row < 7) {
        UIImage *pimage = [UIImage imageNamed:[NSString stringWithFormat:@"ui_addFriend%d",indexPath.row]];
        UIImageView *pView = [[[UIImageView alloc] initWithImage:pimage] autorelease];
        pView.frame = CGRectMake(10, 15, 36, 36);
        [cell addSubview:pView];
        
        UILabel *pTitle = [[[UILabel alloc] initWithFrame:CGRectMake(60, 15, 200, 20)] autorelease];
        pTitle.text = [pTextArray1 objectAtIndex:indexPath.row-1];
        [cell addSubview:pTitle];
        
        UILabel *pTitle2 = [[[UILabel alloc] initWithFrame:CGRectMake(60, 37, 200, 20)]
                            autorelease];
        pTitle2.text = [pTextArray objectAtIndex:indexPath.row-1];
        pTitle2.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:10];
        pTitle2.textColor = [UIColor grayColor];
        [cell addSubview:pTitle2];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone; 
    }
    else if(indexPath.row == 7){
        UIView *pview = [[UIView alloc] init];
        pview.backgroundColor = [UIColor lightGrayColor];
        cell.backgroundView = pview;
        
        UILabel *pTitle = [[[UILabel alloc] initWithFrame:CGRectMake(7, 2, 200, 15)] autorelease];
        pTitle.text = @"公共频道";
        pTitle.textColor= [UIColor whiteColor];
        pTitle.backgroundColor = [UIColor clearColor];
        pTitle.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:10];
        [cell addSubview:pTitle];
    }
    else {
        static NSString *CustomCellIdentifier = @"ContentCell2";
        //cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
        //if (cell == nil) {
            NSString *NIBName =@"ContentCell2";
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:NIBName owner:self options:nil];
            cell = [nib objectAtIndex:0];
       // }
        int indexOff = 8;
        [((ContentCell2*)cell).Text setText:[[pContentArr objectAtIndex:indexPath.row - indexOff] objectForKey:@"nikeName"]];
        [((ContentCell2*)cell).FriendNum setText:[NSString stringWithFormat:@"%@",[[pContentArr objectAtIndex:indexPath.row - indexOff] objectForKey:@"friendNum"]] ];
        
        if ([[pContentArr objectAtIndex:indexPath.row - indexOff] objectForKey:@"userImg"] != nil && [[[pContentArr objectAtIndex:indexPath.row - indexOff] objectForKey:@"userImg"] length] > 0) {
            ((ContentCell2*)cell).picView.imageUrl = [[pContentArr objectAtIndex:indexPath.row - indexOff] objectForKey:@"userImg"];
        }
        else{
            ((ContentCell2*)cell).picView.imageUrl = [NSString stringWithFormat:@"%@/userPic/%@.png",IMAGE_URL,[[pContentArr objectAtIndex:indexPath.row - indexOff] objectForKey:@"name"]];
        }
        if ([pSoundContentArr containsObject:[pContentArr objectAtIndex:indexPath.row - indexOff]]) {
            ((ContentCell2*)cell).PlaySoundButton.hidden = NO;
        }
        ((ContentCell2*)cell).ID = [[pContentArr objectAtIndex:indexPath.row - indexOff] objectForKey:@"ID"];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return;
    }
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
    [pTable reloadData];
}
- (void) requestFailed:(ASIHTTPRequest *)request {
    //NSString *responseString = [request responseString];
    NSLog(@"Response Fail %d : %@", request.responseStatusCode, [request responseString]);
    
}

@end

