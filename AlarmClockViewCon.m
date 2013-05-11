//
//  AlarmClockViewCon.m
//  AlarmClock
//
//  Created by user on 5/2/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "AlarmClockViewCon.h"
#import "AlarmClockCell.h"
#import "AddClockCon.h"
#import "Config.h"
#include "AppDelegate.h"
#import "RootViewController.h"
@interface AlarmClockViewCon ()

@end

@implementation AlarmClockViewCon
@synthesize pTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadData
{
    pDataDic = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:UserClock]];
    [pDataDic retain];
}
- (void)viewDidLoad
{
    self.navigationController.navigationBar.hidden = YES;
    [super viewDidLoad];
    pTableView.allowsSelection = NO;
    pTableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self loadData];
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)Done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [((AppDelegate*)[UIApplication sharedApplication].delegate).pRootViewCon UpdataClockText];
}
- (IBAction)tableViewEdit:(id)sender{
    [pTableView setEditing:!pTableView.editing animated:YES];
}
-(IBAction)AddClock:(id)sender{
    AddClockCon *pAddView = [[AddClockCon alloc] initWithNibName:@"AddClockCon" bundle:nil];
    pAddView.ClockCell = self;
    [self.navigationController pushViewController:pAddView animated:YES];
    [pAddView release];
}
#pragma mark - Standard TableView delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 90;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pDataDic count];
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlarmClockCell *cell = nil;
    static NSString *CustomCellIdentifier = @"AlarmClockCell";
    cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        cell = [[[AlarmClockCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CustomCellIdentifier] autorelease];
        cell.ClockInfo = [pDataDic objectAtIndex:indexPath.row];
        [cell UpdataData];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [pDataDic removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:pDataDic] forKey:UserClock];
        [self.pTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   // 
}
//当 tableview 为 editing 时,左侧按钮的 style
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        
        return @"测试捏";
    }
    return @"删除";
}

@end
