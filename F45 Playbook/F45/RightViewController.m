//
//  RightViewController.m
//  F45
//
//  Created by Paras on 9/21/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import "RightViewController.h"
#import "playBookVC.h"
#import "AppDelegate.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"



@interface RightViewController ()
{
       NSMutableArray *listOfArray;
}

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      listOfArray=[[NSMutableArray alloc]initWithObjects:@"DashBoard",@"Feedback",@"Playoff",@"Support",@"Logout",nil];
    
            // Do any additional setup after loading the view.
}
-(BOOL)prefersStatusBarHidden
{
    return  YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)openFreshSDKView
{
    isFreshDeskOpened=YES;
    [[Mobihelp sharedInstance] presentSupport:self];
    /*[[Mobihelp sharedInstance] addCustomDataForKey:@"Name" withValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"name"]];
    [[Mobihelp sharedInstance] addCustomDataForKey:@"Franchisee_id" withValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"franchisee_id"]];
    [[Mobihelp sharedInstance] setUserName:[[NSUserDefaults standardUserDefaults]objectForKey:@"name"]];
    [[Mobihelp sharedInstance] setEmailAddress:[[NSUserDefaults standardUserDefaults]objectForKey:@"email"]];*/
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listOfArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableVieww cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableVieww dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
       // cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    cell.selected=NO;
    // Configure the cell...
    
    cell.backgroundColor=[UIColor colorWithRed:27.0/255.0 green:28/255.0 blue:46.0/255.0 alpha:1.0];
  
    cell.textLabel.text=[listOfArray objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont fontWithName:@"OpenSans" size:14.0];
    cell.textLabel.textColor=[UIColor whiteColor];
  //  CALayer *separator = [CALayer layer];
//    separator.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"table_line_bg@2x.png"]].CGColor;
//    
//    separator.frame = CGRectMake(-5, 44, self.view.frame.size.width+5, .9);
//    [cell.layer addSublayer:separator];
//    
//    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:35.0/255.0 green:37/255.0 blue:58.0/255.0 alpha:1.0]];
    [cell setSelectedBackgroundView:bgColorView];
    
        return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        switch (indexPath.row)
    {
        case 1:
        {
           [self.mm_drawerController setCenterViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"feedBack"] withCloseAnimation:YES completion:nil];
        }
            break;
        case 2:
        {
             [self.mm_drawerController setCenterViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"PlayBook"] withCloseAnimation:YES completion:nil];
                 }
            break;
        case 3:
        {
            [self openFreshSDKView];
            break;
            
        }
        case 4:
        {
            [self.mm_drawerController  setCenterViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"login"] withCloseAnimation:YES completion:nil];

             }default:
            break;
    }
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
