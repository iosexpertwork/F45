//
//  ListViewController.h
//  F45 Playoffs
//
//  Created by TED Solutions on 27/08/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface ListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *stationList;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@end
