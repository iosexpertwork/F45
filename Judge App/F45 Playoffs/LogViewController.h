//
//  LogViewController.h
//  F45 Playoffs
//
//  Created by Paras on 9/16/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBHandler.h"

@interface LogViewController : UIViewController <UITableViewDataSource>
{
    NSMutableArray *resultsArray;
}

- (IBAction)DismissView:(id)sender;
@end
