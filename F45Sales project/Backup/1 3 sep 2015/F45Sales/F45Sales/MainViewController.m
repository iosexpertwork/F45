//
//  MainViewController.m
//  F45Sales
//
//  Created by Paras on 9/2/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import "MainViewController.h"
#import "Helper.h"

@implementation MainViewController
@synthesize topNavigatonBar, serviceBtn, invetmentBtn, supportBtn, navigationBottomBar, firstBtn, secondBtn, thirdBtn, firstHighlight, secondHightlight , thirdHighlight, sideBar, CategoryBtn, dotTopLabel, upperDot, middleDot, sideBarElementsView;

-(void)viewDidLoad
{
    topNavigatonBar.backgroundColor = [Helper colorFromHexString:@"272b5b"];
    serviceBtn.backgroundColor = [Helper colorFromHexString:@"e62828"];
    [invetmentBtn setTitleColor:[Helper colorFromHexString:@"6972c9"] forState:UIControlStateNormal];
    [supportBtn setTitleColor:[Helper colorFromHexString:@"6972c9"] forState:UIControlStateNormal];
    navigationBottomBar.backgroundColor = [Helper colorFromHexString:@"f2f2f2"];
    
    [firstBtn setTitleColor:[Helper colorFromHexString:@"272b5b"] forState:UIControlStateNormal];
    [secondBtn setTitleColor:[Helper colorFromHexString:@"6e73a6"] forState:UIControlStateNormal];
    [thirdBtn setTitleColor:[Helper colorFromHexString:@"6e73a6"] forState:UIControlStateNormal];
    
    [firstHighlight setBackgroundColor:[Helper colorFromHexString:@"1b72d5"]];
    [secondHightlight setBackgroundColor:[UIColor clearColor]];
    [thirdHighlight setBackgroundColor:[UIColor clearColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismisView) name:@"DismissMenuView" object:nil];
    sideBar.backgroundColor = [Helper colorFromHexString:@"1c2848"];
    CategoryBtn.backgroundColor = [Helper colorFromHexString:@"e62828"];
    CategoryBtn.hidden = YES;
    
    innovationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"innovationView"];
    [self.view addSubview:innovationViewController.view];
    [self addChildViewController:innovationViewController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setDot:) name:@"SetDot" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNumberColor:) name:@"SetNumberColor" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideNavBar) name:@"hideCustomNavBar" object:nil];
    motivationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"motivationView"];
    [self.view addSubview:motivationViewController.view];
    [self addChildViewController:motivationViewController];
    motivationViewController.view.hidden = YES;

    sideBarElementsView.backgroundColor = sideBar.backgroundColor;
}

#pragma mark Status Bar Method

-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark Notification Methods

-(void) hideNavBar
{

            [UIView transitionWithView:topNavigatonBar duration:0.4 options:UIViewAnimationOptionTransitionNone animations:^{
                CategoryBtn.hidden = NO;
                NSLog(@"UP");
                switch (currentlySelectedCategory)
                {
                    case 0:
                        [CategoryBtn setImage:[UIImage imageNamed:@"serviceIconWhite.png"] forState:UIControlStateNormal];
                        break;
                    case 1:
                        [CategoryBtn setImage:[UIImage imageNamed:@"investmentIcon.png"] forState:UIControlStateNormal];
                        break;
                    case 2:
                        [CategoryBtn setImage:[UIImage imageNamed:@"supportIcon.png"] forState:UIControlStateNormal];
                        break;
                    default:
                        break;
                }
                topNavigatonBar.frame = CGRectMake(0, -topNavigatonBar.frame.size.height, topNavigatonBar.frame.size.width, topNavigatonBar.frame.size.height);
                navigationBottomBar.frame = CGRectMake(0, 0, navigationBottomBar.frame.size.width, navigationBottomBar.frame.size.height);
                sideBar.frame = CGRectMake(0, navigationBottomBar.frame.origin.y+navigationBottomBar.frame.size.height, sideBar.frame.size.width, sideBar.frame.size.height);
                innovationViewController.view.frame = CGRectMake(80, navigationBottomBar.frame.origin.y+navigationBottomBar.frame.size.height, innovationViewController.view.frame.size.width, innovationViewController.view.frame.size.height);
                sideBarElementsView.frame = CGRectMake(sideBarElementsView.frame.origin.x, 51+100, sideBarElementsView.frame.size.width, sideBarElementsView.frame.size.height);
            } completion:^(BOOL finished) {
                
            }];
}

-(void) setNumberColor:(NSNotification *) notification
{
    [dotTopLabel setTextColor:notification.object];
}

-(void) setDot:(NSNotification *) notification
{
    NSArray *dotsData = notification.object;
    
    for (int i=0 ; i < dotsData.count ; i = i+2)
    {
        switch ([[dotsData objectAtIndex:i+1] integerValue])
        {
            case 1:
                [upperDot setImage:[UIImage imageNamed:[dotsData objectAtIndex:i]]];
                break;
            case 2:
                [middleDot setImage:[UIImage imageNamed:[dotsData objectAtIndex:i]]];
                break;
            default:
                break;
        }
    }
}

