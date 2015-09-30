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

-(void)viewWillDisappear:(BOOL)animated
{
    [player stop];
}

-(void) viewDidLoad
{
    self.view.frame = CGRectMake(80, 134, self.view.frame.size.width, self.view.frame.size.height);
    innovationsView.backgroundColor = [Helper colorFromHexString:@"4d5393"];
    [innovationsLabel setFont:[UIFont fontWithName:@"ProximaNova-Semibold" size:55]];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [scrollView addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [scrollView addGestureRecognizer:swipeDown];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopVideo) name:@"StopVideo" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fitVideo) name:@"FitVideo" object:nil];
    
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

#pragma mark Helper Methods

-(void) fitVideo
{
    if (scrollView.contentOffset.y == 1366)
    {
        [scrollView setContentOffset:CGPointMake(0, 1450) animated:YES];
    }
}

-(void) stopVideo
{
    [playPauseBtn setImage:[UIImage imageNamed:@"playBtnImage.png"] forState:UIControlStateNormal];
    playPauseBtn.tag = 13;
    [player stop];
    [scrollView setContentOffset:CGPointMake(0, 0)];
}

-(void) initVideo
{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *movieUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"F45Training" ofType:@"mp4"]];
        player = [[MPMoviePlayerController alloc] initWithContentURL:movieUrl];
        player.view.frame = CGRectMake(0, 1366, 949, 719);
        player.controlStyle = MPMovieControlStyleNone;
        
        
        dispatch_async( dispatch_get_main_queue(), ^{
            [scrollView insertSubview:player.view belowSubview:playPauseBtnBottomView];
            player.scalingMode = MPMovieScalingModeAspectFit;
            player.contentURL = movieUrl;
            
            [player setShouldAutoplay:NO];
            [player setCurrentPlaybackTime:10];
            [player prepareToPlay];
        });
    });
}

-(void) handleSwipeUp:(UISwipeGestureRecognizer *) gesture
{
    [self handleAutoScroll:gesture];
}

-(void) handleSwipeDown:(UISwipeGestureRecognizer *) gesture
{
    [player pause];
    [playPauseBtn setImage:[UIImage imageNamed:@"playBtnImage.png"] forState:UIControlStateNormal];
    playPauseBtn.tag = 13;
    [self handleAutoScroll:gesture];
}

-(void) handleAutoScroll:(UISwipeGestureRecognizer *) gesture
{
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
    UIButton *button = (UIButton *) sender;
    
    if (button.tag == 13)
    {
        [player play];
        [button setImage:[UIImage imageNamed:@"pauseBtnImage.png"] forState:UIControlStateNormal];
        button.tag = 12;
    }
    else
    {
        [player pause];
        [button setImage:[UIImage imageNamed:@"playBtnImage.png"] forState:UIControlStateNormal];
        button.tag = 13;
    }
}
@end
