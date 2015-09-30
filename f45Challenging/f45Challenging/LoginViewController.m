//
//  LoginViewController.m
//  f45Challenging
//
//  Created by Paras on 9/28/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import "LoginViewController.h"
#import "DashBoardViewController.h"
#import "Tabbar.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize loginBtn,emailTextField,pwdTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    emailTextField.layer.borderWidth=0.50;
    pwdTextField.layer.borderWidth=0.50;
    emailTextField.layer.borderColor=[UIColor blackColor].CGColor;
    pwdTextField.layer.borderColor=[UIColor blackColor].CGColor;
    loginBtn.layer.cornerRadius=5;
    
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginBtn:(id)sender {
    Tabbar *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
            [self.navigationController pushViewController:controller animated:YES];
    
}
@end
