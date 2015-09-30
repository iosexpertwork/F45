//
//  ViewController.m
//  F45Sales
//
//  Created by Paras on 9/2/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize startBtn, headlineLabel, ThreeNumber, bottomLine, dotBottomLabel, dotTopLabel;

-(void)viewDidAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ActivationCode"] == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Activation Code"
                                                        message:@"Please enter activation code"
                                                       delegate:self
                                              cancelButtonTitle:@"Done"
                                              otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    }
    else
    {
        startBtn.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    startBtn.layer.borderColor = [[Helper colorFromHexString:@"6972c9"] CGColor];
    startBtn.layer.borderWidth = 6;
    startBtn.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MainBackground.png"]];
    startBtn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:27.71];
    headlineLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:48];
    
    bottomLine.backgroundColor = [Helper colorFromHexString:@"1b72d5"];
    ThreeNumber.textColor = [Helper colorFromHexString:@"272b5b"];
    
    dotTopLabel.textColor = [UIColor whiteColor];
    dotBottomLabel.textColor = [Helper colorFromHexString:@"6972c9"];
    
    [dotTopLabel setFont:[UIFont fontWithName:@"ProximaNova-Light" size:28]];
    [dotBottomLabel setFont:[UIFont fontWithName:@"ProximaNova-Light" size:28]];
}

#pragma mark alert view delegate methods

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
     NSLog(@"%@",[alertView textFieldAtIndex:0].text);
    if ([[alertView textFieldAtIndex:0].text isEqualToString:@"f45123"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"f45123" forKey:@"ActivationCode"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        startBtn.hidden = NO;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Activation Code"
                                                        message:@"Please enter valid activation code"
                                                       delegate:self
                                              cancelButtonTitle:@"Done"
                                              otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    }
}

#pragma mark Status Bar Method

-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark Button Actions

- (IBAction)openMainView:(id)sender
{
    MainViewController *mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
    [self presentViewController:mainView animated:YES completion:nil];
}

- (IBAction)showDrawer:(id)sender
{
    SideDrawerViewController *drawer = [self.storyboard instantiateViewControllerWithIdentifier:@"SideDrawer"];
    [self.view addSubview:drawer.view];
    [self addChildViewController:drawer];
}

#pragma mark Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
