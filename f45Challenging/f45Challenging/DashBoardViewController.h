//
//  DashBoardViewController.h
//  f45Challenging
//
//  Created by Paras on 9/28/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomBar.h"
#import "TableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface DashBoardViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableViewCell *CellObj;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UIProgressView *dailyProgressView, *weekleProgressView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;





@end
