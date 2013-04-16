//
//  RootViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 2/20/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"
#import "ContentViewController.h"

@implementation RootViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = true;
    
    ContentViewController *pPublicContentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    [self.view addSubview:pPublicContentViewController.view];
    [self.view sendSubviewToBack:pPublicContentViewController.view];
    [pPublicContentViewController.view setFrame:CGRectMake(0, 44, pPublicContentViewController.view.frame.size.width, pPublicContentViewController.view.frame.size.height)];
}


#pragma mark -
#pragma mark Rotation

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
