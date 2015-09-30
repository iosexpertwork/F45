//
//  InnovationViewController.h
//  F45Sales
//
//  Created by Paras on 9/3/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helper.h"
#import <MediaPlayer/MediaPlayer.h>

@interface InnovationViewController : UIViewController
{
    MPMoviePlayerController *player;
    CGRect originalViewFrame;
}
@property (strong, nonatomic) IBOutlet UIView *innovationsView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *innovationsLabel;
@property (strong, nonatomic) IBOutlet UILabel *attributedTextLabel;
@property (strong, nonatomic) IBOutlet UIView *playPauseBtnBottomView;
@property (strong, nonatomic) IBOutlet UIButton *playPauseBtn;

- (IBAction)playPauseVideo:(id)sender;
@end
