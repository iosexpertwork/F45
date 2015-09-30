//
//  DBHandler.m
//  F45 Playoffs
//
//  Created by TED Solutions on 28/08/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import "DBHandler.h"

@implementation DBHandler

+ (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

+(void)saveData:(NSDictionary *)details
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Submit" inManagedObjectContext:context];
    [newDevice setValue:[NSString stringWithFormat:@"%ld", (long)[[details objectForKey:@"judge_id"] integerValue]] forKey:@"judge_id"];
    [newDevice setValue:[NSString stringWithFormat:@"%ld", (long)[[details objectForKey:@"result"] integerValue]] forKey:@"result"];
    [newDevice setValue:[NSString stringWithFormat:@"%ld", (long)[[details objectForKey:@"station_id"] integerValue]] forKey:@"station_id"];
    [newDevice setValue:[details objectForKey:@"timestamp"] forKey:@"time"];
    [newDevice setValue:[NSString stringWithFormat:@"%ld", (long)[[details objectForKey:@"player_id"] integerValue]] forKey:@"player_id"];
    [newDevice setValue:@"0" forKey:@"status"];
    //[newDevice setValue:self.companyTextField.text forKey:@"status"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else{
        NSLog(@"Saved Successfully");
    }
}

+(NSArray *)getAllData
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Submit"];
    NSArray *list = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    return list;
}

@end
