//
//  ViewController.m
//  F45 countdown
//
//  Created by  on 9/9/15.
//  Copyright (c) 2015 . All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@property (strong, nonatomic) AudioController *audioController;
@end

@implementation ViewController
@synthesize counterLbl, beepLabel;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.audioController = [[AudioController alloc] init];
    [self.audioController tryPlayMusic];
    [self performSelector:@selector(updateTime) withObject:nil afterDelay:1];
    [counterLbl setUserInteractionEnabled:YES];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mute_unmute:)];
    longPressGesture.minimumPressDuration = 5;
    [counterLbl addGestureRecognizer:longPressGesture];
    
    mute=true;
    
    switch ((int) self.view.frame.size.height)
    {
        case 568:
        case 480:
            [counterLbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:286]];
            break;
        case 667:
            [counterLbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:320]];
            break;
        case 736:
            [counterLbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:370]];
            break;
        case 1024:
            [counterLbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:680]];
            break;
        default:
            break;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft | toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        NSLog(@"%d",(int) self.view.frame.size.height);
        
        switch ((int) self.view.frame.size.height)
        {
            case 568:
            case 480:
                [counterLbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:380]];
                break;
            case 667:
                [counterLbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:450]];
                break;
            case 736:
                [counterLbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:500]];
                break;
            case 1024:
                [counterLbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:900]];
                break;
            default:
                break;
        }
    }
    else
    {
        NSLog(@"%d",(int) self.view.frame.size.height);
        switch ((int) self.view.frame.size.height)
        {
            case 320:
                [counterLbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:286]];
                break;
            case 375:
                [counterLbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:320]];
                break;
            case 414:
                [counterLbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:370]];
                break;
            case 768:
                [counterLbl setFont:[UIFont fontWithName:@"Helvetica Neue" size:680]];
                break;
            default:
                break;
        }
    }
}

-(void)mute_unmute:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        if (mute == true)
        {
            mute = false;
            [UIView transitionWithView:beepLabel duration:1 options:UIViewAnimationOptionTransitionNone animations:^{
                beepLabel.alpha = 1;
                beepLabel.text = @"Beep OFF";
            } completion:^(BOOL finished) {
                [self performSelector:@selector(hideBeepLabel) withObject:nil afterDelay:2];
            }];
        }
        else
        {
            mute = true;
            [UIView transitionWithView:beepLabel duration:1 options:UIViewAnimationOptionTransitionNone animations:^{
                beepLabel.alpha = 1;
                beepLabel.text = @"Beep ON";
            } completion:^(BOOL finished) {
                [self performSelector:@selector(hideBeepLabel) withObject:nil afterDelay:2];
            }];
        }
    }
}

-(void) hideBeepLabel
{
    [UIView transitionWithView:beepLabel duration:1 options:UIViewAnimationOptionTransitionNone animations:^{
        beepLabel.alpha = 0;
    } completion:^(BOOL finished) {
    }];
}

-(void)updateTime
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:[NSDate date]];
    
    long second = 60 - components.second;
    long secondToShow;
    if (second>15)
    {
        counterLbl.backgroundColor=[UIColor colorWithRed:17/255.0 green:122/255.0 blue:0/255.0 alpha:1];
        secondToShow=second-15;
    }
    else
    {
        counterLbl.backgroundColor=[UIColor redColor];
        secondToShow=second;
    }
    if (secondToShow<10)
    {
        counterLbl.text=[NSString stringWithFormat:@"0%ld", secondToShow];
    }
    else
    {
        counterLbl.text=[NSString stringWithFormat:@"%ld", secondToShow];
    }
    if (secondToShow==1 && mute==true)
    {
        
        [self.audioController playSystemSound];
    }
    [self performSelector:@selector(updateTime) withObject:nil afterDelay:1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
