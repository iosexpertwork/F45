//
//  AppDelegate.h
//  F45
//
//  Created by TED Solutions on 25/08/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mobihelp.h"
#import "Constants.h"
#import "SupportViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(BOOL)notificationServicesEnabled;
-(void)mainViewSwitch:(UIViewController *)controller;
@end

