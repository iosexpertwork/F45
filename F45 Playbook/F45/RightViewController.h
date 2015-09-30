//
//  RightViewController.h
//  F45
//
//  Created by Paras on 9/21/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightViewController : UIViewController<UIActionSheetDelegate>
{
    BOOL isFreshDeskOpened;
    IBOutlet UITableView *tableData;
}

@end
