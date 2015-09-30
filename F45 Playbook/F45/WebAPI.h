//
//  WebAPI.h
//  canoe
//
//  Created by HashBrown Systems on 04/05/15.
//  Copyright (c) 2015 Hashbrown Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ConnectionHandler.h"
#import "Constants.h"

@protocol APIsDelegate <NSObject>
@required
- (void) callbackFromAPI:(id)response;
@optional
//user methods
-(void) callBackLoginSuccess:(NSDictionary *)response;

@end

@interface WebAPI : NSObject
{
    __weak id <APIsDelegate> delegate;
}

@property (nonatomic,weak) id delegate;

//user methods
-(void)loginWithDetails:(NSDictionary *)details viewController:(UIViewController *)controller;

@end
