//
//  InvestmentViewController.m
//  F45Sales
//
//  Created by Paras on 9/3/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import "InvestmentViewController.h"

@implementation InvestmentViewController
@synthesize scrollView;

-(void)viewDidLoad
{
    self.view.frame = CGRectMake(80, 134, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)viewDidLayoutSubviews {
    scrollView.contentSize = CGSizeMake(949, 3452);
}

@end
