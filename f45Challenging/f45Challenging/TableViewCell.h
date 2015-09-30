//
//  TableViewCell.h
//  f45Challenging
//
//  Created by Paras on 9/28/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *bottomLine;
@property (strong, nonatomic) IBOutlet UILabel *topLine;

@property (strong,nonatomic) IBOutlet UIButton *btn1;

@end
