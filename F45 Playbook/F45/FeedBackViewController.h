//
//  FeedBackViewController.h
//  F45
//
//  Created by Paras on 9/23/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "CPDConstants.h"
#import "CPDStockPriceStore.h"

@interface FeedBackViewController : UIViewController<CPTPlotDataSource>
@property (nonatomic, strong) CPTGraphHostingView *hostView;

@end
