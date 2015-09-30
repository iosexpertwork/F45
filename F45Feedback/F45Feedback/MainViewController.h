//
//  MainViewController.h
//  F45Feedback
//
//  Created by Paras on 9/4/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helper.h"
#import "UIView+Toast.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "PopoverViewController.h"

@interface MainViewController : UIViewController
{
    NSArray *weightedQuestons;
    int currentIndex;
    NSArray *cachedAnswers;
    long long totalCachedAnswers;
    NSInteger currentIndexNumber;
    AFHTTPRequestOperationManager *manager;
    NSArray *questions;
    NSArray *sortedLatestQuestionArray;
    long long totalCountOfQuestions;
    UIButton *currentRatingButton;
    long long key;
    long long value;
    UIView *logoutView;
    UIPopoverController *popOver;
}
@property (strong, nonatomic) IBOutlet UIView *topBar;
@property (strong, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) IBOutlet UIButton *awfulBtn;
@property (strong, nonatomic) IBOutlet UIButton *badBtn;
@property (strong, nonatomic) IBOutlet UIButton *okBtn;
@property (strong, nonatomic) IBOutlet UIButton *goodBtn;
@property (strong, nonatomic) IBOutlet UIButton *greatBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *questionTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *awfulConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *badConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *okConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *goodConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *greatConstraint;

-(IBAction) ratingBtnTapped:(id)sender;
- (IBAction)showLogoutView:(id)sender;
@end
