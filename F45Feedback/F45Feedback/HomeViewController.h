//
//  ViewController.h
//  F45Feedback
//
//  Created by Paras on 9/4/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface HomeViewController : UIViewController
{
    AFHTTPRequestOperationManager *manager;
}
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UITextField *idTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;


- (IBAction)submitFranchiseeId:(id)sender;
@end

