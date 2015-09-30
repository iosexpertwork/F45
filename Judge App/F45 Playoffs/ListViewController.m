//
//  ListViewController.m
//  F45 Playoffs
//
//  Created by TED Solutions on 27/08/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController
@synthesize table;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"Select Station";
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIBarButtonItem *closeBtn=[[UIBarButtonItem alloc]initWithTitle:@"close" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem=closeBtn;
    
    stationList=[[NSArray alloc]initWithObjects:@"POWER", @"BENCH HOPS", @"TRX PUSH UP + KNEE TUCK", @"5 CONE LATERAL HOP", @"BOX JUMP BURPEE", @"CHIN UPS", @"BB SQUAT PRESS", @"MB RUSSIAN TWIST", @"DEADBALL DROP OVER SHOULDER", @"HURDLE HOP AND SPRINT", nil];
    
    [table reloadData];
}

#pragma mark -- UITableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return stationList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    switch (indexPath.row)
    {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
          cell.textLabel.text=[NSString stringWithFormat:@"0%d - %@",indexPath.row+1,[stationList objectAtIndex:indexPath.row]];
        break;
            
        default:
        cell.textLabel.text=[NSString stringWithFormat:@"%d - %@",indexPath.row+1,[stationList objectAtIndex:indexPath.row]];
        break;
    }
    
    
    cell.textLabel.font=[UIFont fontWithName:PROXIMA_NOVA_REGULAR size:15];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *dic=[[NSDictionary alloc]initWithObjects:@[ selectedCell.textLabel.text, [NSString stringWithFormat:@"%d", indexPath.row+1]] forKeys:@[@"name", @"id"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"station" object:dic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- Button Action

-(void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- Memory Warning

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
