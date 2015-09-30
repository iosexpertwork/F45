//
//  DashBoardViewController.m
//  f45Challenging
//
//  Created by Paras on 9/28/15.
//  Copyright (c) 2015 Paras. All rights reserved.
//

#import "DashBoardViewController.h"
#import "TableViewCell.h"

@interface DashBoardViewController ()

@end

@implementation DashBoardViewController
@synthesize backBtn, nextBtn, dailyProgressView, topView,bottomView,weekleProgressView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //backBtn.layer.borderColor=[UIColor blackColor].CGColor;
   // nextBtn.layer.borderColor=[UIColor blackColor].CGColor;
    //backBtn.clipsToBounds = YES;
    
//    backBtn.layer.cornerRadius = 20;//half of the width
//    backBtn.layer.borderColor=[UIColor whiteColor].CGColor;
//    backBtn.layer.borderWidth=2.0f;
//    
//    nextBtn.layer.cornerRadius = 20;//half of the width
//    nextBtn.layer.borderColor=[UIColor whiteColor].CGColor;
//    nextBtn.layer.borderWidth=2.0f;
    
    
    BottomBar *bar=[[BottomBar alloc]init];
    [bar showBottomBar:self.tabBarController];
    
    topView.layer.borderColor=[UIColor blackColor].CGColor;
    dailyProgressView.backgroundColor=[UIColor colorWithRed:243.0 green:243.0 blue:247.0 alpha:1];
    topView.layer.borderWidth=0.5;
    [dailyProgressView setTransform:CGAffineTransformMakeScale(1.0, topView.frame.size.height/2)];
    
    
    bottomView.layer.borderColor=[UIColor blackColor].CGColor;
    bottomView.layer.borderWidth=0.5;
    [weekleProgressView setTransform:CGAffineTransformMakeScale(1.0, bottomView.frame.size.height/2)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableVieww cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = (TableViewCell *)[tableVieww dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:self options:nil] objectAtIndex:0];
            //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.backgroundColor=[UIColor clearColor];
        tableVieww.separatorColor=[UIColor colorWithRed:73.0/255.0 green:66.0/255.0 blue:76.0/255.0 alpha:1.0];
        
    }
    
    
    if (indexPath.row==0) {
        [cell.btn1 setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    }
    
    if (indexPath.row==1) {
        [cell.btn1 setImage:[UIImage imageNamed:@"rond.png"] forState:UIControlStateNormal];
    }

    if (indexPath.row==2) {
        
        cell.btn1.frame = CGRectMake(305, 20, 30, 30);
        [cell.btn1 setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
    }

    
    
    
    if (indexPath.row==9)
    {
        cell.bottomLine.hidden=NO;
    }
    else
        cell.bottomLine.hidden=YES;
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
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
