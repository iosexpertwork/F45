//
//  LoginViewController.h
//  F45
//
//  Created by TED Solutions on 25/08/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "WebAPI.h"
#import "Helper.h"
#import "Constants.h"
#import "MainScreenViewController.h"

@interface LoginViewController : UIViewController<APIsDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate>
{
    WebAPI *api;
}

@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgotBtn;
@property (weak, nonatomic) IBOutlet UILabel *supportLbl;


- (IBAction)login:(id)sender;
- (IBAction)forgotPassword:(id)sender;


@end
