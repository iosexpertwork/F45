//
//  MainViewController.h
//  F45Sales
//
//  Created by Paras on 9/2/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideDrawerViewController.h"
#import "InnovationViewController.h"
#import "MotivationViewController.h"
#import "InvestmentViewController.h"

@interface MainViewController : UIViewController <UIScrollViewDelegate>
{
    int currentlySelectedCategory;
    InnovationViewController *innovationViewController;
    MotivationViewController *motivationViewController;
    InvestmentViewController *investmentViewController;
}
@property (strong, nonatomic) IBOutlet UIView *topNavigatonBar;
@property (strong, nonatomic) IBOutlet UIButton *serviceBtn;
@property (strong, nonatomic) IBOutlet UIButton *invetmentBtn;
@property (strong, nonatomic) IBOutlet UIButton *supportBtn;
@property (strong, nonatomic) IBOutlet UIView *navigationBottomBar;
@property (strong, nonatomic) IBOutlet UIButton *firstBtn;
@property (strong, nonatomic) IBOutlet UIButton *secondBtn;
@property (strong, nonatomic) IBOutlet UIButton *thirdBtn;
@property (strong, nonatomic) IBOutlet UIView *firstHighlight;
@property (strong, nonatomic) IBOutlet UIView *secondHightlight;
@property (strong, nonatomic) IBOutlet UIView *thirdHighlight;
@property (strong, nonatomic) IBOutlet UIView *sideBar;
@property (strong, nonatomic) IBOutlet UIButton *CategoryBtn;
@property (strong, nonatomic) IBOutlet UILabel *dotTopLabel;
@property (strong, nonatomic) IBOutlet UIImageView *upperDot;
@property (strong, nonatomic) IBOutlet UIImageView *middleDot;
@property (strong, nonatomic) IBOutlet UIImageView *lowerDot;
@property (strong, nonatomic) IBOutlet UILabel *dotBottomLabel;
@property (strong, nonatomic) IBOutlet UIView *sideBarElementsView;

- (IBAction)showNavigationView:(id)sender;
- (IBAction)services:(id)sender;
- (IBAction)investment:(id)sender;
- (IBAction)support:(id)sender;
- (IBAction)openMenu:(id)sender;
- (IBAction)openFirstView:(id)sender;
- (IBAction)openSecondView:(id)sender;
- (IBAction)openThirdView:(id)sender;

@end
