//
//  SideDrawerViewController.m
//  F45Sales
//
//  Created by Paras on 9/2/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import "SideDrawerViewController.h"

@implementation SideDrawerViewController
@synthesize drawerVisibleView, homeBtn, manualBtn, faqsBtn, contactBtn;

-(void) viewDidLoad
{
    self.view.backgroundColor = [UIColor clearColor];
    drawerVisibleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    self.view.alpha = 0;
    self.view.frame = CGRectMake(-256, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self performSelector:@selector(animateDrawer) withObject:nil afterDelay:0.0];

    homeBtn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:48];
    manualBtn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:48];
    faqsBtn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:48];
    contactBtn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:48];
    
    [self ToggleSelectionColor];
}

#pragma mark Helper Methods

-(void) ToggleSelectionColor
{
    switch (_CurrentViewIndex)
    {
        case 0:
            [homeBtn setTitleColor:[Helper colorFromHexString:@"e62828"] forState:UIControlStateNormal];
            [manualBtn setTitleColor:[Helper colorFromHexString:@"32363b"] forState:UIControlStateNormal];
            [faqsBtn setTitleColor:[Helper colorFromHexString:@"32363b"] forState:UIControlStateNormal];
            [contactBtn setTitleColor:[Helper colorFromHexString:@"32363b"] forState:UIControlStateNormal];
            break;
        case 1:
            [homeBtn setTitleColor:[Helper colorFromHexString:@"32363b"] forState:UIControlStateNormal];
            [manualBtn setTitleColor:[Helper colorFromHexString:@"e62828"] forState:UIControlStateNormal];
            [faqsBtn setTitleColor:[Helper colorFromHexString:@"32363b"] forState:UIControlStateNormal];
            [contactBtn setTitleColor:[Helper colorFromHexString:@"32363b"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

-(void) animateDrawer
{
    self.view.hidden = NO;
    [UIView transitionWithView:self.view duration:0.28 options:UIViewAnimationOptionTransitionNone animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.view.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark button actions

- (IBAction)openHome:(id)sender
{
    switch (_CurrentViewIndex)
    {
        case 0:
            [self closeDrawer:nil];
            break;
          case 1:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DismissMenuView" object:nil];
            break;
        default:
            break;
    }
}

- (IBAction)openManual:(id)sender {
}

- (IBAction)openFAQs:(id)sender {
}

- (IBAction)openContact:(id)sender {
}

- (IBAction)closeDrawer:(id)sender
{
    [UIView transitionWithView:self.view duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
        self.view.frame = CGRectMake(-256, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

@end
