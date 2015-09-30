//
//  LogViewController.m
//  F45 Playoffs
//
//  Created by Paras on 9/16/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import "LogViewController.h"

@interface LogViewController ()

@end

@implementation LogViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    resultsArray = [[NSMutableArray alloc] init];
    [self getResultsFromDB];
}

-(void) getResultsFromDB
{
    NSManagedObjectContext *managedObjectContext = [DBHandler managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Submit"];
    
    NSArray *fetchedObjects = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:NO];
    
    NSArray *sortedResults = [fetchedObjects sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    for (NSManagedObject *obj in sortedResults)
    {
        NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects:@[[obj valueForKey:@"player_id"],[obj valueForKey:@"station_id"],[obj valueForKey:@"result"],[obj valueForKey:@"time"],[obj valueForKey:@"judge_id"],[obj valueForKey:@"status"]] forKeys:@[@"player_id", @"station_id", @"result", @"timestamp",@"judge_id",@"status"]];
        
        [resultsArray addObject:dictionary];
    }

}

#pragma mark table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return resultsArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    //Date Time / Booking / Station Number / Result
    //eg. 18/02/15 - 2323 - 10 - 232

    NSDictionary *result = [resultsArray objectAtIndex:indexPath.row];
    
    NSString *timestamp = [result objectForKey:@"timestamp"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp longLongValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
    
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    
    NSString *status = @"Not Sent";
    if ([[result objectForKey:@"status"] integerValue] == 1)
    {
        status = @"Sent";
    }
    
    NSString *finalString = [NSString stringWithFormat:@"%@ - %@ - %@ - %@ - %@",formattedDate,[result objectForKey:@"player_id"],[result objectForKey:@"station_id"],[result objectForKey:@"result"],status];
    
    cell.textLabel.text = finalString;
    return cell;
}

#pragma mark Button Actions

- (IBAction)DismissView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark memory warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
