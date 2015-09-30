//
//  playBookVC.h
//  F45
//
//  Created by Paras on 9/21/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface playBookVC : UIViewController<UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textField1;
@property (strong, nonatomic) IBOutlet UITextField *textField2;
@property (strong, nonatomic) IBOutlet UITextField *textField3;

@property (strong, nonatomic) IBOutlet UITextField *textField4;

@property (strong, nonatomic) IBOutlet UITextField *textField5;
@property (strong, nonatomic) IBOutlet UITextField *textFiled6;
@property (strong, nonatomic) IBOutlet UITextField *textField7;
@property (strong, nonatomic) IBOutlet UITextField *textField8;
@property (strong, nonatomic) IBOutlet UITextField *textField9;
@property (strong, nonatomic) IBOutlet UITextField *textField10;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UIButton *GenerateScore;

- (IBAction)RightMenu:(id)sender;
-(void)mainViewSwitch;
- (IBAction)GenerateAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll_View;
- (IBAction)logout:(id)sender;
@end
