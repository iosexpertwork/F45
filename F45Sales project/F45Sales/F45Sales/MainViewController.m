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
@synthesize topNavigatonBar, serviceBtn, invetmentBtn, supportBtn, navigationBottomBar, firstBtn, secondBtn, thirdBtn, firstHighlight, secondHightlight , thirdHighlight, sideBar, CategoryBtn, dotTopLabel, upperDot, middleDot, sideBarElementsView,sidebarSectionView;

-(void)viewDidLoad
{
    currenlyActiveView = @"Innovation";
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
    [self.view insertSubview:innovationViewController.view atIndex:0];
    [self addChildViewController:innovationViewController];
    playerOrignalRect = innovationViewController.view.frame;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setDot:) name:@"SetDot" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNumberColor:) name:@"SetNumberColor" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideNavBar) name:@"hideCustomNavBar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetInnovtionView) name:@"ResetInnovationView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerFullScreen) name:@"playerFullScreen" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disableFullScreen) name:@"disableFullScreen" object:nil];
    
    motivationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"motivationView"];
    [self.view insertSubview:motivationViewController.view atIndex:0];
    [self addChildViewController:motivationViewController];
    motivationViewController.view.hidden = YES;

    sideBarElementsView.backgroundColor = sideBar.backgroundColor;
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShrinknEnlargeSideBar:)];
//    tapGesture.numberOfTapsRequired = 1;
//    sideBar.userInteractionEnabled = YES;
//    [sideBar addGestureRecognizer:tapGesture];
    sidebarSectionView.backgroundColor = sideBarElementsView.backgroundColor;
    [self performSelectorInBackground:@selector(loadViews) withObject:nil];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [sideBar addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [sideBar addGestureRecognizer:swipeDown];
}

#pragma mark Status Bar Method

-(void) loadViews
{
    investmentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"investmentView"];
    [self.view insertSubview:investmentViewController.view atIndex:0];
    [self addChildViewController:investmentViewController];
    investmentViewController.view.hidden = YES;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark Notification Methods

-(void) disableFullScreen
{
    sideBar.hidden = NO;
    navigationBottomBar.hidden = NO;
    topNavigatonBar.hidden = NO;
}

-(void) playerFullScreen
{
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.2];
    sideBar.hidden = YES;
    navigationBottomBar.hidden = YES;
    topNavigatonBar.hidden = YES;
    [UIView commitAnimations];
}

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
                sidebarSectionView.frame = CGRectMake(sidebarSectionView.frame.origin.x, sideBarElementsView.frame.origin.y, sidebarSectionView.frame.size.width, sidebarSectionView.frame.size.height);
                investmentViewController.view.frame = CGRectMake(80, navigationBottomBar.frame.origin.y+navigationBottomBar.frame.size.height, investmentViewController.view.frame.size.width, investmentViewController.view.frame.size.height);
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
        sidebarSectionView.frame = CGRectMake(sidebarSectionView.frame.origin.x, sideBarElementsView.frame.origin.y, sidebarSectionView.frame.size.width, sidebarSectionView.frame.size.height);
        investmentViewController.view.frame = CGRectMake(80, navigationBottomBar.frame.origin.y+navigationBottomBar.frame.size.height, investmentViewController.view.frame.size.width, investmentViewController.view.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)services:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SetDot" object:@[@"mainScreenDot.png",@"1",@"mainScreenDot.png",@"2"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SetNumberColor" object:[UIColor whiteColor]];

    [investmentViewController.scrollView setContentOffset:CGPointMake(0, 0)];
    
    currenlyActiveView = @"Innovation";
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
    investmentViewController.view.hidden = YES;
}

- (IBAction)investment:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SetDot" object:@[@"mainScreenDot.png",@"1",@"mainScreenDot.png",@"2"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SetNumberColor" object:[UIColor whiteColor]];

    [innovationViewController.scrollView setContentOffset:CGPointMake(0, 0)];
    
    currenlyActiveView = @"Returns";
    [self resetInnovtionView];
    [firstBtn setTitleColor:[Helper colorFromHexString:@"272b5b"] forState:UIControlStateNormal];
    [secondBtn setTitleColor:[Helper colorFromHexString:@"6e73a6"] forState:UIControlStateNormal];
    [thirdBtn setTitleColor:[Helper colorFromHexString:@"6e73a6"] forState:UIControlStateNormal];
    
    [firstHighlight setBackgroundColor:[Helper colorFromHexString:@"1b72d5"]];
    [secondHightlight setBackgroundColor:[UIColor clearColor]];
    [thirdHighlight setBackgroundColor:[UIColor clearColor]];

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

    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionFade;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [investmentViewController.view.layer addAnimation:transition forKey:nil];
    investmentViewController.view.hidden = NO;
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
        currenlyActiveView = @"Innovation";
        [motivationViewController.view.layer removeAllAnimations];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [innovationViewController.view.layer addAnimation:transition forKey:nil];

    [innovationViewController.view setHidden:NO];
    [motivationViewController.view setHidden:YES];
    //[self resetInnovtionView];
    }
}

