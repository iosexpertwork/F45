//
//  PopoverViewController.m
//  F45Feedback
//
//  Created by Paras on 9/7/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import "PopoverViewController.h"

@implementation PopoverViewController

-(void)viewDidLoad
{
    _logoutBtn.layer.cornerRadius = 5;
}

- (IBAction)logoutBtn:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:@"Logout" message:@"Are you sure you want to logout?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes, Log me out", nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 1:
        {
            UINavigationController *navController = [self.storyboard instantiateInitialViewController];
            _window = (UIWindow *)[(AppDelegate*)
                                   [[UIApplication sharedApplication]delegate] window];
            
            
            [UIView
             transitionWithView:_window
             duration:0.5
             options:UIViewAnimationOptionTransitionCrossDissolve
             animations:^(void)
             {
                 [_window setRootViewController:navController];
             }
             completion:^(BOOL finished) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [SVProgressHUD dismiss];
                     [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"franchisee_id"];
                     [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"answers"];
                     [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"latestQuestionsFromServer"];
                     [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"latestQuestions"];
                     [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"latestQuestions"];
                     [[NSUserDefaults standardUserDefaults] synchronize];
                 });
             }];
            break;

        }
            break;
        default:
            break;
    }
}


@end
