//
//  LoginViewController.m
//  F45
//
//  Created by TED Solutions on 25/08/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize logo, email, password, loginBtn, forgotBtn, supportLbl;

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    api=[[WebAPI alloc]init];
    api.delegate=self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.view.frame.size.height==480)
    {
        logo.frame=CGRectMake(self.view.frame.size.width/2-64, 40, 128, 63);
    }
    else
    {
        logo.frame=CGRectMake(self.view.frame.size.width/2-64, 80, 128, 63);
    }
    email.frame=CGRectMake(10, self.view.frame.size.height/2-65, self.view.frame.size.width-20, 45);
    password.frame=CGRectMake(10, email.frame.size.height+email.frame.origin.y+3, email.frame.size.width, email.frame.size.height);
    loginBtn.frame=CGRectMake(10, password.frame.origin.y+40+15, email.frame.size.width, 45);
    forgotBtn.frame=CGRectMake(10, loginBtn.frame.origin.y+loginBtn.frame.size.height+40, email.frame.size.width, 45);
    supportLbl.frame=CGRectMake(0, logo.frame.origin.y+logo.frame.size.height, self.view.frame.size.width, 40);
    
    self.view.backgroundColor=APP_COLOR;
    UIColor *textFieldBackgroundColor=[UIColor colorWithRed:82/255.0 green:81/255.0 blue:150/255.0 alpha:1];
    UIColor *loginBackgroundColor=[UIColor colorWithRed:60/255.0 green:111/255.0 blue:218/255.0 alpha:1];
    UIColor *textColor=[UIColor colorWithRed:174/255.0 green:176/255.0 blue:202/255.0 alpha:1];
    
    supportLbl.textColor=[UIColor whiteColor];
    supportLbl.font=[UIFont fontWithName:PROXIMA_NOVA_BOLD size:22];
    
    logo.image=[UIImage imageNamed:@"logo.png"];
    
    email.backgroundColor=textFieldBackgroundColor;
    password.backgroundColor=textFieldBackgroundColor;
    
    email.borderStyle=UITextBorderStyleNone;
    password.borderStyle=UITextBorderStyleNone;
    
    UIView *emailPaddingView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    email.leftView=emailPaddingView;
    email.leftViewMode=UITextFieldViewModeAlways;
    
    UIView *passwordPaddingView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    password.leftView=passwordPaddingView;
    password.leftViewMode=UITextFieldViewModeAlways;
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Email Address" attributes:@{ NSForegroundColorAttributeName : textColor }];
    email.attributedPlaceholder = str;
    
    str = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : textColor }];
    password.attributedPlaceholder = str;
    
    email.font=[UIFont fontWithName:PROXIMA_NOVA_REGULAR size:15];
    password.font=[UIFont fontWithName:PROXIMA_NOVA_REGULAR size:15];
    
    loginBtn.backgroundColor=loginBackgroundColor;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"LOGIN" forState:UIControlStateNormal];
    [loginBtn.titleLabel setFont:[UIFont fontWithName:PROXIMA_NOVA_BOLD size:15]];
    
    forgotBtn.backgroundColor=[UIColor clearColor];
    [forgotBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgotBtn setTitle:@"Forgot your password?" forState:UIControlStateNormal];
    [forgotBtn.titleLabel setFont:[UIFont fontWithName:PROXIMA_NOVA_BOLD size:15]];
}
#pragma mark -- APIs Delegate


-(void)callbackFromAPI:(id)response
{
    [Helper hideIndicatorFromView:self.view];
}

-(void)callBackLoginSuccess:(NSDictionary *)response
{
    MainScreenViewController *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"main"];
    [self.navigationController setViewControllers:@[controller] animated:YES];
    email.text=@"";
    password.text=@"";
}

#pragma mark -- Button Action

- (IBAction)login:(id)sender
{
    [email resignFirstResponder];
    [password resignFirstResponder];
    if (email.text.length==0)
    {
        [[[UIAlertView alloc]initWithTitle:@"Email Address" message:@"Email address cannot be empty." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
    else if ([Helper validateEmailWithString:email.text]==NO)
    {
        [[[UIAlertView alloc]initWithTitle:@"Invalid Email" message:@"Please enter valid email address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
    else if (password.text.length==0)
    {
        [[[UIAlertView alloc]initWithTitle:@"Password" message:@"Password cannot be empty." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
    else
    {
        if ([Helper isInternetConnected]==YES)
        {
            [Helper showIndicatorWithText:@"Signing..." inView:self.view];
            NSDictionary *dic=[[NSDictionary alloc]initWithObjects:@[email.text, password.text, @"f45judge"] forKeys:@[@"email", @"password", @"apptype"]];
            [api loginWithDetails:dic viewController:self];
        }
        else
        {
            [[[UIAlertView alloc]initWithTitle:ALERT message:INTERNET_ERROR delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        }
    }
}

- (IBAction)forgotPassword:(id)sender
{
    NSArray *toRecipents = [NSArray arrayWithObject:@"tech@f4training.com.au"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

#pragma mark -- MFMailComposor Delegate

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -- Helper Methods

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark -- TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag==1)
    {
        [password becomeFirstResponder];
    }
    else{
        [self login:nil];
    }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    if (self.view.frame.size.height==480)
    {
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-70, self.view.frame.size.width, self.view.frame.size.height)];
    }
    else if (self.view.frame.size.height==568)
    {
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-50, self.view.frame.size.width, self.view.frame.size.height)];
    }
    [UIView commitAnimations];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    if (self.view.frame.size.height==480)
    {
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+70, self.view.frame.size.width, self.view.frame.size.height)];
    }
    else if (self.view.frame.size.height==568)
    {
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+50, self.view.frame.size.width, self.view.frame.size.height)];
    }
    [UIView commitAnimations];
    return YES;
}

#pragma mark -- Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
