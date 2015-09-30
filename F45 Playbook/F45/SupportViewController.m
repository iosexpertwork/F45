//
//  SupportViewController.m
//  F45
//
//  Created by TED Solutions on 25/08/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import "SupportViewController.h"

@interface SupportViewController ()

@end

@implementation SupportViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        UIBarButtonItem *feedbackBtn=[[UIBarButtonItem alloc]initWithTitle:@"Feedback" style:UIBarButtonItemStylePlain target:self action:@selector(feedback)];
    UIBarButtonItem *supportBtn=[[UIBarButtonItem alloc]initWithTitle:@"Support" style:UIBarButtonItemStylePlain target:self action:@selector(support)];
    self.navigationItem.rightBarButtonItems=@[feedbackBtn, supportBtn];
        UIBarButtonItem *logoutBtn=[[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    self.navigationItem.leftBarButtonItem=logoutBtn;
        [[Mobihelp sharedInstance] presentSupport:self];
    [[Mobihelp sharedInstance] addCustomDataForKey:@"Name" withValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"name"]];
    [[Mobihelp sharedInstance] addCustomDataForKey:@"Franchisee_id" withValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"franchisee_id"]];
    [[Mobihelp sharedInstance] setUserName:[[NSUserDefaults standardUserDefaults]objectForKey:@"name"]];
    [[Mobihelp sharedInstance] setEmailAddress:[[NSUserDefaults standardUserDefaults]objectForKey:@"email"]];
}

#pragma mark -- Button Action

-(void)feedback
{
    [[Mobihelp sharedInstance] presentFeedback:self];
}

-(void)support
{
    [[Mobihelp sharedInstance] presentSupport:self];
}
-(void)logout
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"email"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"name"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"franchisee_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    LoginViewController *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController setViewControllers:@[controller] animated:YES];
}

#pragma mark -- Memory Warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