#pragma mark Button Actions

- (IBAction)showNavigationView:(id)sender
{
    CategoryBtn.hidden = YES;
    [UIView transitionWithView:topNavigatonBar duration:0.4 options:UIViewAnimationOptionTransitionNone animations:^{
        topNavigatonBar.frame = CGRectMake(0, 0, topNavigatonBar.frame.size.width, topNavigatonBar.frame.size.height);
        navigationBottomBar.frame = CGRectMake(0, topNavigatonBar.frame.origin.y+topNavigatonBar.frame.size.height, navigationBottomBar.frame.size.width, navigationBottomBar.frame.size.height);
        sideBar.frame = CGRectMake(0, navigationBottomBar.frame.origin.y+navigationBottomBar.frame.size.height, sideBar.frame.size.width, sideBar.frame.size.height);
        innovationViewController.view.frame = CGRectMake(80, navigationBottomBar.frame.origin.y+navigationBottomBar.frame.size.height, innovationViewController.view.frame.size.width, innovationViewController.view.frame.size.height);
        sideBarElementsView.frame = CGRectMake(sideBarElementsView.frame.origin.x, 51, sideBarElementsView.frame.size.width, sideBarElementsView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FitVideo" object:nil];
}

- (IBAction)services:(id)sender
{
    currentlySelectedCategory = 0;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    serviceBtn.backgroundColor = [Helper colorFromHexString:@"e62828"];
    invetmentBtn.backgroundColor = [UIColor clearColor];
    supportBtn.backgroundColor = [UIColor clearColor];
    
    [invetmentBtn setTitleColor:[Helper colorFromHexString:@"6972c9"] forState:UIControlStateNormal];
    [supportBtn setTitleColor:[Helper colorFromHexString:@"6972c9"] forState:UIControlStateNormal];
    [serviceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [supportBtn setImage:[UIImage imageNamed:@"supportIconDeactive.png"] forState:UIControlStateNormal];
    [invetmentBtn setImage:[UIImage imageNamed:@"investmentIconDeactive.png"] forState:UIControlStateNormal];
    [serviceBtn setImage:[UIImage imageNamed:@"serviceIconWhite.png"] forState:UIControlStateNormal];
    [UIView commitAnimations];
    
    [firstBtn setTitle:@"Innovation" forState:UIControlStateNormal];
    [secondBtn setTitle:@"Motivation" forState:UIControlStateNormal];
    [thirdBtn setTitle:@"Results" forState:UIControlStateNormal];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionFade;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [innovationViewController.view.layer addAnimation:transition forKey:nil];
    motivationViewController.view.hidden = YES;
    innovationViewController.view.hidden = NO;
    [investmentViewController.view removeFromSuperview];
}

- (IBAction)investment:(id)sender
{
    [firstBtn setTitleColor:[Helper colorFromHexString:@"272b5b"] forState:UIControlStateNormal];
    [secondBtn setTitleColor:[Helper colorFromHexString:@"6e73a6"] forState:UIControlStateNormal];
    [thirdBtn setTitleColor:[Helper colorFromHexString:@"6e73a6"] forState:UIControlStateNormal];
    
    [firstHighlight setBackgroundColor:[Helper colorFromHexString:@"1b72d5"]];
    [secondHightlight setBackgroundColor:[UIColor clearColor]];
    [thirdHighlight setBackgroundColor:[UIColor clearColor]];

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"StopVideo" object:nil];
    
    currentlySelectedCategory = 1;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    invetmentBtn.backgroundColor = [Helper colorFromHexString:@"e62828"];
    serviceBtn.backgroundColor = [UIColor clearColor];
    supportBtn.backgroundColor = [UIColor clearColor];
    [invetmentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [supportBtn setTitleColor:[Helper colorFromHexString:@"6972c9"] forState:UIControlStateNormal];
    [serviceBtn setTitleColor:[Helper colorFromHexString:@"6972c9"] forState:UIControlStateNormal];
    [supportBtn setImage:[UIImage imageNamed:@"supportIconDeactive.png"] forState:UIControlStateNormal];
    [invetmentBtn setImage:[UIImage imageNamed:@"investmentIcon.png"] forState:UIControlStateNormal];
    [serviceBtn setImage:[UIImage imageNamed:@"serviceIconDeactive.png"] forState:UIControlStateNormal];
    [UIView commitAnimations];
    
    [firstBtn setTitle:@"Returns" forState:UIControlStateNormal];
    [secondBtn setTitle:@"Asset" forState:UIControlStateNormal];
    [thirdBtn setTitle:@"Growth" forState:UIControlStateNormal];
    motivationViewController.view.hidden = YES;
    innovationViewController.view.hidden = YES;
    
    investmentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"investmentView"];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionFade;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [investmentViewController.view.layer addAnimation:transition forKey:nil];
    [self.view addSubview:investmentViewController.view];
    [self addChildViewController:investmentViewController];
}
- (IBAction)support:(id)sender
{
//     [[NSNotificationCenter defaultCenter] postNotificationName:@"StopVideo" object:nil];
//    
//    currentlySelectedCategory = 2;
//    [UIView beginAnimations:@"" context:nil];
//    [UIView setAnimationDuration:0.2];
//    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//    supportBtn.backgroundColor = [Helper colorFromHexString:@"e62828"];
//    invetmentBtn.backgroundColor = [UIColor clearColor];
//    serviceBtn.backgroundColor = [UIColor clearColor];
//    [invetmentBtn setTitleColor:[Helper colorFromHexString:@"6972c9"] forState:UIControlStateNormal];
//    [supportBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [serviceBtn setTitleColor:[Helper colorFromHexString:@"6972c9"] forState:UIControlStateNormal];
//    [supportBtn setImage:[UIImage imageNamed:@"supportIcon.png"] forState:UIControlStateNormal];
//    [invetmentBtn setImage:[UIImage imageNamed:@"investmentIconDeactive.png"] forState:UIControlStateNormal];
//    [serviceBtn setImage:[UIImage imageNamed:@"serviceIconDeactive.png"] forState:UIControlStateNormal];
//    [UIView commitAnimations];
}

- (IBAction)openMenu:(id)sender
{
    SideDrawerViewController *drawer = [self.storyboard instantiateViewControllerWithIdentifier:@"SideDrawer"];
    drawer.CurrentViewIndex = 1;
    [self.view addSubview:drawer.view];
    [self addChildViewController:drawer];
}

- (IBAction)openFirstView:(id)sender
{
    UIButton *currentBtn = (UIButton *) sender;
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [firstBtn setTitleColor:[Helper colorFromHexString:@"272b5b"] forState:UIControlStateNormal];
    [secondBtn setTitleColor:[Helper colorFromHexString:@"6e73a6"] forState:UIControlStateNormal];
    [thirdBtn setTitleColor:[Helper colorFromHexString:@"6e73a6"] forState:UIControlStateNormal];
    
    [firstHighlight setBackgroundColor:[Helper colorFromHexString:@"1b72d5"]];
    [secondHightlight setBackgroundColor:[UIColor clearColor]];
    [thirdHighlight setBackgroundColor:[UIColor clearColor]];
    [UIView commitAnimations];
    if ([[currentBtn titleForState:UIControlStateNormal] isEqualToString:@"Innovation"])
    {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.type = kCATransitionFade;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [motivationViewController.view.layer addAnimation:transition forKey:nil];

    [innovationViewController.view setHidden:NO];
    [motivationViewController.view setHidden:YES];
    }
}

- (IBAction)openSecondView:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"StopVideo" object:nil];
    
    UIButton *currentBtn = (UIButton *) sender;
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [firstBtn setTitleColor:[Helper colorFromHexString:@"6e73a6"] forState:UIControlStateNormal];
    [secondBtn setTitleColor:[Helper colorFromHexString:@"272b5b"] forState:UIControlStateNormal];
    [thirdBtn setTitleColor:[Helper colorFromHexString:@"6e73a6"] forState:UIControlStateNormal];
    
    [firstHighlight setBackgroundColor:[UIColor clearColor]];
    [secondHightlight setBackgroundColor:[Helper colorFromHexString:@"1b72d5"]];
    [thirdHighlight setBackgroundColor:[UIColor clearColor]];
    [UIView commitAnimations];
    
    if ([[currentBtn titleForState:UIControlStateNormal] isEqualToString:@"Motivation"])
    {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.type = kCATransitionFade;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [motivationViewController.view.layer addAnimation:transition forKey:nil];
    
        [innovationViewController.view setHidden:YES];
        [motivationViewController.view setHidden:NO];
    }
}

- (IBAction)openThirdView:(id)sender
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"StopVideo" object:nil];
    
//    [UIView beginAnimations:@"" context:nil];
//    [UIView setAnimationDuration:0.2];
//    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//    [firstBtn setTitleColor:[Helper colorFromHexString:@"6e73a6"] forState:UIControlStateNormal];
//    [secondBtn setTitleColor:[Helper colorFromHexString:@"6e73a6"] forState:UIControlStateNormal];
//    [thirdBtn setTitleColor:[Helper colorFromHexString:@"272b5b"] forState:UIControlStateNormal];
//    
//    [firstHighlight setBackgroundColor:[UIColor clearColor]];
//    [secondHightlight setBackgroundColor:[UIColor clearColor]];
//    [thirdHighlight setBackgroundColor:[Helper colorFromHexString:@"1b72d5"]];
//    [UIView commitAnimations];
}

#pragma mark Helper Methods

-(void) dismisView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
