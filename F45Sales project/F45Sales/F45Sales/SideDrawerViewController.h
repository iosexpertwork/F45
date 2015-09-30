//
//  SideDrawerViewController.h
//  F45Sales
//
//  Created by Paras on 9/2/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helper.h"

@interface SideDrawerViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *drawerVisibleView;
@property (strong, nonatomic) IBOutlet UIButton *homeBtn;
@property (strong, nonatomic) IBOutlet UIButton *manualBtn;
@property (strong, nonatomic) IBOutlet UIButton *faqsBtn;
@property (strong, nonatomic) IBOutlet UIButton *contactBtn;
@property (nonatomic) int CurrentViewIndex;

- (IBAction)openHome:(id)sender;
- (IBAction)openManual:(id)sender;
- (IBAction)openFAQs:(id)sender;
- (IBAction)openContact:(id)sender;
- (IBAction)closeDrawer:(id)sender;

@end
