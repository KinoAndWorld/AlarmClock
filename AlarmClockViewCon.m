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
@interface AlarmClockViewCon ()

@end

@implementation AlarmClockViewCon

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
    self.navigationController.navigationBar.hidden = YES;
    [super viewDidLoad];
    pTableView.allowsSelection = NO;
    pTableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
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
}
- (IBAction)tableViewEdit:(id)sender{
    [pTableView setEditing:!pTableView.editing animated:YES];
}
-(IBAction)AddClock:(id)sender{
    AddClockCon *pAddView = [[AddClockCon alloc] initWithNibName:@"AddClockCon" bundle:nil];
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
    return 3;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlarmClockCell *cell = nil;
    static NSString *CustomCellIdentifier = @"AlarmClockCell";
    cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
//        NSString *NIBName =@"AlarmClockCell";
//        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:NIBName owner:self options:nil];
//        cell = [nib objectAtIndex:0];
    
        cell = [[[AlarmClockCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CustomCellIdentifier] autorelease];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
