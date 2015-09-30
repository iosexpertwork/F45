//
//  ViewController.m
//  F45Feedback
//
//  Created by Paras on 9/4/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize submitBtn, idTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.navigationController.navigationBarHidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tapToHideKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapToHideKeyboard.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapToHideKeyboard];
    
    UIView *emailPaddingView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    _emailTextField.leftView=emailPaddingView;
    _emailTextField.leftViewMode=UITextFieldViewModeAlways;
    
    UIView *passwordPaddingView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    _passwordTextField.leftView=passwordPaddingView;
    _passwordTextField.leftViewMode=UITextFieldViewModeAlways;
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Email Address" attributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:174/255.0 green:176/255.0 blue:202/255.0 alpha:1] }];
    _emailTextField.attributedPlaceholder = str;
    
    str = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:174/255.0 green:176/255.0 blue:202/255.0 alpha:1] }];
    _passwordTextField.attributedPlaceholder = str;
    manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10;
}

#pragma mark Keyboard Movements

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height+170;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView transitionWithView:self.view duration:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    } completion:nil];
}

#pragma mark textfield delegate method

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self submitFranchiseeId:@"KeyboardShown"];
    return NO;
}

#pragma mark Status Bar Method

-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark button actions

- (IBAction)submitFranchiseeId:(id)sender
{
    [_emailTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    if (_emailTextField.text.length==0)
    {
        [[[UIAlertView alloc]initWithTitle:@"Email Address" message:@"Email address cannot be empty." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
    else if ([Helper validateEmailWithString:_emailTextField.text]==NO)
    {
        [[[UIAlertView alloc]initWithTitle:@"Invalid Email" message:@"Please enter valid email address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
    else if (_passwordTextField.text.length==0)
    {
        [[[UIAlertView alloc]initWithTitle:@"Password" message:@"Password cannot be empty." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
    else
    {
        if ([Helper isInternetWorking]==YES)
        {
            [Helper showIndicatorWithText:@"Signing..." inView:self.view];
            NSDictionary *dic=[[NSDictionary alloc]initWithObjects:@[_emailTextField.text, _passwordTextField.text, @"f45Feedback"] forKeys:@[@"email", @"password", @"apptype"]];
            
            [manager POST:@"http://f45.info/v1/franchisees/login" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                @try {
                    
                    if (![responseObject isKindOfClass:[NSError class]])
                    {
                        if ([[responseObject objectForKey:@"success"]integerValue]==1)
                        {
                            NSDictionary *details=[responseObject objectForKey:@"data"];
                            [[NSUserDefaults standardUserDefaults] setObject:[details objectForKey:@"franchisee_id"] forKey:@"franchisee_id"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            [self pushMainView];
                        }
                        else
                        {
                            if (![[responseObject objectForKey:@"errors"] isKindOfClass:[NSNull class]])
                            {
                                NSArray *errors=[responseObject objectForKey:@"errors"];
                                if (errors.count>0)
                                {
                                    [[[UIAlertView alloc]initWithTitle:[responseObject objectForKey:@"operation"] message:[errors objectAtIndex:0] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                                    [Helper hideIndicatorFromView:self.view];
                                }
                            }
                        }
                    }
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
            
            
        }
        else
        {
            [[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Check Your Internet Connection!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        }
    }
    
}

#pragma mark helper methods

-(void) pushMainView
{
    MainViewController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
    [self.navigationController pushViewController:mainViewController animated:YES];
}

-(void) hideKeyboard
{
    [idTextField resignFirstResponder];
}

#pragma mark memory warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
