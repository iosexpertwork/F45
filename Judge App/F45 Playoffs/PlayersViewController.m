//
//  PlayersViewController.m
//  F45 Playoffs
//
//  Created by TED Solutions on 27/08/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import "PlayersViewController.h"

@interface PlayersViewController ()

@end

@implementation PlayersViewController
@synthesize table, playerList;

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"Active Players";
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIBarButtonItem *closeBtn=[[UIBarButtonItem alloc]initWithTitle:@"close" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem=closeBtn;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable:) name:@"PlayerList" object:nil];
}

#pragma mark Helper Methods

-(void) reloadTable:(NSNotification *) notification
{
    playerList = notification.object;
    [table reloadData];
}

#pragma mark -- UITableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return playerList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"playerCell"];
    
    NSDictionary *dic = [playerList objectAtIndex:indexPath.row];
    NSString *name=[NSString stringWithFormat:@"%@ - %@", [dic objectForKey:@"id"], [dic objectForKey:@"name"]];
    cell.textLabel.text=name;
    cell.textLabel.font=[UIFont fontWithName:PROXIMA_NOVA_REGULAR size:19];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [playerList objectAtIndex:indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"player" object:dic];
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
