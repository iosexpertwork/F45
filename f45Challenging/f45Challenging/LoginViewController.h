//
//  LoginViewController.h
//  f45Challenging
//
//  Created by Paras on 9/28/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (IBAction)loginBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *loginBtn;

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@property (strong, nonatomic) IBOutlet UITextField *pwdTextField;

@end
