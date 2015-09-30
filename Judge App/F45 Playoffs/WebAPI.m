//
//  WebAPI.m
//  canoe
//
//  Created by HashBrown Systems on 04/05/15.
//  Copyright (c) 2015 Hashbrown Systems. All rights reserved.
//

#import "WebAPI.h"

@implementation WebAPI
@synthesize delegate;

#pragma mark -- Authentication Methods

-(void)loginWithDetails:(NSDictionary *)details viewController:(UIViewController *)controller;
{
    NSString *loginURL=[NSString stringWithFormat:@"franchisees/login"];
    [[ConnectionHandler getSharedInstance] jsonPostData:loginURL :details onCompletion:^(id completed)
     {
         @try {
             if (![completed isKindOfClass:[NSError class]])
             {
                 if ([[completed objectForKey:@"success"]integerValue]==1)
                 {
                     NSDictionary *details=[completed objectForKey:@"data"];
                     [[NSUserDefaults standardUserDefaults] setObject:[details objectForKey:@"email"] forKey:@"email"];
                     [[NSUserDefaults standardUserDefaults] setObject:[details objectForKey:@"name"] forKey:@"name"];
                     [[NSUserDefaults standardUserDefaults] setObject:[details objectForKey:@"franchisee_id"] forKey:@"franchisee_id"];
                     [[NSUserDefaults standardUserDefaults] synchronize];
                     [[self delegate] callBackLoginSuccess:completed];
                 }
                 else
                 {
                     if (![[completed objectForKey:@"errors"] isKindOfClass:[NSNull class]])
                     {
                         NSArray *errors=[completed objectForKey:@"errors"];
                         if (errors.count>0)
                         {
                             [[[UIAlertView alloc]initWithTitle:[completed objectForKey:@"operation"] message:[errors objectAtIndex:0] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                         }
                     }
                 }
             }
             else
             {
                 UINavigationController *navcontroller=(UINavigationController *)controller.parentViewController;
                 if ([navcontroller.topViewController isKindOfClass:[controller class]])
                 {
                     //[[[UIAlertView alloc]initWithTitle:OOPS message:SERVER_ERROR delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                 }
             }
         }
         @catch (NSException *exception) {
             NSLog(@"Exception: %@", exception);
         }
         @finally {
             [[self delegate] callbackFromAPI:completed];
         }
     }];
}

-(void)getAllActivePlayerList
{
    NSString *loginURL=[NSString stringWithFormat:@"users/active"];
    [[ConnectionHandler getSharedInstance] jsonGETDataHTTP:loginURL onCompletion:^(id completed) {
        @try {
            if (![completed isKindOfClass:[NSError class]])
            {
                if ([[completed objectForKey:@"success"]integerValue]==1)
                {
                    [[self delegate] callBackActivePlayerListSuccess:[completed objectForKey:@"data"]];
                }
                else
                {
                    if (![[completed objectForKey:@"errors"] isKindOfClass:[NSNull class]])
                    {
                        NSArray *errors=[completed objectForKey:@"errors"];
                        if (errors.count>0)
                        {
                            [[[UIAlertView alloc]initWithTitle:[completed objectForKey:@"operation"] message:[errors objectAtIndex:0] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                        }
                    }
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"Exception: %@", exception);
        }
        @finally {
            [[self delegate] callbackFromAPI:completed];
        }
    }];
}

-(void)submitDetails:(NSDictionary *)details
{
    NSString *loginURL=[NSString stringWithFormat:@"results/add"];
    [[ConnectionHandler getSharedInstance] jsonPostDataHTTP:loginURL :details onCompletion:^(id completed)
     {
         @try {
             if (![completed isKindOfClass:[NSError class]])
             {
                 if ([[completed objectForKey:@"success"]integerValue]==1)
                 {
                     
                 }
                 else
                 {
                     if (![[completed objectForKey:@"errors"] isKindOfClass:[NSNull class]])
                     {
                         NSArray *errors=[completed objectForKey:@"errors"];
                         if (errors.count>0)
                         {
                             [[[UIAlertView alloc]initWithTitle:[completed objectForKey:@"operation"] message:[errors objectAtIndex:0] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                         }
                     }
                 }
             }
             else
             {
                 [DBHandler saveData:details];
             }
         }
         @catch (NSException *exception) {
             NSLog(@"Exception: %@", exception);
             [DBHandler saveData:details];
         }
         @finally {
             [[self delegate] callbackFromAPI:completed];
         }
     }];
}

@end
