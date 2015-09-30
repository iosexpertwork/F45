//
//  InvestmentViewController.m
//  F45Sales
//
//  Created by Paras on 9/3/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import "InvestmentViewController.h"

@implementation InvestmentViewController
@synthesize scrollView;

-(void)viewDidLoad
{
    self.view.frame = CGRectMake(80, 134, self.view.frame.size.width, self.view.frame.size.height);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSwipeUp:) name:@"ReturnsUp" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSwipeDown:) name:@"ReturnsDown" object:nil];
}

#pragma mark helper methods

-(void) handleSwipeUp:(NSNotification *) gesture
{
    [self handleAutoScroll:gesture.object];
}

-(void) handleSwipeDown:(NSNotification *) gesture
{
    [self handleAutoScroll:gesture.object];
}

- (void)viewDidLayoutSubviews {
    scrollView.contentSize = CGSizeMake(949, 3452);
}

-(void) handleAutoScroll:(UISwipeGestureRecognizer *) gesture
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"ResetInnovationView" object:nil];
    int yValue;
    if (gesture.direction == UISwipeGestureRecognizerDirectionUp)
    {
        yValue = 1543;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SetDot" object:@[@"mainScreenDot.png",@"1",@"whiteDot.png",@"2"]];
        
        if (scrollView.contentOffset.y == 1626)
        {
            [scrollView setContentOffset:CGPointMake(0, 1543) animated:YES];
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
                [scrollView setContentOffset:CGPointMake(0, 755) animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SetDot" object:@[@"whiteDot.png",@"1",@"mainScreenDot.png",@"2"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SetNumberColor" object:[Helper colorFromHexString:@"5a63af"]];
            }
        }
        case 1543:
        case 1626:
        {
            if (gesture.direction == UISwipeGestureRecognizerDirectionDown)
            {
                [scrollView setContentOffset:CGPointMake(0, 755) animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SetDot" object:@[@"whiteDot.png",@"1",@"mainScreenDot.png",@"2"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SetNumberColor" object:[Helper colorFromHexString:@"5a63af"]];
            }
        }
            break;
        case 755:
        {
            [scrollView setContentOffset:CGPointMake(0, yValue) animated:YES];
        }
            break;
    }
}


@end
