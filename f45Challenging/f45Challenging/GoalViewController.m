//
//  GoalViewController.m
//  f45Challenging
//
//  Created by Paras on 9/28/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import "GoalViewController.h"

@interface GoalViewController ()

@end

@implementation GoalViewController
@synthesize save;
- (void)viewDidLoad {
    
    BottomBar *bar=[[BottomBar alloc]init];
    [bar showBottomBar:self.tabBarController];
    [super viewDidLoad];
      // Do any additional setup after loading the view.
    save.layer.cornerRadius =5;
    save.layer.borderWidth  =1;
    save.layer.borderColor = [UIColor blackColor].CGColor;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
