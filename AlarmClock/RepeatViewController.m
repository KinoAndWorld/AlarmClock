//
//  RepeatViewController.m
//  AlarmClock
//
//  Created by user on 5/5/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "RepeatViewController.h"
#import "AddClockCon.h"
@interface RepeatViewController ()

@end

@implementation RepeatViewController
@synthesize pAddClockCon;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)Done :(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [pAddClockCon.pTabelView reloadData ];
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
#pragma mark - Standard TableView delegates
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    return 90;
//
//}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    UITableViewCell *cell = nil;
    static NSString *CustomCellIdentifier = @"AlarmClockCell";
    cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        //        NSString *NIBName =@"AlarmClockCell";
        //        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:NIBName owner:self options:nil];
        //        cell = [nib objectAtIndex:0];
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CustomCellIdentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"星期一";
            break;
        case 1:
            cell.textLabel.text = @"星期二";
            break;
        case 2:
            cell.textLabel.text = @"星期三";
            break;
        case 3:
            cell.textLabel.text = @"星期四";
            break;
        case 4:
            cell.textLabel.text = @"星期五";
            break;
        case 5:
            cell.textLabel.text = @"星期六";
            break;
        case 6:
            cell.textLabel.text = @"星期日";
            break;
            
        default:
            break;
    }
     if ([[[pAddClockCon.pClockDataDic objectForKey:@"repeat"] objectAtIndex:indexPath.row] isEqual:@"0"]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
     }
     else{
         cell.accessoryType = UITableViewCellAccessoryCheckmark;
     }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *pAr = [NSMutableArray arrayWithArray:[pAddClockCon.pClockDataDic objectForKey:@"repeat"]];
    if ([[pAr objectAtIndex:indexPath.row] isEqual:@"0"]) {
        [pAr setObject:@"1" atIndexedSubscript:indexPath.row];
    }
    else{
        [pAr setObject:@"0" atIndexedSubscript:indexPath.row];
    }
    [pAddClockCon.pClockDataDic setObject:pAr forKey:@"repeat"];
    [pTabelView reloadData];
}

@end
