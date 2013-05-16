//
//  AddClockCon.m
//  AlarmClock
//
//  Created by user on 5/3/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "AddClockCon.h"
#include "CPPickerViewCell.h"
#include "RepeatViewController.h"
#include "Config.h"
#include "ClockManager.h"
#include "AlarmClockViewCon.h"

@interface AddClockCon ()

@end

@implementation AddClockCon
@synthesize settingsStorage,pClockDataDic,ClockCell,pTabelView;
-(IBAction)Cancle :(id)sender
{
     [self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)Done :(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    NSDate * date = [pPick date];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    comps =[calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit)
            
                       fromDate:date];
    NSInteger second = [comps second];
    
    [pClockDataDic setObject:[date dateByAddingTimeInterval:-second] forKey:@"data"];
    NSArray *pDataDic = [[NSUserDefaults standardUserDefaults] objectForKey:UserClock];
    NSLog(@"pDataDic:::%@",pDataDic);
    NSMutableArray *pTempArray = [NSMutableArray arrayWithArray:pDataDic];
    [pTempArray addObject:pClockDataDic];
    NSMutableArray *pTempArray2 = [NSArray arrayWithArray:pTempArray];
    [[NSUserDefaults standardUserDefaults] setObject:pTempArray2 forKey:UserClock];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"%@",pTempArray2);
    
    [ClockCell loadData];
    [ClockCell.pTableView reloadData];
    
    
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
    self.settingsStorage = [NSMutableArray arrayWithObjects:[NSMutableArray arrayWithObject:[NSNumber numberWithInt:0]], [NSMutableArray arrayWithObject:[NSNumber numberWithInt:1]], nil];
    [pPick setDate:[NSDate date] animated:YES];

    
    NSMutableArray *pRepeatArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    NSDate *pData = [pPick date];
    pClockDataDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:pData,@"data",pRepeatArray,@"repeat" ,@"1",@"redioNum",@"1",@"isSleepLittle",@"闹钟",@"tag",@"1",@"isOpen",nil];
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
    return 4;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
        CPPickerViewCell* cell2 = nil;
        cell2 = [[CPPickerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell2.textLabel.text = @"闹铃频道";
        cell2.dataSource = self;
        cell2.delegate = self;
        cell2.currentIndexPath = indexPath;
        cell2.peekInset = UIEdgeInsetsMake(0, 55, 0, 55);
        [cell2 reloadData];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell2 selectItemAtIndex:1 animated:NO];
        return cell2;
    }
    
    UITableViewCell *cell = nil;
    static NSString *CustomCellIdentifier = @"AlarmClockCell";
    cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        //        NSString *NIBName =@"AlarmClockCell";
        //        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:NIBName owner:self options:nil];
        //        cell = [nib objectAtIndex:0];
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CustomCellIdentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    int rightLablePosY = 11;
    int rightLablePosX = 250;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"重复";
        
        for (UILabel *lable in [cell subviews]) {
            if (lable.tag == 123) {
                [lable removeFromSuperview];
                break;
            }
        }
        UILabel *pLable = [[UILabel alloc] initWithFrame:CGRectMake(rightLablePosX-200, rightLablePosY, 230, 25)];
        pLable.textAlignment   = NSTextAlignmentRight;
        pLable.backgroundColor = [UIColor clearColor];
        pLable.textColor = [UIColor redColor];
        pLable.tag = 123;
        [cell addSubview:pLable];
        if (pClockDataDic && [pClockDataDic objectForKey:@"repeat"] &&[[pClockDataDic objectForKey:@"repeat"] isKindOfClass:[NSArray class]]) {
             pLable.text = [AddClockCon getNameForRepeat:[pClockDataDic objectForKey:@"repeat"]];
        }
        else{
             pLable.text = @"永不";
        }
        [pLable release];
    }
    else if (indexPath.row == 2) {
        cell.textLabel.text = @"小睡";
        cell.accessoryType = UITableViewCellAccessoryNone;
        for (UISwitch *lable in [cell subviews]) {
            if (lable.tag == 123) {
                [lable removeFromSuperview];
                break;
            }
        }
        pSwich= [[UISwitch alloc] initWithFrame:CGRectMake(rightLablePosX-30, rightLablePosY, 90, 20)];
        pSwich.tag = 123;
        [cell addSubview:pSwich];
        [pSwich addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [pSwich setOn:YES];
        [pSwich release];
        }
    else if (indexPath.row == 3) {
        cell.textLabel.text = @"标签";
        
        for (UITextField *lable in [cell subviews]) {
            if (lable.tag == 123) {
                [lable removeFromSuperview];
                break;
            }
        }
        
        pTagText= [[UITextField alloc] initWithFrame:CGRectMake(rightLablePosX-185, rightLablePosY, 220, 20)];
        pTagText.delegate = self;
        
         pTagText.backgroundColor = [UIColor clearColor];
        pTagText.textColor = [UIColor redColor];
        pTagText.tag = 123;
        pTagText.textAlignment = NSTextAlignmentRight;
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell addSubview:pTagText];
        pTagText.text =[pClockDataDic objectForKey:@"tag"];
        pTagText.returnKeyType=UIReturnKeyDone;
        [pTagText release];
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)switchAction :(id)sender
{
    if (pSwich.isOn) {
        [pClockDataDic setObject:@"1" forKey:@"isSleepLittle"];
    }
    else{
        [pClockDataDic setObject:@"0" forKey:@"isSleepLittle"];
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Do Nothing
    if (indexPath.row == 0) {
        RepeatViewController *pRrepeatViewCon = [[RepeatViewController alloc] init];
        pRrepeatViewCon.pAddClockCon = self;
        [self.navigationController pushViewController:pRrepeatViewCon animated:YES];
        [pRrepeatViewCon release];
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [pClockDataDic setObject:@"tag" forKey:pTagText.text];
    [pTagText resignFirstResponder];
    return true;
}
#pragma mark - CPPickerViewCell DataSource

- (NSInteger)numberOfItemsInPickerViewAtIndexPath:(NSIndexPath *)pickerPath {
    if (pickerPath.section == 0) {
        return 3;
    }
    
    return 0;
}
- (NSString *)pickerViewAtIndexPath:(NSIndexPath *)pickerPath titleForItem:(NSInteger)item {
    if (pickerPath.section == 0) {
        if (item == 0) {
            return @"公共";
        }
        else if (item == 1 ){
             return @"好友";
        }
        else{
            return @"私人";
        }
    }
    
    return nil;
}

#pragma mark - CPPickerViewCell Delegate

- (void)pickerViewAtIndexPath:(NSIndexPath *)pickerPath didSelectItem:(NSInteger)item {
    [pClockDataDic setObject:[NSString stringWithFormat:@"%d",item] forKey:@"isSleepLittle"];
}

+(NSString*)getNameForRepeat:(NSArray*)Data
{
    NSString *pString = @"";
    bool isWork = false;
    if ([Data[0] isEqual:@"1"] && [Data[1] isEqual:@"1"] && [Data[2] isEqual:@"1"] && [Data[3] isEqual:@"1"] && [Data[4] isEqual:@"1"] && [Data[5] isEqual:@"0"] && [Data[6] isEqual:@"0"]) {
        pString = @"工作日";
    }
    else if([Data[0] isEqual:@"0"] && [Data[1] isEqual:@"0"] && [Data[2] isEqual:@"0"] && [Data[3] isEqual:@"0"] && [Data[4] isEqual:@"0"] && [Data[5] isEqual:@"1"] && [Data[6] isEqual:@"1"])
    {
        pString = @"周末";
    }
    else if([Data[0] isEqual:@"1"] && [Data[1] isEqual:@"1"] && [Data[2] isEqual:@"1"] && [Data[3] isEqual:@"1"] && [Data[4] isEqual:@"1"] && [Data[5] isEqual:@"1"] && [Data[6] isEqual:@"1"]){
        pString = @"每天";
    }
    else if([Data[0] isEqual:@"0"] && [Data[1] isEqual:@"0"] && [Data[2] isEqual:@"0"] && [Data[3] isEqual:@"0"] && [Data[4] isEqual:@"0"] && [Data[5] isEqual:@"0"] && [Data[6] isEqual:@"0"]){
        pString = @"不重复";
    }
    else{
        if ([Data[0] isEqual:@"1"]) {
            pString = [NSString stringWithFormat:@"%@%@",pString,@"星期一"];
             isWork = true;
        }
        if ([Data[1] isEqual:@"1"]) {
            if (isWork) {
                 pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"星期二"];
             isWork = true;
        }
        if ([Data[2] isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"星期三"];
             isWork = true;
        }
        if ([Data[3] isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"星期四"];
             isWork = true;
        }
        if ([Data[4] isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"星期五"];
             isWork = true;
        }
        if ([Data[5] isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"星期六"];
             isWork = true;
        }
        if ([Data[6] isEqual:@"1"]) {
            if (isWork) {
                pString = [NSString stringWithFormat:@"%@%@",pString,@","];
            }
            pString = [NSString stringWithFormat:@"%@%@",pString,@"星期七"];
             isWork = true;
        }
    }
    
    return pString;
}
@end
