//
//  PopoverViewController.h
//  F45Feedback
//
//  Created by Paras on 9/7/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface PopoverViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *logoutBtn;
@property (strong, nonatomic) UIWindow *window;

@end
