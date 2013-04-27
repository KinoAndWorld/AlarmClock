//
//  ErrorView.m
//  AlarmClock
//
//  Created by user on 4/16/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "ErrorView.h"

@implementation ErrorView
@synthesize ErrorInfo;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)PlayAnimation:(NSString*)errorInfo
{
    [ErrorInfo setText:errorInfo];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.4];
    [self setFrame:CGRectMake(self.frame.origin.x, 45, self.frame.size.width, self.frame.size.height)];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(Back:)];
    [UIView commitAnimations];
    

}
-(void)Back:(id)send
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.4];
     [UIView setAnimationDelay:1];
    [self setFrame:CGRectMake(self.frame.origin.x, 0, self.frame.size.width, self.frame.size.height)];
    [UIView commitAnimations];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
