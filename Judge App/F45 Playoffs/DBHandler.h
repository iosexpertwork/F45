//
//  DBHandler.h
//  F45 Playoffs
//
//  Created by TED Solutions on 28/08/15.
//  Copyright (c) 2015 PARAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface DBHandler : NSObject

+(void)saveData:(NSDictionary *)details;
+(NSArray *)getAllData;
+ (NSManagedObjectContext *)managedObjectContext;
@end
