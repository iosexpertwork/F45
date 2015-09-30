//
//  MotivationViewController.m
//  F45Sales
//
//  Created by Paras on 9/3/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import "MotivationViewController.h"

@implementation MotivationViewController
@synthesize attributedTextLabel;

-(void) viewDidLoad
{
    self.view.frame = CGRectMake(80, 134, self.view.frame.size.width, self.view.frame.size.height);
    NSString *firstString = @"Founders Rob Deutsch and Adam Gilchrist";
    
    NSString *secondString = @" excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.";
    
    NSRange range1 = NSMakeRange(0,[firstString length]);
    NSRange range2 = NSMakeRange(range1.length, [secondString length]);
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",firstString,secondString]];
    
    [attributedText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Medium" size:17] range:range1];
    [attributedText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:17] range:range2];
    
    attributedTextLabel.attributedText = attributedText;
    
    

}

@end
