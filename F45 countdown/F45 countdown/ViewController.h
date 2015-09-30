//
//  ViewController.h
//  F45 countdown
//
//  Created by  on 9/9/15.
//  Copyright (c) 2015 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AudioController.h"
@interface ViewController : UIViewController
{
    BOOL mute;
    UIWindow *secondwindow;
}
@property (weak, nonatomic) IBOutlet UILabel *counterLbl;
@property (strong, nonatomic) IBOutlet UILabel *beepLabel;

@end

