//
//  InnovationViewController.m
//  F45Sales
//
//  Created by Paras on 9/3/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import "InnovationViewController.h"

@implementation InnovationViewController
@synthesize innovationsView, scrollView, innovationsLabel, attributedTextLabel, playPauseBtnBottomView, playPauseBtn;

-(void) viewDidLoad
{
    self.view.frame = CGRectMake(80, 134, self.view.frame.size.width, self.view.frame.size.height);
    innovationsView.backgroundColor = [Helper colorFromHexString:@"4d5393"];
    [innovationsLabel setFont:[UIFont fontWithName:@"ProximaNova-Semibold" size:55]];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSwipeUp:) name:@"InnovationUp" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSwipeDown:) name:@"InnovationDown" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doneButtonClick:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    
    playPauseBtnBottomView.backgroundColor = [[Helper colorFromHexString:@"1b1c2e"] colorWithAlphaComponent:0.6];
    playPauseBtnBottomView.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    playPauseBtnBottomView.layer.shadowOffset = CGSizeMake(0, 0);
    playPauseBtnBottomView.layer.shadowOpacity = 0.4;
    playPauseBtnBottomView.layer.shadowRadius = 2;
    
    [self initVideo];
}

- (void)viewDidLayoutSubviews {
    scrollView.contentSize = CGSizeMake(949, 3452);
}

#pragma mark notification methods

-(void)doneButtonClick:(NSNotification*)aNotification
{
    [player stop];
    player.view.hidden = YES;
   [[NSNotificationCenter defaultCenter] postNotificationName:@"disableFullScreen" object:nil];
    self.view.frame = originalViewFrame;
}

#pragma mark Helper Methods

-(void) initVideo
{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *movieUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"F45Training" ofType:@"mp4"]];
        player = [[MPMoviePlayerController alloc] initWithContentURL:movieUrl];
        player.view.frame = CGRectMake(0, 0, 1024, 768);
        player.controlStyle = MPMovieControlStyleFullscreen;

        dispatch_async( dispatch_get_main_queue(), ^{
            [self.view addSubview:player.view];
            player.view.hidden = YES;
            player.scalingMode = MPMovieScalingModeAspectFit;
            player.contentURL = movieUrl;
            
            [player setShouldAutoplay:NO];
            [player setCurrentPlaybackTime:10];
            [player prepareToPlay];
        });
    });
}

-(void) handleSwipeUp:(NSNotification *) gesture
{
    [self handleAutoScroll:gesture.object];
}

-(void) handleSwipeDown:(NSNotification *) gesture
{
    [self handleAutoScroll:gesture.object];
}

-(void) handleAutoScroll:(UISwipeGestureRecognizer *) gesture
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ResetInnovationView" object:nil];
    int yValue;
    if (gesture.direction == UISwipeGestureRecognizerDirectionUp)
    {
        yValue = 1366;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SetDot" object:@[@"mainScreenDot.png",@"1",@"whiteDot.png",@"2"]];
        
        if (scrollView.contentOffset.y == 1450)
        {
            [scrollView setContentOffset:CGPointMake(0, 1366) animated:YES];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideCustomNavBar" object:nil];
    }
    else
    {
        yValue = 0;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SetDot" object:@[@"mainScreenDot.png",@"1",@"mainScreenDot.png",@"2"]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SetNumberColor" object:[UIColor whiteColor]];
    }
    
    switch ((int) scrollView.contentOffset.y)
    {
        case 0:
        {
            if (gesture.direction == UISwipeGestureRecognizerDirectionUp)
            {
                [scrollView setContentOffset:CGPointMake(0, 472) animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SetDot" object:@[@"whiteDot.png",@"1",@"mainScreenDot.png",@"2"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SetNumberColor" object:[Helper colorFromHexString:@"5a63af"]];
            }
        }
        case 1450:
        case 1366:
        {
            if (gesture.direction == UISwipeGestureRecognizerDirectionDown)
            {
            [scrollView setContentOffset:CGPointMake(0, 472) animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SetDot" object:@[@"whiteDot.png",@"1",@"mainScreenDot.png",@"2"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SetNumberColor" object:[Helper colorFromHexString:@"5a63af"]];
            }
        }
            break;
        case 472:
        {
            [scrollView setContentOffset:CGPointMake(0, yValue) animated:YES];
        }
            break;
    }
}

- (IBAction)playPauseVideo:(id)sender
{
    player.view.hidden = NO;
    originalViewFrame = self.view.frame;
    self.view.frame = CGRectMake(0, 0, 1024, 768);
    [player play];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playerFullScreen" object:nil];
}
@end
