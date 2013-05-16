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
#include "EditClockViewController.h"
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
    if (pDataDic) {
        [pDataDic release];
        pDataDic = nil;
    }
    pDataDic = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:UserClock]];
    [pDataDic retain];
}
- (void)viewDidLoad
{
    self.navigationController.navigationBar.hidden = YES;
    [super viewDidLoad];
    pTableView.allowsSelection = NO;
    pTableView.allowsSelectionDuringEditing = YES;
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
    //pTableView.allowsSelection = !pTableView.editing;
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
    if (indexPath.row == 0) {
        return 40;
    }
    return 90;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pDataDic count] + 1;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.row == 0) {
         UITableViewCell *cell = nil;
         static NSString *CustomCellIdentifier = @"addClock";
         cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
         if (cell == nil) {
             //        NSString *NIBName =@"AlarmClockCell";
             //        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:NIBName owner:self options:nil];
             //        cell = [nib objectAtIndex:0];
             
             cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CustomCellIdentifier] autorelease];
         }
         cell.backgroundColor = [UIColor clearColor];
         
         UIButton *pButton = [UIButton buttonWithType:UIButtonTypeCustom];
         [pButton setBackgroundImage:[UIImage imageNamed:@"ui_addButton.png"] forState:UIControlStateNormal];
         [cell addSubview:pButton];
         [pButton addTarget:self action:@selector(AddClock:) forControlEvents:UIControlEventTouchUpInside];
         pButton.frame = CGRectMake(60, 5, 200, 30);
         return cell;
     }
    AlarmClockCell *cell = nil;
    static NSString *CustomCellIdentifier = @"AlarmClockCell";
    cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        cell = [[[AlarmClockCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CustomCellIdentifier] autorelease];
        cell.ClockInfo = [pDataDic objectAtIndex:indexPath.row - 1];
        [cell UpdataData];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.row == 0) {
        return  NO;
    }
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [pDataDic removeObjectAtIndex:indexPath.row - 1];
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:pDataDic] forKey:UserClock];
        [self.pTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   // 
}
//当 tableview 为 editing 时,左侧按钮的 style
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    if (row == 0)
        return nil;
    
    return indexPath;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"fdsafdsafas");
    
    EditClockViewController *pAddView = [[EditClockViewController alloc] initWithNibName:@"AddClockCon" bundle:nil];
    pAddView.ClockCell = self;
    pAddView.indexInArray = indexPath.row - 1;
    [self.navigationController pushViewController:pAddView animated:YES];
    [pAddView release];
}
@end