- (IBAction)openSecondView:(id)sender
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"StopVideo" object:nil];
    
    UIButton *currentBtn = (UIButton *) sender;
    
    if (![[currentBtn titleForState:UIControlStateNormal] isEqualToString:@"Asset"])
    {
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
    }
    
    if ([[currentBtn titleForState:UIControlStateNormal] isEqualToString:@"Motivation"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SetDot" object:@[@"mainScreenDot.png",@"1",@"mainScreenDot.png",@"2"]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SetNumberColor" object:[UIColor whiteColor]];
         currenlyActiveView = @"Motivation";
        [innovationViewController.view.layer removeAllAnimations];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [motivationViewController.view.layer addAnimation:transition forKey:nil];
    
        [innovationViewController.view setHidden:YES];
        [motivationViewController.view setHidden:NO];
        
        [innovationViewController.scrollView setContentOffset:CGPointMake(0, 0)];
        
        //[self resetInnovtionView];
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

-(void) handleSwipeUp:(UISwipeGestureRecognizer *) gesture
{
    if ([currenlyActiveView isEqualToString:@"Innovation"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"InnovationUp" object:gesture];
    }
    else if ([currenlyActiveView isEqualToString:@"Returns"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReturnsUp" object:gesture];
    }
}

-(void) handleSwipeDown:(UISwipeGestureRecognizer *) gesture
{
    if ([currenlyActiveView isEqualToString:@"Innovation"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"InnovationDown" object:gesture];
    }
    else if ([currenlyActiveView isEqualToString:@"Returns"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReturnsDown" object:gesture];
    }
}

-(void) resetInnovtionView
{
//    [UIView transitionWithView:sideBar duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
//    sideBarElementsView.hidden = NO;
//    sidebarSectionView.alpha = 0;
//    sideBar.frame = CGRectMake(0, sideBar.frame.origin.y, 80, sideBar.frame.size.height);
//    innovationViewController.view.frame = CGRectMake(80, 81, innovationViewController.view.frame.size.width, innovationViewController.view.frame.size.height);
//        motivationViewController.view.frame = CGRectMake(80, motivationViewController.view.frame.origin.y, motivationViewController.view.frame.size.width, motivationViewController.view.frame.size.height);
//        investmentViewController.view.frame = CGRectMake(80, investmentViewController.view.frame.origin.y, investmentViewController.view.frame.size.width, investmentViewController.view.frame.size.height);
//    } completion:nil];
}

-(void) ShrinknEnlargeSideBar:(UITapGestureRecognizer *) recognizer
{
    switch ((int) sideBar.frame.size.width)
    {
        case 80:
        {
            sideBarElementsView.hidden = YES;
            [UIView transitionWithView:sideBar duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
                sideBar.frame = CGRectMake(0, sideBar.frame.origin.y, 224, sideBar.frame.size.height);
                innovationViewController.view.frame = CGRectMake(224, innovationViewController.view.frame.origin.y, innovationViewController.view.frame.size.width, innovationViewController.view.frame.size.height);
                motivationViewController.view.frame = CGRectMake(224, motivationViewController.view.frame.origin.y, motivationViewController.view.frame.size.width, motivationViewController.view.frame.size.height);
                investmentViewController.view.frame = CGRectMake(224, investmentViewController.view.frame.origin.y, investmentViewController.view.frame.size.width, investmentViewController.view.frame.size.height);
                sidebarSectionView.alpha = 1;
                sidebarSectionView.frame = CGRectMake(sidebarSectionView.frame.origin.x, sidebarSectionView.frame.origin.y, 121, sidebarSectionView.frame.size.height);
            } completion:^(BOOL finished) {
                
            }];
        }
        break;
        case 224:
        {
            sideBarElementsView.hidden = NO;
            [UIView transitionWithView:sideBar duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
                sideBar.frame = CGRectMake(0, sideBar.frame.origin.y, 80, sideBar.frame.size.height);
                innovationViewController.view.frame = CGRectMake(80, innovationViewController.view.frame.origin.y, innovationViewController.view.frame.size.width, innovationViewController.view.frame.size.height);
                motivationViewController.view.frame = CGRectMake(80, motivationViewController.view.frame.origin.y, motivationViewController.view.frame.size.width, motivationViewController.view.frame.size.height);
                investmentViewController.view.frame = CGRectMake(80, investmentViewController.view.frame.origin.y, investmentViewController.view.frame.size.width, investmentViewController.view.frame.size.height);
                sidebarSectionView.alpha = 0;
                sidebarSectionView.frame = CGRectMake(sidebarSectionView.frame.origin.x, sidebarSectionView.frame.origin.y, 40, sidebarSectionView.frame.size.height);
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        default:
            break;
    }
}


-(void) dismisView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
