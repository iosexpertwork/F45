//
//  PlayersViewController.h
//  F45 Playoffs
//
//  Created by TED Solutions on 27/08/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "Helper.h"
#import "WebAPI.h"

@interface PlayersViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    WebAPI *api;
}

@property (strong, nonatomic) NSArray *playerList;
@property (weak, nonatomic) IBOutlet UITableView *table;
@end
