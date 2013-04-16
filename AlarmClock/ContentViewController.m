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


@interface ContentViewController ()

@end

@implementation ContentViewController

@synthesize tableView;

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
    
    self.tableView = [[[UITableView alloc] init] autorelease];
    tableView.frame = self.view.bounds;
    tableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.dataSource = self;
    tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"color2.png"]];
    [tableView setBackgroundView:tableBg];
    [tableBg release];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.allowsSelection = NO;
    [self.view addSubview:tableView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Standard TableView delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0) {
        return 170;
    }
    return 65;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 2;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        NSString *NIBName =@"ContentHeadCell";
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:NIBName owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    else {
        NSString *NIBName =@"ContentCell";
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:NIBName owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
@end
