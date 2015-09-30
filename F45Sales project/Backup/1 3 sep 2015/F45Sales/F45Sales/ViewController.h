//
//  ViewController.h
//  F45Sales
//
//  Created by Paras on 9/2/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "SideDrawerViewController.h"
#import "Helper.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *startBtn;
@property (strong, nonatomic) IBOutlet UILabel *headlineLabel;
@property (strong, nonatomic) IBOutlet UIView *bottomLine;
@property (strong, nonatomic) IBOutlet UILabel *ThreeNumber;
@property (strong, nonatomic) IBOutlet UILabel *dotTopLabel;
@property (strong, nonatomic) IBOutlet UILabel *dotBottomLabel;



- (IBAction)openMainView:(id)sender;
- (IBAction)showDrawer:(id)sender;
@end

