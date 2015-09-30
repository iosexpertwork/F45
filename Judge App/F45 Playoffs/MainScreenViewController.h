//
//  MainScreenViewController.h
//  F45 Playoffs
//
//  Created by TED Solutions on 27/08/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "ListViewController.h"
#import "LoginViewController.h"
#import "PlayersViewController.h"
#import "Constants.h"
#import "WebAPI.h"
#import "Mobihelp.h"
#import "DBHandler.h"
#import <AudioToolbox/AudioServices.h>
#import "LogViewController.h"

@interface MainScreenViewController : UIViewController<UITextFieldDelegate, APIsDelegate>
{
    NSString *stationId;
    WebAPI *api;
    int vibrateCount;
    NSArray *playerList;
    BOOL shouldPushNotification;
}
@property (weak, nonatomic) IBOutlet UILabel *playerLbl;
@property (weak, nonatomic) IBOutlet UITextField *playerText;
@property (weak, nonatomic) IBOutlet UILabel *stationLbl;
@property (weak, nonatomic) IBOutlet UITextField *stationText;
@property (weak, nonatomic) IBOutlet UILabel *resultLbl;
@property (weak, nonatomic) IBOutlet UITextField *resultText;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *counterLbl;
@property (strong, nonatomic) IBOutlet UIButton *logBtn;


- (IBAction)openLog:(id)sender;
- (IBAction)submit:(id)sender;
@end
